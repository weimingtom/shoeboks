/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.controllers {	import org.shoebox.biskwy.core.Menu;	import org.shoebox.biskwy.items.TileItem;	import org.shoebox.biskwy.models.TilesModel;	import org.shoebox.patterns.mvc.abstracts.AController;	import org.shoebox.patterns.mvc.interfaces.IController;	import org.shoebox.utils.logger.Logger;	import flash.display.NativeMenu;	import flash.display.NativeMenuItem;	import flash.events.Event;	import flash.events.FileListEvent;	import flash.events.MouseEvent;	import flash.filesystem.File;	import flash.net.FileFilter;	/**	 * org.shoebox.biskwy.controllers.TilesController	* @author shoebox	*/	public class TilesController extends AController implements IController{				protected var _oFILE		:File;		protected var _oMENU		:NativeMenu;				// -------o constructor					public function TilesController() : void {			}		// -------o public						/**			* onEvent function			* @public			* @param 			* @return			*/			final override public function onEvent( e : Event ) : void {								switch( e.type ){										case MouseEvent.CLICK:						(model as TilesModel).selectedID = (e.target as TileItem).id;						break;										case MouseEvent.MOUSE_OVER:						(e.target as TileItem).over();						break;											case MouseEvent.MOUSE_OUT:						(e.target as TileItem).out();						break;				}								//if(e.target is TileItem)								}									/**			* initialize function			* @public			* @param 			* @return			*/			final override public function initialize() : void {				Menu.getInstance().addEventListener(Event.SELECT , _onSelect , false , 10 , true);				}						/**			* cancel function			* @public			* @param 			* @return			*/			final override public function cancel( e : Event = null ) : void {						}					// -------o protected					/**			* 			*			* @param 			* @return			*/			protected function _onSelect( e : Event ) : void {				return;				if(!e.target is NativeMenuItem)					return;								//TODO : Import désactivés pour l'instant								switch( (e.target as NativeMenuItem).label ){										case Menu.TILE_IMPORTFROMDIR:						_import();						break;									}			}						/**			* 			*			* @param 			* @return			*/			protected function _import() : void {				_oFILE = new File();				_oFILE.addEventListener(FileListEvent.SELECT_MULTIPLE , _onBrowsed , false , 10 , true);				_oFILE.browseForOpenMultiple('From ... ' , [new FileFilter('Media Files','*.swf;*.png')]);			}						/**			* 			*			* @param 			* @return			*/			protected function _onBrowsed( e: FileListEvent ) : void {				var aFILES:Array = e.files;				var l : int = aFILES.length - 1;				var i : int = -1;				while( i++ < l ){					(model as TilesModel).importFile(aFILES[i]);				}								(model as TilesModel).dbUpdate();			}				// -------o misc			public static function trc(arguments : *) : void {				Logger.log(TilesController, arguments);			}	}}