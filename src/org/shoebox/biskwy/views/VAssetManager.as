/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.views {	import flash.display.Sprite;
	import org.shoebox.patterns.mvc.abstracts.AView;	import org.shoebox.patterns.mvc.events.UpdateEvent;	import org.shoebox.patterns.mvc.interfaces.IView;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	/**	* org.shoebox.biskwy.views.VAssetManager	* @author shoebox	*/	public class VAssetManager extends AView implements IView {				protected var		_spCONTAINER			:Sprite = new Sprite();				// -------o constructor					/**			* Constructor of the VAssetManager class			*			* @public			* @return	void			*/			public function VAssetManager() : void {			}		// -------o public						/**			* View initialization			*			* @public			* @return	void			*/			override final public function initialize() : void {				addChild( _spCONTAINER );			}						/**			* When the view receive an update			* 			* @public			* @param	o : optional update event (UpdateEvent) 			* @return	void			*/			override final public function update(o:UpdateEvent = null) : void {						}												/**			* When the view is canceled			* 			* @public			* @param	e : optional cancel event (Event) 			* @return	void			*/			override final public function cancel(e:Event = null) : void {												}					// -------o protected		// -------o misc			public static function trc(...args : *) : void {				Logger.log(VAssetManager, args);			}	}}