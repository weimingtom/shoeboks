/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.core {	import org.shoebox.biskwy.apps.AppTools;	import org.shoebox.biskwy.commands.AboutCommand;	import org.shoebox.biskwy.commands.map.CommandBehavior;	import org.shoebox.biskwy.commands.menu.CommandCloseProject;	import org.shoebox.biskwy.commands.menu.CommandNewProject;	import org.shoebox.biskwy.commands.menu.CommandOpenLastProject;	import org.shoebox.biskwy.commands.menu.CommandOpenProject;	import org.shoebox.biskwy.commands.menu.CommandTest;	import org.shoebox.biskwy.commands.menu.CommandUpdater;	import org.shoebox.biskwy.commands.tiles.CommandDelTile;	import org.shoebox.biskwy.commands.tiles.CommandEditTile;	import org.shoebox.biskwy.controllers.CMaps;	import org.shoebox.biskwy.controllers.CTileContent;	import org.shoebox.biskwy.controllers.CToolProperty;	import org.shoebox.biskwy.controllers.GenericController;	import org.shoebox.biskwy.controllers.MapController;	import org.shoebox.biskwy.controllers.TilesController;	import org.shoebox.biskwy.events.GridTileEvent;	import org.shoebox.biskwy.events.TileEvent;	import org.shoebox.biskwy.models.MMaps;	import org.shoebox.biskwy.models.MTileContent;	import org.shoebox.biskwy.models.MToolProperty;	import org.shoebox.biskwy.models.MapModel;	import org.shoebox.biskwy.models.TilesModel;	import org.shoebox.biskwy.views.TilesView;	import org.shoebox.biskwy.views.VMaps;	import org.shoebox.biskwy.views.VTileContent;	import org.shoebox.biskwy.views.VToolProperty;	import org.shoebox.biskwy.views.VWelcome;	import org.shoebox.biskwy.views.maps.IsoMap;	import org.shoebox.biskwy.views.maps.MapTwoD;	import org.shoebox.libs.pimpmyair.behaviors.ZWindow;	import org.shoebox.libs.pimpmyair.utils.NativeWindowUtils;	import org.shoebox.patterns.commands.events.CommandEvents;	import org.shoebox.patterns.commands.samples.StageResize;	import org.shoebox.patterns.frontcontroller.FrontController;	import org.shoebox.utils.display.STAGEINSTANCE;	import org.shoebox.utils.logger.Logger;	import flash.display.NativeMenuItem;	import flash.display.NativeWindow;	import flash.display.NativeWindowInitOptions;	import flash.display.NativeWindowSystemChrome;	import flash.display.NativeWindowType;	import flash.display.Sprite;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.events.Event;	/**	 * org.shoebox.biskwy.core.Facade	* @author shoebox	*/	public class Facade extends FrontController {				public static const APP_MAPS			: String = 'APP_MAPS';		public static const APP_WELCOME		: String = 'APP_WELCOME';		public static const APP_TILES			: String = 'APP_TILES';		public static const APP_MAP_ISO		: String = 'APP_MAP_ISO';		public static const APP_MAP_TWOD		: String = 'APP_MAP_TWOD';		public static const APP_TILE_CONTENT	: String = 'APP_TILE_CONTENT';		public static const APP_TOOLS_PROPS		: String = 'APP_TOOLS_PROPS';				public static const STATE_WELCOME		: String = 'STATE_WELCOME';		public static const STATE_PROJECT2D		: String = 'STATE_PROJECT2D';		public static const STATE_PROJECTISO	: String = 'STATE_PROJECTISO';				protected var _oTOOLS				: NativeWindow;		protected var _spFREEZE				: Sprite;				static protected var __instance		:Facade = null;				// -------o constructor					public function Facade( e : SingletonEnforcer ) : void {				super();			}		// -------o public						/**			* Freezing the stage			* @public			* @return void			*/			public function freeze() : void {				_spFREEZE.width = StageResize.rect.width;				_spFREEZE.height = StageResize.rect.height;				owner.addChild(_spFREEZE);				}						/**			* Unfreezing the stage			* @public			* @return void			*/			public function unfreeze() : void {				if(_spFREEZE)					if(owner.contains(_spFREEZE))						owner.removeChild(_spFREEZE);			}						/**			* Initialization of the Application facade			* @public			* @return void			*/			public function init() : void {								//					registerTriad(APP_WELCOME 	 , null , VWelcome , GenericController );					registerTriad(APP_TILES 	 , TilesModel , TilesView , TilesController );					registerTriad(APP_MAPS 		 , MMaps , VMaps , CMaps );					registerTriad(APP_MAP_ISO	 , MapModel , IsoMap , MapController); 					registerTriad(APP_MAP_TWOD	 , MapModel , MapTwoD , MapController); 					registerTriad(APP_TILE_CONTENT , MTileContent , VTileContent , CTileContent); 					registerTriad(APP_TOOLS_PROPS	 , MToolProperty , VToolProperty , CToolProperty); 												//					registerState( STATE_WELCOME , Vector.<String>([ APP_WELCOME ]));										registerState( STATE_PROJECT2D , Vector.<String>([ 															APP_MAPS , 														APP_MAP_TWOD , 														APP_TILE_CONTENT,														APP_TILES , 														APP_TOOLS_PROPS													]));																		registerState( STATE_PROJECTISO , Vector.<String>([ 															APP_MAPS , 														APP_MAP_ISO, 														APP_TILE_CONTENT,														APP_TILES , 														APP_TOOLS_PROPS																	]));								//					_spFREEZE = new Sprite();					_spFREEZE.graphics.beginFill( 0x000000 , .90 );					_spFREEZE.graphics.drawRect( 0 , 0 , 200 , 200);					_spFREEZE.graphics.endFill();					_spFREEZE.buttonMode = true;					_spFREEZE.useHandCursor = false;									//					_openTools();						_events();					Menu.getInstance().addEventListener(Event.SELECT , _onMenuSelection , false , 10 , true );									//					addCommand(TileEvent.EDIT, CommandEditTile);					addCommand(TileEvent.DELETE, CommandDelTile);					addCommand(GridTileEvent.GRIDTILE_EDIT, CommandBehavior);												addCommand(Menu.ABOUT_UPDATE, CommandUpdater);					addCommand(Menu.PROJECT_NEW, CommandNewProject);					addCommand(Menu.PROJECT_OPEN, CommandOpenProject);					addCommand(Menu.PROJECT_CLOSE, CommandCloseProject);					addCommand(Menu.COMPILE_TEST, CommandTest);					addCommand(Menu.ABOUT_ABOUT, AboutCommand);			}		// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _events() : void {				CommandNewProject.getInstance().addEventListener(CommandEvents.COMPLETE , _onProject , false , 10 , true);				CommandOpenProject.getInstance().addEventListener(CommandEvents.COMPLETE , _onProject , false , 10 , true);				CommandOpenLastProject.getInstance().addEventListener(CommandEvents.COMPLETE , _onProject , false , 10 , true);				CommandCloseProject.getInstance().addEventListener(CommandEvents.COMPLETE , _onClosedProject , false , 10 , true);			}						/**			* When a project is opened			*			* @param 	e : CommandEvents			* @return	void			*/			protected function _onProject( e : CommandEvents) : void {				Menu.getInstance().activate();				state = (Config.GRIDTYPE) == IsoGrid ? STATE_PROJECTISO : STATE_PROJECT2D;			}			/**			* When a project is closed			*			* @param 	e : CommandEvents			* @return	void			*/			protected function _onClosedProject( e : CommandEvents ) : void {				state = STATE_WELCOME;			}						/**			* Open the tools windows and adding the content in it 			*			* @return void			*/			protected function _openTools() : void {								//					var	oOPT:NativeWindowInitOptions = new NativeWindowInitOptions();						oOPT.resizable = oOPT.maximizable = oOPT.minimizable =  false;						oOPT.systemChrome = NativeWindowSystemChrome.STANDARD;						oOPT.type = NativeWindowType.UTILITY;								//					_oTOOLS = new NativeWindow( oOPT );					_oTOOLS.addEventListener( Event.CLOSE , _onClosedTools , false , 10 , true );					_oTOOLS.title = 'Tools';					//_oTOOLS.alwaysInFront = true;					_oTOOLS.orderInFrontOf( STAGEINSTANCE.nativeWindow );					_oTOOLS.stage.addChild(new AppTools());					_oTOOLS.stage.scaleMode = StageScaleMode.NO_SCALE;					_oTOOLS.stage.align = StageAlign.TOP_LEFT;					_oTOOLS.visible = false;										NativeWindowUtils.resizeWindow(_oTOOLS,85,200);					ZWindow.getInstance().register( _oTOOLS , 50 );			}						/**			* When the tools windows is closed			*			* @param 	e : Event.CLOSE (Event)			* @return	void			*/			protected function _onClosedTools( e : Event ) : void {				Menu.getInstance().toolState = false;				_oTOOLS = null;			}						/**			* When an item is selected in to the menu 			*			* @param 	e : selection event (Event)			* @return	void			*/			protected function _onMenuSelection( e : Event ) : void {								if(!(e.target is NativeMenuItem))					return;								var oITEM : NativeMenuItem = e.target as NativeMenuItem;				if( oITEM.label == Menu.WINDOW_TOOLS ){					oITEM.checked = !oITEM.checked;					if(_oTOOLS){						_oTOOLS.close();						_oTOOLS = null;					}else						_openTools();				}								}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(Facade, args);			}						/**			* Return the singleton instance of the class			* @public			* @return instance of the class (Facade)			*/			static public function getInstance() : Facade {								if( !__instance )					__instance = new Facade( new SingletonEnforcer() );												return __instance;			}	}}internal class SingletonEnforcer{	}