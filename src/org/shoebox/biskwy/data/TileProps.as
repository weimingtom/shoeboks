/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.data {	import org.shoebox.utils.logger.Logger;	import flash.display.DisplayObject;	import flash.geom.Point;	import flash.utils.ByteArray;	/**	 * org.shoebox.engine.datas.TileProps	* @author shoebox	*/	public class TileProps {				public var media		:DisplayObject;				protected var _bCOLLIDABLE		:Boolean;		protected var _baMEDIA			:ByteArray;		protected var _ptDECAL			:Point;					// -------o constructor					/**			* Constructor of the TileProps class			*			* @public			* @return	void			*/			public function TileProps() : void {			}		// -------o public						/**			* set collidable function			* @public			* @param 			* @return			*/			public function set collidable( b : Boolean ) : void {				_bCOLLIDABLE = b;			}						/**			* get collidable function			* @public			* @param 			* @return			*/			public function get collidable() : Boolean {				return _bCOLLIDABLE;			}						/**			* set ptDecal function			* @public			* @param 			* @return			*/			public function set ptDecal( pt : Point ) : void {				_ptDECAL = pt;			}						/**			* get ptDecal function			* @public			* @param 			* @return			*/			public function get ptDecal() : Point {				return _ptDECAL;			}						/**			* set mediaDatas function			* @public			* @param 			* @return			*/			public function set mediaDatas( ba : ByteArray ) : void {				_baMEDIA = ba;			}						/**			* get mediaDatas function			* @public			* @param 			* @return			*/			public function get mediaDatas() : ByteArray {				return _baMEDIA;			}								// -------o protected		// -------o misc			public static function trc(...args : *) : void {				Logger.log(TileProps, args);			}	}}