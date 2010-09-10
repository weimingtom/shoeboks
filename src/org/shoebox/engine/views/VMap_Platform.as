/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.views {	import org.shoebox.biskwy.utils.Transformer;	import org.shoebox.collections.QuadTree;	import org.shoebox.engine.core.BitmapDataHitTest;	import org.shoebox.engine.core.variables.Camera;	import org.shoebox.engine.core.variables.Container;	import org.shoebox.engine.core.variables.Dimension;	import org.shoebox.engine.core.variables.Forces;	import org.shoebox.engine.core.variables.Gravity;	import org.shoebox.engine.core.variables.Grounded;	import org.shoebox.engine.core.variables.MapDatas;	import org.shoebox.engine.core.variables.PlayerSize;	import org.shoebox.engine.core.variables.PlayerView;	import org.shoebox.engine.core.variables.Position;	import org.shoebox.engine.core.variables.Position2D;	import org.shoebox.engine.core.variables.TileSize;	import org.shoebox.engine.core.variables.Velocity;	import org.shoebox.engine.events.PlayerEvent;	import org.shoebox.events.LightSignal;	import org.shoebox.patterns.mvc.events.UpdateEvent;	import org.shoebox.patterns.mvc.interfaces.IView;	import org.shoebox.utils.PerfectTimer;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	import flash.geom.Point;	import flash.geom.Rectangle;	import flash.geom.Vector3D;	/**	 * org.shoebox.engine.views.VMap_Platform	* @author shoebox	*/	public class VMap_Platform extends AMapView implements IView {				protected const uFPS			: uint = 48;				protected var _oTEST			: BitmapDataHitTest;		protected var _bJUMPING		: Boolean;		protected var _vTMP			: Point = new Point();		protected var _oTREESTATIC		: QuadTree;		protected var _vCENTER			: Vector3D;		protected var _oTIMER			: PerfectTimer;		protected var _nT			: Number = 0;		protected var _oREC_BOTTOM		: Rectangle;				protected const POINT			: Point = new Point();						// -------o constructor					/**			* Constructor of the VMap_Platform class			*			* @public			* @return	void			*/			public function VMap_Platform() : void {			}		// -------o public						/**			* initialize function			* @public			* @param 			* @return			*/			override final public function initialize() : void {				trc('initialize');				Container.addChildAt( _oVIEW  , 0 );							}						/**			* update function			* @public			* @param 			* @return			*/			override final public function update(o:UpdateEvent = null) : void {				_oTREESTATIC = new QuadTree( new Rectangle( 0, 0, MapDatas.mapWidth * TileSize , MapDatas.mapHeight * TileSize ));				_precache();				init();				_init();							}												/**			* cancel function			* @public			* @param 			* @return			*/			override final public function cancel(e:Event = null) : void {												}				// -------o protected						/**			* 			*			* @param 			* @return			*/			final override protected function _addStatic( x : Number , y : Number , w : Number , h : Number  , bCollidable : Boolean = false ) : void {								var r : Rectangle = new Rectangle( x , y , w , h ); 								if( bCollidable )					_oTREESTATIC.addItemAt( r , r );			}						/**			* 			*			* @param 			* @return			*/			final protected function _init() : void {												LightSignal.getInstance().connect( PlayerEvent.PLAYER_MOVE , _onMove );				_oTEST = new BitmapDataHitTest( _oMAPHITTEST.clone() , PlayerView );				_update();							}						/**			* 			*			* @param 			* @return			*/			final protected function _onMove( ) : void {								//					if( PlayerView == null )						return;									//trace(Forces.y);									//					if( Forces.y < 0 && Velocity.y !== 0 || !Grounded)						Forces.y = 0;										//					var 	vTMP : Vector3D = Velocity.clone();						vTMP.incrementBy( Forces );						vTMP.y += Gravity;								//					var 	vWLD : Vector3D = Transformer.worldToScreen(Position2D.clone().add(vTMP));						vWLD.x = Math.floor( vWLD.x );						vWLD.y = Math.floor( vWLD.y );									if( vWLD.x < 0 || vWLD.y < 0 || vWLD.x > MapDatas.mapWidth || vWLD.y > MapDatas.mapHeight ){						Position2D = new Vector3D( 12 * TileSize, 20 * TileSize );						Position.x = Position.y = 20;						Camera.x = Position2D.x - Dimension.x * TileSize;						Camera.y = Position2D.y - Dimension.y * TileSize;						vTMP.x = vTMP.y = 0;						return;					}								Container.graphics.clear();				Container.graphics.lineStyle( .1 , 0xFFFFFF );								// Left - right					var oREC : Rectangle;					if( vTMP.x ){												oREC = PlayerSize.clone();						oREC.offset( Position2D.x + vTMP.x , Position2D.y + vTMP.y );						oREC.height -= 5;												if( vTMP.x < 0 ){														oREC.width = 10;							oREC.x -= 10;														if( _oMAPHITTEST.hitTest( POINT , 0x01 , oREC ) )								vTMP.x = 0;																												}else if( vTMP.x > 0 ){														oREC.x = oREC.right;							oREC.width = 10;														if( _oMAPHITTEST.hitTest( POINT , 0x01 , oREC ))								vTMP.x = 0;															//Container.graphics.drawRect( oREC.x , oREC.y , oREC.width , oREC.height );													}																	}								// Bottom					oREC = PlayerSize.clone();					oREC.offset( Position2D.x + vTMP.x , Position2D.y + oREC.height + vTMP.y -20 );					oREC.height = 20;															//Container.graphics.drawRect( oREC.x , oREC.y , oREC.width , oREC.height );										Grounded = _oMAPHITTEST.hitTest( POINT , 0x01 , oREC );					if( Grounded && vTMP.y > 0 )						vTMP.y = 0;										// Top					if( vTMP.y < 0 ){						oREC = PlayerSize.clone();						oREC.offset( Position2D.x + vTMP.x , Position2D.y + vTMP.y );						oREC.height = 20;						//Container.graphics.drawRect( oREC.x , oREC.y , oREC.width , oREC.height );						if( _oMAPHITTEST.hitTest( POINT , 0x01 , oREC ))							vTMP.y = 0;					}									//														Camera.offset( vTMP.x , vTMP.y );				Position2D.incrementBy( vTMP);				vTMP.x = 0;				Velocity = vTMP;				MapDatas.testSounds( Position2D );				_update( vWLD == Position );				Position = vWLD;				PlayerView.center();							}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(VMap_Platform, args);			}	}}