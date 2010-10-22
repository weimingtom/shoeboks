package org.shoebox.biskwy.services {
	import flash.events.SQLEvent;
	import org.shoebox.biskwy.core.DatabaseAssets;
	import org.shoebox.patterns.service.AbstractService;
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
	public class SImportMedia extends AbstractService implements IService {
		
		protected var _oFILE			: File;
		protected var _oBMP			: BitmapData;		protected var _sTYPE			: String;		protected var _oCOPY			: File;
		protected var _oLOADER			: Loader;
		protected var _oBASE			: DatabaseAssets;
		
		// -------o constructor
		
			public function SImportMedia( ) : void {
				trc('constructor');
				super();
				//request = 'SELECT DISTINCT cat FROM TilesDB';
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
						oB = new BitmapData( 125 , 125 , false , 0x0000FF );
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
				_oBMP = oB;
				_sTYPE = sType;
				_initBase();
				
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			final protected function _initBase() : void {
				_oBASE = new DatabaseAssets( );
				_oBASE.addEventListener( Event.OPEN , _onOpened , false , 10 , true );
				_oBASE.init( );
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			final protected function _onOpened( e : Event ) : void {
				trc('onOpened');
				
				
				var v : Vector.<uint> = _oBMP.getVector( _oBMP.rect );
					v.unshift( _oBMP.width , _oBMP.height );
				
				var 	oP : Object = {};
					oP[':mediavec'] = v;

				_oBASE.removeEventListener( Event.OPEN , _onOpened , false );
				_oBASE.addEventListener( SQLEvent.RESULT , _onResults , false , 10 , true );
				_oBASE.call('INSERT INTO TB_Assets ( name , filePath , type , preview  ) VALUES ("'+_oCOPY.name+'","'+_oCOPY.nativePath+'","'+_sTYPE+'",:mediavec)' , oP );
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			final protected function _onResults( e : SQLEvent ) : void {
				trc('onResults ::: ' + e );
				
				_oBASE.removeEventListener(SQLEvent.RESULT , _onResults , false );
				_oBASE.close( );
				onComplete( );
			}
			
		// -------o misc

			public static function trc(arguments : *) : void {
				//Logger.log(SImportMedia, arguments);
			}
	}
}
