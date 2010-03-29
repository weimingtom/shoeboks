/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.data {	import org.shoebox.collections.Array2D;	import org.shoebox.utils.logger.Logger;	/**	 * org.shoebox.bwyengine.datas.MapData	* @author shoebox	*/	public class MapData {				protected var _aCONTENT			:Array2D;		protected var _aBEHAVIORS		:Array2D;		protected var _uHEIGHT			:uint;		protected var _uMAPTYPE			:uint;		protected var _uWIDTH			:uint;				// -------o constructor					/**			* Constructor of the MapData class			*			* @public			* @return	void			*/			public function MapData() : void {			}		// -------o public						/**			* Getter of the map width			* @public			* @return	width of the map (uint)			*/			public function get mapWidth() : uint {				return _uWIDTH;			}					/**			* Getter of the map height			* @public			* @return	height of the map (uint)			*/			public function get mapHeight() : uint {				return _uHEIGHT;			}			/**			* set size function			* @public			* @param 			* @return			*/			public function setSize( uW : uint , uH : uint ) : void {				_uWIDTH = uW;				_uHEIGHT = uH;				_aCONTENT = new Array2D( uW , uH );				_aBEHAVIORS = new Array2D( uW , uH );			}						/**			* set mapType function			* @public			* @param 			* @return			*/			public function set mapType( u : uint ) : void {				_uMAPTYPE = u;			}						/**			* addContentAt function			* @public			* @param 			* @return			*/			public function addContentAt( uX : uint , uY : uint , v : Vector.<int> = null ) : void {				_aCONTENT.setDatasAt( uX, uY, v );			}						/**			* getContentAt function			* @public			* @param 			* @return			*/			public function getContentAt( uX : uint , uY : uint ) : Vector.<int> {				return _aCONTENT.getDatasAt(uX , uY);			}						/**			* addBehaviorAt function			* @public			* @param 			* @return			*/			public function addBehaviorAt( uX : uint , uY : uint , sTYPE : String , oOPT : Object ) : void {				//TODO:			}					// -------o protected		// -------o misc			public static function trc(...args : *) : void {				Logger.log(MapData, args);			}	}}