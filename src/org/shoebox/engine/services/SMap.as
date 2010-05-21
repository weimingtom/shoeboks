/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.services {	import org.shoebox.biskwy.utils.IsoTransform;	import org.shoebox.biskwy.utils.Transformer;	import org.shoebox.core.BoxMath;	import org.shoebox.engine.core.variables.MapDatas;	import org.shoebox.engine.core.variables.RootPath;	import org.shoebox.engine.datas.MapData;	import org.shoebox.engine.datas.MapFileChunks;	import org.shoebox.engine.transforms.Transformer2D;	import org.shoebox.patterns.service.HTTP_Service;	import org.shoebox.patterns.service.IService;	import org.shoebox.patterns.service.ServiceEvent;	import org.shoebox.utils.logger.Logger;	import flash.geom.Vector3D;	import flash.net.URLLoaderDataFormat;	import flash.net.URLRequest;	import flash.utils.ByteArray;	/**	 * Service who load the raw map data	* 	* @author shoebox	*/	public class SMap extends HTTP_Service implements IService {				protected var _oBA		:ByteArray;		protected var _uMAPID		:uint;				// -------o constructor					/**			* Constructor of the SMap class			*			* @public			* @return	void			*/			public function SMap() : void {				useCaching = true;				dataFormat = URLLoaderDataFormat.BINARY;			}		// -------o public						/**			* When the service is called			* 			* @public			* @return	void			*/			final override public function onCall() : void {				request = new URLRequest(RootPath+'maps/'+BoxMath.toString(_uMAPID , 4)+'.bwm');				addEventListener( ServiceEvent.ON_DATAS , _onRawDatas , false , 1000 , true );				super.onCall();			}						/**			* When the service refresh is called			* 			* @public			* @return	void			*/			final override public function onRefresh() : void {						}						/**			* Setter of the current map ID			* 			* @public			* @param	u : current mapID	(uint) 			* @return	void			*/			public function set mapID( u : uint ) : void {				_uMAPID = u;			}					// -------o protected						/**			* When the raw map file is loaded			* 			* @param	e : service response event (ServiceEvent) 			* @return	void			*/			protected function _onRawDatas( e : ServiceEvent ) : void {								//					removeEventListener( ServiceEvent.ON_DATAS , _onRawDatas , false );					e.stopImmediatePropagation();									//					_oBA = new ByteArray();					_oBA.writeBytes( e.datas as ByteArray );					_oBA.uncompress();								//					var id : int;					var 	oDATAS : MapData = new MapData();											while( _oBA.bytesAvailable > 0 ){												id = _oBA.readUnsignedShort();						switch(id){														case MapFileChunks.INFOS_BWM:								oDATAS.mapType = _oBA.readShort();								Transformer.transform = ( oDATAS.mapType == 1 ) ? new Transformer2D() : new IsoTransform(); 								trace('Transformer.transform ::: '+Transformer.transform)								oDATAS.setSize(_oBA.readInt() , _oBA.readInt());								break;															case MapFileChunks.GRID_ENTRY:								oDATAS.addContentAt(_oBA.readInt(), _oBA.readInt(), _oBA.readObject() as Vector.<int>);								break;														case MapFileChunks.GRID_BEHAVIOR:								oDATAS.addBehaviorAt(new Vector3D(_oBA.readInt() , _oBA.readInt() , _oBA.readInt()) , _oBA.readInt() , _oBA.readUTF());								break;																					}					}									//					MapDatas = oDATAS;					dispatch( oDATAS );								}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(SMap, args);			}	}}