/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.items {	import org.shoebox.biskwy.events.TileEvent;
	import org.shoebox.biskwy.core.Config;	import org.shoebox.biskwy.core.IsoGrid;	import org.shoebox.biskwy.core.TwoD;	import org.shoebox.biskwy.core.variables.TilesCache;	import org.shoebox.biskwy.data.TileDesc;	import org.shoebox.utils.logger.Logger;	import flash.display.Bitmap;	import flash.display.DisplayObject;	import flash.display.Sprite;	import flash.events.Event;	import flash.geom.Vector3D;	/**	 * org.shoebox.biskwy.items.TileLayer	* @author shoebox	*/	public class TileLayer extends Sprite {				protected var _oMEDIA		:DisplayObject;		protected var _uDECALZ		:int = 0;		protected var _oDESC		:TileDesc;		protected var _uID		:uint;			protected var _vDECAL		:Vector3D = new Vector3D();				// -------o constructor					/**			* Constructor of the TileLayer class			*			* @public			* @return	void			*/			public function TileLayer() : void {			}		// -------o public						/**			* fill function			* @public			* @param 			* @return			*/			final public function fill( id : uint  , iDecZ : int ) : void {				trc('fill ::: '+id+' /// '+iDecZ );								_oDESC = TilesCache.getValue(id);				trace('_oDESC ::: '+_oDESC);				_oDESC.addEventListener( Event.CHANGE , _onChange , false , 10 , true );				_oDESC.addEventListener( TileEvent.DELETE, _onDelete , false , 10 , true );								_uID = id;				_uDECALZ = iDecZ;				_update();			}			/**			* get id function			* @public			* @param 			* @return			*/			public function get id() : uint {				return _uID;			}						/**			* get decalZ function			* @public			* @param 			* @return			*/			public function get decalZ() : int {				return _uDECALZ;			}						/**			* set decalZ function			* @public			* @param 			* @return			*/			final public function set decalZ( i : int ) : void {				_uDECALZ = i;				_decal();			}						/**			* get decal function			* @public			* @param 			* @return			*/			public function get decal() : Vector3D {				return _vDECAL;				_decal();			}						/**			* set decal function			* @public			* @param 			* @return			*/			final public function set decal( v : Vector3D ) : void {				trace('decal ::: '+v);				_vDECAL = v;				_oDESC.decalX = v.x;				_oDESC.decalY = v.y;				_decal();			}						/**			* get media function			* @public			* @param 			* @return			*/			final public function get media() : DisplayObject {				return _oMEDIA;			}								// -------o protected						/**			* 			*			* @param 			* @return			*/			final protected function _update() : void {				trace('update ::: ' + _oDESC.mediaSource );								//					if(  _oDESC.mediaSource == null )						return;								//					if( _oMEDIA == null ){						_oMEDIA = new Bitmap( _oDESC.img.clone() );						addChild(_oMEDIA);					}								//					if(Config.GRIDTYPE == TwoD )						_oMEDIA.y = -_oMEDIA.height + 2 + _vDECAL.y + _uDECALZ;								else						_oMEDIA.y = -_oMEDIA.height + Config.TILESIZE/2 + 2 + _vDECAL.y + _uDECALZ;												//					_decal();				}						/**			* 			*			* @param 			* @return			*/			final protected function _onChange( e : Event ) : void {				_decal();			}						/**			* 			*			* @param 			* @return			*/			final protected function _decal() : void {				trace('decal ::: ' + _oDESC.decalX+' /// ' + _oDESC.decalY);				if(Config.GRIDTYPE == IsoGrid){					trace('isoGrid');					_oMEDIA.y = -_oMEDIA.height + Config.TILESIZE/2 + 2;					_oMEDIA.x = _oDESC.decalX;					_oMEDIA.y += _oDESC.decalY;					_oMEDIA.y += decalZ;				}else{					_oMEDIA.x = _oDESC.decalX;					_oMEDIA.y = _oDESC.decalY;				}							}						/**			* 			*			* @param 			* @return			*/			final protected function _onChanged( e : Event ) : void {							}						/**			* 			*			* @param 			* @return			*/			final protected function _onDelete( e : Event ) : void {				if( !parent )					return;								if( parent is TileLayersGroup )					(parent as TileLayersGroup).remove( _uID );			}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(TileLayer, args);			}	}}