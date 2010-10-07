/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.services {
	import org.shoebox.engine.core.variables.Position;
	import org.shoebox.engine.core.variables.Position2D;
	import org.shoebox.engine.items.actors.*;
	import org.shoebox.biskwy.utils.IsoTransform;
	import org.shoebox.biskwy.utils.Transformer;
	import org.shoebox.core.BoxMath;
	import org.shoebox.engine.core.variables.Container;
	import org.shoebox.engine.core.variables.MapDatas;
	import org.shoebox.engine.core.variables.RootPath;
	import org.shoebox.engine.datas.MapData;
	import org.shoebox.engine.datas.MapFileChunks;
	import org.shoebox.engine.datas.NVMLink;
	import org.shoebox.engine.datas.NVMRef;
	import org.shoebox.engine.transforms.Transformer2D;
	import org.shoebox.patterns.factory.Factory;
	import org.shoebox.patterns.service.HTTP_Service;
	import org.shoebox.patterns.service.IService;
	import org.shoebox.patterns.service.ServiceEvent;
	import org.shoebox.utils.logger.Logger;

	import flash.geom.Vector3D;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;	/**	 * Service who load the raw map data	* 	* @author shoebox	*/	public class SMap extends HTTP_Service implements IService {				protected var _oBA			: ByteArray;		protected var _vLINKS			: Vector.<NVMLink>;		protected var _vREFS			: Vector.<NVMRef>;		protected var _uMAPID			: uint;				// -------o constructor					/**			* Constructor of the SMap class			*			* @public			* @return	void			*/			public function SMap() : void {				useCaching = true;				dataFormat = URLLoaderDataFormat.BINARY;			}		// -------o public						/**			* When the service is called			* 			* @public			* @return	void			*/			final override public function onCall() : void {				trc('onCall ::: '+RootPath);				request = new URLRequest(RootPath+'maps/'+BoxMath.toString(_uMAPID , 4)+'.bwm');				addEventListener( ServiceEvent.ON_DATAS , _onRawDatas , false , 1000 , true );				super.onCall();			}						/**			* When the service refresh is called			* 			* @public			* @return	void			*/			final override public function onRefresh() : void {						}						/**			* Setter of the current map ID			* 			* @public			* @param	u : current mapID	(uint) 			* @return	void			*/			public function set mapID( u : uint ) : void {				_uMAPID = u;			}					// -------o protected						/**			* When the raw map file is loaded			* 			* @param	e : service response event (ServiceEvent) 			* @return	void			*/			protected function _onRawDatas( e : ServiceEvent ) : void {				trc('_onRawDatas');				//					removeEventListener( ServiceEvent.ON_DATAS , _onRawDatas , false );					e.stopImmediatePropagation();									//					_oBA = new ByteArray();					_oBA.writeBytes( e.datas as ByteArray );					_oBA.uncompress();								//					var id : int;					var 	oDATAS : MapData = new MapData();					var uX : int , uY : int , vO : Vector.<int>;						var s : String , c : Class , act : AActor;					while( _oBA.bytesAvailable > 0 ){												id = _oBA.readUnsignedShort();						switch(id){														case MapFileChunks.INFOS_BWM:								oDATAS.mapType = _oBA.readShort();								trace('oDATAS.mapType ::: '+oDATAS.mapType);								Transformer.transform = ( oDATAS.mapType == 1 ) ? new Transformer2D() : new IsoTransform(); 								oDATAS.setSize(_oBA.readInt() , _oBA.readInt());								break;															case MapFileChunks.GRID_ENTRY:								uX = _oBA.readInt();								uY = _oBA.readInt();								vO = _oBA.readObject() as Vector.<int>;								oDATAS.addContentAt( uX , uY , vO );								vO = new Vector.<int>();								break;														case MapFileChunks.ACTOR:								//oDATAS.addActor(new Vector3D(_oBA.readInt() , _oBA.readInt() , _oBA.readInt()) , _oBA.readInt() , _oBA.readUTF());																								s = _oBA.readUTF();																c = getDefinitionByName( s ) as Class; 																var 	vars : Object = {};									vars.x = _oBA.readInt();									vars.y = _oBA.readInt();									_oBA.readInt();									vars.name = _oBA.readUTF();																l = _oBA.readInt();								i = 0;																for( i ;  i < l ; i++ )									vars[ _oBA.readUTF() ] = getDefinitionByName(_oBA.readUTF())(_oBA.readObject());
								trace('::::: c ::: '+c);								if( c ){									if( c == PlayerStart ) {										if( !Position2D )											Position2D = new Vector3D();										Position2D.x = vars.x;										Position2D.y = vars.y;
										Position = Transformer.worldToScreen(Position2D);
										trace('PlayerStart ::: '+PlayerStart);										trace('Position2D ::: '+Position2D);
										trace('Position ::: '+Position);									}								}																								act = Factory.build(c, vars) as AActor;								Container.addChild( act );								 oDATAS.addActor( act.name , act );									break;															case MapFileChunks.GRID_SOUND:									oDATAS.addSoundAt(new Vector3D(_oBA.readInt() , _oBA.readInt() , _oBA.readInt()) , _oBA.readInt() , _oBA.readUTF());								break;														case MapFileChunks.MAP_LAYER:								var bBOL 	: Boolean = _oBA.readBoolean(); 																oDATAS.addLayer(										bBOL, 										_oBA.readUTF(),										_oBA.readInt(),										_oBA.readInt(),										_oBA.readBoolean(),										_oBA.readBoolean(),										_oBA.readFloat(),										(bBOL) ? null : _oBA.readObject() 								);								break;														case MapFileChunks.POLY:								oDATAS.addPoly( _oBA.readObject() as Vector.<int> );								break;																							case MapFileChunks.NEVERMIND_SCRIPT:								trc('NEVERMIND_SCRIPT');																//									_vREFS = new Vector.<NVMRef>();									_vLINKS = new Vector.<NVMLink>();																//									var l : int = _oBA.readInt();									var i : int = 0;									var oR : NVMRef;									var oL : NVMLink;									for( i ; i < l ; i++ ){																				oR = new NVMRef();										oR.className 	= _oBA.readUTF();										oR.refType 		= _oBA.readUTF();																					if(oR.refType == 'Actor'){
											oR.actorName = _oBA.readUTF();											oR.variables = _oBA.readObject();										}else{											oR.variables = _oBA.readObject();											oR.ref = Factory.build( oR.className , oR.variables );
										}										_vREFS.push( oR );																				trace('##########################');										trace( 'ref name 		::: '+ oR.className);										trace( 'ref type		::: '+ oR.refType );										trace( 'ref type		::: '+ oR.ref );										trace( 'ref actor name  ::: '+ oR.actorName );										trace(' x 			::: '+_oBA.readFloat() );										trace(' y 			::: '+_oBA.readFloat() );									}																		i = 0;									l = _oBA.readInt();									trace(i+' /// '+l);									for( i ; i < l ; i++ ){																				oL = new NVMLink();										oL.from( 												_vREFS[_oBA.readInt()] , 												_oBA.readUTF() , 												new XML(_oBA.readUTF()) 											);																				oL.to( 													_vREFS[_oBA.readInt()] , 												_oBA.readUTF() , 												new XML(_oBA.readUTF()) 											);																				_vLINKS.push( oL );										}																	//									oDATAS.nvmRefs = _vREFS;									oDATAS.nvmLinks = _vLINKS;																								break;													}					}					_oBA.clear();				//					MapDatas = oDATAS;					dispatch( oDATAS );								}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(SMap, args);			}	}}