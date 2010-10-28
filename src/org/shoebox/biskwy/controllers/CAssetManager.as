/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.controllers {
	import org.shoebox.biskwy.commands.assets.CommandAssetPreview;
	import org.shoebox.biskwy.commands.menu.CommandAssetsManager;
	import org.shoebox.biskwy.core.variables.AssetSelection;
	import org.shoebox.biskwy.core.variables.TilesCache;
	import org.shoebox.biskwy.core.variables.TilesDesc;
	import org.shoebox.biskwy.commands.tiles.CommandEditTile;
	import org.shoebox.biskwy.core.variables.TileSelection;
	import org.shoebox.biskwy.data.TileDesc;
	import org.shoebox.biskwy.events.TileEvent;
	import org.shoebox.biskwy.items.AssetItem;
	import org.shoebox.biskwy.models.MAssetManager;
	import org.shoebox.biskwy.views.VAssetManager;
	import org.shoebox.patterns.mvc.abstracts.AController;
	import org.shoebox.patterns.mvc.interfaces.IController;
	import org.shoebox.utils.logger.Logger;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;		/**	 * org.shoebox.biskwy.controllers.CAssetManager	* @author shoebox	*/	public class CAssetManager extends AController implements IController {				protected var _bMULTISEL			: Boolean;		protected var _bCTRL				: Boolean;		protected var _iSTART				: int = -1;		protected var _vSELECTED			: Vector.<AssetItem>;				// -------o constructor					/**			* Constructor of the CAssetManager class			*			* @public			* @return	void			*/			public function CAssetManager() : void {			}		// -------o public						/**			* Controller initialization			* 			* @public			* @return void			*/			final override public function initialize() : void {
				_vSELECTED = new Vector.<AssetItem>();
				register(view , KeyboardEvent.KEY_DOWN , false , 10 , true );				register(view , KeyboardEvent.KEY_UP	, false , 10 , true );			}			/**			* When the controller receive an event 			* 			* @public			* @param	e : received event (Event) 			* @return	void			*/			final override public function onEvent( e : Event ) : void {
								if( e.type == MouseEvent.DOUBLE_CLICK){										var 	oA7 : AssetItem =  (e.target as AssetItem);										if( oA7.type == 'Tile' ) {						
						var 	oEVENT : TileEvent = new TileEvent(TileEvent.EDIT );							oEVENT.tileID = oA7.id;												var 	oCOM : CommandEditTile = CommandEditTile.getInstance();							oCOM.execute( oEVENT );												}else{						var 	oCOMP : CommandAssetPreview = CommandAssetPreview.getInstance();						if(!oCOMP.isRunning)							oCOMP.execute( e );							oCOMP.run( oA7 );											}					return;				}								if( e.type == Event.SELECT ){										var vSEL : Vector.<uint> = Vector.<uint>([ ]);					var a : AssetItem;
					for each( a in _vSELECTED  ){						vSEL.push(a.datas.iID);					}																				var sNEW : String;					switch( e.target ){						
						case ( view as VAssetManager).menuDelete:							(model as MAssetManager).delAssets( vSEL );							break;													case (view as VAssetManager).menuConvertToTile:							(model as MAssetManager).convertAs( vSEL , 'Tile' );							sNEW = 'Tile';							break;							
						case (view as VAssetManager).menuConvertToBmpAsset:							(model as MAssetManager).convertAs( vSEL , 'Bitmap asset' );							break;												}										if( sNEW !== null ){						for each( a in _vSELECTED  ) 							a.datas.sType = sNEW;					}																			}								if( e.type == KeyboardEvent.KEY_DOWN ){
										if( (e as KeyboardEvent).keyCode == Keyboard.SHIFT )						_bMULTISEL = true;
										if( (e as KeyboardEvent).keyCode == Keyboard.CONTROL  )
						_bCTRL = true;												return;				}								if( e.type == KeyboardEvent.KEY_UP ){										if( (e as KeyboardEvent).keyCode == Keyboard.SHIFT )						_bMULTISEL = false;											if( (e as KeyboardEvent).keyCode == Keyboard.CONTROL  )						_bCTRL = false;											return;				}								if( e.target is AssetItem ){										var o : AssetItem = e.target as AssetItem;										switch( e.type ){						
						case MouseEvent.MOUSE_OVER:							if( o.buttonMode )								o.over();							break;						
						case MouseEvent.MOUSE_OUT:							if( o.buttonMode )								o.out();							break;													case MouseEvent.CLICK:								_deselect();														if( !_bMULTISEL )								_vSELECTED = Vector.<AssetItem>([ ]);
																					var iPOS : int = int( o.name );														//								if( !_bMULTISEL ){																		_iSTART = iPOS;									_vSELECTED.push( o );
									o.selected();									
								} else {																											if( _iSTART == -1 ){										_iSTART = iPOS;										o.selected();										_vSELECTED.push( o );									}else										_select( _iSTART , iPOS , o.parent );																	}														// 
								TileSelection = new Vector.<TileDesc>( [] );								var oAsset : AssetItem;
								for each( oAsset in _vSELECTED ) {
								if( oAsset.datas.sType == 'Tile') {
										trace('oAsset.id ::: ' + oAsset.datas.iID + ' /// ' + oAsset.id);
										TileSelection.push(TilesCache.getValue(oAsset.id));									}
								}
								AssetSelection = oAsset.datas;
														trace('TileSelection ::: '+TileSelection);							break;											}				}			}												/**			* When the controller is canceled			* 			* @public			* @param	e : optional cance event (Event) 			* @return	void			*/			final override public function cancel( e : Event = null ) : void {							}				// -------o protected					/**			* 			*			* @param 			* @return			*/			final protected function _select( s : uint , e : uint , o : DisplayObjectContainer ) : void {				trace('select ::: '+s+' /// '+e );								var t : uint = s;				if( s > e ){					t = e;										e = s;					s = t;				}								var i : uint = s;				var a : AssetItem;				for( i ; i <= e ; i++ ){										a = o.getChildByName(i+'') as AssetItem;					a.selected();					_vSELECTED.push( a );				}							}					/**			* 			*			* @param 			* @return			*/
			final protected function _deselect( ) : void {
									var o : AssetItem;
				for each( o in _vSELECTED )					o.unSelected();
								_vSELECTED = new Vector.<AssetItem>();							}				// -------o misc			public static function trc(...args : *) : void {				Logger.log(CAssetManager, args);			}	}}