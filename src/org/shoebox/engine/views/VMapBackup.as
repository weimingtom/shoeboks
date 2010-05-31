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
	import org.shoebox.engine.events.CameraEvent;
	import org.shoebox.biskwy.utils.Transformer;
	import org.shoebox.collections.Array2D;
	import org.shoebox.core.BoxObject;
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
	import org.shoebox.utils.ObjectPool;
	import org.shoebox.utils.logger.Logger;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;

	/**
	 * Map view extend the <code>AView</code> class
	* 
	* org.shoebox.engine.views.VMap
	* @author shoebox
	*/
	public class VMap extends AView implements IView {
		
		protected var _aCONTENT		: Array2D;
		protected var _bINIT		: Boolean = false;
		protected var _vTIMER 		: Vector.<Number> = new Vector.<Number>();
		protected var _vTILES		: Vector.<IZSortable>;
		protected var _oINNERREC	: Rectangle;
		protected var _oPOOL		: ObjectPool;
		
		// -------o constructor
		
			/**
			* Constructor of the VMap class
			*
			* @public
			* @return	void
			*/
			public function VMap() : void {
			}

		// -------o public
		
			/**
			* View initialization
			* override the <code>AView</code> method
			* 
			* @public
			* @return	void
			*/
			final override public function initialize() : void {
				
			}

			/**
			* When the view receive an update
			* override the <code>AView</code> method
			* 
			* @public
			* @param	o : optional update event (UpdateEvent) 
			* @return	void
			*/
			override final public function update(o:UpdateEvent = null) : void {
				_redraw();
			}

			/**
			* When the view is canceled
			* override the <code>AView</code> method
			* 
			* @public
			* @param	e : optional event (Event) 
			* @return	void
			*/
			override final public function cancel(e:Event = null) : void {
				freeze();			
			}
			
			/**
			* Stop listening the player controls
			* 
			* @public
			* @return	void
			*/
			public function freeze() : void {
				LightSignal.getInstance().disconnect( PlayerEvent.PLAYER_MOVE , _onMove );
				_bINIT = false;
			}
		
		// -------o protected
			
			/**
			* Redrawning the map
			*
			* @return	void
			*/
			final protected function _redraw( ) : void {
				trc('redraw');
				Position2D = new Vector3D();
				Container.x = Container.y = 0;
				
				_removeAll();
				_vTILES = new Vector.<IZSortable>();
				
				_oPOOL = new ObjectPool( GridTileItem , (MapDatas.mapWidth + 1) * (MapDatas.mapHeight + 1) , 1);
				
				_aCONTENT = new Array2D( MapDatas.mapWidth , MapDatas.mapHeight );
				_oINNERREC = new Rectangle( 
									Dimension.x , Dimension.y , 
									MapDatas.mapWidth - Dimension.x*2 , MapDatas.mapHeight - Dimension.y * 2 
								);
								
				//
					var	iFIXX : int;
					if( Dimension.x > Position.x )
						iFIXX = Position.x - Dimension.x;
					else if( Position.x > (MapDatas.mapWidth - Dimension.x))
						iFIXX = MapDatas.mapWidth - Position.x;
				
				//
					var 	iFIXY : int;
					if( Dimension.y > Position.y )
						iFIXY = Position.y - Dimension.y;
					else if( Position.y > ( MapDatas.mapHeight - Dimension.y ))
						iFIXY = MapDatas.mapHeight - Position.y - 1;
						
					
				//
					var iX : int;
					var iY : int = Position.y - Dimension.y - iFIXY;
					var iH : int = Position.y + Dimension.y - iFIXY + 1; 
					var iW : int = Position.x + Dimension.x - iFIXX + 1; 
					var iT : int = Position.x - Dimension.x - iFIXX; 
					for( iY ; iY < iH ; ++iY){
						
						iX = iT;
						for( iX ; iX < iW ; ++iX ){
							_drawTileAt( iX , iY );
						}
						
					}
					
					Position2D = Transformer.screenToWorld( Position );
			
				
				//
					if( Position.x >= _oINNERREC.left && Position.x <= _oINNERREC.right )
						Container.x = -Position2D.x + StageResize.rect.width / 2;
					
					if( Position.x >= _oINNERREC.right )
						Container.x = -Position2D.x + StageResize.rect.width / 2 + (Position.x - _oINNERREC.right) * TileSize;
				
				//
					if( Position.y >= _oINNERREC.top && Position.y <= _oINNERREC.bottom )	
						Container.y = -Position2D.y + StageResize.rect.height / 2;
					
					if( Position.y >= _oINNERREC.bottom )
						Container.y = -Position2D.y + StageResize.rect.height / 2 + (Position.y - _oINNERREC.bottom) * TileSize;
				
				//	
					if( !_bINIT ){
						//EventCentral.getInstance().addEventListener( PlayerEvent.PLAYER_MOVE , _onMove , false , 10 , true );
						LightSignal.getInstance().connect( PlayerEvent.PLAYER_MOVE , _onMove );
						LightSignal.getInstance().connect( CameraEvent.MOVE_CAM, _onMoveCam );
						_bINIT = true;
					}
			}
			
			/**
			* Drawning a tile at the specified position
			*
			* @param	iX : x position of the tile ( uint ) 
			* @param	iY : y position of the tile ( uint ) 
			* @return	void
			*/
			final protected function _drawTileAt( iX : uint , iY : uint ) : void {
				
				if( iX >= MapDatas.mapWidth || iX < 0 || iY >= MapDatas.mapHeight || iY < 0)
					return;
				
				if( _aCONTENT.getDatasAt(iX, iY) !== null)
					return;
				
				var	vPOS : Vector3D = new Vector3D( iX , iY );
				
				var 	vP : Vector3D = Transformer.screenToWorld( vPOS  );
				
				var 	oT : GridTileItem = _oPOOL.getObject();
					oT.reset();
				
				
				BoxObject.accessorInit( oT , { 	
										x : vP.x , y : vP.y , 
										name : 'Tile_'+iX+'-'+iY , 
										position : vPOS , 
										depth : iY*4000 + iX + 1 , 
										content : MapDatas.getContentAt( iX, iY )
									}); 
				
				
				Container.addChild( oT );
				
				_aCONTENT.setDatasAt(iX, iY, oT);
				_vTILES.push( oT );
			}
			
			/**
			* When the player move
			*
			* @param 	e : player move event (PlayerEvent)
			* @return	void
			*/
			final protected function _onMove( e : PlayerEvent ) : void {
				trace('onMove ::: '+e.moveVector);
				
				// 
					var	vPOS : Vector3D = Transformer.worldToScreen( Position2D.add( e.moveVector ) );
					if(vPOS.x < 0 || vPOS.y < 0 || vPOS.x >= MapDatas.mapWidth || vPOS.y >= MapDatas.mapHeight)
						return;
				
				//
					var oITEM : GridTileItem = _aCONTENT.getDatasAt( vPOS.x, vPOS.y) as GridTileItem;
					if(oITEM.collidable)
						return;	
						
					Position2D.incrementBy( e.moveVector );
					
				//
					_decal( vPOS.subtract( Position ) , vPOS );
				
				//
					Position = vPOS;
					_align();
					_zSort();
					MapDatas.testBehaviors( Position2D );
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			final protected function _onMoveCam(  e : CameraEvent ) : void {
				trace('onMoveCam ::: '+e.moveVector);
				// 
					var	vPOS : Vector3D = Transformer.worldToScreen( Position2D.add( e.moveVector ) );
					if(vPOS.x < 0 || vPOS.y < 0 || vPOS.x >= MapDatas.mapWidth || vPOS.y >= MapDatas.mapHeight)
						return;
				
				//
					var oITEM : GridTileItem = _aCONTENT.getDatasAt( vPOS.x, vPOS.y) as GridTileItem;
					if(oITEM.collidable)
						return;	
						
					Position2D.incrementBy( e.moveVector );
					
				//
					_decal( vPOS.subtract( Position ) , vPOS );
				
				//
					Position = vPOS;
					_align();
					_zSort();
					MapDatas.testBehaviors( Position2D );
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			final protected function _decal( vDECAL : Vector3D , vPOS : Vector3D ) : void {
				
					var	oREC 	: Rectangle = _getRect();
					var 	iDIM 	: int;
					
					if( vDECAL.y !== 0 ){
						
						var iFIXY:int = Math.round((( StageResize.rect.height / 2 - PlayerView.y) - Container.y ) / TileSize);
						iDIM = Dimension.y + 1;
						if( vDECAL.y > 0 ){
							
							_drawRow( vPOS.y + Dimension.y , oREC);	
							if(iFIXY == 0 )
								_removeRow( vPOS.y - iDIM );	
								
						}else if( vDECAL.y < 0){
							
							_drawRow( vPOS.y - Dimension.y , oREC);	
							if(iFIXY == 0 )
								_removeRow( vPOS.y + iDIM );
									
						}
						
					}
				
				//
					if(vDECAL.x !== 0){
						var iFIXX:int = Math.round((( StageResize.rect.width / 2 - PlayerView.x) - Container.x ) / TileSize);
						iDIM = Dimension.x + 1;
						if( vDECAL.x > 0 ){	
								
							_drawCol( vPOS.x + Dimension.x , oREC);
							if(iFIXX == 0)
								_removeCol( vPOS.x - iDIM  );
								
						}else if( vDECAL.x < 0 ){
							
							_drawCol( vPOS.x - Dimension.x , oREC);
							if(iFIXX == 0)
								_removeCol( vPOS.x + iDIM );
								
						}
					}
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
			* Remove a tile column 
			*
			* @param 	iX : x position of the column to be removed (int)
			* @return	void
			*/
			final protected function _removeCol( iX : int ) : void {
				
				if( iX < 0 || iX >= MapDatas.mapWidth )
					return;
			
				var o : GridTileItem;
				var v : Vector.<*> = _aCONTENT.getItemsAtX(iX) as Vector.<*>;
				
				for each( o in v ) {
					
					if( o == null )
						continue;
					
					Container.removeChild( o );
					_vTILES.splice( _vTILES.indexOf( o ) , 1);
					_aCONTENT.setDatasAt( o.position.x , o.position.y , null );
					_oPOOL.dispose(o);
				}
			}
			
			/**
			* Remove of tiles row
			*
			* @param 	iX : y position of the row to be removed (int)
			* @return
			*/
			final protected function _removeRow( iY : int ) : void {
				
				if( iY < 0 || iY >= MapDatas.mapHeight )
					return;
			
				var o : GridTileItem;
				var v : Vector.<*> = _aCONTENT.getItemsAtY(iY) as Vector.<*>;
				for each( o in v ) {
					
					if( o == null )
						continue;
						
					Container.removeChild( o );
					_vTILES.splice( _vTILES.indexOf( o ) , 1);
					_aCONTENT.setDatasAt( o.position.x , o.position.y , null );
					_oPOOL.dispose(o);
				}
			}
			
			/**
			* Remove all the tiles of the map
			*
			* @return	void
			*/
			protected function _removeAll() : void {
				
				var o : GridTileItem;
				for each( o in _vTILES)
					if( Container.contains(o) )
						Container.removeChild( o );
				
			}
			
			/**
			* Drawning a tiles column
			*	
			* @param	iX : x position of the column (int) 
			* @return	void
			*/
			final protected function _drawCol( iX : int , oREC : Rectangle ) : void {
			
				if( iX > MapDatas.mapWidth )
					return;
				
				//
					var iFIXY:int = Math.round((( StageResize.rect.height / 2 - PlayerView.y) - Container.y ) / TileSize);
					var 	iY 	: int = oREC.top + iFIXY;
					var	iL	: int = oREC.bottom + iFIXY;
					for( iY ; iY <= iL ; iY ++ )
						_drawTileAt( iX , iY );
				
			}
			
			/**
			* Drawning a tiles row 
			*
			* @param 	iX : y position of the row (int)	
			* @return	void
			*/
			final protected function _drawRow( iY : int , oREC : Rectangle ) : void {
				
				if( iY > MapDatas.mapHeight )
					return;
					
				var 	iFIXX:int = Math.round((( StageResize.rect.width / 2 - PlayerView.x) - Container.x ) / TileSize);
				
				var iX : int = oREC.left + iFIXX;
				var iL : int = oREC.right + iFIXX;
				for( iX ; iX <= iL ; iX ++ )
					_drawTileAt( iX , iY );	
				
			}
			
			/**
			* Get the view bounding rect
			*
			* @return	rect (Rectangle)
			*/
			final protected function _getRect() : Rectangle {
				return new Rectangle( Math.floor(Position.x) - Dimension.x , Math.floor(Position.y) - Dimension.y , Dimension.x * 2 , Dimension.y * 2 );
			}
			
			/**
			* Z sorting the tiles & the Player (<code>PlayerView</code>) 
			*
			* @return	void
			*/
			final protected function _zSort() : void {
				
				//
					var 	vTMP : Vector.<IZSortable> = _vTILES.slice();
						vTMP.push( PlayerView );
					_shellSort(vTMP);
					//vTMP.sort(_sortFunc);
					
					
				//
					
					var i : uint = 0;
					var o : IZSortable;
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
			protected function _shellSort( data : Vector.<IZSortable> ) : void {
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
				Logger.log(VMap, args);
			}
	}
}
