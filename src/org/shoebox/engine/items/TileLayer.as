/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.items {
	import org.shoebox.biskwy.core.variables.TilesCache;
	import org.shoebox.biskwy.utils.IsoTransform;
	import org.shoebox.biskwy.utils.Transformer;
	import org.shoebox.engine.core.variables.TileSize;
	import org.shoebox.engine.datas.TileProps;
	import org.shoebox.utils.logger.Logger;

	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;	
	/**	 * org.shoebox.engine.items.TileLayer	* @author shoebox	*/	public class TileLayer extends Sprite {				protected var _spCONTAINER	:Sprite = new Sprite();		protected var _oMEDIA		:DisplayObject;		protected var _oPROPS		:TileProps;		protected var _iDECAL		:int;		protected var _oLOADER		:Loader;		protected var _uTILEID		:uint;				// -------o constructor					/**			* Constructor of the TileLayer class			*			* @public			* @return	void			*/			public function TileLayer( uTILEID : uint , iDECAL : int ) : void {				//				cacheAsBitmap = true;				_iDECAL = iDECAL;				_uTILEID = uTILEID;				_oPROPS =  TilesCache.getValue( uTILEID );				_cachedMedia();			}		// -------o public						/**			* get collidable function			* @public			* @param 			* @return			*/			public function get collidable() : Boolean {								if( _oPROPS == null)					return true;									return _oPROPS.collidable;			}					// -------o protected					/**			* 			*			* @param 			* @return			*/			final protected function _cachedMedia() : void {				
				var o : TileProps = TilesCache.getValue(_uTILEID);								trace('TilesCache[_uTILEID] ::: ' + o);
				trace('_cachedMedia ::: ' + o.media);				trace('_cachedMedia ::: ' + o.ptDecal);										if( o.media is Bitmap )						_oMEDIA = new Bitmap( (o.media as Bitmap).bitmapData.clone() );					else						_oMEDIA = o.media;						_oMEDIA.x = o.ptDecal.x;											if( Transformer.transform is IsoTransform)						_oMEDIA.y = -_oMEDIA.height + TileSize / 2 + 2 + o.ptDecal.y;					else						_oMEDIA.y = -_oMEDIA.height + TileSize + o.ptDecal.y + _iDECAL;										addChild(_oMEDIA);			}		// -------o misc			public static function trc(...args : *) : void {				Logger.log(TileLayer, args);			}	}}