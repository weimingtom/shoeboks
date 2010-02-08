/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.commands.tools {	import org.shoebox.biskwy.events.GridTileEvent;
	import org.shoebox.biskwy.items.GridTile;	import org.shoebox.biskwy.items.TileLayer;	import org.shoebox.events.EventCentral;	import org.shoebox.patterns.commands.ICommand;	import org.shoebox.patterns.singleton.ISingleton;	import org.shoebox.utils.display.STAGEINSTANCE;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	import flash.events.KeyboardEvent;	import flash.events.MouseEvent;	import flash.ui.Keyboard;	/**	 * org.shoebox.biskwy.commands.tools.ToolClickFill	* @author shoebox	*/	public class ToolClickFill extends ATool implements ICommand , ISingleton{				protected var _bSPACE		:Boolean;		protected var _bINHERITZ	:Boolean = false;				protected static var __instance		:ToolClickFill = null;				// -------o constructor					public function ToolClickFill( e : SingletonEnforcer ) : void {				addProperty( ATool.P_CHECKBOX , { label : 'Inherit Z decal' } , 'inheritZ' );				addProperty( ATool.P_CHECKBOX , { label : 'Replace content' } , 'replace' );			}		// -------o public												/**			* set inheritZ function			* @public			* @param 			* @return			*/			public function set inheritZ( b : Boolean ) : void {				_bINHERITZ = b;			}						/**			* get inheritZ function			* @public			* @param 			* @return			*/			public function get inheritZ() : Boolean {				return _bINHERITZ;			}						/**			* getInstance function			* @public			* @param 			* @return			*/			static public function getInstance() : ToolClickFill {								if(!__instance)					__instance = new ToolClickFill(new SingletonEnforcer());								return __instance;			}						/**			* onExecute function			* @public			* @param 			* @return			*/			final override public function onExecute( e : Event = null ) : void {				trc('onExecute ::: '+map);				STAGEINSTANCE.addEventListener(KeyboardEvent.KEY_DOWN , 	_onEvent , false , 10 , true );												EventCentral.getInstance().addEventListener( GridTileEvent.GRIDTILE_CLICK, _onEvent , false , 10 , true );							}						/**			* onCancel function			* @public			* @param 			* @return			*/			final override public function onCancel( e : Event = null ) : void {				trc('onCancel');				STAGEINSTANCE.removeEventListener(KeyboardEvent.KEY_DOWN , 	_onEvent , false );				STAGEINSTANCE.removeEventListener(KeyboardEvent.KEY_UP , 	_onEvent , false );								EventCentral.getInstance().removeEventListener( GridTileEvent.GRIDTILE_CLICK, _onEvent , false );								//__instance = null;				_bISRUNNING = false;				_bISCANCEL = false;			}					// -------o protected			/**			* 			*			* @param 			* @return			*/			protected function _onEvent( e : Event ) : void {							switch(e.type){										case KeyboardEvent.KEY_DOWN:							if((e as KeyboardEvent).keyCode == Keyboard.SPACE){							_bSPACE = true;							EventCentral.getInstance().addEventListener( GridTileEvent.GRIDTILE_OVER, _onEvent , false , 10 , true);							STAGEINSTANCE.addEventListener(KeyboardEvent.KEY_UP , _onEvent , false , 10 , true );						}						break;											case KeyboardEvent.KEY_UP:						if((e as KeyboardEvent).keyCode == Keyboard.SPACE){							_bSPACE = false;							STAGEINSTANCE.removeEventListener(KeyboardEvent.KEY_UP , _onEvent , false );							EventCentral.getInstance().removeEventListener( GridTileEvent.GRIDTILE_OVER , _onEvent , false);						}						break;										case GridTileEvent.GRIDTILE_OVER:						trc('over');						if(!_bSPACE)							break;												case GridTileEvent.GRIDTILE_CLICK:						var 	g : GridTile = (e as GridTileEvent).gridTile;						if(_bREPLACE)							g.container.clear();													var 	l : uint = g.container.layers.length;						if( inheritZ && l > 0) 							g.container.fill( _oTILEDESC , (g.container.layers[l-1] as TileLayer).decalZ , true);						else									g.container.fill( _oTILEDESC );					break;				}							}		// -------o misc			public static function trc(arguments : *) : void {				Logger.log(ToolClickFill, arguments);			}	}}internal class SingletonEnforcer{}