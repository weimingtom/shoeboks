/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.views {	import org.shoebox.engine.core.variables.Position2D;
	import flash.utils.Dictionary;
	import org.shoebox.biskwy.utils.IsoTransform;	import org.shoebox.biskwy.utils.Transformer;	import org.shoebox.engine.core.variables.PlayerView;	import org.shoebox.engine.core.variables.Position;	import org.shoebox.engine.core.variables.TileSize;	import org.shoebox.engine.interfaces.IZSortable;	import org.shoebox.events.LightSignal;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.patterns.mvc.abstracts.AView;	import org.shoebox.patterns.mvc.events.UpdateEvent;	import org.shoebox.patterns.mvc.interfaces.IView;	import org.shoebox.utils.logger.Logger;	import flash.display.Bitmap;	import flash.display.BitmapData;	import flash.display.MovieClip;	import flash.events.Event;	import flash.geom.Matrix;	import flash.geom.Rectangle;	import flash.geom.Vector3D;	/**	 * org.shoebox.engine.views.VPlayer	* @author shoebox	*/	public class VPlayer extends AView implements IView , IZSortable {				protected var _oBITMAP			:Bitmap = new Bitmap();				protected var _uFRAME			:uint = 0;		protected var _uDIR			:uint = 0;		protected var _sCYCLE			:String = 'static';		protected var _dCYCLES			:Dictionary = new Dictionary( true );				// -------o constructor					/**			* Constructor of the VPlayer class			*			* @public			* @return	void			*/			public function VPlayer() : void {			}		// -------o public												/**			* View initialization			* 			* @public			* @return void			*/			final override public function initialize() : void {								_caching();				gizmo();				PlayerView = this;				addChild( _oBITMAP );							}						/**			* When the view receive an event 			* 			* @public			* @param	o : optional update event (UpdateEvent) 			* @return	void			*/			final override public function update(o:UpdateEvent = null) : void {						}									/**			* When the view is canceled			* 			* @public			* @param	e : opntional cancel event (Event) 			* @return	void			*/			final override public function cancel(e:Event = null) : void {									}						/**			* gizmo function			* @public			* @param 			* @return			*/			public function gizmo() : void {				graphics.lineStyle( 1 ,0xFF6600 );				graphics.moveTo( -10 , 0 );				graphics.lineTo( +10 , 0 );				graphics.moveTo( 0 , -10 );				graphics.lineTo( 0 , +10 );			}						/**			* center function			* @public			* @param 			* @return			*/			public function center() : void {				if( Position2D == null )					return;								x = Position2D.x;				y = Position2D.y;			}			/**			* get depth function			* @public			* @param 			* @return			*/			public function get depth() : uint {				return Position.y * 4000 + Position.x + 10;			}						/**			* set depth function			* @public			* @param 			* @return			*/			public function set depth( u : uint ) : void {						}						/**			* draw function			* @public			* @param 			* @return			*/			final public function draw( s : String = 'static ') : void {								if( _sCYCLE == s )					return;								_uFRAME = 0;				_sCYCLE = s;			}						/**			* set dir function			* @public			* @param 			* @return			*/			final public function set dir( u : int ) : void {				_uDIR = u;			}		// -------o protected					/**			* 			*			* @param 			* @return			*/			final protected function _caching() : void {								var aCYCLES : Vector.<String> = Vector.<String>(['static','walk']);								var s : String;				for each( s in aCYCLES ) 					_cacheCycle( s );								LightSignal.getInstance().connect(Event.ENTER_FRAME , _onFrame );			}						/**			* 			*			* @param 			* @return			*/			final protected function _cacheCycle( s : String ) : void {								_dCYCLES[s] = new Vector.<Vector.<BitmapData>>( 8 , true );				var oREF : MovieClip;				var oBMP : BitmapData;				var oREC : Rectangle;				var oMAT : Matrix = new Matrix();				var uSCL : uint = 2;				var i : uint  = 0 , z : uint , l : uint , p:uint;								for( i ; i < 8 ; i++ ){										if( i==1 || i==5 || i==6 )						continue;										oREF = Factory.build(s+''+i) as MovieClip;										_dCYCLES[s][i] = new Vector.<BitmapData>();					l = oREF.totalFrames;					z = 0;					for( z ; z <= l ; z++ ){												oREF.gotoAndStop( z + 1 );						oREC = oREF.getRect( stage );												oMAT.identity();						oMAT.tx = -oREC.x; 						oMAT.ty = -oREC.y;						oMAT.scale( uSCL , uSCL );						oBMP = new BitmapData( oREF.width * uSCL , oREF.height * uSCL  , true , 0xFF6600 );						oBMP.draw( oREF , oMAT , null , null , null );						oBMP.lock();						_dCYCLES[s][i].push( oBMP );					}									}							}			/**			* 			*			* @param 			* @return			*/			final protected function _onFrame() : void {								var iDIR : int = _uDIR;				if( iDIR == 1 )					iDIR = 7;				else if( iDIR == 5 )					iDIR = 3;				else if( iDIR == 6 )					iDIR = 2;								_oBITMAP.scaleX = ( _uDIR == 5 || _uDIR == 6 || _uDIR == 1 ) ? -1 : 1;								_uFRAME++;								if( _uFRAME >= _dCYCLES[_sCYCLE][iDIR].length )					_uFRAME = 0;								if(_oBITMAP.bitmapData)					_oBITMAP.bitmapData.dispose();						_oBITMAP.bitmapData = (_dCYCLES[_sCYCLE][iDIR][_uFRAME] as BitmapData).clone();					_oBITMAP.x = ( _uDIR == 5 || _uDIR == 6 || _uDIR == 1 ) ? _oBITMAP.width / 2 : -_oBITMAP.width / 2 ;					_oBITMAP.y = -_oBITMAP.height + 15;											}		// -------o misc			public static function trc(...args : *) : void {				Logger.log(VPlayer, args);			}	}}