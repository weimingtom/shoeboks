/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.views {	import org.shoebox.biskwy.core.IsoGrid;
	import fl.controls.Button;	import org.shoebox.biskwy.core.Config;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.patterns.mvc.abstracts.AView;	import org.shoebox.patterns.mvc.events.UpdateEvent;	import org.shoebox.patterns.mvc.interfaces.IView;	import org.shoebox.utils.Relegate;	import org.shoebox.utils.logger.Logger;	import flash.data.EncryptedLocalStore;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.events.NativeWindowBoundsEvent;	import flash.utils.ByteArray;	import flash.utils.getDefinitionByName;	/**	 * org.shoebox.biskwy.views.VTools	* @author shoebox	*/	public class VTools extends AView implements IView{				protected var _vBUTTONS	:Vector.<String> = Vector.<String>(['ClickFill','RectFill','Clear','Edit','Elevation','Groups','Trigger','Sound','Poly']);				// -------o constructor					public function VTools() : void {				graphics.beginFill(0xFFFFFF);				graphics.drawRect(0,0,100,200);			}		// -------o public						/**			* initialize function			* @public			* @param 			* @return			*/			final override public function initialize() : void {								var b : Button;				var s : String;				var iX : uint = 0;				var iY : uint = 0;				for each( s in _vBUTTONS){										b = Factory.build(Button , { x : iX * 40 + 5, y : iY * 40 + 5 , label:'' , name : s , width : 80});					if( s!== 'Poly' )						b.setStyle("icon", getDefinitionByName('ico'+s));						b.setSize( 34 , 34);										addChild(b);										if(iX++ > 0){						iX = 0;						iY ++;					}									}				controller.register(this , MouseEvent.CLICK , true , 10 , false);								Relegate.afterFrame( this , _onFrame , 5);			}						/**			* update function			* @public			* @param 			* @return			*/			final override public function update( o : UpdateEvent = null ) : void {						}									/**			* cancel function			* @public			* @param 			* @return			*/			final override public function cancel( e : Event = null ) : void {									}								// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _onFrame( e : Event ) : void {				if(EncryptedLocalStore.getItem('windowposition')){					trc('onFrame');					var oBA:ByteArray = EncryptedLocalStore.getItem('windowposition') as ByteArray;					stage.nativeWindow.x = oBA.readInt();					stage.nativeWindow.y = oBA.readInt();				}				stage.nativeWindow.visible = true;				controller.register(stage.nativeWindow , NativeWindowBoundsEvent.MOVE , false , 10 , true);							}					// -------o misc			public static function trc(arguments : *) : void {				Logger.log(VTools, arguments);			}	}}