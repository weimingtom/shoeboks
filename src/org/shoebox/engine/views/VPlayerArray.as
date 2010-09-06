/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.views {	import org.shoebox.engine.controllers.AbstractCharController;	import org.shoebox.engine.core.variables.PlayerView;	import org.shoebox.engine.core.variables.Position2D;	import org.shoebox.engine.events.PlayerEvent;	import org.shoebox.engine.models.MPlayerArray;	import org.shoebox.errors.Errors;	import org.shoebox.events.LightSignal;	import org.shoebox.patterns.commands.samples.IFrameable;	import org.shoebox.patterns.mvc.events.UpdateEvent;	import org.shoebox.patterns.mvc.interfaces.IView;	import org.shoebox.utils.logger.Logger;	import flash.display.FrameLabel;	import flash.display.MovieClip;	import flash.events.Event;	import flash.geom.Point;	/**	 * org.shoebox.engine.views.VPlayerArray	* @author shoebox	*/	public class VPlayerArray extends APlayerView implements IView , IFrameable {				protected var _mcPERSO				: MovieClip;		protected var _ptPOSITION			: Point = new Point( 400 , 600 );		protected var _toCYCLE				: uint;		protected var _vSPEEDS				: Vector.<uint>;				protected var _nSCALE				: Number = 1;				// -------o constructor					/**			* Constructor of the VSandBox class			*			* @public			* @return	void			*/			public function VPlayerArray() : void {				mouseChildren = false;			}		// -------o public						/**			* set position function			* @public			* @param 			* @return			*/			final public function set position( p : Point ) : void {				x = p.x;				y = p.y;				_ptPOSITION = p;			}						/**			* get position function			* @public			* @param 			* @return			*/			final public function get position() : Point {				return _ptPOSITION;			}						/**			* View initialization			*			* @public			* @return	void			*/			override final public function initialize() : void {				PlayerView = this;			}			/**			* When the view receive an update			* 			* @public			* @param	o : optional update event (UpdateEvent) 			* @return	void			*/			override final public function update(o:UpdateEvent = null) : void {						}												/**			* When the view is canceled			*  			* @public			* @param	e : optional cancel event (Event) 			* @return	void			*/			override final public function cancel(e:Event = null) : void {												}						/**			* show function			* @public			* @param 			* @return			*/			final public function show( i : int ) : void {				_toCYCLE = i;			}						/**			* mirror function			* @public			* @param 			* @return			*/			final public function mirror( b : Boolean = false , bValue : Boolean = false  ) : void {				if( b )					_mcPERSO.scaleX = bValue ? _nSCALE : -_nSCALE;				else					_mcPERSO.scaleX = -_mcPERSO.scaleX;			}						/**			* drawCircle function			* @public			* @param 			* @return			*/			final public function drawCircle( u : uint , r : uint ) : void {				_mcPERSO.graphics.lineStyle( .1 , u , .5 );				_mcPERSO.graphics.drawCircle( 0 , 0 , u );			}						/**			* drawCircle function			* @public			* @param 			* @return			*/			final public function drawRect( u : uint , w : uint , h : uint ) : void {				w *= 1 / _nSCALE;				h *= 1 / _nSCALE;				_mcPERSO.graphics.lineStyle( .1 , u , 1 );				_mcPERSO.graphics.drawRect( -w/2 , -h , w , h );			}						/**			* onFrame function			* @public			* @param 			* @return			*/			final public function onFrame( e : Event ) : void {				_onFrame();			}						/**			* mouseMove function			* @public			* @param 			* @return			*/			final public function mouseMove( ) : void {							}						/**			* run function			* @public			* @param 			* @return			*/			final public function run( mc : MovieClip ) : void {				_mcPERSO = mc;				_mcPERSO.addEventListener(Event.EXIT_FRAME, _onPersoFrame , false , 10 , true );							}						/**			* center function			* @public			* @param 			* @return			*/			final override public function center() : void {				if( Position2D == null )					return;								x = Position2D.x;				y = Position2D.y;			}		// -------o protected						/**			* 			*			* @param 			* @return			*/			final protected function _onPersoFrame( e : Event ) : void {								trc('_onPersoFrame');								if(_mcPERSO.cycleArray==null)					Errors.throwError('Error ::: cycleArray is not defined');								if(_mcPERSO.subCycleArray==null)					Errors.throwError('Error ::: Sub cycle is not defined');								_mcPERSO.scaleX = _mcPERSO.scaleY = _mcPERSO.nScale;				_mcPERSO.removeEventListener( Event.EXIT_FRAME , _onPersoFrame , false );								(model as MPlayerArray).cycleArray 	= _mcPERSO.cycleArray;				(model as MPlayerArray).subCycleArray 	= _mcPERSO.subCycleArray;								_nSCALE = _mcPERSO.nScale;				_compute();				show( 0 );				(controller as AbstractCharController).run();								addChild( _mcPERSO );			}						/**			* 			*			* @param 			* @return			*/			final protected function _compute() : void {				var aFRAMES : Array = _mcPERSO.currentLabels;								_vSPEEDS = new Vector.<uint>( _mcPERSO.totalFrames + 1 , true );								var i : uint = 0;				var l : uint = aFRAMES.length;				var f : FrameLabel;				var z : uint = 0;				var u : uint;				for( i ; i < l ; i++ ){										f = aFRAMES[i];					z = f.frame;					u = 0;						_mcPERSO.gotoAndStop(z);										while( true ){						if( _mcPERSO.currentFrame == _mcPERSO.totalFrames )							break;												_mcPERSO.nextFrame();														if( _mcPERSO.currentLabel !== f.name )							break;												_vSPEEDS[f.frame+u] = _mcPERSO.speed;						u++;					}										(model as MPlayerArray).addCycle( f.name , f.frame , u );				}			}						/**			* 			*			* @param 			* @return			*/			final protected function _onFrame( ) : void {				if( _vSPEEDS == null )					return;												var i : uint = (model as MPlayerArray).currentFrame;				_mcPERSO.gotoAndStop( i );								LightSignal.getInstance().emit( PlayerEvent.PLAYER_MOVE , (_mcPERSO.scaleX > 0 ) ? -_vSPEEDS[i] : _vSPEEDS[i] );							}					// -------o protected		// -------o misc			public static function trc(...args : *) : void {				Logger.log(VPlayerArray, args);			}	}}