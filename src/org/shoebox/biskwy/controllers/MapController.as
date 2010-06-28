/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.controllers {	import fl.controls.ComboBox;	import org.shoebox.biskwy.core.Facade;	import org.shoebox.biskwy.core.Menu;	import org.shoebox.biskwy.events.GridTileEvent;	import org.shoebox.biskwy.events.SoundEvent;	import org.shoebox.biskwy.events.TriggerEvent;	import org.shoebox.biskwy.items.GridTile;	import org.shoebox.biskwy.items.SoundItem;	import org.shoebox.biskwy.items.TriggerItem;	import org.shoebox.biskwy.models.MapModel;	import org.shoebox.biskwy.views.maps.VMap;	import org.shoebox.events.EventCentral;	import org.shoebox.patterns.mvc.abstracts.AController;	import org.shoebox.patterns.mvc.interfaces.IController;	import org.shoebox.utils.logger.Logger;	import flash.display.NativeMenuItem;	import flash.events.Event;	import flash.events.MouseEvent;	/**	 * org.shoebox.biskwy.controllers.MapController	* @author shoebox	*/	public class MapController extends AController implements IController{				// -------o constructor					public function MapController() : void {							}		// -------o public						/**			* onEvent function			* @public			* @param 			* @return			*/			final override public function onEvent( e : Event ) : void {								// Zoom buttons					if(e.target is ComboBox)						(view as VMap).setScale( (e.target as ComboBox).selectedItem.value / 100 );									// Controller of GridTile events					if(e.target is GridTile){												var eTILEVENT : GridTileEvent;												switch(e . type){														case MouseEvent.MOUSE_OVER:								(e.target as GridTile).over();								eTILEVENT = new GridTileEvent( GridTileEvent.GRIDTILE_OVER , e.target as GridTile);								break;														case MouseEvent.MOUSE_OUT:								(e.target as GridTile).out();								eTILEVENT = new GridTileEvent( GridTileEvent.GRIDTILE_OUT, e.target as GridTile);								break;															case MouseEvent.CLICK:								eTILEVENT = new GridTileEvent( GridTileEvent.GRIDTILE_CLICK, e.target as GridTile);								break;													}												if(eTILEVENT)							EventCentral.getInstance().dispatchEvent( eTILEVENT );					}									// Trigger									if( e.type == MouseEvent.DOUBLE_CLICK){						var oEVENT : Event;												if( e.target is TriggerItem ) 							oEVENT = new TriggerEvent( TriggerEvent.EDIT , e.target as TriggerItem );						else if(e.target is SoundItem ){							oEVENT = new SoundEvent( SoundEvent.EDIT );							(oEVENT as SoundEvent).soundItem = e.target as SoundItem;						}												if( oEVENT )							Facade.getInstance().dispatchEvent( oEVENT );					}			}									/**			* initialize function			* @public			* @param 			* @return			*/			final override public function initialize() : void {				Menu.getInstance().addEventListener(Event.SELECT , _onMenuSelection , false , 10 , true);				}						/**			* cancel function			* @public			* @param 			* @return			*/			final override public function cancel( e : Event = null ) : void {				Menu.getInstance().removeEventListener(Event.SELECT , _onMenuSelection);				}					// -------o protected												/**			* 			*			* @param 			* @return			*/			protected function _onMenuSelection( e : Event ) : void {								if(!(e.target is NativeMenuItem))					return;								switch((e.target as NativeMenuItem).label){										case Menu.MAP_SAVE:						(model as MapModel).save();						break;											case Menu.MAP_OPEN:						//(model as MapModel).open();						break;				}			}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(MapController, args);			}	}}