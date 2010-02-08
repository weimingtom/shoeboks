/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.views {	import org.shoebox.biskwy.data.ToolProp;	import org.shoebox.biskwy.items.ToolPropertyItem;	import org.shoebox.biskwy.models.MToolProperty;	import org.shoebox.display.DisplayFuncs;	import org.shoebox.patterns.mvc.abstracts.AView;	import org.shoebox.patterns.mvc.events.UpdateEvent;	import org.shoebox.patterns.mvc.interfaces.IView;	import org.shoebox.utils.Relegate;	import org.shoebox.utils.logger.Logger;	import flash.display.Sprite;	import flash.events.Event;	/**	 * org.shoebox.biskwy.views.VToolProperty	* @author shoebox	*/	public class VToolProperty extends AView implements IView{				protected var _spCONTAINER		:Sprite = new Sprite();				// -------o constructor					public function VToolProperty() : void {				addChild( _spCONTAINER );			}		// -------o public						/**			* initialize function			* @public			* @param 			* @return			*/			override final public function initialize() : void {				x = 190;				y = 5;				controller.register( _spCONTAINER , Event.CHANGE , true , 10 , true );				}						/**			* update function			* @public			* @param 			* @return			*/			override final public function update(o:UpdateEvent = null) : void {				_draw();			}												/**			* cancel function			* @public			* @param 			* @return			*/			override final public function cancel(e:Event = null) : void {				controller.unRegister( _spCONTAINER , Event.CHANGE , true );									}					// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _draw() : void {				trc('draw');								//					DisplayFuncs.purge( _spCONTAINER );					_spCONTAINER.visible = false;								var l : uint = (model as MToolProperty).length;				var i : uint = 0;				var o : ToolPropertyItem;				var p : ToolProp;				while( i < l ){					p = (model as MToolProperty).getItemAt(i);					o = new ToolPropertyItem( p , (model as MToolProperty).getValue(p.propName) );					_spCONTAINER.addChild(o);					i++;				}								Relegate.afterFrame( this, _align , 5);			}						/**			* 			*			* @param 			* @return			*/			protected function _align( e : Event ) : void {				DisplayFuncs.distributeX( _spCONTAINER , 15 );				_spCONTAINER.visible = true;			}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(VToolProperty, args);			}	}}