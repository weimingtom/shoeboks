/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.views {	import fl.controls.Button;	import fl.controls.ComboBox;	import org.shoebox.biskwy.commands.menu.CommandGroupEdit;	import org.shoebox.biskwy.commands.tools.ToolGroups;	import org.shoebox.biskwy.models.MGroups;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.patterns.mvc.abstracts.AView;	import org.shoebox.patterns.mvc.events.UpdateEvent;	import org.shoebox.patterns.mvc.interfaces.IView;	import org.shoebox.utils.logger.Logger;	import flash.display.Loader;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.geom.Matrix;	/**	 * org.shoebox.biskwy.views.VGroups	* @author shoebox	*/	public class VGroups extends AView implements IView {				protected var _oLOADER			:Loader = new Loader();		protected var _btnEDIT			:Button;		protected var _btnCREATE		:Button;		protected var _cbCONTENT		:ComboBox;				// -------o constructor					/**			* Constructor of the VGroups class			*			* @public			* @return	void			*/			public function VGroups() : void {								//					graphics.lineStyle( 1 , 0x2A2A2A , .5);					graphics.moveTo( 5 , 210 );					graphics.lineTo( 165 , 210 );										graphics.lineStyle( 0 , 0x2A2A2A , 0);					graphics.beginFill( 0xBBBBBB );					graphics.drawRect( 10 , 40 , 150 , 130 );					graphics.endFill();								// Group edition button					_btnEDIT 	= Factory.build( Button , { name:'edit' , x : 10 , y : 180 , width : 150 , label : 'Edit'} );					_btnCREATE 	= Factory.build( Button , { name:'create' , x : 10 , y : 220 , width : 150 , label : 'Create new'} );					addChild(_btnCREATE);					addChild(_btnEDIT);														// Group list combobox					_cbCONTENT = Factory.build( ComboBox , { x : 10 , y : 10 , width : 150 } );					addChild(_cbCONTENT);									//					_oLOADER.y = 40;					addChild(_oLOADER);								}		// -------o public						/**			* When the view is initialized			* 			* @public			* @return	void			*/			final override public function initialize() : void {				controller.registerCommand( CommandGroupEdit , {} , _btnCREATE , MouseEvent.CLICK , false , 10 , true );				controller.register( _btnEDIT , MouseEvent.CLICK , false , 10 , true );					controller.register( _cbCONTENT , Event.CHANGE , false , 10 , true );				}							/**			* When the view receive an update			* 			* @public			* @param	o : update event (UpdateEvent)	 			* @return	void			*/			override final public function update( o:UpdateEvent = null) : void {				trc('update');				_cbCONTENT.dataProvider = (model as MGroups).dataProvider;				_redraw();			}												/**			* When the view is canceled			* 			* @public			* @param	e : cancel event (Event) 			* @return	void			*/			override final public function cancel( e:Event = null) : void {				controller.unRegisterCommand( CommandGroupEdit, _btnCREATE , MouseEvent.CLICK );				controller.unRegister( _btnEDIT , MouseEvent.CLICK , false );					controller.unRegister( _cbCONTENT , Event.CHANGE , false );				}						/**			* redraw function			* @public			* @param 			* @return			*/			public function redraw() : void {				_redraw();			}						// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _redraw() : void {				trc('redraw ::: '+(model as MGroups).datas);				_oLOADER.contentLoaderInfo.addEventListener( Event.COMPLETE , _onComplete , false , 10 , true );				_oLOADER.loadBytes((model as MGroups).datas.img);								//					ToolGroups.getInstance().setSize((model as MGroups).datas.baseW , (model as MGroups).datas.baseH + (model as MGroups).datas.height);			}						/**			* 			*			* @param 			* @return			*/			protected function _onComplete( e : Event ) : void {				e.target.removeEventListener( Event.COMPLETE , _onComplete , false );								_oLOADER.transform.matrix = new Matrix();								var 	nS : Number = Math.min( _oLOADER.width / 150 , _oLOADER.height / 130 );								var 	oMAT : Matrix = new Matrix();						oMAT.scale( nS , nS );					oMAT.translate( 10 + (150 - _oLOADER.width * nS)/2 , 40 + (130 - _oLOADER.height * nS)/2 );								_oLOADER.transform.matrix = oMAT;			}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(VGroups, args);			}	}}