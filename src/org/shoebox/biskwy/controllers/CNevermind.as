/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.controllers {	import fl.controls.Button;	import org.shoebox.biskwy.items.scriptsEditor.AAction;	import org.shoebox.biskwy.items.scriptsEditor.Anchor;	import org.shoebox.biskwy.models.MNevermind;	import org.shoebox.biskwy.views.VNevermind;	import org.shoebox.patterns.mvc.abstracts.AController;	import org.shoebox.patterns.mvc.interfaces.IController;	import org.shoebox.utils.logger.Logger;	import flash.display.DisplayObject;	import flash.display.NativeMenuItem;	import flash.display.Sprite;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.utils.getDefinitionByName;	import flash.utils.getQualifiedClassName;	/**	 * org.shoebox.biskwy.controllers.CNevermind	* @author shoebox	*/	public class CNevermind extends AController implements IController {				protected var _oDRAG			:AAction;		protected var _oANCHOR			:Anchor;		protected var _bANCHOR			:Boolean = false;				// -------o constructor					/**			* Constructor of the CNevermind class			*			* @public			* @return	void			*/			public function CNevermind() : void {			}		// -------o public						/**			* onEvent function			* @public			* @param 			* @return			*/			final override public function onEvent( e : Event ) : void {								switch( e.type ){										case MouseEvent.CLICK:						trc('click ::: '+e.target);												if( e.target is Button )							if( e.target.name == 'menu')								(view as VNevermind ).openMenu();						else if(e.target.parent is AAction)							(view as VNevermind).edit( e.target.parent as AAction );												break;										case Event.SELECT:						var n : NativeMenuItem = e.target as NativeMenuItem;						trc('select ::: '+n.data);						if( n.data is Class )							( view as VNevermind ).create( e.target.name , n.data as Class );						else if( n.data is DisplayObject )							( view as VNevermind ).create( n.data.name , Class(getDefinitionByName(getQualifiedClassName( n.data))) );													break;											case MouseEvent.MOUSE_DOWN:											if(e.target is Anchor)							_dragAnchor( e.target as Anchor );						else if( e.target is Sprite && e.target.parent is AAction)							_dragAction( e.target.parent );												break;										case MouseEvent.MOUSE_UP:												unRegister( view , MouseEvent.MOUSE_MOVE 	, false );						unRegister( view , MouseEvent.MOUSE_UP 	, false);												if( _oDRAG ) {							_oDRAG.stopDrag();							_oDRAG = null;						}else if( e.target is Anchor )							_dragAnchorEnd( e.target as Anchor );												(view as VNevermind).clearPreview();						_bANCHOR = false;												break;											case MouseEvent.MOUSE_MOVE:						if( _oDRAG )							(model as MNevermind).update( VNevermind.REDRAW );						else if( _bANCHOR )							(view as VNevermind).previewLink( _oANCHOR );						break;													}							}									/**			* initialize function			* @public			* @param 			* @return			*/			final override public function initialize() : void {							}						/**			* cancel function			* @public			* @param 			* @return			*/			final override public function cancel( e : Event = null ) : void {						}					// -------o protected						/**			* Drawning an anchor  			*			* @param 				* @return			*/			final protected function _dragAnchor( o : Anchor ) : void {								_oANCHOR = o;				register(view, MouseEvent.MOUSE_MOVE, false, 10, true);				register(view, MouseEvent.MOUSE_UP, false, 10, true);				_bANCHOR = true;							}						/**			* 			*			* @param 			* @return			*/			final protected function _dragAnchorEnd( o : Anchor ) : void {								if( o!== _oANCHOR )					(model as MNevermind).registerLink( _oANCHOR , o );			}						/**			* 			*			* @param 			* @return			*/			final protected function _dragAction( o : AAction ) : void {				trc('dragAction ::: '+o);				_oDRAG = o;				_oDRAG.startDrag( false );				register(view, MouseEvent.MOUSE_MOVE, false, 10, true);				register(view, MouseEvent.MOUSE_UP, false, 10, true);			}		// -------o misc			public static function trc(...args : *) : void {				Logger.log(CNevermind, args);			}	}}