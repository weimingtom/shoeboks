/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.commands.tiles {		import org.shoebox.biskwy.controllers.TileEditorController;	import org.shoebox.biskwy.core.Facade;	import org.shoebox.biskwy.models.TileEditorModel;	import org.shoebox.biskwy.views.TileEditorView;	import org.shoebox.patterns.commands.AbstractCommand;	import org.shoebox.patterns.commands.ICommand;	import org.shoebox.patterns.mvc.commands.MVCCommand;	import org.shoebox.patterns.singleton.ISingleton;	import org.shoebox.utils.logger.Logger;	import flash.display.NativeWindow;	import flash.display.NativeWindowInitOptions;	import flash.display.Screen;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.events.Event;	/**	 * org.shoebox.biskwy.commands.tiles.CommandEditTile	* @author shoebox	*/	public class CommandEditTile extends AbstractCommand implements ICommand , ISingleton {				protected static var __instance		:CommandEditTile = null;				// -------o constructor					public function CommandEditTile( e : SingletonEnforcer ) : void {							}		// -------o public						/**			* onExecute function			* @public			* @param 			* @return			*/			final override public function onExecute( e: Event = null ) : void {
								trc('onExecute ::: '+e);								Facade.getInstance().freeze();								var	oOPT : NativeWindowInitOptions = new NativeWindowInitOptions();					oOPT.resizable = false;								var 	oWIN : NativeWindow = new NativeWindow( oOPT );					oWIN.title = 'Tile Editor';										oWIN.stage.scaleMode = StageScaleMode.NO_SCALE;					oWIN.stage.align = StageAlign.TOP_LEFT;					oWIN.addEventListener( Event.CLOSE , _onClosed , false , 10 , true );					oWIN.x = (Screen.mainScreen.bounds.width - 900)/2;					oWIN.y = (Screen.mainScreen.bounds.height - 600)/2;					oWIN.activate();					oWIN.stage.stageWidth = 900;					oWIN.stage.stageHeight = 600;								var 	oMVC : MVCCommand = new MVCCommand( { 												modelClass: TileEditorModel , 												viewClass : TileEditorView , 												controllerClass : TileEditorController											} );					oMVC.container = oWIN.stage;					oMVC.execute( e );									////ZWindow.getInstance().register( oWIN , 5009 );							}			/**			* name function			* @public			* @param 			* @return			*/			final override public function onCancel( e : Event = null ) : void {						}					// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _onClosed( e : Event ) : void {				trc('onClosed');				Facade.getInstance().unfreeze();
				onComplete();
				_bISCANCEL = false;			}		// -------o misc			public static function trc(...args : *) : void {				Logger.log(CommandEditTile, args);			}						/**			* Return the singleton instance of the class			* @public			* @return instance of the class (CommandEditTile)			*/			static public function getInstance() : CommandEditTile {								if( !__instance )					__instance = new CommandEditTile( new SingletonEnforcer() );												return __instance;			}	}}internal class SingletonEnforcer{	}