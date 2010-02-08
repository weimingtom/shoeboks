/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.core {	import org.shoebox.engine.apps.AppMapRenderer;	import org.shoebox.libs.pimpmyair.utils.FileUtils;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.utils.logger.Logger;	import flash.display.Shape;	import flash.display.Sprite;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.filesystem.File;	import flash.geom.Rectangle;	import flash.utils.ByteArray;	/**	 * org.shoebox.engine.core.MainRender	* @author shoebox	*/	public class MainRender extends Sprite {				public static var oBASEFILE	:File;				protected var _oRENDER		:AppMapRenderer;		protected var _oFILE		:File;		protected var _spCONTAINER	:Sprite;				// -------o constructor					public function MainRender() : void {				trc('constructor');				if(stage){					stage.scaleMode = StageScaleMode.NO_SCALE;					stage.align = StageAlign.TOP_LEFT;				}				_oFILE = File.documentsDirectory.resolvePath('/Users/shoeboks/Documents/Biskwy_My project');				projectFile = _oFILE;			}		// -------o public						/**			* set projectPath function			* @public			* @param 			* @return			*/			public function set projectFile( f : File ) : void {				_oFILE = f;				oBASEFILE = f;				trc('setProjectPath ::: '+_oFILE.nativePath);				_getMapDatas();				}					// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _getMapDatas() : void {				var 	oFILEMAP : File = _oFILE.resolvePath('maps/1.bwy');				trace(oFILEMAP);				var oBA : ByteArray = FileUtils.readFile(oFILEMAP);								_spCONTAINER = new Sprite();				_spCONTAINER.scrollRect = new Rectangle(0 , 0 , 550 , 400);				_spCONTAINER.cacheAsBitmap = true;				_spCONTAINER.addChild( Factory.build( AppMapRenderer , {datas : oBA } ));				addChild(_spCONTAINER);								var 	shTMP : Shape = new Shape();					shTMP.graphics.lineStyle(.1);					shTMP.graphics.drawRect(0 ,0 , 550 , 400);				addChild(shTMP);			}								// -------o misc			public static function trc(...args : *) : void {				Logger.log(MainRender, args);			}	}}