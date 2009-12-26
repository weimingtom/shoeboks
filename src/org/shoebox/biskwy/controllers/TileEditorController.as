/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.controllers {	import fl.controls.ComboBox;	import fl.events.ComponentEvent;	import org.shoebox.biskwy.models.TileEditorModel;	import org.shoebox.biskwy.views.TileEditorView;	import org.shoebox.patterns.mvc.abstracts.AController;	import org.shoebox.patterns.mvc.interfaces.IController;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	import flash.events.MouseEvent;	/**	 * org.shoebox.biskwy.controllers.TileEditorController	* @author shoebox	*/	public class TileEditorController extends AController implements IController{				// -------o constructor					public function TileEditorController() : void {			}		// -------o public						/**			* onEvent function			* @public			* @param 			* @return			*/			final override public function onEvent( e : Event ) : void {				switch( e.type ){										case Event.CHANGE:						(view as TileEditorView).change();						break;											case MouseEvent.CLICK:							(model as TileEditorModel).dbUpdate();						break;										case ComponentEvent.ENTER:						var 	oCB : ComboBox = e.currentTarget as ComboBox;							oCB.addItem({label:oCB.text , value:oCB.text});							oCB.text = '';							oCB.sortItemsOn("label", Array.CASEINSENSITIVE);												break;				}			}									/**			* initialize function			* @public			* @param 			* @return			*/			final override public function initialize() : void {								}						/**			* cancel function			* @public			* @param 			* @return			*/			final override public function cancel( e : Event = null ) : void {						}						// -------o protected		// -------o misc			public static function trc(arguments : *) : void {				Logger.log(TileEditorController, arguments);			}	}}