package org.shoebox.biskwy.services {
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import org.shoebox.biskwy.core.variables.ProjectDirectory;
	import org.shoebox.patterns.service.IService;
	import org.shoebox.utils.logger.Logger;

	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Matrix;

	/**
	* Service who permit to import a new Tile in to the tiles Libray
	* 
	*  
	* org.shoebox.biskwy.services.SImportTile
	* @author shoebox
	*/
	public class SImportTile extends SQLLiteService implements IService {
		
		protected var _oFILE			:File;		protected var _oFILECOPY		:File;
		protected var _oLOADER			:Loader;
		
		protected const uSIZE			:uint = 60;
		
		// -------o constructor
		
			public function SImportTile( ) : void {
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
				
				_oFILECOPY = ProjectDirectory.resolvePath('assets');
				_oFILECOPY = _oFILECOPY.resolvePath(_oFILE.name);
					
				_oFILE.copyTo( _oFILECOPY , true );
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
				_oFILE.removeEventListener(Event.COMPLETE , _onLoad , false);
				
				var 	oCONTEXT : LoaderContext = new LoaderContext( false ,  ApplicationDomain.currentDomain );
					oCONTEXT.allowCodeImport = true;
				
				_oLOADER = new Loader();
				_oLOADER.contentLoaderInfo.addEventListener( Event.COMPLETE , _onLoadContent , false , 10 , true );
				_oLOADER.loadBytes( _oFILE.data , oCONTEXT );
					
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			final protected function _onLoadContent( e : Event ) : void {
				
				_oLOADER.contentLoaderInfo.removeEventListener( Event.COMPLETE , _onLoadContent , false );
				var 	nSCALE 	: Number = Math.min( uSIZE/ _oLOADER.content.width , uSIZE / _oLOADER.content.height);
				
				var 	oMAT:Matrix = new Matrix();
					oMAT.scale( nSCALE , nSCALE );
				
				var 	oBMP : BitmapData = new BitmapData( uSIZE , uSIZE , true , 0 );
					oBMP.draw( _oLOADER , oMAT );
				
				request = 'INSERT INTO TilesDB ( name , filepath , ground , collide , active , cat , preview , media , mediaW , mediaH ) VALUES ("'+_oFILECOPY.name+'","'+_oFILECOPY.nativePath+'",true,false,false,"none",:preview,:media,'+_oLOADER.width+','+_oLOADER.height+')';
				addParameter(':preview' , oBMP.getVector(oBMP.rect));				addParameter(':media' , _oFILE.data);
				super.onCall();
				oBMP.dispose();
			}				
			
		// -------o misc

			public static function trc(arguments : *) : void {
				Logger.log(SImportTile, arguments);
			}
	}
}
