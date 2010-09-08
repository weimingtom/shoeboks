/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.windows {	import org.shoebox.libs.pimpmyair.behaviors.ZWindow;	import org.shoebox.libs.pimpmyair.utils.NativeWindowUtils;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.utils.logger.Logger;	import flash.display.NativeWindow;	import flash.display.NativeWindowInitOptions;	import flash.display.NativeWindowSystemChrome;	import flash.display.NativeWindowType;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.events.Event;	import flash.events.NativeWindowDisplayStateEvent;	/**	 * org.shoebox.biskwy.windows.NewProjectWindow	* @author shoebox	*/	public class NewProjectWindow extends NativeWindow{				// -------o constructor					public function NewProjectWindow() : void {								super(Factory.build( NativeWindowInitOptions , {														systemChrome : NativeWindowSystemChrome.ALTERNATE, 													type : NativeWindowType.UTILITY, 													resizable : false, 													maximizable : false, 													minimizable : false 												}));									title = 'New project';				alwaysInFront = true;									stage.align = StageAlign.TOP_LEFT;				stage.scaleMode = StageScaleMode.NO_SCALE;				NativeWindowUtils.resizeWindow(this, 350, 350 );				stage.nativeWindow.visible = false;					addEventListener( NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE , _onEvent , false, 10 , true );				addEventListener( NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, _onEvent , false, 10 , true );				addEventListener( Event.ACTIVATE , _onEvent , false, 10 , true );				addEventListener(Event.DISPLAYING, _onEvent , false, 10 , true );			}		// -------o public						/**			* activate function			* @public			* @param 			* @return			*/			final override public function activate() : void {				//ZWindow.getInstance().register(this , 1000);					super.activate();			}						/**			* 			*			* @param 			* @return			*/			protected function _onEvent ( e : Event ) : void {				//trc('onEvent ::: '+e);			}					// -------o protected					// -------o misc			public static function trc(arguments : *) : void {				Logger.log(NewProjectWindow, arguments);			}	}}