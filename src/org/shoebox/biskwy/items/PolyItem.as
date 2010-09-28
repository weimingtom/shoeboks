/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.items {
	import org.shoebox.engine.core.variables.TileSize;
	import flash.display.JointStyle;
	import org.shoebox.utils.logger.Logger;	import flash.display.BlendMode;	import flash.display.Sprite;	import flash.events.Event;	/**	 * org.shoebox.biskwy.items.PolyItem	* @author shoebox	*/	public class PolyItem extends Sprite {				public static const DONE		: String = 'PolyItem_DONE';				protected var _vSPOTS			: Vector.<int>;		protected var _iSPOTS			: int = 0;				// -------o constructor					/**			* Constructor of the PolyItem class			*			* @public			* @return	void			*/			public function PolyItem() : void {				mouseEnabled = mouseChildren = false;				_vSPOTS = new Vector.<int>( );				graphics.lineStyle( 2 , 0xFF0000 , 1 , true , null , null , JointStyle.MITER );				graphics.beginFill( 0xFF6600 , .4 );			}					// -------o public						/**			* draw function			* @public			* @param 			* @return			*/			final public function set content( v : Vector.<int> ) : void {				_vSPOTS = v;				var l : int = _vSPOTS.length;				var i : int = 0;				while( i < l ){										if( i == 0 )						graphics.moveTo( v[i] , v[i+1] );					else						graphics.lineTo( v[i] , v[i+1] );												_iSPOTS++;					i+=2;				}			}			/**			* getContent function			* @public			* @param 			* @return			*/			final public function get content() : Vector.<int> {				return _vSPOTS;			}						/**			* addSpot function			* @public			* @param 			* @return			*/			final public function addSpot( iX : int , iY : int ) : void {								iX = Math.round( iX / TileSize ) * TileSize;
				iY = Math.round( iY / TileSize ) * TileSize;								if( _iSPOTS == 0)					graphics.moveTo( iX , iY );				else					graphics.lineTo( iX , iY );									_vSPOTS.push( iX , iY );				_iSPOTS++;				trace('_vSPOTS.length ::: '+_vSPOTS.length);				if(  _vSPOTS.length == 6 ){					graphics.lineTo( _vSPOTS[0] , _vSPOTS[1] );					dispatchEvent( new Event( DONE ));					}			}					// -------o protected								// -------o misc			public static function trc(...args : *) : void {				Logger.log(PolyItem, args);			}	}}