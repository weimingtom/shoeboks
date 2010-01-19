/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.items {	import org.shoebox.biskwy.core.Config;	import org.shoebox.engine.data.TileData;	import org.shoebox.engine.services.GetTile;	import org.shoebox.patterns.service.ServiceEvent;	import org.shoebox.patterns.service.ServiceFactory;	import org.shoebox.utils.Relegate;	import org.shoebox.utils.logger.Logger;	import flash.display.Loader;	import flash.display.LoaderInfo;	import flash.display.Sprite;	import flash.events.Event;	/**	 * org.shoebox.engine.items.TileLayers	* @author shoebox	*/	public class TileLayers extends Sprite {				protected var _bWALKABLE		:Boolean = true;		protected var _oLOADER			:Loader;		protected var _spCONTAINER		:Sprite;				// -------o constructor					public function TileLayers() : void {				_spCONTAINER = new Sprite();				addChild(_spCONTAINER);			}		// -------o public						/**			* addItem function			* @public			* @param 			* @return			*/			public function addItem( uCODE : int , uDECALZ : int ) : void {				//trc('addItem ::: '+arguments);				//_spCONTAINER.addChild(Factory.build('Tile' , {x : -10 , y : -16 + uDECALZ}));								var 	oSERVICE : GetTile = new GetTile();					oSERVICE.tileID = uCODE;					oSERVICE.addEventListener( ServiceEvent.ON_DATAS , _onDatas , false , 10 , true );					oSERVICE.call();			}						/**			* get walkable function			* @public			* @param 			* @return			*/			public function get walkable() : Boolean {				return _bWALKABLE;			}					// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _onDatas( e : ServiceEvent ) : void {				//trc('onDatas ::: '+e);				(e.target as GetTile).removeEventListener( ServiceEvent.ON_DATAS , _onDatas , false);								//_oLOADER.y = -_oLOADER.height + Config.TILESIZE/2 + 2 + pt.y;									//					var oDATAS:TileData = e.datas as TileData;					if(!oDATAS.bWALKABLE)						_bWALKABLE = false;										//					var 	oLOADER:Loader = new Loader();						oLOADER.contentLoaderInfo.addEventListener( Event.COMPLETE , Relegate.create(_onMedia,oDATAS) , false , 10 , true );						oLOADER.loadBytes(oDATAS.media);						oLOADER.visible = false;					_spCONTAINER.addChild(oLOADER);					//oLOADER.x = oTILE.decalX;					//oLOADER.y = oTILE.decalY;								//addChild(oLOADER);			}			/**			* 			*			* @param 			* @return			*/			protected function _onMedia( e : Event , oDATAS : TileData) : void {				var 	oLOADER : Loader = (e.target as LoaderInfo).loader;					oLOADER.x = oDATAS.decalX;					oLOADER.y = -oLOADER.height + Config.TILESIZE/2 + 2 + oDATAS.decalY;					oLOADER.visible = true;			}				// -------o misc			public static function trc(arguments : *) : void {				Logger.log(TileLayers, arguments);			}	}}