/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.views.maps {	import flash.events.KeyboardEvent;	import org.shoebox.biskwy.commands.TileCommand;	import org.shoebox.biskwy.core.Config;	import org.shoebox.biskwy.items.GridTile;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.text.TextField;	/**	 * org.shoebox.biskwy.views.maps.IsoMap	* @author shoebox	*/	public class IsoMap extends VMap{						// -------o constructor					public function IsoMap() : void {				trc('constructor');				super();			}		// -------o public						/**			* initialize function			* @public			* @param 			* @return			*/			final override public function initialize() : void {						}						/**			* onResize function			* @public			* @param 			* @return			*/			final override public function onStaged(e:Event = null) : void {				super.onStaged(e);				_run();				}									/**			* onRemoved function			* @public			* @param 			* @return			*/			final override public function onRemoved(e:Event = null) : void {				super.onRemoved(e);								}					// -------o protected							/**			* 			*			* @param 			* @return			*/			protected function _run() : void {								var x : int = -1;				var y : int = -1;								var w : uint = (Config.GRID_WIDTH / Config.TILESIZE);				var h : uint = (Config.GRID_HEIGHT / (Config.TILESIZE / 4)) + 1;								var c : GridTile;								while( y++ < h){					x = w - 1;					while( x-- > 0) {												c = Factory.build( GridTile , { name : 'tile'+x+'_'+y , x : x * Config.TILESIZE - ((y % 2) ? 0 : Config.TILESIZE/2), y : y * ( Config.TILESIZE / 4) - Config.TILESIZE / 2 });						controller.registerCommand(TileCommand , null , stage , KeyboardEvent.KEY_DOWN, false , 10 , true);						controller.registerCommand(TileCommand , null , stage , KeyboardEvent.KEY_UP, false , 10 , true);						controller.registerCommand(TileCommand , null , c , MouseEvent.CLICK , false , 10 , true);						controller.registerCommand(TileCommand , null , c , MouseEvent.MOUSE_OVER , false , 10 , true);						controller.registerCommand(TileCommand , null , c , MouseEvent.MOUSE_OUT  , false , 10 , true);						_spCONTAINER.addChild( c );												//c.addChild(Factory.build(TextField,{text:x+'_'+y}));					}				}						}		// -------o misc			public static function trc(...args : *) : void {				Logger.log(IsoMap, args);			}	}}