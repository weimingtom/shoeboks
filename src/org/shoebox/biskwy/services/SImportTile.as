package org.shoebox.biskwy.services {
	import org.shoebox.patterns.commands.ICommand;
	import org.shoebox.patterns.singleton.ISingleton;
	import org.shoebox.utils.logger.Logger;

	import flash.events.Event;
	import flash.filesystem.File;

	/**
	* Service who permit to import a new Tile in to the tiles Libray
	* 
	*  
	* org.shoebox.biskwy.services.SImportTile
	* @author shoebox
	*/
	public class SImportTile extends SQLLiteService implements ICommand {
		
		protected var _oFILE			:File;
		
		// -------o constructor
		
			public function SImportTile( ) : void {
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
			final override public function onExecute( e : Event = null ) : void {
				
				_oFILE.addEventListener(Event.COMPLETE , _onLoad , false , 10 , true);
				_oFILE.load();
			}
			
			/**
			* onCancel function
			* @public
			* @param 
			* @return
			*/
			final override public function onCancel( e : Event = null ) : void {
				super.onCancel();
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
				request = 'INSERT INTO TilesDB (name,filepath,walkable,active,cat , media) VALUES ("'+_oFILE.name+'","'+_oFILE.nativePath+'",true,false,"none",:byteArray)';
				addParameter(':byteArray' , _oFILE.data);
				super.onExecute();
			}				
			
		// -------o misc

			public static function trc(arguments : *) : void {
				Logger.log(SImportTile, arguments);
			}
	}
}
