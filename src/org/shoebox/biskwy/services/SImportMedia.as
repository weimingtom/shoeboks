package org.shoebox.biskwy.services {
	import flash.utils.ByteArray;
	import flash.display.BitmapData;
	import org.shoebox.biskwy.core.Config;
	import org.shoebox.patterns.service.IService;
	import org.shoebox.utils.logger.Logger;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;

	/**
	* Service who permit to import a new Tile in to the tiles Libray
	* 
	*  
	* org.shoebox.biskwy.services.SImportMedia
	* @author shoebox
	*/
	public class SImportMedia extends SQLLiteService implements IService {
		
		protected var _oFILE			:File;
		protected var _oLOADER			:Loader;
		
		// -------o constructor
		
			public function SImportMedia( ) : void {
				trc('constructor');
				super();
				request = 'SELECT DISTINCT cat FROM TilesDB';
			}

		// -------o public
			
			/**
			* file function
			* @public
			* @param 
			* @return
			*/
			public function set file( f : File) : void {
				_oFILE = f;
			}
			
			/**
			* onCall function
			* @public
			* @param 
			* @return
			*/
			final override public function onCall( ) : void {
				trc('onCall ::: '+_oFILE);
				_oFILE.addEventListener(Event.COMPLETE , _onLoad , false , 10 , true);
				_oFILE.load();
			}
			
			/**
			* onCancel function
			* @public
			* @param 
			* @return
			*/
			final override public function onRefresh( ) : void {
				
			}
			
		// -------o protected
				
			
			/**
			* 
			*
			* @param  
			* @return
			*/
			protected function _onLoad( e : Event ) : void {
				trc('onLoad');
				var oF : File = Config.PROJECTFILE.parent.resolvePath('assets');
				if( !oF.exists )
					oF.createDirectory();
				
				_oFILE.copyTo(oF.resolvePath(_oFILE.name));
				_oFILE.removeEventListener(Event.COMPLETE , _onLoad , false);
				//'CREATE TABLE IF NOT EXISTS TB_Assets ( id INTEGER PRIMARY KEY , name TEXT , preview BLOB , filePath TEXT )';
				
				_oLOADER = new Loader();
				_oLOADER.contentLoaderInfo.addEventListener( Event.COMPLETE , _onLoadComplete , false , 10 , true );
				_oLOADER.loadBytes( _oFILE.data );
				
			}	
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			final protected function _onLoadComplete( e : Event ) : void {
				trace('_onLoadComplete');
				var 	oB : BitmapData = new BitmapData( _oLOADER.width , _oLOADER.height , true );
					oB.draw( _oLOADER );
				
				var 	oBA : ByteArray = new ByteArray();
					oBA.writeObject( oB );
				
				_oLOADER.contentLoaderInfo.removeEventListener( Event.COMPLETE , _onLoadComplete , false );
				request = 'INSERT INTO TB_Assets ( name , filePath , preview ) VALUES ("'+_oFILE.name+'","'+_oFILE.nativePath+'",:byteArray)';
				addParameter(':byteArray' , oB );
				super.onCall();
			}			
			
		// -------o misc

			public static function trc(arguments : *) : void {
				Logger.log(SImportMedia, arguments);
			}
	}
}
