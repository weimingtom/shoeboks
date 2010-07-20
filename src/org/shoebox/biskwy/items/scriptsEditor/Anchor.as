/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.items.scriptsEditor {	import flash.utils.getDefinitionByName;
	import org.shoebox.core.BoxObject;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.utils.logger.Logger;	import flash.display.Sprite;	import flash.text.GridFitType;	import flash.text.TextField;	import flash.text.TextFieldAutoSize;	import flash.text.TextFormat;	/**	 * org.shoebox.biskwy.items.scriptsEditor.Anchor	* @author shoebox	*/	public class Anchor extends Sprite {				public var actionRef		:AAction;				protected var _bRIGHT		:Boolean;		protected var _spSQUARE		:Sprite = new Sprite();		protected var _oTF		:TextField = new TextField();		protected var _oXML		:XML;		protected var _oREF		:*;				// -------o constructor					/**			* Constructor of the Anchor class			*			* @public			* @return	void			*/			public function Anchor( sTEXT : String , bREVERT : Boolean = false , x : XML = null ) : void {								//					buttonMode = true;					mouseChildren = false;					_bRIGHT = bREVERT;					_oXML = x;									//					_spSQUARE.graphics.beginFill( 0x333333 );					_spSQUARE.graphics.drawRect( 0 , 1 , 8 , 8 );					_spSQUARE.graphics.endFill();					_spSQUARE.buttonMode = _spSQUARE.useHandCursor = true;					_spSQUARE.x = bREVERT ? 0 : -8;					_spSQUARE.name = 'Anchor';					addChild( _spSQUARE );					hitArea = _spSQUARE;									//					BoxObject.accessorInit( _oTF , 	{												defaultTextFormat : new TextFormat('Verdana',11 , 0xFFFFFF , false , false , false , null , null , 'center' ),											height : 20  , y : -4,											gridFitType : GridFitType.PIXEL,											autoSize : TextFieldAutoSize.LEFT,											mouseEnabled : false ,											selectable : false										});					_oTF.text = sTEXT;					addChild( _oTF );													//					_oTF.x = bREVERT ? 10 : -(10 +_oTF.width) ;									}		// -------o public								/**			* get square function			* @public			* @param 			* @return			*/			final public function get square() : Sprite {				return _spSQUARE;			}						/**			* get right function			* @public			* @param 			* @return			*/			final public function get right() : Boolean {				return _bRIGHT;			}						/**			* get reference function			* @public			* @param 			* @return			*/			final public function get reference() : * {				return _oREF;			}						/**			* init function			* @public			* @param 			* @return			*/			final public function init() : void {				_init();			}							// -------o protected						/**			* 			*			* @param 			* @return			*/			final protected function _init() : void {				trc('init ::: '+_oXML.name());								switch( _oXML.name().toString() ){										case 'method':						_oREF = actionRef.referenceInstance[_oXML.@name];						break;										case 'metadata':											if( _oXML.@name == 'Event'){							trace('addEvent ::: '+_oXML);							_oREF = new (getDefinitionByName(_oXML..arg.(@key=='type')[0].@value ))( _oXML..arg.(@key=='name')[0].@value );							trc('event reference ::: '+_oREF);						}else																	break;									}							}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(Anchor, args);			}	}}