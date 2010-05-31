/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.models {	import org.shoebox.biskwy.commands.menu.CommandNewMap;	import org.shoebox.biskwy.core.Database;	import org.shoebox.biskwy.core.Schemas;	import org.shoebox.biskwy.services.SMaps;	import org.shoebox.patterns.commands.events.CommandEvents;	import org.shoebox.patterns.mvc.abstracts.AModel;	import org.shoebox.patterns.mvc.interfaces.IModel;	import org.shoebox.patterns.service.ServiceEvent;	import org.shoebox.patterns.service.ServiceFactory;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	import flash.events.SQLEvent;	/**	 * org.shoebox.biskwy.models.MMaps	* @author shoebox	*/	public class MMaps extends AModel implements IModel {				protected var _aMAPS			:Array;		protected var _oSMAPS			:SMaps;		protected var _uLEN			:uint;		protected var _uMAPID			:uint;				// -------o constructor					public function MMaps() : void {			}		// -------o public						/**			* initialize function			* @public			* @param 			* @return			*/			final override public function initialize( e : Event = null ) : void {								//					_oSMAPS = ServiceFactory.getService(SMaps) as SMaps;					_oSMAPS.addEventListener(ServiceEvent.ON_DATAS , 	_onMaps , false , 10 , true);					_oSMAPS.addEventListener(ServiceEvent.ON_REFRESH, 	_onMaps , false , 10 , true);								_onTable();				CommandNewMap.getInstance().addEventListener( CommandEvents.COMPLETE , _getDatas , false , 10 , true );			}									/**			* cancel function			* @public			* @param 			* @return			*/			final override public function cancel(e:Event = null) : void {				CommandNewMap.getInstance().removeEventListener( CommandEvents.COMPLETE , _getDatas , false);						}						/**			* Getter the length of the maps list 			* @public			* @return	size of the list (uint)			*/			public function get length() : uint {				return _uLEN;			}						/**			* Get the complete list of maps			* @public			* @return	list of maps (Array)			*/			public function get maps() : Array {				return _aMAPS;			}						/**			* Get the item contains in the list at the provided position			* @public				* @param 	i : Position in to the list (uint)			* @return	table item (object)			*/			public function getItemAt( i : uint ) : Object {				return _aMAPS[i];			}						/**			* refresh function			* @public			* @param 			* @return			*/			public function refresh() : void {				_getDatas();			}						/**			* set selectedMapID function			* @public			* @param 			* @return			*/			public function set selectedMapID( u : uint ) : void {				_uMAPID = u;			}						/**			* get selectedMapID function			* @public			* @param 			* @return			*/			public function get selectedMapID() : uint {				return _uMAPID;			}					// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _onTable( ) : void {				trc('onTable');				_getDatas();			}						/**			* 			*			* @param 			* @return			*/			protected function _getDatas( e : Event = null ) : void {				_oSMAPS.call();			}						/**			* 			*			* @param 			* @return			*/			protected function _onMaps( e : ServiceEvent ) : void {								if(!e.datas)					return;								_aMAPS = e.datas as Array;				_uLEN = _aMAPS.length;				update('osef');			}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(MMaps, args);			}	}}