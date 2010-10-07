/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.items {		import fl.data.DataProvider;	import fl.controls.ComboBox;	import fl.controls.CheckBox;	import fl.controls.NumericStepper;	import fl.controls.TextArea;	import fl.controls.TextInput;		import org.shoebox.biskwy.items.PropsPanel;	import org.shoebox.patterns.factory.Factory;	import flash.events.Event;	import flash.display.Sprite;	import flash.text.TextField;	import flash.text.TextFormat;		/**	* org.shoebox.biskwy.items.PropsPanel	* @author shoebox	*/	public class PropsPanelItem extends Sprite {				protected var _bISSUB			:Boolean = false;		protected var _cbBOOL			:CheckBox;		protected var _oCOMBO			:ComboBox;		protected var _oSTEPPER		:NumericStepper;		protected var _spCONTAINER		:Sprite = new Sprite();		protected var _spBACK			:Sprite = new Sprite();		protected var _sPROP			:String;		protected var _oINPUT			:TextInput;		protected var _uWIDTH			:uint;		protected var _uHEIGHT			:uint;		protected var _uBORDER			:uint = 3;		protected var _oDATAS			:XML;				// -------o constructor					/**			* Constructor of the PropsPanelItem class			*			* @public			* @return	void			*/			public function PropsPanelItem() : void {				addChild( _spBACK );				addChild(_spCONTAINER);				addEventListener( Event.CHANGE , _onChanged , true , 100000000 , true );			}		// -------o public					/**			* set propName function			* @public			* @param 			* @return			*/			public function set propName( s : String ) : void {				trace('--------- set propName ::: '+s);				_sPROP = s;			}						/**			* get propName function			* @public			* @param 			* @return			*/			public function get propName() : String {				return _sPROP;			}					/**			* set width function			* @public			* @param 			* @return			*/			override public function set width( w : Number ) : void {				_uWIDTH = w;			}						/**			* set height function			* @public			* @param 			* @return			*/			override public function set height( h : Number ) : void {				_uHEIGHT = h;			}						/**			* set datas function			* @public			* @param 			* @return			*/			public function set datas( o : XML ) : void {				_oDATAS = o;			}						/**			* isSubProp function			* @public			* @param 			* @return			*/			public function set isSubProp( b : Boolean ) : void {				_bISSUB = b;			}						/**			* draw function			* @public			* @param 			* @return			*/			public function draw() : void {								_spBACK.graphics.lineStyle( 1 , 0x2A2A2A , .2);				_spBACK.graphics.moveTo( 0 , _uHEIGHT);				_spBACK.graphics.lineTo( _uWIDTH , _uHEIGHT );								var oTF : TextField;				var oFIELD : TextArea;				var w3 : uint = _uWIDTH * .60 - 40;								//					if( String(_oDATAS.@type) !== PropsPanel.PROP_TITLE){												//								oTF = Factory.build( TextField , { 														embedFonts : true , 														x : (_bISSUB ? 30 : 15) , y : 5 , 														width : w3 - (_bISSUB ? 30 : 15)  , 														height : 20 , 														text : _oDATAS.@label , 														selectable : true														}  ) as TextField;																						oTF.setTextFormat( new TextFormat('PF Tempesta Seven',8, (_bISSUB) ? 0x666666 : 0x2A2A2A, (_oDATAS..sub.length() > 0)) );								_spCONTAINER.addChild( oTF );														//							_spBACK.graphics.moveTo( w3 , 0 );							_spBACK.graphics.lineTo( w3 , 25 );												}									// 					trace('type ::: ' + _oDATAS.@type);					switch( String(_oDATAS.@type) ){												case PropsPanel.PROP_TITLE:														//								graphics.beginFill( 0x666666 );								graphics.drawRect( 5 , 0  , _uWIDTH - 2 , _uHEIGHT );								graphics.endFill();														//								oTF = Factory.build( TextField , { 															embedFonts : true , 														x : 15 , y : 5 , 														width : _uWIDTH - 42 , 														height : 20 , 														text : _oDATAS.@label , 														selectable : false														}  ) as TextField;																						oTF.setTextFormat( new TextFormat('PF Tempesta Seven',8,0xFFFFFF,true) );								_spCONTAINER.addChild( oTF );							break;												case PropsPanel.PROP_PATH:						case PropsPanel.PROP_STRING:							trace('string');							//								_oINPUT = Factory.build( TextInput , { 															x : w3 + 5, 															width : _uWIDTH - w3 - 20 , 															text : _oDATAS.@value , 															height : 25 ,															editable : true,															name : _oDATAS.@prop, y : 5														} );								_spCONTAINER.addChild(_oINPUT);															break;													case PropsPanel.PROP_BOOLEAN:														//									_cbBOOL = Factory.build( CheckBox , { x : w3 , label : '' , y : 2 , name : _oDATAS.@prop , height : 20} );								_cbBOOL.selected = (String(_oDATAS.@value) == 'true');								_spCONTAINER.addChild( _cbBOOL );														break;												case PropsPanel.PROP_NUMBER:														//								_oSTEPPER = Factory.build( NumericStepper , { 																x 		: w3 + 5, 																width 	: _uWIDTH - w3 - 20, 																height 	: 25 ,																name 		: _oDATAS.@prop															} );														//								_oSTEPPER.stepSize = .1;								_oSTEPPER.minimum = Number( (_oDATAS.attribute('min').length() == 0 ) ? -100000 : _oDATAS.@min );								_oSTEPPER.maximum = Number( (_oDATAS.attribute('max').length() == 0 ) ? 100000 : _oDATAS.@max );								_oSTEPPER.value 	= Number( (_oDATAS.attribute('value').length() == 0 ) ? 0 : _oDATAS.@value );								_spCONTAINER.addChild(_oSTEPPER);															break;													case PropsPanel.PROP_COMBO:														//								var 	aTMP 	: Array = _oDATAS.@options.split(',');								var 	oDP 	: DataProvider = new DataProvider();								for each( var s : String in aTMP )  									oDP.addItem( { label : s , value : s } );															//								var i : uint = 0;								var l : uint = oDP.length;								for( i ; i < l ; i++ ){									if( oDP.getItemAt(i).label == _oDATAS.@value )											break;								}															//								_oCOMBO = Factory.build( ComboBox  , 	{															x 		: w3 + 5, 															width 	: _uWIDTH - w3 - 20, 															height 	: 25															});								_oCOMBO.dataProvider = oDP;								_oCOMBO.selectedIndex = i;								_spCONTAINER.addChild(_oCOMBO);							break;											}			}						/**			* get value function			* 			* @public			* @param 			* @return				*/			public function get value() : * {								//					switch( String(_oDATAS.@type) ){																		case PropsPanel.PROP_PATH:						case PropsPanel.PROP_STRING:							return _oINPUT.text;							break;													case PropsPanel.PROP_BOOLEAN:							return _cbBOOL.selected;							break;												case PropsPanel.PROP_NUMBER:							return _oSTEPPER.value;							break;													case PropsPanel.PROP_COMBO:							return _oCOMBO.selectedItem.value;					}								return 'unknow';			}				// -------o protected						/**			* 			*			* @param 			* @return			*/			final protected function _onChanged( e : Event ) : void {				trace('_onChanged ::: '+_onChanged);				e.stopImmediatePropagation();
				e.preventDefault();
				dispatchEvent( new Event( PropsPanel.PROP_CHANGED , true , false ) );			}					// -------o misc			public static function trc(...args : *) : void {				//Logger.log(PropsPanelItem, args);			}	}}