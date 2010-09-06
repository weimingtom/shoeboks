/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.commands.menu {	import org.shoebox.biskwy.core.Config;	import org.shoebox.biskwy.core.Database;	import org.shoebox.biskwy.core.Facade;	import org.shoebox.biskwy.core.IsoGrid;	import org.shoebox.biskwy.core.Schemas;	import org.shoebox.biskwy.core.TwoD;	import org.shoebox.biskwy.core.variables.ProjectDirectory;	import org.shoebox.biskwy.windows.NewProjectWindow;	import org.shoebox.biskwy.windows.content.CtntNewProject;	import org.shoebox.errors.Errors;	import org.shoebox.patterns.commands.AbstractCommand;	import org.shoebox.patterns.commands.ICommand;	import org.shoebox.patterns.singleton.ISingleton;	import org.shoebox.utils.logger.Logger;	import flash.data.SQLStatement;	import flash.display.Screen;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.events.SQLEvent;	import flash.filesystem.File;	import flash.filesystem.FileMode;	import flash.filesystem.FileStream;	/**	 * org.shoebox.biskwy.commands.menu.CommandNewProject	* @author shoebox	*/	public class CommandNewProject extends AbstractCommand implements ICommand , ISingleton{				protected var _oWINDOW		:NewProjectWindow;		protected var _oFILE		:File;		protected var _oFOLDER		:File;		protected var _oCONTENT	:CtntNewProject;				protected static var __instance		:CommandNewProject = null;				// -------o constructor					public function CommandNewProject( e : SingletonEnforcer ) : void {			}		// -------o public						/**			* getInstance function			* @public			* @param 			* @return			*/			static public function getInstance() : CommandNewProject {								if(__instance == null)					__instance = new CommandNewProject(new SingletonEnforcer());									return __instance;							}						/**			* onExecute function			* @public			* @param 			* @return			*/			override public function onExecute( e : Event = null ) : void {								Facade.getInstance().freeze();				_run();							}						/**			* onCancel function			* @public			* @param 			* @return			*/			override public function onCancel( e : Event = null ) : void {						}					// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _run(  ) : void {				        			/*	        			onComplete();				Database.getInstance().init();				*/								//					_oWINDOW = new NewProjectWindow();								//									_oCONTENT = new CtntNewProject();					_oCONTENT.addEventListener( MouseEvent.CLICK , _onClick , true , 10 , true);										//					_oWINDOW.stage.addChild( _oCONTENT );					_oWINDOW.activate();										_oWINDOW.x = ( Screen.mainScreen.bounds.width - 350 ) / 2;					_oWINDOW.y = ( Screen.mainScreen.bounds.height - 350 ) / 2;			}						/**			* 			*			* @param 			* @return			*/			protected function _onClick( e : MouseEvent ) : void {								switch(e.target.name){										case 'Validate':						_validate();						break;											case 'Cancel':						_cancel();						break;									}							}						/**			* 			*			* @param 			* @return			*/			protected function _validate() : void {								trc('validate ::: '+_oCONTENT.projectName);								//					_oFOLDER = File.documentsDirectory;					_oFILE = File.documentsDirectory.resolvePath('Biskwy_'+ _oCONTENT.projectName );										//						if(_oFILE.exists){							Errors.throwError( new Error('The project '+_oCONTENT.projectName+' already exist') );							return;						}										//						var 	oTMP : File = _oFILE.resolvePath('assets');							oTMP.createDirectory();							oTMP = _oFILE.resolvePath('maps');							oTMP.createDirectory();													_oFILE.createDirectory();						_oFILE = _oFILE.resolvePath('project.bwp');								//					Config.PROJECTNAME = _oCONTENT.projectName;									//					 var 	oS:FileStream = new FileStream();	        				oS.open(_oFILE, FileMode.WRITE);	        				oS.writeUTFBytes('');	        				oS.close();								//					Config.PROJECTFILE = _oFILE;					ProjectDirectory = _oFILE.parent;					Database.getInstance().addEventListener( Event.COMPLETE , _onDBInit , false , 10 , true );					Database.getInstance().init();							}						/**			* 			*			* @param 			* @return			*/			protected function _onDBInit( e : Event = null ) : void {				trc('onDBInit');				e.target.removeEventListener( Event.COMPLETE , _onDBInit , false);								var 	oSTAT : SQLStatement = new SQLStatement();					oSTAT.sqlConnection = Database.getInstance();									var v : Vector.<String> = Vector.<String>([											Schemas.TBConfig,											Schemas.TBGroups,											Schemas.TBMaps,											Schemas.TBTiles,											Schemas.TBAssets											]);									var s : String;				for each( s in v ){					oSTAT.text = s;					oSTAT.execute();				}							_config();			}			/**			* 			*			* @param 			* @return			*/			protected function _onComplete( e : Event = null ) : void {				trc('onComplete');				e.target.removeEventListener( SQLEvent.RESULT , _onComplete , false);								_config();			}						/**			* 			*			* @param 			* @return			*/			protected function _config() : void {								Config.TILESIZE = _oCONTENT.tileSize; 				Config.GRIDTYPE = (_oCONTENT.mapType == 'Isometric') ? IsoGrid : TwoD;								var 	oDB : Database = Database.getInstance();					oDB.text = 'INSERT INTO Config (name , tileSize , type , camW , camH ) VALUES ( "'+_oCONTENT.projectName+'" , '+_oCONTENT.tileSize+' , "'+_oCONTENT.mapType+'" , '+_oCONTENT.getProp('camW')+' ,'+_oCONTENT.getProp('camH')+' )';					oDB.addEventListener( SQLEvent.RESULT , _onSave , false , 10 , true);					oDB.execute();			}						/**			* 			*  			* @param 			* @return			*/ 			protected function _onSave( e : SQLEvent ) : void {				trc('_onSave');				e.target.removeEventListener( SQLEvent.RESULT , _onSave , false);				_cancel();				onComplete();				Facade.getInstance().unfreeze();			}						/**			* 			*			* @param 			* @return			*/			protected function _cancel() : void {								if(_oWINDOW)					_oWINDOW.close();								_bISRUNNING = false;				Facade.getInstance().unfreeze();							}									/**			* 			*			* @param 			* @return			*/			protected function _onCancel( e : Event ) : void {				_bISRUNNING = false;				_oFILE.removeEventListener(Event.CANCEL , _onCancel , false);				//_oFILE.removeEventListener(Event.SELECT , _onSelect , false);				Facade.getInstance().unfreeze();			}					// -------o misc			public static function trc(arguments : *) : void {				Logger.log(CommandNewProject, arguments);			}	}}internal class SingletonEnforcer{	}