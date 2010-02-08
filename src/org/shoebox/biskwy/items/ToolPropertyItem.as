/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.items {	import fl.controls.CheckBox;	import fl.controls.ComboBox;	import fl.controls.Label;	import fl.controls.NumericStepper;	import fl.core.UIComponent;	import org.shoebox.biskwy.commands.tools.ATool;	import org.shoebox.biskwy.data.ToolProp;	import org.shoebox.display.DisplayFuncs;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.utils.Relegate;	import org.shoebox.utils.logger.Logger;	import flash.display.Sprite;	import flash.events.Event;	import flash.text.TextFieldAutoSize;	import flash.text.TextFormat;	/**	 * org.shoebox.biskwy.items.ToolPropertyItem	* @author shoebox	*/	public class ToolPropertyItem extends Sprite {				protected var _oDEFAULTVALUE 	: *;		protected var _oPROPS		: ToolProp;		protected var _oCOMPONENT	: UIComponent;				// -------o constructor					public function ToolPropertyItem( o : ToolProp , oDEFAULTVALUE : *) : void {				trc('constructor ::: '+arguments);				_oDEFAULTVALUE = oDEFAULTVALUE;				_oPROPS = o;				_draw();			}		// -------o public						/**			* get component function			* @public			* @param 			* @return			*/			public function get component() : UIComponent {				return _oCOMPONENT;			}						/**			* get type function			* @public			* @param 			* @return			*/			public function get type() : String {				return _oPROPS.type;			}						/**			* get props function			* @public			* @param 			* @return			*/			public function get props() : ToolProp {				return _oPROPS;			}					// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _draw() : void {								var l : Label;				var o : UIComponent;				switch( _oPROPS.type ){										case ATool.P_CHECKBOX:						o = new CheckBox();						(o as CheckBox).textField.autoSize = TextFieldAutoSize.LEFT;						(o as CheckBox).label = _oPROPS.props.label;						(o as CheckBox).selected = _oDEFAULTVALUE as Boolean;						o.setStyle('textFormat', new TextFormat('PF Tempesta Seven_8pt_st',8,0xFFFFFF) );						break;											case ATool.P_COMBOBOX:						o = new ComboBox();						o.x = 50;						(o as ComboBox).dataProvider = _oPROPS.dataProvider;						l = Factory.build( Label , {text : _oPROPS.props.label , autoSize : TextFieldAutoSize.LEFT} );						l.setStyle('textFormat', new TextFormat('PF Tempesta Seven_8pt_st',8,0xFFFFFF) );						addChild(l);						break;											case ATool.P_STEPPER:						l = Factory.build( Label , {text : _oPROPS.props.label , autoSize : TextFieldAutoSize.LEFT} );						l.setStyle('textFormat', new TextFormat('PF Tempesta Seven_8pt_st',8,0xFFFFFF) );						addChild(l);						o = Factory.build(NumericStepper, { minimum : 0, maximum : 1000, x : 50, y : 0, value : _oDEFAULTVALUE as uint });						break;									}								o.name = _oPROPS.propName;				addChild(o);				_oCOMPONENT = o;								Relegate.afterFrame( this , _align , 3 );			}						/**			* 			*			* @param 			* @return			*/			protected function _align( e : Event ) : void {				DisplayFuncs.distributeX( this , 5 );			}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(ToolPropertyItem, args);			}	}}