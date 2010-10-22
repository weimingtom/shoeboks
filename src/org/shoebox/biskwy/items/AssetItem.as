/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.items {		import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	import org.shoebox.display.text.TextFormatter;
	import flash.text.TextField;
	import org.shoebox.patterns.factory.Factory;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import org.shoebox.display.DisplayFuncs;
	import org.shoebox.display.BoxBitmapData;
	import flash.display.Bitmap;
	import flash.display.Shape;
	import org.shoebox.biskwy.data.MediaDesc;
	import flash.display.Sprite;
	import org.shoebox.utils.logger.Logger;		/**	* org.shoebox.biskwy.items.AssetItem	* @author shoebox	*/	public class AssetItem extends Sprite {				public var datas					: MediaDesc;		public var id					: uint;				protected var _bPREVIEW			: Bitmap;		protected var _spBORDER			: Shape = new Shape();			protected var _spCOLOR				: Shape = new Shape();			protected var _tfTEXT				: TextField;		protected var _tfTYPE				: TextField;		protected var _uSIZE				: uint = 125;			protected var _uCOLOR				: uint; 		protected var _oCOLORS				: Object;				// -------o constructor					/**			* Constructor of the AssetItem class			*			* @public			* @return	void			*/			public function AssetItem( uCOL : uint = 0xAFAFAF ) : void {								doubleClickEnabled = true;				buttonMode = true;				mouseChildren = false;								_uCOLOR = uCOL;				_draw();								_oCOLORS = {};				_oCOLORS['Tile'] = 0xFF6600;				_oCOLORS['SoundAsset'] = 0x00FF33;				_oCOLORS['Asset'] = 0xEFEFEF;								addChild( _spCOLOR );				addChild( _spBORDER );			}		// -------o public						/**			* set size function			* @public			* @param 			* @return			*/			final public function set size( u : uint ) : void {				_uSIZE = u;				_draw();			}						/**			* set color function			* @public			* @param 			* @return			*/			final public function set color( u : uint ) : void {				_uCOLOR = u;				_draw();			}						/**			* set type function			* @public			* @param 			* @return			*/			final public function set type( s : String ) : void {								if( _tfTYPE )					_tfTYPE.text = s;								_color( _oCOLORS[s] );			}						/**			* redraw function			* @public			* @param 			* @return			*/			final public function redraw() : void {
								_bPREVIEW = new Bitmap( BoxBitmapData.resize( datas.bMedia , 85 , 75 , false , true ));				addChild( _bPREVIEW );								DisplayFuncs.align( _bPREVIEW , new Rectangle( 0 , 0 , _uSIZE , _uSIZE ));				//_bPREVIEW.y -= 10;								if( !_tfTEXT ) { 										_tfTEXT = Factory.build( TextField , {													x			: 5, 													y			: _uSIZE - 20, 													width			: _uSIZE - 10, 													height		: 15,													background		: true, 													backgroundColor	: 0xFFFFFF,													textColor		: 0x2A2A2A												} );					TextFormatter.apply(_tfTEXT,8,'PF Tempesta Seven',TextFormatAlign.CENTER,TextFieldAutoSize.NONE);					addChild( _tfTEXT );					}								if( !_tfTYPE ){										_tfTYPE = Factory.build( TextField , {													x		: 10, 													y		: 5, 													width		: _uSIZE - 20, 													height	: 20,													text		: datas.sType,													textColor	: 0x2A2A2A												} );										TextFormatter.apply(_tfTYPE,8,'PF Tempesta Seven',TextFormatAlign.CENTER,TextFieldAutoSize.NONE);					addChild( _tfTYPE );					}				
				_tfTEXT.text = datas.iID+'';							}						/**			* over function			* @public			* @param 			* @return			*/			public function over() : void {				DisplayFuncs.setColor(_spBORDER , 0xEEEEEE);			}						/**			* out function			* @public			* @param 			* @return			*/			public function out() : void {				_spBORDER.transform.colorTransform = new ColorTransform();			}						/**			* selected function			* @public			* @param 			* @return			*/			final public function selected() : void {				buttonMode = false;				DisplayFuncs.setColor(_spBORDER , 0x0AB6f3);			}						/**			* unSelected function			* @public			* @param 			* @return			*/			final public function unSelected() : void {				buttonMode = true;				out();			}					// -------o protected						/**			* 			*			* @param 			* @return			*/			final protected function _draw() : void {
												_spBORDER.graphics.clear();				_spBORDER.graphics.beginFill( _uCOLOR );				_spBORDER.graphics.drawRect(4,4,_uSIZE - 8,_uSIZE - 8);
				_spBORDER.graphics.endFill();
											}						/**			* 			*			* @param 			* @return			*/			final protected function _color( u : uint ) : void {				_spCOLOR.graphics.clear();				_spCOLOR.graphics.beginFill( u );				_spCOLOR.graphics.drawRect( 0 , 0 , _uSIZE , _uSIZE );				_spCOLOR.graphics.endFill();			}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(AssetItem, args);			}	}}