/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.services.digester {	import org.shoebox.collections.Array2D;	import org.shoebox.engine.data.MapData;	import org.shoebox.engine.data.MapFileChunks;	import org.shoebox.patterns.service.AbstractService;	import org.shoebox.patterns.service.IService;	import org.shoebox.utils.logger.Logger;	import flash.utils.ByteArray;	/**	 * org.shoebox.bwyengine.service.SMapDigester	* @author shoebox	*/	public class SMapDigester extends AbstractService implements IService {				protected var _aCONTENT		:Array2D;		protected var _oBA		:ByteArray;				// -------o constructor					/**			* Constructor of the SMapDigester class			*			* @public			* @return	void			*/			public function SMapDigester() : void {			}		// -------o public						/**			* onCall function			* @public			* @param 			* @return			*/			final override public function onCall() : void {									//					_oBA.uncompress();								//					var id : int;					var 	oDATAS : MapData = new MapData();											while( _oBA.bytesAvailable > 0 ){												id = _oBA.readUnsignedShort();						switch(id){														case MapFileChunks.INFOS_BWM:								oDATAS.mapType = _oBA.readShort();								oDATAS.setSize(_oBA.readInt() , _oBA.readInt());								break;															case MapFileChunks.GRID_ENTRY:								oDATAS.addContentAt(_oBA.readInt(), _oBA.readInt(), _oBA.readObject() as Vector.<int>);								break;														case MapFileChunks.GRID_BEHAVIOR:								//oDATAS.addBehaviorAt(_oBA.readInt(), _oBA.readInt(), _oBA.readUTF(), _oBA.readObject());								break;													}					}									//					dispatch( oDATAS );				}						/**			* onCancel function			* @public			* @param 			* @return			*/			final override public function onRefresh() : void {						}						/**			* set source function			* @public			* @param 			* @return			*/			public function set source( ba : ByteArray ) : void {								//					_oBA = ba;												}					// -------o protected		// -------o misc			public static function trc(...args : *) : void {				Logger.log(SMapDigester, args);			}	}}