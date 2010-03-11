/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.views {	import fl.controls.Button;	import fl.controls.Label;	import org.shoebox.biskwy.controllers.CMaps;	import org.shoebox.biskwy.items.MapItem;	import org.shoebox.biskwy.models.MMaps;	import org.shoebox.display.DisplayFuncs;	import org.shoebox.display.containers.BoxGrid;	import org.shoebox.patterns.commands.samples.CommandRollOut;	import org.shoebox.patterns.commands.samples.CommandRollOver;	import org.shoebox.patterns.commands.samples.IResizeable;	import org.shoebox.patterns.commands.samples.StageResize;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.patterns.mvc.abstracts.AView;	import org.shoebox.patterns.mvc.events.UpdateEvent;	import org.shoebox.patterns.mvc.interfaces.IView;	import org.shoebox.utils.logger.Logger;	import flash.display.Sprite;	import flash.events.Event;	import flash.events.MouseEvent;	/**	 * org.shoebox.biskwy.views.VMaps	* @author shoebox	*/	public class VMaps extends AView implements IView , IResizeable {				protected var _oBUTTONOPEN	:Button;		protected var _oBUTTONDEL	:Button;		protected var _oBUTTONNEW	:Button;		protected var _dDRAWNED		:Boolean = false;		protected var _oGRID		:BoxGrid;		protected var _spCONTAINER	:Sprite = new Sprite();				// -------o constructor					public function VMaps() : void {				graphics.lineStyle( .1 , 0xA1A1A1);				graphics.drawRect(0 , 0 , 250 , 300);			}		// -------o public						/**			* onResize function			* @public			* @param 			* @return			*/			public function onResize( e : Event = null ) : void {				trc('onResize');				x = StageResize.rect.width - 250;			}			/**			* update function			* @public			* @param 			* @return			*/			override final public function update(o:UpdateEvent = null) : void {				_drawList();			}												/**			* cancel function			* @public			* @param 			* @return			*/			override final public function cancel(e:Event = null) : void {				controller.unRegisterCommand(CommandRollOver, _spCONTAINER, MouseEvent.MOUSE_OVER);				controller.unRegisterCommand(CommandRollOut, _spCONTAINER, MouseEvent.MOUSE_OUT);				controller.unRegister(this, MouseEvent.CLICK, true);									}						/**			* initialize function			* @public			* @param 			* @return			*/			override public function initialize() : void {				onResize();				_draw();			}					// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _draw() : void {				trc('draw');				if(_dDRAWNED)					return;					_dDRAWNED = true;				addChild(Factory.build( Label , {text : 'MAPS LIST' , width : 230 , y : 10 , x : 10}));								//					_spCONTAINER.x = 10;					_spCONTAINER.y = 30;					addChild(_spCONTAINER);														//					graphics.lineStyle( .1 , 0x696969 );					graphics.drawRect( 9 , 29 , 232 , 161);								//																	_oBUTTONNEW = Factory.build( Button , { 													label : 'NEW' , 												x : 10 , y : 200 , 												width : 230 ,												name : 'newmap'												} );																	_oBUTTONOPEN = Factory.build( Button , { 													label : 'OPEN' , 												x : 10 , y : 230 , 												width : 230 ,												name : 'openmap'												} );																	_oBUTTONDEL = Factory.build( Button , { 													label : 'DELETE' , 												x : 10 , y : 260 , 												width : 230 ,												name : 'delmap'												} );																						addChild(_oBUTTONNEW);					addChild(_oBUTTONOPEN);					addChild(_oBUTTONDEL);									//controller.registerCommand( CommandNewMap , 	{ } , _oBUTTONNEW , MouseEvent.CLICK , false , 10 , true);				//controller.registerCommand( CommandOpenMap , 	{ } , _oBUTTONOPEN , MouseEvent.CLICK , false , 10 , true );				//controller.registerCommand( CommandDelMap , 	{ model : model } , _oBUTTONDEL , MouseEvent.CLICK , false , 10 , true);				controller.registerCommand( CommandRollOver , 	{ } , _spCONTAINER , MouseEvent.MOUSE_OVER , true , 10 , true);				controller.registerCommand( CommandRollOut , 	{ } , _spCONTAINER , MouseEvent.MOUSE_OUT , true , 10 , true);				controller.register(this , MouseEvent.CLICK , true , 10 , true);				//controller.register( _spCONTAINER , MouseEvent.CLICK , true , 10 , true);			}						/**			* 			*			* @param 			* @return			*/			protected function _drawList() : void {								_oGRID = new BoxGrid(1,(model as MMaps).length);				_spCONTAINER.addChild(_oGRID);								DisplayFuncs.purge(_spCONTAINER);								var o : MapItem;				var l : uint = (model as MMaps).length;				var d : Object;				var i : int = 0;				while( i < l ){										d = (model as MMaps).getItemAt(i);					o = Factory.build( MapItem , { datas : d , y : 30 * i , id : uint(d.id) });					if(i==0){						o.freeze(true);						(controller as CMaps).selection = o;					}					_spCONTAINER.addChild(o);										i++;				}									}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(VMaps, args);			}	}}