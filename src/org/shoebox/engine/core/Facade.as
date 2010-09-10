/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.core {	import org.shoebox.engine.views.VPlayerArray;
	import org.shoebox.engine.models.MPlayerArray;
	import org.shoebox.apps.frakconsole.core.Frak;	import org.shoebox.engine.commands.CommandLoadAnimSet;	import org.shoebox.engine.commands.CommandMoveCam;	import org.shoebox.engine.commands.CommandOpenMap;	import org.shoebox.engine.controllers.CPlayer;	import org.shoebox.engine.core.variables.Container;	import org.shoebox.engine.core.variables.Dimension;	import org.shoebox.engine.core.variables.Position2D;	import org.shoebox.engine.core.variables.TileSize;	import org.shoebox.engine.events.MapEvent;	import org.shoebox.engine.events.WarpEvent;	import org.shoebox.engine.models.MMap;	import org.shoebox.engine.models.MParallax;	import org.shoebox.engine.models.MPlayer;	import org.shoebox.engine.views.VMapBitmap;	import org.shoebox.engine.views.VMap_Platform;	import org.shoebox.engine.views.VParallax;	import org.shoebox.engine.views.VPlayer;	import org.shoebox.events.LightSignal;	import org.shoebox.patterns.frontcontroller.FrontController;	import org.shoebox.patterns.mvc.commands.MVCCommand;	import org.shoebox.utils.display.STAGEINSTANCE;	import org.shoebox.utils.logger.Logger;	import flash.display.MovieClip;	import flash.events.Event;	import flash.events.TimerEvent;	import flash.geom.Vector3D;	import flash.utils.Timer;	/**	 * Facade of the application extending the <code>FrontController</code> class	* 	* org.shoebox.engine.core.Facade	* @author shoebox	*/	public class Facade extends FrontController{				public static const MAPRENDER				:String = 'APP_MAP_RENDERER_TWOD';		public static const MAPRENDER_PLATFORM		:String = 'APP_MAP_RENDERER_PLATFORM';		public static const APP_PARALLAX			:String = 'APP_PARALLAX';		public static const APPPLAYER				:String = 'APP_PLAYER';		public static const APPPLAYER_ARRAY			:String = 'APPPLAYER_ARRAY';		public static const APPPLAYER_HYPERFICTION		:String = 'APPPLAYER_HYPERFICTION';		public static const APPPLAYER_PLATFORM		:String = 'APP_PLAYER_PLATFORM';				public static const STATE_DEFAULT			:String = 'STATE_DEFAULT';		public static const STATE_PLATFORM			:String = 'STATE_PLATFORM';				protected static var __instance		:Facade = null;				// -------o constructor					/**			* Constructor of the Facade class			* @see <code>SingletonEnforcer</code>			*			* @param	e : singleton enforcer instance (SingletonEnforcer)			* @public			* @return	void			*/			public function Facade( e : SingletonEnforcer ) : void {				trc('constructor ::: '+e);			}		// -------o public						/**			* Running the facade			* 			* @public			* @return	void			*/			public function run() : void {				addCommand( MapEvent.LOAD_MAP , CommandOpenMap );								Keys.getInstance().ref = STAGEINSTANCE;				Keys.getInstance().execute();								//registerTriad( MAPRENDER , MMap , VMapIso );				//registerTriad( MAPRENDER , MMap , VMapQuadTree );				//registerTriad( APPPLAYER , MPlayer , VPlayer , CPlayer_Platform , Container );								registerTriad( MAPRENDER , MMap , VMapBitmap );				registerTriad( MAPRENDER_PLATFORM , MMap , VMap_Platform );				registerTriad( APP_PARALLAX , MParallax , VParallax , null );								registerTriad( APPPLAYER , MPlayer , VPlayer , CPlayer , Container );				//registerTriad( APPPLAYER_ARRAY , MPlayerArray , VPlayerArray , CPlayerArray , Container );				//registerTriad( APPPLAYER_PLATFORM, null , VPlayer , CPlayer_Platform , Container );								registerState( STATE_DEFAULT , Vector.<String>([MAPRENDER , APPPLAYER ]));				registerState( STATE_PLATFORM , Vector.<String>([ MAPRENDER_PLATFORM  ]));								//Frak debugging purpose					Frak.registerCommand('warp',_warp,'Warp to the specified mapID');						Frak.registerCommand('moveCam',_moveCam,'Move the camera to the specified tile postiion');					Frak.registerCommand('center',_center,'Move the camera to the player');					Frak.registerCommand('addLib',_addLib,'Add character library to the scene');								var oT : Timer = new Timer( 2000 , 1 );					oT.addEventListener( TimerEvent.TIMER_COMPLETE , _addLib );					oT.start();								}			/**			* addLib function			* @public			* @param 			* @return			*/			final public function addLib( o : MovieClip , c : Class = null ) : void {				trc('addLib ::: '+arguments);				var 	oCOM : MVCCommand = new MVCCommand( { 												modelClass : MPlayerArray , 												viewClass : VPlayerArray , 												controllerClass : c , 												container : Container 											} );					oCOM.execute();					with( ( oCOM.view as VPlayerArray ) ) {						run( o );						x = Position2D.x;						y = Position2D.y;					}			}										// -------o protected						/**			* 			*			* @param 			* @return			*/			final protected function _addLib( e : Event = null ) : void {				trace('_addLib');				CommandLoadAnimSet.getInstance().execute();			}						/**			* Warp command call listener and emit an <code>WarpEvent</code>			*			* @param 	uID : Map ID to go to (uint)			* @return	void			*/			protected function _warp( uID : uint ) : void {				LightSignal.getInstance().emit( WarpEvent.WARP , new WarpEvent(WarpEvent.WARP , uID , new Vector3D( 5 , 5 , 0 )));			}						/**			* 			*			* @param 			* @return			*/			final protected function _moveCam( i1 : int  = 1 , i2 : int = 1 ) : void {				trc('moveCam ::: '+i1+' /// '+i2 );				var 	oCOM : CommandMoveCam = CommandMoveCam.getInstance();					oCOM.toPosition = new Vector3D( i1 , i2 );					oCOM.execute();			}						/**			* 			*			* @param 			* @return			*/			final protected function _center() : void {								var  	vPOS : Vector3D = Position2D.clone();					vPOS.x -= Dimension.x * TileSize;					vPOS.y -= Dimension.y * TileSize;								var 	oCOM : CommandMoveCam = CommandMoveCam.getInstance();					oCOM.toPosition = vPOS;					oCOM.execute(); 			}		// -------o misc			public static function trc(...args : *) : void {				Logger.log(Facade, args);			}						/**			* Return the singleton instance of the class			* 			* @public			* @return instance of the class (Facade)			*/			static public function getInstance() : Facade {								if( !__instance )					__instance = new Facade( new SingletonEnforcer() );												return __instance;			}	}}internal class SingletonEnforcer{	}