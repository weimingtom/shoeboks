/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.items.scriptsEditor {	import flash.text.TextFieldAutoSize;
	import org.shoebox.core.BoxObject;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.utils.logger.Logger;	import flash.display.Sprite;	import flash.geom.Rectangle;	import flash.text.GridFitType;	import flash.text.TextField;	import flash.text.TextFormat;	/**	 * org.shoebox.biskwy.items.scriptsEditor.AAction	* @author shoebox	*/	public class AAction extends Sprite{				public var sACTION_NAME		: String;				protected var _cREF			: Class;		protected var _spLEFT			: Sprite = new Sprite();		protected var _spRIGHT			: Sprite = new Sprite();		protected var _mcSHAPE			: Sprite = new Sprite();		protected var _tfFIELD			: TextField = new TextField();		protected var _uMARGIN			: uint = 30;		protected var _uWIDTH			: uint = 100;		protected var _vVARIABLES		: Vector.<String>;		protected var _oREF			: *;						// -------o constructor					/**			* Constructor of the AAction class			*			* @public			* @return	void			*/			public function AAction( WIDTH : uint , sTEXT : String , cREF : Class , bIS_EVENT:Boolean = false ) : void {				trc('AAction contructor ::: '+arguments);								sACTION_NAME = sTEXT;								if( bIS_EVENT)						_oREF = new cREF(sTEXT);				else					_oREF = Factory.build( cREF );									_vVARIABLES = Vector.<String>([]);				_cREF = cREF;				_uWIDTH = WIDTH;				_mcSHAPE.graphics.beginFill( 0xAAAAAA );				//mouseEnabled = _mcSHAPE.mouseEnabled = false;				buttonMode = true;				//_mcSHAPE.graphics.lineStyle( 1 , 0xBBBBBB );				addChild( _mcSHAPE );												var oFORMAT : TextFormat = new TextFormat('Verdana', 14 , 0xAAAAAA , false , true , false , null , null , 'center' );				BoxObject.accessorInit( _tfFIELD , 	{												defaultTextFormat : oFORMAT,											height : 25 , width : WIDTH , y : -20 ,											gridFitType : GridFitType.PIXEL,											mouseEnabled : false, selectable:false, 											text:sTEXT, 											autoSize:TextFieldAutoSize.LEFT										});				_tfFIELD.setTextFormat( oFORMAT );				_tfFIELD.x = ( WIDTH - _tfFIELD.width ) / 2;				_spRIGHT.x = WIDTH + 10;				_spLEFT.x = -10;				addChild( _tfFIELD );				addChild( _spLEFT );				addChild( _spRIGHT );			}		// -------o public						/**			* getRefClass function			* @public			* @param 			* @return			*/			final public function get refClass() : Class {				return _cREF;			}						/**			* get referenceInstance function			* @public			* @param 			* @return			*/			final public function get referenceInstance() : * {				return _oREF;			}						/**			* Link a variable to the action function			* @public			* @param 	x : Variable desc XML obtained from the describe type of the reference class (XML)			* @return	void			*/			final public function addVariable( x : XML  ) : void {				_vVARIABLES.push( x.@name );			}			/**			* get variables function			* @public			* @param 			* @return			*/			final public function get variables() : Vector.<String> {				return _vVARIABLES;			}			/**			* Add an anchor to the action			* Nota : the anchor xml desc is obtained from the describte type of the refetence class			* 			* @public			* @param 	s 	: Anchor name - only used for display purpose (String)			* @param 	bLeft : Input or output channel (Boolean)			* @param 	x	: Anchor XML desc  (XML)			* @return	void			*/			final public function addAnchor( s : String , bLeft : Boolean = true , x : XML = null  ) : void {				trc('addAnchor ::: '+arguments);				//					var 	o : Anchor = new Anchor( s , bLeft , x );						o.actionRef = this;						o.y = ((( bLeft ) ? _spLEFT : _spRIGHT).numChildren + 1 ) * 20;						o.init();						 				//					(( bLeft ) ? _spLEFT : _spRIGHT).addChild( o );									//					_mcSHAPE.height = Math.max( _spLEFT.height , _spRIGHT.height ) + 30 + _uMARGIN * 2;			}						/**			* getAnchor function			* @public			* @param 			* @return			*/			final public function getAnchor( x : XML ) : Anchor {												//					var o : Anchor;					var l : int = _spLEFT.numChildren ;					var i : int = 0;								//					for( i ; i < l ; i++ ){												o = _spLEFT.getChildAt(i) as Anchor;												if( o.descXML == x )							return o;												}								//					i = 0;					l = _spRIGHT.numChildren ;					for( i ; i < l ; i++ ){											o = _spRIGHT.getChildAt(i) as Anchor;												if( o.descXML == x )							return o;					}								return null;						}			/**			* Draw a rectangular action shape			* 			* @public			* @return	void			*/			final public function _drawRect() : void {				_uMARGIN = 0;				_mcSHAPE.graphics.drawRect( 0 , 0 , _uWIDTH , 100 );			}						/**			* Draw a triangular action shape			*			* @return	void			*/			final protected function _drawTriangle() : void {				_uMARGIN = 0;				var w : int = (_uWIDTH - 50 ) / 2;				_spLEFT.x = w - 10;				_mcSHAPE.graphics.drawCircle( w +25  , _uMARGIN + 25 , 25 );			}						/**			* Draw an hexagonal action shape			*			* @return	void			*/			final protected function _drawHex() : void {								_mcSHAPE.graphics.moveTo( 0 , _uMARGIN );				_mcSHAPE.graphics.lineTo(_uWIDTH/2 , 0);				_mcSHAPE.graphics.lineTo(_uWIDTH , _uMARGIN);				_mcSHAPE.graphics.lineTo(_uWIDTH , _uMARGIN + 100 );				_mcSHAPE.graphics.lineTo(_uWIDTH/2 , _uMARGIN*2 + 100 );				_mcSHAPE.graphics.lineTo(0 , _uMARGIN + 100 );				_mcSHAPE.graphics.lineTo(0 , _uMARGIN);				_spLEFT.y = _spRIGHT.y = _uMARGIN;												var oREC : Rectangle = new Rectangle(1, _uMARGIN, _uWIDTH - 2, 50);				_mcSHAPE.scale9Grid = oREC;				//_mcSHAPE.graphics.drawRect( 0 , 0 , _uWIDTH , 100 );			}					// -------o protected					// -------o misc			public static function trc(...args : *) : void {				Logger.log(AAction, args);			}	}}