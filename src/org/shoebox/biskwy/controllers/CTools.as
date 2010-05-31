/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.controllers {	import fl.controls.Button;	import org.shoebox.biskwy.commands.tools.ATool;	import org.shoebox.biskwy.commands.tools.ToolClickClear;	import org.shoebox.biskwy.commands.tools.ToolClickEdit;	import org.shoebox.biskwy.commands.tools.ToolClickFill;	import org.shoebox.biskwy.commands.tools.ToolElevation;	import org.shoebox.biskwy.commands.tools.ToolGroups;	import org.shoebox.biskwy.commands.tools.ToolLight;	import org.shoebox.biskwy.commands.tools.ToolRectFill;	import org.shoebox.biskwy.commands.tools.ToolTrigger;	import org.shoebox.biskwy.events.MapEvent;	import org.shoebox.biskwy.events.TileEvent;	import org.shoebox.biskwy.events.ToolEvent;	import org.shoebox.biskwy.views.maps.VMap;	import org.shoebox.events.EventCentral;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.patterns.mvc.abstracts.AController;	import org.shoebox.patterns.mvc.interfaces.IController;	import org.shoebox.utils.logger.Logger;	import flash.data.EncryptedLocalStore;	import flash.events.Event;	import flash.events.NativeWindowBoundsEvent;	import flash.utils.ByteArray;	/**	 * org.shoebox.biskwy.controllers.CTools	* @author shoebox	*/	public class CTools extends AController implements IController{				protected var _oCOMMAND			:ATool;		protected var _oOLDBUTTON		:Button;		protected var _oSELECTEDTILEDESC	:Object;		protected var _oMAP			:VMap;		protected var _uSELECTEDTILEID	:uint;		protected var _vMULTISELECTION	:Vector.<Object> = new Vector.<Object>();						// -------o constructor					public function CTools() : void {			}		// -------o public						/**			* onEvent function			* @public			* @param 			* @return			*/			final override public function onEvent( e : Event ) : void {								//					if(e.type == NativeWindowBoundsEvent.MOVE){						var 	oBA : ByteArray = new ByteArray();							oBA.writeInt( view.stage.nativeWindow.x );							oBA.writeInt( view.stage.nativeWindow.y );						EncryptedLocalStore.setItem('windowposition',oBA);						return;					}								//					if(_oCOMMAND)						_oCOMMAND.cancel();						_oCOMMAND = null;								//					if(_oOLDBUTTON)						_oOLDBUTTON.toggle = false;									_oOLDBUTTON = e.target as Button;					_oOLDBUTTON.toggle = true;													switch( e.target.name  as String ){										case 'ClickFill':						_oCOMMAND = Factory.build(ToolClickFill);						break;											case 'Edit':						_oCOMMAND = Factory.build(ToolClickEdit );												break;											case 'Clear':						_oCOMMAND = Factory.build(ToolClickClear);						break;										case 'Trigger':						_oCOMMAND = Factory.build(ToolTrigger);						break;											/*					case 'Select':						_oCOMMAND = Factory.build(ToolSelection);						break;					*/										case 'RectFill':						_oCOMMAND = Factory.build(ToolRectFill);						break;										case 'Groups':						_oCOMMAND = Factory.build(ToolGroups);						break;										case 'Light':						_oCOMMAND = Factory.build( ToolLight );						break;										case 'Elevation':						_oCOMMAND = Factory.build(ToolElevation );						break;														}								if(!_oCOMMAND)					return;												_oCOMMAND.tileID = _uSELECTEDTILEID;				if(_vMULTISELECTION.length > 0 )					_oCOMMAND.tileDESC = _vMULTISELECTION[0];				else					_oCOMMAND.tileDESC = _oSELECTEDTILEDESC;									_oCOMMAND.multiSelection = _vMULTISELECTION;				_oCOMMAND.execute();								EventCentral.getInstance().dispatchEvent( new ToolEvent( ToolEvent.TOOL_INIT , _oCOMMAND ));				}									/**			* Initializing the controller			* 			* @public			* @return	void			*/			final override public function initialize() : void {				EventCentral.getInstance().addEventListener( TileEvent.SELECTION , _onTileSelection , false , 10 , true );				EventCentral.getInstance().addEventListener( TileEvent.MULTISELECTION, _onTileMultiSelection , false , 10 , true );				//EventCentral.getInstance().addEventListener( MapEvent.MAP_OPEN, _onMap , false , 10 , true );			}						/**			* When the controller is canceled			* 			* @public			* @param	e : optional cancel event (Event) 			* @return	void			*/			final override public function cancel( e : Event = null ) : void {						}					// -------o protected						/**			* When a tile is selected			*				* @param 	e : tile event (TileEvent)			* @return 	void			*/			protected function _onTileSelection( e : TileEvent ) : void {								if(e.tileDesc==null)					return;								_vMULTISELECTION = new Vector.<Object>();					if(_oCOMMAND && e.tileDesc !== null){					_oCOMMAND.tileID = e.tileID;					_oCOMMAND.tileDESC = e.tileDesc;					_oCOMMAND.multiSelection = new Vector.<Object>();				}								_oSELECTEDTILEDESC = e.tileDesc;				_uSELECTEDTILEID = e.tileID;			}						/**			* When multiple tile are selected			*			* @param 	e : Selection event (TileEvent)			* @return	void			*/			protected function _onTileMultiSelection( e : TileEvent ) : void {				if(_oCOMMAND && e.multiSelectionList !== null){					_oCOMMAND.tileID = e.tileID;					_oCOMMAND.tileDESC = e.tileDesc;					_oCOMMAND.multiSelection = e.multiSelectionList;				}				_vMULTISELECTION = e.multiSelectionList;			}					// -------o misc			public static function trc(arguments : *) : void {				Logger.log(CTools, arguments);			}	}}