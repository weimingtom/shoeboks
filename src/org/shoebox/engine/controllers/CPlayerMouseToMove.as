/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.controllers {	import org.shoebox.apps.frakconsole.core.Frak;	import org.shoebox.core.BoxMath;	import org.shoebox.engine.events.PlayerEvent;	import org.shoebox.engine.views.VPlayer;	import org.shoebox.events.LightSignal;	import org.shoebox.patterns.mvc.abstracts.AController;	import org.shoebox.patterns.mvc.interfaces.IController;	import org.shoebox.utils.display.STAGEINSTANCE;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.geom.Vector3D;	/**	 * org.shoebox.engine.controllers.CPlayerMouseToMove	* @author shoebox	*/	public class CPlayerMouseToMove extends AController implements IController {				public var freq			:uint = 30;				protected var _bMOVING		:Boolean = false;		protected var _nANGLE		:Number;		protected var _oEVENT		:PlayerEvent = new PlayerEvent( PlayerEvent.PLAYER_MOVE );				protected const _vMOVES		:Vector.<Vector3D> = Vector.<Vector3D>([														new Vector3D( 0 , -1 , 0 ), 	//T														new Vector3D( +1 , -1 , 0 ),	//TR														new Vector3D( +1 , 0 , 0 ),	//R														new Vector3D( +1 , +1 , 0 ),	//BR														new Vector3D( 0 , +1 , 0 ),	//B														new Vector3D( -1 , +1 , 0 ),	//BL														new Vector3D( -1 , 0 , 0 ),	//L														new Vector3D( -1 , -1 , 0 ),	//TL														]);																protected const _uSPEED		:uint = 10;		protected const _vCENTER	:Vector3D = new Vector3D();		protected const _vMOUSE		:Vector3D = new Vector3D();				// -------o constructor					/**			* Constructor of the CPlayerMouseToMove class			*			* @public			* @return	void			*/			public function CPlayerMouseToMove() : void {				//Frak.registerVar('freq', this);			}		// -------o public						/**			* When the controller is initialized			* 			* @public			* @return	void			*/			final override public function initialize() : void {				( view as VPlayer ).draw( 'static' );				_oEVENT.moveVector = new Vector3D( 0 , 0 );				STAGEINSTANCE.addEventListener( MouseEvent.MOUSE_DOWN , _onMouse , false , 10 , true );			}			/**			* When the controller receive an event 			* 			* @public			* @param	e : received event (Event) 			* @return	void			*/			final override public function onEvent( e : Event ) : void {						}						/**			* When the controller is canceled			* 			* @public			* @param	e : optional cancel event (Event) 			* @return	void			*/			final override public function cancel( e : Event = null ) : void {							}								// -------o protected						/**			* 			*			* @param 			* @return			*/			final protected function _onMouse( e : MouseEvent ) : void {								switch( e.type ){										case MouseEvent.MOUSE_UP:						( view as VPlayer ).draw( 'static' );						STAGEINSTANCE.removeEventListener( MouseEvent.MOUSE_UP, _onMouse , false );						STAGEINSTANCE.removeEventListener( MouseEvent.MOUSE_MOVE , _onMouse , false );						LightSignal.getInstance().disconnect(Event.ENTER_FRAME , _onFrame);						break;										case MouseEvent.MOUSE_DOWN:						_onMove();						STAGEINSTANCE.addEventListener( MouseEvent.MOUSE_MOVE , _onMouse , false , 10 , true );						STAGEINSTANCE.addEventListener( MouseEvent.MOUSE_UP, _onMouse , false , 10 , true );						LightSignal.getInstance().connect(Event.ENTER_FRAME , _onFrame);						break;											case MouseEvent.MOUSE_MOVE:						_onMove();						break;									}							}						/**			* 			*			* @param 			* @return			*/			final protected function _onMove() : void {								//					_vMOUSE.x = view.mouseX; 					_vMOUSE.y = view.mouseY;									//				if( Vector3D.distance( _vCENTER , _vMOUSE ) > 50 ){										_nANGLE = BoxMath.vector3DtoAngle(_vMOUSE)+90;					if( _nANGLE < 0 )						_nANGLE = 360 + _nANGLE;						_nANGLE = Math.round(_nANGLE / 45);					if( _nANGLE > 7 )						_nANGLE = 0;											( view as VPlayer ).dir =_nANGLE;						( view as VPlayer ).draw( 'walk' );										_oEVENT.moveVector = _vMOVES[_nANGLE].clone();					_oEVENT.moveVector.scaleBy( 10 );									}else{					_oEVENT.moveVector.x = _oEVENT.moveVector.y = 0;					_bMOVING = false;					( view as VPlayer ).draw( 'static' );				}								( view as VPlayer ).center();			}						/**			* 			*			* @param 			* @return			*/			final protected function _onFrame() : void {				LightSignal.getInstance().emit( PlayerEvent.PLAYER_MOVE , _oEVENT );				( view as VPlayer ).center();				}		// -------o misc			public static function trc(...args : *) : void {				Logger.log(CPlayerMouseToMove, args);			}	}}