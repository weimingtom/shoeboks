/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.items {	import org.shoebox.engine.interfaces.IZSortable;	import org.shoebox.utils.logger.Logger;	import flash.display.Sprite;	import flash.geom.Vector3D;	/**	 * org.shoebox.engine.items.GridTileItem	* @author shoebox	*/	public class GridTileItem extends Sprite implements IZSortable {				public var position		:Vector3D;				protected var _bCOLLIDABLE	:Boolean = false;		protected var _bINIT		:Boolean = false;		protected var _uDEPTH		:uint;		protected var _vLAYERS		:Vector.<TileLayer>;		protected var _vPOS		:Vector3D;				// -------o constructor					/**			* Constructor of the GridTileItem class			*			* @public			* @return	void			*/			public function GridTileItem() : void {				cacheAsBitmap = true;			}		// -------o public						/**			* Setting the content of the <code>GridTileItem</code>			* 			* @public			* @param	v : content list ( Vector.<int> ) 			* @return	void			*/			public function set content( v : Vector.<int> ) : void {								var l : uint = v.length;				var i : uint = 0;				var o : TileLayer;				_vLAYERS = new Vector.<TileLayer>();				for( i ; i < l ; i+=2 ){					o = new TileLayer( v[i] , v[i+1] );					_vLAYERS.push( o );					addChild( o );				}								}						/**			* Getter of the <code>GridTileItem</code> depth			* 			* @public			* @param	u : depth of tile (uint) 			* @return	void			*/			public function set depth( u : uint ) : void {				_uDEPTH = u;			}						/**			* Getter of the calculate depth of the <code>GridTileItem</code>			* 			* @public			* @return	depth of the tile (uint)			*/			public function get depth() : uint {				return _uDEPTH;			}						/**			* Is the <code>GridTileItem</code> contains <code>TileLayer</code> who is collidable			* 			* @public			* @return	is collidable (Boolean)			*/			public function get collidable() : Boolean {								//					if( _bINIT)						return _bCOLLIDABLE;								//					var o : TileLayer;					_bCOLLIDABLE = false;					for each( o in _vLAYERS){						if(o.collidable){							_bCOLLIDABLE = true;							break;						}					}					_bINIT = true;									return _bCOLLIDABLE;			}					// -------o protected		// -------o misc			public static function trc(...args : *) : void {				Logger.log(GridTileItem, args);			}	}}