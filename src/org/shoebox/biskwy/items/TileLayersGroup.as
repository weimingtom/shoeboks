/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.items {	import org.shoebox.biskwy.data.TileDesc;
	import org.shoebox.display.DisplayFuncs;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.utils.logger.Logger;	import flash.display.Sprite;	/**	 * org.shoebox.biskwy.items.TileContent	* @author shoebox	*/	public class TileLayersGroup extends Sprite{				protected var _oTMP			:Object;		protected var _vLAYERS			:Vector.<TileLayer>;						// -------o constructor					public function TileLayersGroup() : void {								_vLAYERS = new Vector.<TileLayer>();			}		// -------o public						/**			* clear function			* @public			* @param 			* @return			*/			public function clear() : void {				_vLAYERS = new Vector.<TileLayer>();				DisplayFuncs.purge(this);			}						/**			* get layers function			* @public			* @param 			* @return			*/			public function get layers() : Vector.<TileLayer> {				return _vLAYERS;			}						/**			* fill function			* @public			* @param 			* @return			*/			public function fill( o : TileDesc , iDECALZ : int = -1 , bDECAL : Boolean = false , bUNIQUE : Boolean = true ) : TileLayer {								var bTMP : Boolean = false;								if(bUNIQUE){					var oFUNC : Function = function( item : TileLayer , index : int , vSOURCE : Vector.<TileLayer>):Boolean{						bTMP = (item.id == o.id );						return !bTMP;					};					_vLAYERS.every(oFUNC);										if(bTMP)						return null ;				}									var 	oLAYER : TileLayer = new TileLayer();					oLAYER.fill( o.id , (bDECAL) ? iDECALZ : Controls.getInstance().decalZ);									_vLAYERS.push(oLAYER);				addChild(oLAYER);								return oLAYER;			}						/**			* fillByDatas function			* @public			* @param 			* @return			*/			public function fillByDatas( o : Object , iDECALZ : int = -1 , bDECAL : Boolean = false ) : TileLayer {							var 	oLAYER : TileLayer = new TileLayer();					oLAYER.fill( o.id , (bDECAL) ? iDECALZ : Controls.getInstance().decalZ);								_vLAYERS.push(oLAYER);				addChild(oLAYER);								return oLAYER;			}						/**			* get content function			* @public			* @param 			* @return			*/			public function get content() : Vector.<int> {								var vTMP : Vector.<int> = new Vector.<int>();				var oFUNC : Function = function(item : TileLayer , index : int , vSOURCE : Vector.<TileLayer>):void{					vTMP.push(item.id);					vTMP.push(item.decalZ);				};								_vLAYERS.forEach( oFUNC , this);								return vTMP;			}						/**			* remove function			* @public			* @param 			* @return			*/			public function remove( id : uint) : void {				//_spCONTAINER.remove(id);								var oFUNC : Function = function(item:TileLayer, index:int, vSOURCE:Vector.<TileLayer>):Boolean{										if(item.id==id)						removeChild(item);											return !(item.id==id);				};								_vLAYERS = _vLAYERS.filter( oFUNC , this);							}						/**			* setZForId function			* @public			* @param 			* @return			*/			public function setZForId( id : uint , z : int = 0) : void {								var i : int = _getTileZ(id);				if(i == -1)			 		return;			 					 	var 	oLAYER:TileLayer = _vLAYERS[i];			 		oLAYER.decalZ = z;			}						/**			* up function			* @public			* @param 			* @return			*/			public function swap( id : uint , u : int = +1) : void {				trc('swap ::: '+arguments);				var z : int = _getTileZ(id);			 				 	if(z == -1)			 		return;			 				 	var oTL1:TileLayer = _vLAYERS[z];			 	var oTMP:TileLayer = _vLAYERS[z + u];			 				 	if(!oTMP)			 		return;			 				 	swapChildren(oTL1,oTMP);			 				 	_vLAYERS[z + u] = oTL1;			 	_vLAYERS[z] = oTMP;			 			}											// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _drawLayer() : void {			}						/**			* 			*			* @param 			* @return			*/			protected function _getTileZ( id : uint ) : int {				var i : int = 0;				var l : uint = _vLAYERS.length;				var o : TileLayer;			 	for( i ; i < l ; i++){			 					 		o = _vLAYERS[i];			 					 		if(o.id == id)			 			break;			 					 	}			 				 	return (!o) ? -1 : i;			}					// -------o misc			public static function trc(arguments : *) : void {				Logger.log(TileLayersGroup, arguments);			}	}}/* * name /// 83.pngfilepath /// C:\DL\TEMP\world\png\83.pngdecalX /// -65id /// 35cat /// nulldecalY /// null */