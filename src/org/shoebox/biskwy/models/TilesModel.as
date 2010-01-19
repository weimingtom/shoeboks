/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.models {	import fl.data.DataProvider;	import org.shoebox.biskwy.apps.TilesApp;	import org.shoebox.biskwy.core.Database;	import org.shoebox.biskwy.services.SCats;	import org.shoebox.biskwy.services.SImportTile;	import org.shoebox.biskwy.services.STiles;	import org.shoebox.patterns.commands.events.CommandEvents;	import org.shoebox.patterns.mvc.abstracts.AModel;	import org.shoebox.patterns.mvc.interfaces.IModel;	import org.shoebox.patterns.service.ServiceBatch;	import org.shoebox.patterns.service.ServiceEvent;	import org.shoebox.patterns.service.ServiceFactory;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	import flash.events.SQLErrorEvent;	import flash.events.SQLEvent;	import flash.filesystem.File;	/**	 * org.shoebox.biskwy.models.TilesModel	* @author shoebox	*/	public class TilesModel extends AModel implements IModel{				protected var _aFILES		: Array;		protected var _oBATCH		: ServiceBatch;		protected var _oDPCATS		: DataProvider;		protected var _oBASE		: Database;		protected var _oSERVICE	: STiles;		protected var _sCAT		: String;		protected var _oIMPORT		: SImportTile;		protected var _uLENGTH		: uint;		protected var _uSELECTION	: uint = 0;				// -------o constructor					public function TilesModel() : void {				_oBASE = Database.getInstance();			}		// -------o public						/**			* initialize function			* @public			* @param 			* @return			*/			final override public function initialize() : void {				_oBASE = Database.getInstance();						_createTable();					}									/**			* cancel function			* @public			* @param 			* @return			*/			final override public function cancel(e:Event = null) : void {									}						/**			* import function			* @public			* @param 			* @return			*/			public function importFile( o : File ) : void {				if(!_oBATCH)					_oBATCH = new ServiceBatch();					_oBATCH.addService(SImportTile , {file : o});							}						/**			* launchImport function			* @public			* @param 			* @return			*/			public function launchImport() : void {				trc('launchImport');				_oBATCH.addEventListener( CommandEvents.COMPLETE , _filter , false , 10 , true );				_oBATCH.call();			}						/**			* dbUpdate function			* @public			* @param 			* @return			*/			public function dbUpdate() : void {				_onDBInit();			}						/**			* get length function			* @public			* @param 			* @return			*/			public function get length() : uint {				return _uLENGTH;						}						/**			* get files function			* @public			* @param 			* @return			*/			public function get files() : Array {				return _aFILES;			}						/**			* get selected function			* @public			* @param 			* @return			*/			public function get selected() : Object {				return _aFILES[_uSELECTION];			}						/**			* set selected function			* @public			* @param 			* @return			*/			public function set selectedID( u : uint) : void {				trc('set selected ::: '+u);				_uSELECTION = u;			}						/**			* get selectedID function			* @public			* @param 			* @return			*/			public function get selectedID() : uint {				return _uSELECTION;			}						/**			* get cats function			* @public			* @param 			* @return			*/			public function get cats() : DataProvider {				return _oDPCATS;			}						/**			* filter function			* @public			* @param 			* @return			*/			public function filter( sCAT : String ) : void {				_sCAT = sCAT;				_filter();							}						/**			* getTileByID function			* @public			* @param 			* @return			*/			public function getTileByID( u : uint ) : Object {				//getTileByID								var i : int = 0;				for( i ; i < length ; i++)					if(_aFILES[i].id==u)						return _aFILES[i];								return null;			}					// -------o protected									/**			* 			*			* @param 			* @return			*/			protected function _createTable( e : Event = null) : void {				trc('createTable :::: '+e);				//_oBASE.text = 'DROP TABLE TilesDB';				_oBASE.text = 'CREATE TABLE IF NOT EXISTS TilesDB (id INTEGER PRIMARY KEY , name TEXT , cat TEXT , filepath TEXT , decalX NUMERIC , decalY NUMERIC , walkable BOOLEAN , active BOOLEAN ,media BLOB)';				_oBASE.addEventListener( SQLEvent.RESULT , _onDBInit , false , 10 , true);				_oBASE.execute();			}									/**			* 			*			* @param 			* @return			*/			protected function _onDBInit( e : SQLEvent = null ) : void {				trc('onDBInit');				if(e);					_oBASE.removeEventListener( SQLEvent.RESULT , _onDBInit , false);									_getCats();			}						/**			* 			*			* @param 			* @return			*/			protected function _getCats() : void {				var 	oSERVICE : SCats = ServiceFactory.getService(SCats) as SCats;					oSERVICE.addEventListener(ServiceEvent.ON_DATAS , 	_onCats , false , 10 , true);					//oSERVICE.addEventListener(ServiceEvent.ON_REFRESH, 	_onCats , false , 10 , true);					oSERVICE.call();			}						/**			* 			*			* @param 			* @return			*/			protected function _onCats( e : ServiceEvent ) : void {								var aCATS:Array = e.datas as Array;								_oDPCATS = new DataProvider();				_oDPCATS.addItem({label:'All'});								var o : Object = {};				for each( o in aCATS)					_oDPCATS.addItem({label : o.cat});								if(e.type == ServiceEvent.ON_DATAS){					e.target.removeEventListener(ServiceEvent.ON_DATAS , 	_onCats , false);					_getTiles();				}							}							/**			* 			*			* @param 			* @return			*/			protected function _getTiles( e : ServiceEvent = null ) : void {							_oSERVICE = ServiceFactory.getService(STiles) as STiles;				_oSERVICE.addEventListener(ServiceEvent.ON_DATAS , _onResults , false , 10 , true);				_oSERVICE.call();							}						/**			* 			*			* @param 			* @return			*/			protected function _onResults( e : ServiceEvent ) : void {				_oBASE.removeEventListener( SQLEvent.RESULT , _onResults , false);				_aFILES = e.datas;				_uLENGTH = (_aFILES) ? _aFILES.length : 0;				update(TilesApp.ON_DATAS);			}						/**			* 			*			* @param 			* @return			*/			protected function _onError(e:SQLErrorEvent) : void {				trc('onError ::: '+e);			}						/**			* 			*			* @param 			* @return			*/			protected function _filter( e : CommandEvents = null ) : void {				trc('_filter');				_oSERVICE = ServiceFactory.getService(STiles) as STiles;				_oSERVICE.filter = _sCAT;				_oSERVICE.addEventListener(ServiceEvent.ON_DATAS , _onResults , false , 10 , true);				_oSERVICE.call();			}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(TilesModel, args);			}	}}