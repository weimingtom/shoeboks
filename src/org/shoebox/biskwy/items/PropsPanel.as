/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.items {	import fl.controls.ScrollPolicy;
	import fl.containers.ScrollPane;	import org.shoebox.display.DisplayFuncs;	import org.shoebox.patterns.factory.Factory;	import flash.display.Sprite;	import flash.geom.Point;	/**	 * org.shoebox.biskwy.items.PropsPanel	* @author shoebox	*/	public class PropsPanel extends Sprite {				public static const PROP_TITLE	:String = 'title';		public static const PROP_BOOLEAN	:String = 'boolean';		public static const PROP_STRING	:String = 'string';		public static const PROP_PATH		:String = 'path';		public static const PROP_NUMBER	:String = 'number';				protected var _oSCROLLBAR	:ScrollPane;		protected var _ptSIZE		:Point = new Point( 300 , 500 );		protected var _spBACK		:Sprite = new Sprite();		protected var _spBORDER		:Sprite = new Sprite();		protected var _spCONTAINER	:Sprite = new Sprite();		protected var _oXML		:XML;		protected var _vITEMS		:Vector.<PropsPanelItem>;				// -------o constructor					/**			* Constructor of the PropsPanel class			*			* @public			* @return	void			*/			public function PropsPanel() : void {				trc('constructor');								//										//_spBORDER.graphics.lineStyle( 1 , 0x2A2A2A , .2);					//_spBORDER.graphics.drawRect( 0 , 0 , 300 , 400 );					//addChild( _spBORDER );									//					_spCONTAINER = new Sprite();					addChild( _spCONTAINER );										_oSCROLLBAR = new ScrollPane();					_oSCROLLBAR.source = _spCONTAINER;					_oSCROLLBAR.setSize( 300 , 400 );					_oSCROLLBAR.horizontalScrollPolicy = ScrollPolicy.OFF;					addChild(_oSCROLLBAR);			}		// -------o public						/**			* Setting the size of the <code>PropsPanel</code>			* 			* @public			* @param	w : components width 	(uint) 			* @param	h : components height 	(uint) 			* @return	void			*/			public function setSize( w : uint , h : uint ) : void {				trc('setSize ::: '+w+' / '+h);				_ptSIZE.x = w;				_ptSIZE.y = h;				_oSCROLLBAR.setSize( w , h );			}						/**			* Redrawning the <code>PropsPanel</code>			* 			* @public			* @return	void			*/			public function redraw() : void {				_redraw();			}						/**			* Setter of the <code>PropsPanel</code> dataProvider			* 			* @public			* @param	dp : XML dataprovider (XML) 			* @return	void			*/			public function set dataProvider( dp : XML ) : void {				_oXML = dp;				_redraw();			}						/**			* Return the <code>PropsPanel</code> dataProvider XML filled			* 			* @public			* @return	dataprovider XML (XML)			*/			public function get dataProvider() : XML {								var 	oOBJ 	: Object = getDatas();				var	sPROP : String;				var 	oTMP 	: XML = new XML(_oXML.toString());								for( sPROP in oOBJ ){										//						if(oTMP..sub.(@prop == sPROP).length() > 0){							oTMP..sub.(@prop == sPROP)[0].@value = oOBJ[sPROP];							continue;						}											//						if(oTMP..entry.(@prop == sPROP).length == 0)							continue;													oTMP..entry.(@prop == sPROP)[0].@value = oOBJ[sPROP]; 										}				return oTMP;			}						/**			* Getter of the datas			* 			* @public			* @return	datas ( Object )			*/			public function getDatas() : Object {				var oRES : Object = {};				var u : uint = 0;				var l : uint = _vITEMS.length;				var o : PropsPanelItem;				for( u ; u < l ; u ++ ){										o = _vITEMS[u];					oRES[o.propName] = o.value;				}				return oRES;			}					// -------o protected				/**			* Redrawning the <code>PropsPanel</code>			*			* @return	void			*/			protected function _redraw() : void {				trc('redraw');								//					_spBORDER.width = _ptSIZE.x;					_spBORDER.height = _ptSIZE.y;									//					DisplayFuncs.purge( _spCONTAINER );					_vITEMS = new Vector.<PropsPanelItem>();										var uINC 	: uint = 0;					var uINC2	: uint;					var uLEN 	: uint = _oXML..entry.length();					var uH 	: uint = 0;					var oPROP 	: PropsPanelItem;					var uY	: uint;					var oXML 	: XML;					var oSUB	: XML;					var uSUBS	: uint;														for( uINC ; uINC < uLEN ; uINC++ ){												oXML = _oXML..entry[uINC];						uH = (oXML.@type == PropsPanel.PROP_TITLE) ? 30 : 25;												//							if(oXML.@type == PropsPanel.PROP_TITLE)								uY += 10; 						//							oPROP = Factory.build( PropsPanelItem , { propName : oXML.@prop , y : uY , width : _ptSIZE.x , height : uH , datas : oXML });							oPROP.draw();							_spCONTAINER.addChild( oPROP );							uY += uH;							_vITEMS.push( oPROP );													//subs							uSUBS = oXML..sub.length();							uINC2 = 0;							uH = 25;							for( uINC2 ; uINC2 < uSUBS ; uINC2++ ){																oPROP = Factory.build( PropsPanelItem , { propName : oXML..sub[uINC2].@prop , isSubProp : true , y : uY , width : _ptSIZE.x , height : uH , datas : oXML..sub[uINC2] });								oPROP.draw();								_spCONTAINER.addChild( oPROP );								uY+= uH;								_vITEMS.push( oPROP );							}																			}								_oSCROLLBAR.update();				}		// -------o misc			public static function trc(...args : *) : void {				//Logger.log(PropsPanel, args);			}	}}	import fl.controls.CheckBox;	import fl.controls.NumericStepper;	import fl.controls.TextArea;	import fl.controls.TextInput;		import org.shoebox.biskwy.items.PropsPanel;	import org.shoebox.patterns.factory.Factory;		import flash.display.Sprite;	import flash.text.TextField;	import flash.text.TextFormat;		/**	* org.shoebox.biskwy.items.PropsPanel	* @author shoebox	*/	internal class PropsPanelItem extends Sprite {				protected var _bISSUB		:Boolean = false;		protected var _cbBOOL		:CheckBox;		protected var _oSTEPPER		:NumericStepper;		protected var _spCONTAINER	:Sprite = new Sprite();		protected var _spBACK		:Sprite = new Sprite();		protected var _oINPUT		:TextInput;		protected var _uWIDTH		:uint;		protected var _uHEIGHT		:uint;		protected var _uBORDER		:uint = 3;		protected var _sPROP		:String;		protected var _oDATAS		:XML;				// -------o constructor					/**			* Constructor of the PropsPanelItem class			*			* @public			* @return	void			*/			public function PropsPanelItem() : void {				addChild( _spBACK );				addChild(_spCONTAINER);			}		// -------o public					/**			* set propName function			* @public			* @param 			* @return			*/			public function set propName( s : String ) : void {				_sPROP = s;			}						/**			* get propName function			* @public			* @param 			* @return			*/			public function get propName() : String {				return _sPROP;			}					/**			* set width function			* @public			* @param 			* @return			*/			override public function set width( w : Number ) : void {				_uWIDTH = w;			}						/**			* set height function			* @public			* @param 			* @return			*/			override public function set height( h : Number ) : void {				_uHEIGHT = h;			}						/**			* set datas function			* @public			* @param 			* @return			*/			public function set datas( o : XML ) : void {				_oDATAS = o;			}						/**			* isSubProp function			* @public			* @param 			* @return			*/			public function set isSubProp( b : Boolean ) : void {				_bISSUB = b;			}						/**			* draw function			* @public			* @param 			* @return			*/			public function draw() : void {								_spBACK.graphics.lineStyle( 1 , 0x2A2A2A , .2);				_spBACK.graphics.moveTo( 0 , _uHEIGHT);				_spBACK.graphics.lineTo( _uWIDTH , _uHEIGHT );								var oTF : TextField;				var oFIELD : TextArea;				var w3 : uint = _uWIDTH * .60 - 40;								//					if( String(_oDATAS.@type) !== PropsPanel.PROP_TITLE){												//								oTF = Factory.build( TextField , { 														embedFonts : true , 														x : (_bISSUB ? 30 : 15) , y : 5 , 														width : w3 - (_bISSUB ? 30 : 15)  , 														height : 20 , 														text : _oDATAS.@label , 														selectable : true														}  ) as TextField;																						oTF.setTextFormat( new TextFormat('PF Tempesta Seven',8, (_bISSUB) ? 0x666666 : 0x2A2A2A, (_oDATAS..sub.length() > 0)) );								_spCONTAINER.addChild( oTF );														//							_spBACK.graphics.moveTo( w3 , 0 );							_spBACK.graphics.lineTo( w3 , 25 );												}									//					switch( String(_oDATAS.@type) ){												case PropsPanel.PROP_TITLE:														//								graphics.beginFill( 0x666666 );								graphics.drawRect( 5 , 0  , _uWIDTH - 2 , _uHEIGHT );								graphics.endFill();														//								oTF = Factory.build( TextField , { 															embedFonts : true , 														x : 15 , y : 5 , 														width : _uWIDTH - 42 , 														height : 20 , 														text : _oDATAS.@label , 														selectable : false														}  ) as TextField;																						oTF.setTextFormat( new TextFormat('PF Tempesta Seven',8,0xFFFFFF,true) );								_spCONTAINER.addChild( oTF );							break;												case PropsPanel.PROP_PATH:						case PropsPanel.PROP_STRING:														//								_oINPUT = Factory.build( TextInput , { 															x : w3 + 5, 															width : _uWIDTH - w3 - 20 , 															text : _oDATAS.@value , 															height : 25 ,															editable : true,															name : _oDATAS.@prop, y : 5														} );								_spCONTAINER.addChild(_oINPUT);															break;													case PropsPanel.PROP_BOOLEAN:														//									_cbBOOL = Factory.build( CheckBox , { x : w3 , label : '' , y : 2 , name : _oDATAS.@prop , height : 20} );								_cbBOOL.selected = (String(_oDATAS.@value) == 'true');								_spCONTAINER.addChild( _cbBOOL );														break;												case PropsPanel.PROP_NUMBER:														//								_oSTEPPER = Factory.build( NumericStepper , { 																x 		: w3 + 5, 																width 	: _uWIDTH - w3 - 20, 																height 	: 25 ,																minimum 	: _oDATAS.@min , 																maximum 	: _oDATAS.@max , 																value 	: _oDATAS.@value , 																name 		: _oDATAS.@prop															} );														//								_oSTEPPER.minimum = Number(_oDATAS.@min);								_oSTEPPER.maximum = Number(_oDATAS.@max);								_oSTEPPER.value 	= Number(_oDATAS.@value);								_spCONTAINER.addChild(_oSTEPPER);															break;					}			}						/**			* get value function			* @public			* @param 			* @return			*/			public function get value() : * {								//					switch( String(_oDATAS.@type) ){																		case PropsPanel.PROP_PATH:						case PropsPanel.PROP_STRING:							return _oINPUT.text;							break;													case PropsPanel.PROP_BOOLEAN:							return _cbBOOL.selected;							break;												case PropsPanel.PROP_NUMBER:							return _oSTEPPER.value;							break;					}								return 'unknow';			}				// -------o protected		// -------o misc			public static function trc(...args : *) : void {				//Logger.log(PropsPanelItem, args);			}	}