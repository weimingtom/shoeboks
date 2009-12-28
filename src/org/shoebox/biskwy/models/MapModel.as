/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.models {	import org.shoebox.biskwy.items.GridTile;	import org.shoebox.biskwy.views.maps.VMap;	import org.shoebox.patterns.mvc.abstracts.AModel;	import org.shoebox.patterns.mvc.interfaces.IModel;	import org.shoebox.utils.display.STAGEINSTANCE;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	import flash.events.TimerEvent;	import flash.filesystem.File;	import flash.filesystem.FileMode;	import flash.filesystem.FileStream;	import flash.net.FileFilter;	import flash.utils.ByteArray;	import flash.utils.Timer;	import flash.utils.getTimer;	/**	 * org.shoebox.biskwy.models.MapModel	* @author shoebox	*/	public class MapModel extends AModel implements IModel {				protected var _oCONTENT		:ByteArray;		protected var _oFILE			:File;		protected var _vCONTENT		:Vector.<GridTile> = new Vector.<GridTile>();		protected var _oSTREAM			:FileStream;				// -------o constructor					public function MapModel() : void {			}		// -------o public						/**			* initialize function			* @public			* @param 			* @return			*/			final override public function initialize() : void {						}									/**			* cancel function			* @public			* @param 			* @return			*/			final override public function cancel( e : Event = null ) : void {						}						/**			* register function			* @public			* @param 			* @return			*/			public function register( t : GridTile ) : void {				_vCONTENT.push(t);			}						/**			* clear function			* @public			* @param 			* @return			*/			public function clear() : void {				trc('clear');								var oFUNC : Function = function( o : GridTile , index : int , v : Vector.<GridTile> ):void{					o.clear();					};								_vCONTENT.forEach( oFUNC );			}						/**			* export function			* @public			* @param 			* @return			*/			public function saveas() : void {								_oFILE = File.desktopDirectory.resolvePath('test.bwy');				_oFILE.browseForSave('Save as');				_oFILE.addEventListener(Event.SELECT , _onBrowsed , false , 10 ,true);							}						/**			* save function			* @public			* @param 			* @return			*/			public function save() : void {								if(!_oFILE)					saveas();				else					_save();							}						/**			* open function			* @public			* @param 			* @return			*/			public function open() : void {				_oFILE = new File();				_oFILE.addEventListener( Event.SELECT , _opening , false , 10 , true);				_oFILE.browseForOpen('Open map',[new FileFilter('Biskwy map file','*.bwy')]);			}					// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _onBrowsed( e : Event ) : void {				_oFILE.removeEventListener(Event.SELECT , _onBrowsed , false );				_save();			}						/**			* 			*			* @param 			* @return			*/			protected function _save(  ) : void {				var 	oSTREAM : FileStream = new FileStream();					oSTREAM.open(_oFILE , FileMode.WRITE );					oSTREAM.writeBytes(getContent());					oSTREAM.close();			}						/**			* 			*			* @param 			* @return			*/			protected function getContent() : ByteArray {				_oCONTENT = new ByteArray();				var oFUNC : Function = function( o : GridTile , index : int , v : Vector.<GridTile> ):void{					_oCONTENT.writeInt(o.position.x);					_oCONTENT.writeInt(o.position.y);					_oCONTENT.writeObject(o.container.content);				};				_vCONTENT.forEach( oFUNC );								return _oCONTENT;			}						/**			* 			*			* @param 			* @return			*/			protected function _opening( e : Event ) : void {				STAGEINSTANCE.mouseChildren = false;				_oSTREAM = new FileStream();				_oSTREAM.open( _oFILE , FileMode.READ);												_onTimer();								var 	oT:Timer = new Timer(.0001);					oT.addEventListener(TimerEvent.TIMER , _onTimer , false , 10 , true);					oT.start();			}						/**			* 			*			* @param 			* @return			*/			protected function _onTimer( e : TimerEvent = null ) : void {				if(_oSTREAM.bytesAvailable==0){					(e.target as Timer).stop();					STAGEINSTANCE.mouseChildren = true;					_oSTREAM.close();						return;				}								//					var o : GridTile = (view as VMap).getTileAt(_oSTREAM.readInt() , _oSTREAM.readInt());					var d : Vector.<int> = _oSTREAM.readObject();									//					var l : uint = d.length;					var i : int = 0;					while( i < l){						o.container.fill(d.shift(),d.shift(),true);						i+=2;					}																}					// -------o misc			public static function trc(arguments : *) : void {				Logger.log(MapModel, arguments);			}	}}