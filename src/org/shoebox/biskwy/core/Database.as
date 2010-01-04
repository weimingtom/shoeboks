/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.core {	import org.shoebox.utils.logger.Logger;	import flash.data.SQLConnection;	import flash.data.SQLResult;	import flash.data.SQLStatement;	import flash.events.Event;	import flash.events.SQLErrorEvent;	import flash.events.SQLEvent;	/**	 * org.shoebox.biskwy.core.Database	* @author shoebox	*/	public class Database extends SQLConnection{				protected var _oPARAMS			: Object;		protected var _stSQL			: SQLStatement;		protected var _oCONN			: SQLConnection;				protected static var __instance	: Database = null;				// -------o constructor					public function Database( e : SingletonEnforcer ) : void {							}		// -------o public						/**			* getInstance function			* @public			* @param 			* @return			*/			static public function getInstance() : Database {								if(__instance==null)					__instance = new Database(new SingletonEnforcer());								return __instance;			}						/**			* purge function			* @public			* @param 			* @return			*/			static public function purge() : void {				__instance = null;			}						/**			* set request function			* @public			* @param 			* @return			*/			public function set text( s : String ) : void {				_stSQL =  new SQLStatement();				_stSQL.text = s;				_stSQL.addEventListener( SQLEvent.RESULT , _onResults , false , 10 , true);				_stSQL.sqlConnection = this;								for(var prop:String in _oPARAMS)					_stSQL.parameters[prop] = _oPARAMS[prop];								_oPARAMS = null;			}						/**			* get statement function			* @public			* @param 			* @return			*/			public function get statement() : SQLStatement {				return _stSQL;			}						/**			* get text function			* @public			* @param 			* @return			*/			public function get text() : String {				return _stSQL.text;			}						/**			* execute function			* @public			* @param 			* @return			*/			public function execute() : void {				//trc('execute ::: '+_stSQL.text);				_stSQL.execute();			}						/**			* getResult function			* @public			* @param 			* @return			*/			public function getResult() : SQLResult {				return _stSQL.getResult();			}						/**			* init function			* @public			* @param 			* @return			*/			public function init() : void {				if(connected)					close();								addEventListener( SQLEvent.OPEN , _init , false , 10 , true);				open( Config.PROJECTFILE );					}						/**			* set params function			* @public			* @param 			* @return			*/			public function set params( o : Object ) : void {				_oPARAMS = o;			}		// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _init( e : SQLEvent ) : void {				dispatchEvent(new Event(Event.COMPLETE));						}						/**			* 			*			* @param 			* @return			*/			protected function _onError( e : SQLErrorEvent ) : void {				trc('onError ::: '+e.text);			}						/**			* 			*			* @param 			* @return			*/			protected function _onResults( e : SQLEvent) : void {				dispatchEvent(e);			}								// -------o misc			public static function trc(arguments : *) : void {				Logger.log(Database, arguments);			}	}}internal class SingletonEnforcer{	}