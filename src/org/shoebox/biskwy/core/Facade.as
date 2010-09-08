/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.core {	import flash.events.NativeWindowDisplayStateEvent;
	import org.shoebox.biskwy.apps.AppTools;	import org.shoebox.biskwy.commands.*;	import org.shoebox.biskwy.commands.actor.CommandEditSound;	import org.shoebox.biskwy.commands.map.CommandBehavior;	import org.shoebox.biskwy.commands.menu.*;	import org.shoebox.biskwy.commands.nevermind.CommandNewScript;	import org.shoebox.biskwy.commands.tiles.*;	import org.shoebox.biskwy.controllers.*;	import org.shoebox.biskwy.core.variables.PolyContainer;	import org.shoebox.biskwy.events.*;	import org.shoebox.biskwy.items.ErrorContent;	import org.shoebox.biskwy.models.*;	import org.shoebox.biskwy.views.*;	import org.shoebox.biskwy.views.maps.*;	import org.shoebox.libs.pimpmyair.behaviors.ZWindow;	import org.shoebox.libs.pimpmyair.utils.NativeWindowUtils;	import org.shoebox.patterns.commands.events.CommandEvents;	import org.shoebox.patterns.commands.samples.StageResize;	import org.shoebox.patterns.frontcontroller.FrontController;	import org.shoebox.utils.logger.Logger;	import flash.display.NativeMenuItem;	import flash.display.NativeWindow;	import flash.display.NativeWindowInitOptions;	import flash.display.NativeWindowSystemChrome;	import flash.display.NativeWindowType;	import flash.display.Sprite;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.events.Event;	import flash.geom.Point;	/**	 * org.shoebox.biskwy.core.Facade	* @author shoebox	*/	public class Facade extends FrontController {				public static const APP_ASSETS			: String = 'APP_ASSETS';		public static const APP_NEWGROUP		: String = 'APP_NEWGROUP';		public static const APP_MAPS			: String = 'APP_MAPS';		public static const APP_WELCOME			: String = 'APP_WELCOME';		public static const APP_TILES			: String = 'APP_TILES';		public static const APP_MAP_ISO			: String = 'APP_MAP_ISO';		public static const APP_MAP_TWOD		: String = 'APP_MAP_TWOD';		public static const APP_TILE_CONTENT		: String = 'APP_TILE_CONTENT';		public static const APP_TOOLS_PROPS		: String = 'APP_TOOLS_PROPS';		public static const APP_INTERACTIONS		: String = 'APP_INTERACTIONS';				public static const STATE_WELCOME		: String = 'STATE_WELCOME';		public static const STATE_PROJECT2D		: String = 'STATE_PROJECT2D';		public static const STATE_PROJECTISO		: String = 'STATE_PROJECTISO';		public static const STATE_GROUPEDIT		: String = 'STATE_GROUPEDIT';				protected var _oASSETS					: NativeWindow;		protected var _oTOOLS					: NativeWindow;		protected var _oGROUP					: NativeWindow;		protected var _spFREEZE				: Sprite;		protected var _uFPS					: uint;				static protected var __instance			:Facade = null;				// -------o constructor					public function Facade( e : SingletonEnforcer ) : void {				super();			}		// -------o public						/**			* set windowTitle function			* @public			* @param 			* @return			*/			static public function set windowTitle( s : String ) : void {				getInstance().owner.stage.nativeWindow.title = 'Biskwy ::: '+s;			}						/**			* Freezing the stage			* 			* @public			* @return void			*/			public function freeze() : void {				_spFREEZE.width = StageResize.rect.width;				_spFREEZE.height = StageResize.rect.height;				owner.addChild(_spFREEZE);					_uFPS = owner.stage.frameRate;				owner.stage.frameRate = 10;			}						/**			* Unfreezing the stage			* 			* @public			* @return void			*/
			public function unfreeze() : void {
				owner.stage.frameRate = _uFPS;					if(_spFREEZE)					if(owner.contains(_spFREEZE))						owner.removeChild(_spFREEZE);			}						/**			* Initialization of the Application facade			* @public			* @return void			*/			public function init() : void {								//					//registerTriad( APP_TILE_CONTENT , MTileContent , VTileContent , CTileContent); 					//registerTriad( APP_MAPS 	  , MMaps , VMaps , CMaps );					registerTriad( APP_WELCOME 	 	, null , VWelcome , GenericController );					registerTriad( APP_TILES 	  	, TilesModel , TilesView , TilesController );					registerTriad( APP_MAP_ISO	 	, MapModel , IsoMap , MapController); 					registerTriad( APP_MAP_TWOD	  	, MapModel , MapTwoD , MapController); 					registerTriad( APP_TOOLS_PROPS  	, MToolProperty , VToolProperty , CToolProperty); 					registerTriad( APP_INTERACTIONS 	, MInteractivity , VInteractivity , null);					registerTriad( APP_NEWGROUP	 	, MNewGroup , VNewGroup , CNewGroup);										//					registerState( STATE_WELCOME , Vector.<String>([ APP_WELCOME ]));										registerState( STATE_PROJECT2D , Vector.<String>([ 															APP_MAP_TWOD , 														APP_TILES , 														APP_TOOLS_PROPS , 														APP_INTERACTIONS													]));																		registerState( STATE_PROJECTISO , Vector.<String>([ 															APP_MAP_ISO, 														APP_TILES , 														APP_TOOLS_PROPS ,														APP_INTERACTIONS													]));									//					_spFREEZE = new Sprite();					_spFREEZE.graphics.beginFill( 0x000000 , .6 );					_spFREEZE.graphics.drawRect( 0 , 0 , 200 , 200);					_spFREEZE.graphics.endFill();					_spFREEZE.buttonMode = true;					_spFREEZE.useHandCursor = false;									//					_openTools();						_events();					Menu.getInstance().addEventListener(Event.SELECT , _onMenuSelection , false , 10 , true );									//					addCommand(TileEvent.EDIT		, CommandEditTile);					addCommand(TileEvent.DELETE		, CommandDelTile);					addCommand(TriggerEvent.EDIT 	, CommandNewScript );					addCommand(SoundEvent.EDIT 		, CommandEditSound );					addCommand(GridTileEvent.GRIDTILE_EDIT, CommandBehavior);
					addCommand(GroupEvent.EDIT		, CommandGroupEdit);
										addCommand( Menu.ABOUT_UPDATE	, CommandUpdater );							addCommand( Menu.PROJECT_NEW	, CommandNewProject );					addCommand( Menu.PROJECT_OPEN	, CommandOpenProject );					addCommand( Menu.PROJECT_CLOSE	, CommandCloseProject );					addCommand( Menu.COMPILE_TEST	, CommandTest );					addCommand( Menu.MAP_NEW		, CommandNewMap );					addCommand( Menu.MAP_OPEN		, CommandOpenMap );					addCommand( Menu.ABOUT_ABOUT	, AboutCommand );					addCommand( Menu.NEVERMIND_NEW	, CommandNewScript );					addCommand( Menu.MAP_EDIT		, CommandEditMap ); 					addCommand( Menu.VIEW_ASSETS	, CommandAssetsManager );			}			/**			* error function			* @public			* @param 			* @return void			*/			public function error( sTITLE : String , sTEXT : String ) : void {				trc('error ::: '+arguments);								//					var	oOPT:NativeWindowInitOptions = new NativeWindowInitOptions();						oOPT.resizable = oOPT.maximizable = oOPT.minimizable =  false;						oOPT.systemChrome = NativeWindowSystemChrome.STANDARD;						oOPT.type = NativeWindowType.NORMAL;																//					var	oERROR : NativeWindow = new NativeWindow( oOPT );						oERROR.title = sTITLE;						oERROR.width = 300;						oERROR.height = 150;						oERROR.activate();						oERROR.alwaysInFront = true;						oERROR.stage.scaleMode = StageScaleMode.NO_SCALE;						oERROR.stage.align = StageAlign.TOP_LEFT;						oERROR.stage.addChild( new ErrorContent( sTITLE , sTEXT ));										NativeWindowUtils.resizeWindow(oERROR,300,150);				//ZWindow.getInstance().register( oERROR , 5000000000 );			}		// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _events() : void {				CommandNewProject.getInstance().addEventListener(CommandEvents.COMPLETE , _onProject , false , 10 , true);				CommandOpenProject.getInstance().addEventListener(CommandEvents.COMPLETE , _onProject , false , 10 , true);				CommandOpenLastProject.getInstance().addEventListener(CommandEvents.COMPLETE , _onProject , false , 10 , true);				CommandCloseProject.getInstance().addEventListener(CommandEvents.COMPLETE , _onClosedProject , false , 10 , true);			}						/**			* When a project is opened			*			* @param 	e : CommandEvents			* @return	void			*/			protected function _onProject( e : CommandEvents) : void {				Menu.getInstance().activate();				state = (Config.GRIDTYPE) == IsoGrid ? STATE_PROJECTISO : STATE_PROJECT2D;			}			/**			* When a project is closed			*			* @param 	e : CommandEvents			* @return	void			*/			protected function _onClosedProject( e : CommandEvents ) : void {				state = STATE_WELCOME;			}						/**			* Open the tools windows and adding the content in it 			*			* @return void			*/			protected function _openTools() : void {				trc('_openTools');				//					var	oOPT:NativeWindowInitOptions = new NativeWindowInitOptions();						oOPT.resizable = oOPT.maximizable = oOPT.minimizable =  false;						oOPT.systemChrome = NativeWindowSystemChrome.ALTERNATE;						oOPT.type = NativeWindowType.UTILITY;								//					_oTOOLS = new NativeWindow( oOPT );					_oTOOLS.addEventListener( Event.CLOSE , _onClosedTools , false , 10 , true );					_oTOOLS.title = 'Tools';					_oTOOLS.alwaysInFront = true;					_oTOOLS.stage.addChild(new AppTools());					_oTOOLS.stage.scaleMode = StageScaleMode.NO_SCALE;					_oTOOLS.stage.align = StageAlign.TOP_LEFT;					_oTOOLS.visible = false;					_oTOOLS.activate();					_oTOOLS.stage.stageWidth = 100;					_oTOOLS.stage.stageHeight = 205;								}									/**			* When the tools windows is closed			*			* @param 	e : Event.CLOSE (Event)			* @return	void			*/			protected function _onClosedTools( e : Event ) : void {				Menu.getInstance().toolState = false;				_oTOOLS = null;			}						/**			* When an item is selected in to the menu 			*			* @param 	e : selection event (Event)			* @return	void			*/			protected function _onMenuSelection( e : Event ) : void {								if(!(e.target is NativeMenuItem))					return;								var oITEM : NativeMenuItem = e.target as NativeMenuItem;								//					if( oITEM.label == Menu.VIEW_TOOLS ) {						oITEM.checked = !oITEM.checked;						if(_oTOOLS){							_oTOOLS.close();							_oTOOLS = null;						}else							_openTools();					}								//					if( oITEM.label == Menu.VIEW_GRID ){											}								//					if( oITEM.label == Menu.VIEW_POLY ) {						oITEM.checked = !oITEM.checked;						PolyContainer.visible = oITEM.checked;					}			}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(Facade, args);			}						/**			* Return the singleton instance of the class			* @public			* @return instance of the class (Facade)			*/			static public function getInstance() : Facade {								if( !__instance )					__instance = new Facade( new SingletonEnforcer() );												return __instance;			}	}}internal class SingletonEnforcer{	}