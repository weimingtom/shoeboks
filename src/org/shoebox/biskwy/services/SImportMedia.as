package org.shoebox.biskwy.services {
	import org.shoebox.display.BoxBitmapData;
	import flash.display.BitmapData;
	import org.shoebox.biskwy.core.Config;
	import org.shoebox.patterns.service.IService;
	
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
		
		protected var _oFILE			:File;		protected var _oCOPY			:File;
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
				var oF : File = Config.PROJECTFILE.parent.resolvePath('assets');
				if( !oF.exists )
					oF.createDirectory();
				trace('_oFILE.name ::: '+_oFILE.name);
				_oCOPY = oF.resolvePath(_oFILE.name); 
				_oFILE.copyTo( _oCOPY );
				_oFILE.removeEventListener(Event.COMPLETE , _onLoad , false);
				
				var oB : BitmapData;
				switch( _oFILE.name.split('.')[1] ){
					
					case 'jpg':					case 'jpeg':
					case 'png':
					case 'swf':
						_oLOADER = new Loader();
						_oLOADER.contentLoaderInfo.addEventListener( Event.COMPLETE , _onLoadComplete , false , 10 , true );
						_oLOADER.loadBytes( _oFILE.data );
						break;
					
					case 'mp3':
						oB = new BitmapData( 125 , 125 , false , 0x0AB6F3 );
						_push( oB , 'SoundAsset' );
						break;
					
				}
				
				
				
			}	
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			final protected function _onLoadComplete( e : Event ) : void {
				_oLOADER.contentLoaderInfo.removeEventListener( Event.COMPLETE , _onLoadComplete , false );
				
				var 	oB : BitmapData = new BitmapData( _oLOADER.width , _oLOADER.height , true );
					oB.draw( _oLOADER );
					oB = BoxBitmapData.resize( oB , 250 , 250 , true , true );
				
				_push( oB );
			}			

			/**
			* Pushing a new asset
			*
			* @param 	oB : preview bitmapdata		
			* @return	void
			*/
			final protected function _push( oB : BitmapData , sType : String = 'Asset' ) : void {
				trace('push ::: '+oB);
				
				request = 'INSERT INTO TB_Assets ( name , filePath , type , preview  ) VALUES ("'+_oCOPY.name+'","'+_oCOPY.nativePath+'","'+sType+'",:mediavec)';
				
				var v : Vector.<uint> = oB.getVector( oB.rect );
					v.unshift( oB.width , oB.height );
				
				addParameter(':mediavec' , v );
				super.onCall();
			}
			
		// -------o misc

			public static function trc(arguments : *) : void {
				//Logger.log(SImportMedia, arguments);
			}
	}
}
