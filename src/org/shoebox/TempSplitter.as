/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox {	import com.adobe.images.PNGEncoder;	import org.shoebox.libs.pimpmyair.utils.FileUtils;	import org.shoebox.utils.logger.Logger;	import flash.display.Bitmap;	import flash.display.BitmapData;	import flash.display.Loader;	import flash.display.LoaderInfo;	import flash.display.Sprite;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.events.Event;	import flash.filesystem.File;	import flash.filesystem.FileMode;	import flash.filesystem.FileStream;	import flash.geom.Matrix;	import flash.geom.Point;	import flash.geom.Rectangle;	import flash.utils.ByteArray;	/**	 * org.shoebox.TempSplitter	* @author shoebox	*/	public class TempSplitter extends Sprite{				protected var _uINC		:uint;				// -------o constructor					public function TempSplitter() : void {				_run();				stage.scaleMode = StageScaleMode.NO_SCALE;				stage.align = StageAlign.TOP_LEFT;			}		// -------o public				// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _run() : void {				_uINC = 0;				var 	oF : File = new File();					oF = oF.resolvePath('/Users/shoeboks/Desktop/zelda/split/zelda.png');									var	oLOADER : Loader = new Loader();					oLOADER.contentLoaderInfo.addEventListener( Event.COMPLETE , _onComplete , false , 10 , true);					oLOADER.loadBytes(FileUtils.readFile(oF));			}						/**			* 			*			* @param 			* @return			*/			protected function _onComplete( e : Event ) : void {				var oB : BitmapData = (((e.target as LoaderInfo).loader as Loader).content as Bitmap).bitmapData;				//0xFEFED4				var uINC : uint = 0;				var w : uint = oB.width;				var h : uint = oB.height;				var iX : uint = 0;				var iY : uint = 0;				var b : BitmapData;				var p : Point = new Point( 0 , 0);				var r : Rectangle = new Rectangle(0 , 0 , 16 , 16);				var bmp : Bitmap;				var oBASE : File = new File().resolvePath('/Users/shoeboks/Desktop/zelda/split/');				var oSTREAM : FileStream;				var oFILE2 : File;				var oMAT : Matrix = new Matrix();					oMAT.scale(2,2);				var bTMP : BitmapData = new BitmapData( 32 , 32 , true , 0xFFFFFFFF);								var	uX : uint = 0;				var 	uY : uint = 0;				while( iX < w){										uY = 0;					iY = 0;					r.y = 0;					while( iY < h ){												b = new BitmapData( 16 , 16 , true , 0xFFFFFFFF);						b.copyPixels(oB , r , p);												bTMP = new BitmapData( 32 , 32 , true , 0xFFFFFFFF);						bTMP.draw( b , oMAT );												iY+=16;						r.y+=16;						_export(bTMP , oBASE , uY+'-'+uX , uX , uY);						uINC++;						uY++;					}					r.x += 16;					iX+=16;					uX++;				}						}						/**			* 			*			* @param 			* @return			*/			protected function _export( o : BitmapData , oBASE : File , sNAME : String , uX : uint , uY : uint) : void {								var b : Boolean = false;				var bTMP : BitmapData = o.clone();									var uLEN : uint = bTMP.threshold( bTMP , bTMP.rect, new Point(), '!=', 0xFFFFFFFF , 0xFF6600);				if( uLEN == 0)					return;								o.threshold( o , bTMP.rect, new Point(), '==', 0xFFFFFFFF);									var	oFILE : File = oBASE.resolvePath(sNAME+'.png');								var oBMP : Bitmap = new Bitmap( o );					oBMP.x = uX * 33;					oBMP.y = uY * 33;				addChild( oBMP );								var 	oPNG : ByteArray = PNGEncoder.encode(o);								var 	oSTREAM : FileStream = new FileStream();					oSTREAM.open( oFILE , FileMode.WRITE );					oSTREAM.writeBytes( oPNG , 0 , oPNG.length );					oSTREAM.close();				_uINC++;			}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(TempSplitter, args);			}	}}