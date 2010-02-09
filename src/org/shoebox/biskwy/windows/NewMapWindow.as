/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.windows {	import org.shoebox.biskwy.apps.AppNewMap;	import org.shoebox.libs.pimpmyair.utils.NativeWindowUtils;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.utils.logger.Logger;	import flash.display.NativeWindow;	import flash.display.NativeWindowInitOptions;	import flash.display.NativeWindowSystemChrome;	import flash.display.NativeWindowType;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	/**	 * org.shoebox.biskwy.windows.NewMapWindow	* @author shoebox	*/	public class NewMapWindow extends NativeWindow{				protected static var __instance		:NewMapWindow = null;				// -------o constructor					public function NewMapWindow() : void {								super(Factory.build( NativeWindowInitOptions , {													systemChrome : NativeWindowSystemChrome.ALTERNATE,												type : NativeWindowType.UTILITY,												resizable : false , 												maximizable : false , minimizable : false } ));								title = 'New map...';				alwaysInFront = true;								stage.align = StageAlign.TOP_LEFT;				stage.scaleMode = StageScaleMode.NO_SCALE;				stage.nativeWindow.visible = false;					NativeWindowUtils.resizeWindow(this, 300, 300);				activate();																	}		// -------o public						/**			* activate function			* @public			* @param 			* @return			*/			final override public function activate() : void {				super.activate();				NativeWindowUtils.resizeWindow(this, 300, 200);				stage.nativeWindow.visible = true;			}								/**			* close function			* @public			* @param 			* @return			*/			final override public function close() : void {				__instance = null;				super.close();			}					// -------o protected		// -------o misc			public static function trc(arguments : *) : void {				Logger.log(NewMapWindow, arguments);			}	}}