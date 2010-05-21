/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.controllers {	import org.shoebox.apps.frakconsole.core.Frak;	import org.shoebox.engine.events.PlayerEvent;	import org.shoebox.engine.views.VPlayer;	import org.shoebox.events.LightSignal;	import org.shoebox.patterns.commands.samples.IFrameable;	import org.shoebox.patterns.mvc.abstracts.AController;	import org.shoebox.patterns.mvc.interfaces.IController;	import org.shoebox.utils.display.STAGEINSTANCE;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	import flash.events.KeyboardEvent;	import flash.geom.Vector3D;	import flash.ui.Keyboard;	import flash.utils.Timer;	import flash.utils.getTimer;	/**	 * org.shoebox.engine.controllers.CPlayer	* @author shoebox	*/	public class CPlayer extends AController implements IController {				public var freq			:uint = 30;				protected var _oTIMER		:Timer = new Timer( 1000 , -1);		protected var _bLEFT		:Boolean = false;		protected var _bRIGHT		:Boolean = false;		protected var _bUP			:Boolean = false;		protected var _bDOWN		:Boolean = false;		protected var _nELAPSED		:uint = 0;		protected var _nTIMER		:uint = 0;		protected var _uSPEED		:uint = 10;				// -------o constructor					/**			* Constructor of the CPlayer class			*			* @public			* @return	void			*/			public function CPlayer() : void {				Frak.registerVar('freq', this);			}		// -------o public						/**			* When the controller is initialized			* 			* @public			* @return	void			*/			final override public function initialize() : void {				STAGEINSTANCE.addEventListener( KeyboardEvent.KEY_DOWN , _onKey , false , 10 , true );				STAGEINSTANCE.addEventListener( KeyboardEvent.KEY_UP , _onKey , false , 10 , true );				LightSignal.getInstance().connect(Event.ENTER_FRAME , onFrame);				Frak.registerVar('speed',this);			}			/**			* When the controller receive an event 			* 			* @public			* @param	e : received event (Event) 			* @return	void			*/			final override public function onEvent( e : Event ) : void {						}						/**			* When the controller is canceled			* 			* @public			* @param	e : optional cancel event (Event) 			* @return	void			*/			final override public function cancel( e : Event = null ) : void {				STAGEINSTANCE.removeEventListener( KeyboardEvent.KEY_DOWN , _onKey , false );				STAGEINSTANCE.removeEventListener( KeyboardEvent.KEY_UP , _onKey , false );				LightSignal.getInstance().disconnect(Event.ENTER_FRAME , onFrame);			}						/**			* onFrame function			* @public			* @param 			* @return			*/			public function onFrame() : void {								 _nTIMER = getTimer();                                                if( (_nTIMER - freq) < _nELAPSED )                        	return;                        else                        	 _nELAPSED = _nTIMER;								if( _bUP || _bDOWN || _bLEFT || _bRIGHT ){						var	vMOVE : Vector3D = new Vector3D();									if( _bUP )						vMOVE.y += _uSPEED;										if( _bDOWN )						vMOVE.y -= _uSPEED;											if( _bLEFT )						vMOVE.x += _uSPEED;											if( _bRIGHT )						vMOVE.x -= _uSPEED;										var 	oEVENT : PlayerEvent = new PlayerEvent( PlayerEvent.PLAYER_MOVE );						oEVENT.moveVector = vMOVE;										//EventCentral.getInstance().dispatchEvent( oEVENT );					LightSignal.getInstance().emit( PlayerEvent.PLAYER_MOVE , oEVENT );					( view as VPlayer ).center();				}			}						/**			* Setter of the walk speed			* 			* @public			* @param	u : walk speed (uint) 			* @return	void			*/			public function set speed( u : uint ) : void {				_uSPEED = u;			}						/**			* Getter of the walk speed			* 			* @public			* @return	walk speed (uint)			*/			public function get speed() : uint {				return _uSPEED;			}		// -------o protected						/**			* When a key is pressed			*			* @param 	e : key board event (KeyboardEvent)			* @return	void			*/			protected function _onKey( e : KeyboardEvent ) : void {								var v : Vector3D = new Vector3D();				var b : Boolean = (e.type == KeyboardEvent.KEY_DOWN );				switch( e.keyCode ){										case Keyboard.LEFT:						_bLEFT = b;						break;										case Keyboard.RIGHT:						_bRIGHT = b;						break;											case Keyboard.UP:						_bUP = b;						break;											case Keyboard.DOWN:						_bDOWN = b;						break;									}															}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(CPlayer, args);			}	}}