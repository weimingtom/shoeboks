/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.commands.menu {	import org.shoebox.biskwy.commands.tiles.STilesDescCacher;
	import org.shoebox.biskwy.core.Config;	import org.shoebox.biskwy.core.Database;	import org.shoebox.biskwy.core.IsoGrid;	import org.shoebox.biskwy.core.TwoD;	import org.shoebox.biskwy.core.variables.ProjectDirectory;	import org.shoebox.biskwy.utils.IsoTransform;	import org.shoebox.biskwy.utils.Transformer;	import org.shoebox.biskwy.utils.TwoDTransform;	import org.shoebox.patterns.commands.AbstractCommand;	import org.shoebox.patterns.commands.ICommand;	import org.shoebox.patterns.singleton.ISingleton;	import org.shoebox.utils.logger.Logger;	import flash.data.EncryptedLocalStore;	import flash.events.Event;	import flash.events.SQLEvent;	import flash.filesystem.File;	import flash.net.FileFilter;	import flash.utils.ByteArray;	/**	 * Opening an existing project file	* first browse to open a db file and then stream to file content	* 	* @implements ICommand	* @implements ISingleton 	* org.shoebox.biskwy.commands.menu.CommandOpenProject	* @author shoebox	*/	public class CommandOpenProject extends AbstractCommand implements ICommand , ISingleton{				protected var _oFILE		:File;				protected static var __instance		:CommandOpenProject = null;				// -------o constructor					public function CommandOpenProject( e : SingletonEnforcer ) : void {				trc('constructor');			}		// -------o public							/**			* getInstance function			* @public			* @param 			* @return			*/			static public function getInstance() : CommandOpenProject {								if(__instance == null)					__instance = new CommandOpenProject(new SingletonEnforcer());									return __instance;							}							/**			* onExecute function			* @public			* @param 			* @return			*/			override public function onExecute( e : Event = null ) : void {				trc('execute');				_oFILE = new File();				_oFILE.addEventListener(Event.SELECT , _onSelect , false , 10 , true);				_oFILE.addEventListener(Event.CANCEL , _onCancel , false , 10 , true);				_oFILE.browseForOpen('Open project', [new FileFilter('Biskwy project file','*.bwp;')]);							}						/**			* onCancel function			* @public			* @param 			* @return			*/			override public function onCancel( e : Event = null ) : void {							}					// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _onSelect( e : Event = null ) : void {				trc('_onSelect');				Config.PROJECTFILE = _oFILE;				ProjectDirectory = _oFILE.parent;								var 	o : ByteArray = new ByteArray();					o.writeUTF( _oFILE.nativePath );									EncryptedLocalStore.setItem('BiskwyLatestProjects', o);				//onComplete();				Database.getInstance().addEventListener( Event.COMPLETE , _onComplete , false , 10 , true);								Database.getInstance().init();			}						/**			* 			*			* @param 			* @return			*/			protected function _onComplete( e : Event ) : void {				e.target.removeEventListener( Event.COMPLETE , _onComplete , false);								var 	oBASE : Database = Database.getInstance(); 					oBASE.text = 'SELECT * FROM Config';					oBASE.addEventListener( SQLEvent.RESULT , _onResult , false , 10 , true);					oBASE.execute();			}						/**			* 			*			* @param 			* @return			*/			protected function _onResult( e : SQLEvent ) : void {				trace('_onResult');				e.target.removeEventListener( SQLEvent.RESULT , _onResult , false);								var o : Object = Database.getInstance().getResult().data[0];									Config.PROJECTNAME = o.name;				Config.TILESIZE = o.tileSize;								switch(o.type){										case 'Isometric':						Config.GRIDTYPE = IsoGrid;						Transformer.transform = new IsoTransform();						break;											case '2D':						Config.GRIDTYPE = TwoD;						Transformer.transform = new TwoDTransform();						break;										case 'Platform':						Config.GRIDTYPE = TwoD;						Transformer.transform = new TwoDTransform();						break;									}								onComplete();								//					if( !CommandAssetsManager.getInstance().isRunning )						CommandAssetsManager.getInstance().execute();								//					STilesDescCacher.getInstance().execute();								}						/**			* 			*			* @param 			* @return			*/			protected function _onCancel( e : Event ) : void {				_bISRUNNING = false;				_oFILE.removeEventListener(Event.CANCEL , _onCancel , false);				_oFILE.removeEventListener(Event.SELECT , _onSelect , false);			}					// -------o misc			public static function trc(arguments : *) : void {				Logger.log(CommandOpenProject, arguments);			}	}}internal class SingletonEnforcer{}