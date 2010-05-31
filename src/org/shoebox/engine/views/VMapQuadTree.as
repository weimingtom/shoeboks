/**
  HomeMade by shoe[box]
 
  Redistribution and use in source and binary forms, with or without 
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the 
    documentation and/or other materials provided with the distribution.
  
  * Neither the name of shoe[box] nor the names of its 
    contributors may be used to endorse or promote products derived from 
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

package org.shoebox.engine.views {
	import org.shoebox.biskwy.utils.Transformer;
	import org.shoebox.collections.Array2D;
	import org.shoebox.collections.QuadTree;
	import org.shoebox.core.BoxObject;
	import org.shoebox.engine.core.variables.Camera;
	import org.shoebox.engine.core.variables.Container;
	import org.shoebox.engine.core.variables.Dimension;
	import org.shoebox.engine.core.variables.MapDatas;
	import org.shoebox.engine.core.variables.PlayerView;
	import org.shoebox.engine.core.variables.Position;
	import org.shoebox.engine.core.variables.Position2D;
	import org.shoebox.engine.core.variables.TileSize;
	import org.shoebox.engine.events.PlayerEvent;
	import org.shoebox.engine.interfaces.IZSortable;
	import org.shoebox.engine.items.GridTileItem;
	import org.shoebox.events.LightSignal;
	import org.shoebox.patterns.commands.samples.StageResize;
	import org.shoebox.patterns.mvc.abstracts.AView;
	import org.shoebox.patterns.mvc.events.UpdateEvent;
	import org.shoebox.patterns.mvc.interfaces.IView;
	import org.shoebox.utils.logger.Logger;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;

	/**
	 * org.shoebox.engine.views.VMap
	* @author shoebox
	*/
	public class VMapQuadTree extends AView implements IView {
		
		protected var _oTREE		:QuadTree;
		protected var _aCONTENT		:Array2D;
		protected var _vPOSISO		:Vector3D;
		protected var _oINNERREC	:Rectangle;
		protected var _vTILES		:Vector.<*>;
		
		// -------o constructor
		
			/**
			* Constructor of the VMap class
			*
			* @public
			* @return	void
			*/
			public function VMapQuadTree() : void {
			}

		// -------o public
			
			/**
			* initialize function
			* @public
			* @param 
			* @return
			*/
			override final public function initialize() : void {
				_vTILES = new Vector.<*>();
			}
			
			/**
			* update function
			* @public
			* @param 
			* @return
			*/
			override final public function update(o:UpdateEvent = null) : void {
				
				_oINNERREC = new Rectangle( 
									Dimension.x , Dimension.y , 
									MapDatas.mapWidth - Dimension.x*2 , MapDatas.mapHeight - Dimension.y * 2 
								);
				
				Camera = new Rectangle( 
									Position.x - Dimension.x,
									Position.y - Dimension.y, 
									Dimension.x * 2, 
									Dimension.y * 2
								);
			
				if( Camera.x < 0 )
					Camera.x = 0;
				
				if( Camera.y < 0 )
					Camera.y = 0;
			
				Position2D = Transformer.screenToWorld( Position ); 
				
				_fill();
				_redraw();
				LightSignal.getInstance().connect( PlayerEvent.PLAYER_MOVE , _onMove );
			}

			/**
			* cancel function
			* @public
			* @param 
			* @return
			*/
			override final public function cancel(e:Event = null) : void {
									
			}
			
		// -------o protected
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			final protected function _fill() : void {
				_oTREE = new QuadTree( new Rectangle( 0 , 0 , MapDatas.mapWidth , MapDatas.mapHeight ));
				_aCONTENT = new Array2D( MapDatas.mapWidth , MapDatas.mapHeight );
				
				var iX : int = 0;
				var iY : int = 0;
				var oT : GridTileItem = new GridTileItem();
				
				var vP : Vector3D = new Vector3D( );
				var vW : Vector3D = new Vector3D( );
				for( iX ; iX < MapDatas.mapWidth ; iX++ ){
					
					iY = 0;
					vP.x = iX;
					for( iY ; iY < MapDatas.mapHeight ; iY ++ ){
						
						vP.y = iY;
						
						vW = Transformer.screenToWorld( vP );
						
						oT = new GridTileItem();
						oT.x = vW.x;
						oT.y = vW.y;
						
						BoxObject.accessorInit( oT , { 	
										x : vW.x , y : vW.y , 
										name : 'Tile_'+iX+'-'+iY , 
										depth : iY*4000 + iX + 1 ,
										position : vW, 
										content : MapDatas.getContentAt( iX, iY )
									}); 
									
						_oTREE.addItemAt( oT , new Rectangle( iX , iY , 1 , 1 ));
					}
					
				}
				
			}
			
			
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			final protected function _onMove( e : PlayerEvent ) : void {
				
				
				// 
					var	vPOS : Vector3D = Transformer.worldToScreen( Position2D.add( e.moveVector ) );
					if(vPOS.x < 0 || vPOS.y < 0 || vPOS.x >= MapDatas.mapWidth || vPOS.y >= MapDatas.mapHeight)
						return;
				
				// 
					//var oITEM : GridTileItem = _aCONTENT.getDatasAt( vPOS.x, vPOS.y) as GridTileItem;
					//if(oITEM.collidable)
					//	return;	
						
					Position2D.incrementBy( e.moveVector );
					
				//
					
					_align();
					var vDECAL : Vector3D = vPOS.subtract( Position ) ; 
					
					if( Math.abs(vDECAL.x) > 1 || Math.abs(vDECAL.y) > 1 ){
						vDECAL.x = Math.round( vDECAL.x );
						vDECAL.y = Math.round( vDECAL.y );
						_decal( vDECAL );
						Position = vPOS;
						_zSort();
						//MapDatas.testBehaviors( Position2D );
					}
				
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			final protected function _decal( vDECAL : Vector3D ) : void {
				Camera.x += vDECAL.x;
				Camera.y += vDECAL.y;
				_redraw();
				_zSort();
			}
			
			/**
			* Aligning the container 
			*
			* @return	void
			*/
			protected function _align() : void {
				if( Position.x >= _oINNERREC.left && Position.x <= _oINNERREC.right )
					Container.x = -Position2D.x + StageResize.rect.width / 2;
				
				if( Position.y >= _oINNERREC.top && Position.y <= _oINNERREC.bottom )	
					Container.y = -Position2D.y + StageResize.rect.height / 2;
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			final protected function _redraw() : void {
				
				//
					var v : Vector.<*> = _oTREE.getRectContent( Camera );
					
				//
					for each( o in _vTILES ){
						if( v.indexOf( o )== -1)
							Container.removeChild( o );
					}		
				
				//
					var o : GridTileItem;
					for each( o in v ){
						if( !Container.contains(o)){
							Container.addChild( o );
						}
					}

					_vTILES = v;	
					
				
			}
			
			/**
			* Z sorting the tiles & the Player (<code>PlayerView</code>) 
			*
			* @return	void
			*/
			final protected function _zSort() : void {
				
				//
					var 	vTMP : Vector.<*> = _vTILES.slice();
						vTMP.push( PlayerView );
					//_shellSort(vTMP);
					vTMP.sort(_sortFunc);
					
					
				//
					
					var i : uint = 0;
					var o : *;
					for each( o in vTMP ){
						if(Container.contains(o as DisplayObject)) {
							Container.setChildIndex(o as DisplayObject, i);
							++i;
						}
					}
			}
			
			/**
			* The shell sort algorithm is quicker than the <code>Vector.sort()</code> function
			*
			* @param 	data : Data to be sorted (Vector.<IZSortable>)
			* @return	void
			*/
			protected function _shellSort( data : Vector.<*> ) : void {
				const n : int = data.length;
				var inc : int = int(n / 2 + .5);
				var temp : IZSortable;
				var j : int;
				while( inc ) {
					for(var i : int = inc;i < n;i++) {
						temp = data[i];
						j = i;
						while(j >= inc && data[int(j - inc)].depth > temp.depth) {
							data[j] = data[int(j - inc)];
							j = int(j - inc);
						}
						data[j] = temp;
					}
					inc = int(inc / 2.2 + 0.5);
				}
			}
			
			/**
			* Depth sorting func
			*
			* @param 	t1 : sorting item 1 	(IZSortable)
			* @param 	t2 : sorting item 2 	(IZSortable)
			* @return	sort result 		(int)
			*/
			final protected function _sortFunc( t1 : IZSortable , t2 : IZSortable ) : int {
				return (t1.depth==t2.depth ? 0 : (t1.depth < t2.depth) ? -1 : 1);
			}
			
			
			
		// -------o misc

			public static function trc(...args : *) : void {
				Logger.log(VMapQuadTree, args);
			}
	}
}
