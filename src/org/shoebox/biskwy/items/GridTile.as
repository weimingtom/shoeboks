/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.items {	import org.shoebox.biskwy.core.Config;	import org.shoebox.biskwy.core.IsoGrid;	import org.shoebox.biskwy.core.TwoD;	import org.shoebox.utils.logger.Logger;	import flash.display.Sprite;	/**	 * The GridTile class is the representation of the tile in to the map	* It contains a border preview shape, a background clip for hittest purpose and a container	* 	* The drawing method of the tile depend of the namespace in the Config class	*	* @see Config	* org.shoebox.biskwy.items.GridTile	* @author shoebox	*/	public class GridTile extends Sprite{				protected var _nALPHA			:Number = .1;		protected var _spBACK			:Sprite = new Sprite();		protected var _spBORDER		:Sprite = new Sprite();		protected var _spCONTAINER		:TileLayersGroup = new TileLayersGroup();		protected var _spOVER			:Sprite = new Sprite();		protected var _uLINECOL		:uint = 0x888888;				// -------o constructor					public function GridTile(nALPHA : Number = .1 , uLINECOL : uint = 0x888888) : void {								_uLINECOL = uLINECOL;				_nALPHA = nALPHA;								buttonMode = true;				mouseChildren = false;								_spBACK.name = 'back';				_spCONTAINER.name = 'container';				_spBORDER.name = 'border';								hitArea = _spBACK;												addChild(_spBACK);				addChild(_spCONTAINER);				addChild(_spBORDER);				addChild(_spOVER);								var 	ns : Namespace = Config.GRIDTYPE;					ns :: draw();			}		// -------o public						/**			* clear function			* @public			* @param 			* @return			*/			public function clear() : void {				_spCONTAINER.clear();			}						/**			* get back function			* @public			* @param 			* @return			*/			public function get back() : Sprite {				return _spBACK;			}						/**			* over function			* @public			* @param 			* @return			*/			public function over() : void {				_spOVER.visible = true;			}						/**			* out function			* @public			* @param 			* @return			*/			public function out() : void {				_spOVER.visible = false;			}									/**			* get container function			* @public			* @param 			* @return			*/			public function get container() : TileLayersGroup {				return _spCONTAINER;			}						/**			* Remove from the container the sprite with the specified id			* @public				* @param 	id : ID of the sprite to be removed			* @return	void			*/			public function remove( id : uint ) : void {				_spCONTAINER.remove(id);							}						/**			* Draw the tile for a 2D grid 			* @public			* @return void			*/			TwoD function draw() : void {								//					_spBORDER.graphics.lineStyle( 2 , _uLINECOL , 1 , true);					_spBORDER.graphics.drawRect( 0 , 0 , Config.TILESIZE , Config.TILESIZE );								//For hittest purpose					_spBACK.graphics.beginFill(0xEEEEEE);					_spBACK.graphics.drawRect( 0 , 0 , Config.TILESIZE , Config.TILESIZE );					_spBACK.graphics.endFill();			}						/**			* draw function			* @public			* @param 			* @return			*/			IsoGrid function draw() : void {								//					var w : Number = Config.TILESIZE;					var h : Number = Config.TILESIZE / 2;					_spBORDER.graphics.lineStyle( .1 , _uLINECOL , _nALPHA , true);					_spBORDER.graphics.beginFill(0,0);					_spBORDER.graphics.moveTo( 0 , h / 2);					_spBORDER.graphics.lineTo( w/2 , 0 );					_spBORDER.graphics.lineTo( w , h/2 );					_spBORDER.graphics.lineTo( w/2 , h );					_spBORDER.graphics.lineTo( 0 , h/2 );									//For hittest purpose					_spBACK.graphics.beginFill(0xEEEEEE , .1);					_spBACK.graphics.moveTo( 0 , h / 2);					_spBACK.graphics.lineTo( w/2 , 0 );					_spBACK.graphics.lineTo( w , h/2 );					_spBACK.graphics.lineTo( w/2 , h );					_spBACK.graphics.lineTo( 0 , h/2 );								//					_spOVER.graphics.lineStyle( .1 , 0xFF0000 , 1);					//_spOVER.graphics.beginFill(0xFF0000 , .1);					_spOVER.graphics.moveTo( 0 , h / 2);					_spOVER.graphics.lineTo( w/2 , 0 );					_spOVER.graphics.lineTo( w , h/2 );					_spOVER.graphics.lineTo( w/2 , h );					_spOVER.graphics.lineTo( 0 , h/2 );					_spOVER.visible = false;			}					// -------o protected					// -------o misc			public static function trc(arguments : *) : void {				Logger.log(GridTile, arguments);			}	}}