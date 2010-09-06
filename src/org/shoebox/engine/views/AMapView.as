/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.views {	import org.shoebox.collections.Array2D;	import org.shoebox.collections.QuadTree;	import org.shoebox.engine.core.variables.Camera;	import org.shoebox.engine.core.variables.Container;	import org.shoebox.engine.core.variables.Dimension;	import org.shoebox.engine.core.variables.DisplayObjectCache;	import org.shoebox.engine.core.variables.MapDatas;	import org.shoebox.engine.core.variables.Position;	import org.shoebox.engine.core.variables.Position2D;	import org.shoebox.engine.core.variables.SpritesCache;	import org.shoebox.engine.core.variables.TileSize;	import org.shoebox.engine.datas.CameraRef;	import org.shoebox.engine.datas.TileProps;	import org.shoebox.engine.items.GridTileItem;	import org.shoebox.patterns.commands.samples.StageResize;	import org.shoebox.patterns.mvc.abstracts.AView;	import org.shoebox.utils.logger.Logger;	import flash.display.Bitmap;	import flash.display.BitmapData;	import flash.display.Graphics;	import flash.display.Sprite;	import flash.geom.Point;	import flash.geom.Rectangle;	import flash.geom.Vector3D;	/**	 * org.shoebox.engine.views.AMapView	* @author shoebox	*/	public class AMapView extends AView {				protected var _aCOLLIDABLE			:Array2D;		protected var _oMEDIA				:BitmapData;		protected var _oVIEW				:Bitmap = new Bitmap();		protected var _oMAP				:BitmapData;		protected var _oMAPHITTEST			:BitmapData;		protected var _oQUADTREE			:QuadTree;		protected var _vCHILDS				:Vector.<*>;				protected const _oPOINT			:Point = new Point( 0 , 0 );		// -------o constructor					/**			* Constructor of the AMapView class			*			* @public			* @return	void			*/			public function AMapView() : void {				//_oVIEW.alpha = .2;			}		// -------o public						/**			* init function			* @public			* @param 			* @return			*/			final public function init() : void {				Position2D = new Vector3D( Position.x * TileSize , Position.y * TileSize );				Camera = new CameraRef( 0 , 0 , Dimension.x * TileSize * 2 , Dimension.y * TileSize * 2 );				Camera.x = Position2D.x - Dimension.x * TileSize;				Camera.y = Position2D.y - Dimension.y * TileSize;								_oMEDIA = new BitmapData( Dimension.x * TileSize * 2 , Dimension.y * TileSize * 2 , true , 0 );				_oVIEW.bitmapData = _oMEDIA;			}					// -------o protected						/**			* 			*			* @param 			* @return			*/			final protected function _precache() : void {									//					_vCHILDS = new Vector.<*>();					_oMAP = new BitmapData( TileSize * MapDatas.mapWidth , TileSize * MapDatas.mapHeight , true , 0  );						_oMAPHITTEST = _oMAP.clone();						_oQUADTREE = new QuadTree( new Rectangle( 0 , 0 , TileSize * MapDatas.mapWidth , TileSize * MapDatas.mapHeight ));								//					_aCOLLIDABLE = new Array2D( MapDatas.mapWidth + 1 , MapDatas.mapHeight + 1 );					var o : Sprite = new Sprite();					var g : Graphics = o.graphics;					var v : Vector.<int>;					var z : int ;					var l : int;					_oMAPHITTEST.unlock();					for each( v in MapDatas.vPolygons ){												z = 0;						l = v.length;						g.clear();						g.beginFill( 0xFF6600 );												while( z < v.length ){							if( z == 0 )								g.moveTo( v[z] , v[z+1] );							else								g.lineTo( v[z] , v[z+1] );							z+=2;						}						g.lineTo( v[0] , v[1] );												_oMAPHITTEST.draw( o , null , null );												//_oMAPHITTEST.copyPixels( oB , oB.rect , oP , null ,null, true );					}					_oMAPHITTEST.lock();									//					var vC : Vector.<int>;					var iX : int = 0;					var iY : int = 0;					var iL : int;					var iI : int;					var oB : BitmapData;					var oT : BitmapData;					var oP : Point = new Point();					var oTILE : GridTileItem;					var oD : *;					var oDESC :TileProps;					var oR : Rectangle;					for( iX ; iX < MapDatas.mapWidth ; iX++ ){												iY = 0;												for( iY ; iY < MapDatas.mapHeight ; iY++ ){														vC = MapDatas.getContentAt( iX, iY );														iI = 0;							iL = vC.length;							for( iI ; iI < iL ; iI+=2 ){																oDESC = SpritesCache[vC[iI]]; 																if( oDESC.collidable )									_aCOLLIDABLE.setDatasAt(iX, iY, true);																if( oDESC.ground ){																		oD = DisplayObjectCache[vC[iI]];																		if( oD is BitmapData )										oB = oD as BitmapData;									else{										oB = new BitmapData( oD.width , oD.height , true , 0  );										oB.draw( oD );									}																		oP.x = iX * TileSize + oDESC.ptDecal.x;									oP.y = iY * TileSize + oDESC.ptDecal.y;									_oMAP.copyPixels( oB , oB.rect , oP , null , null , true );																		//if( oDESC.collidable )									//	_oMAPHITTEST.copyPixels( oB , oB.rect , oP , null ,null, true );																		_addStatic( oP.x , oP.y , oB.rect.width , oB.rect.height , oDESC.collidable );																	}else{									if( !oTILE ){										oTILE = new GridTileItem();										oTILE.x = iX * TileSize - oDESC.ptDecal.x;										oTILE.depth = iY*4000 + iX + 1;										oTILE.y = iY * TileSize - oDESC.ptDecal.y;									}																		oTILE.addLayer(  vC[iI], vC[iI+1] );								}							}														if( oTILE ){								Container.addChild( oTILE );								_addItemAt( oTILE , oTILE.getRect( Container ) );								Container.removeChild( oTILE );								oTILE = null; 							}						}					}								}						/**			* 			*			* @param 			* @return			*/			protected function _addItemAt( oTILE :GridTileItem , r : Rectangle ) : void {				_oQUADTREE.addItemAt( oTILE , oTILE.getRect( Container ) );			}						/**			* 			*			* @param 			* @return			*/			protected function _addStatic( x : Number , y : Number , w : Number , h : Number  , bCollidable : Boolean = false ) : void {			}						/**			* 			*			* @param 			* @return			*/ 			final protected function _update( b : Boolean = true ) : void {								var nFIXL : int = (Camera.left < 0) ? -Camera.left : 0;				var nFIXR : int = Math.max( Camera.right - _oMAP.width , 0 );				var nFIXT : int = ( Camera.top < 0 ) ? -Camera.top : 0;				var nFIXB : int = Math.max( Camera.bottom - _oMAP.height , 0 );								var 	oREC : Rectangle = Camera.clone();					oREC.x = oREC.x - nFIXR + nFIXL;					oREC.y = oREC.y - nFIXB + nFIXT;									_oMEDIA.copyPixels( _oMAP , oREC , _oPOINT );								//					Container.x = -(Camera.x + Camera.width / 2) + StageResize.rect.width / 2 + nFIXR - nFIXL;					Container.y = -(Camera.y + Camera.height / 2) + StageResize.rect.height / 2 + nFIXB - nFIXT;								_oVIEW.x = Camera.left - nFIXR + nFIXL;				_oVIEW.y = Camera.top - nFIXB + nFIXT;				if( !b )					_treeTest( oREC );			}						/**			* 			*			* @param 			* @return			*/			final protected function _treeTest( r : Rectangle ) : void {								if( r.right > _oMAP.width )					r.width -= (r.right - _oMAP.width );								if( r.bottom > _oMAP.height )					r.height -= (r.bottom - _oMAP.height );								var v : Vector.<*> = _oQUADTREE.getRectContent( r );								for each( o in _vCHILDS ){										if( v.indexOf(o)==-1)						Container.removeChild( o );									}								var o : Sprite;				for each( o in v )					if( !Container.contains(o) )						Container.addChild( o );								_vCHILDS = v;				v = null;						}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(AMapView, args);			}	}}