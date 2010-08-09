/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.core {	import org.shoebox.engine.core.variables.Container;	import org.shoebox.engine.core.variables.TmpDebug;	import org.shoebox.utils.logger.Logger;	import flash.display.BitmapData;	import flash.display.BlendMode;	import flash.display.DisplayObject;	import flash.geom.Matrix;	import flash.geom.Point;	import flash.geom.Rectangle;	import flash.geom.Transform;	import flash.geom.Vector3D;	/**	 * org.shoebox.engine.core.BitmapDataHitTest	* @author shoebox	*/	public class BitmapDataHitTest {				private const identity: Matrix = new Matrix();				private var _oMASK		: BitmapData;		private var _oREF			: DisplayObject;				private var _bDIFF		: BitmapData;				// -------o constructor					/**			* Constructor of the BitmapDataHitTest class			*			* @public			* @return	void			*/			public function BitmapDataHitTest( mask: BitmapData, ref: DisplayObject ) : void {				_oMASK = mask.clone();				_oMASK.threshold(_oMASK, _oMASK.rect, new Point(), '!=', 0 , 0xFFFF0000);				_oREF	= ref;								//TmpDebug.bitmapData = _oMASK;				_bDIFF = new BitmapData( mask.width, mask.height, true, 0x333333 );			}		// -------o public						/**			 * compute function			 * @public			 * @param 			 * @return			 */			public function compute( v : Vector3D = null ) : Rectangle {								var oREC : Rectangle = _oREF.getRect(Container);				if( v )					oREC.offset( v.x , v.y );								_bDIFF.fillRect(_bDIFF.rect, 0x00000000 );				_bDIFF.copyPixels(_oMASK, oREC, oREC.topLeft);				//TmpDebug.bitmapData = _bDIFF;				return _bDIFF.getColorBoundsRect( 0xFFFF0000, 0x00000000 , false);			}						/**			* getRect function			* @public			* @param 			* @return			*/			final public function getRect( oREC : Rectangle , v:Vector3D = null ) : Rectangle {								if( v )					oREC.offset( v.x , v.y );								_bDIFF.fillRect(_bDIFF.rect, 0x00000000 );				_bDIFF.copyPixels(_oMASK, oREC, oREC.topLeft);				TmpDebug.bitmapData = _bDIFF;				return _bDIFF.getColorBoundsRect( 0xFFFF0000, 0x00000000 , false);							}		// -------o protected		// -------o misc			public static function trc(...args : *) : void {				Logger.log(BitmapDataHitTest, args);			}	}}