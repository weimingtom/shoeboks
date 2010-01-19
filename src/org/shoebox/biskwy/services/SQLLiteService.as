/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.services {	import org.shoebox.biskwy.core.Database;	import org.shoebox.core.BoxObject;	import org.shoebox.patterns.service.AbstractService;	import org.shoebox.patterns.service.IService;	import org.shoebox.patterns.service.ServiceEvent;	import org.shoebox.utils.logger.Logger;	import flash.events.SQLEvent;	/**	 * org.shoebox.biskwy.services.SQLLiteService	* @author shoebox	*/	public class SQLLiteService extends AbstractService implements IService{				protected var _oBASE			:Database;		protected var _oPARAMS			:Object;		protected var _sREQUEST		:String;				// -------o constructor					public function SQLLiteService() : void {			}		// -------o public						/**			* set request function			* @public			* @param 			* @return			*/			public function set request( s : String ) : void {				_sREQUEST = s;			}						/**			* get request function			* @public			* @param 			* @return			*/			public function get request() : String {				return _sREQUEST;			}						/**			* get base function			* @public			* @param 			* @return			*/			public function get base() : Database {				if(_oBASE==null)					_oBASE = Database.getInstance();									return _oBASE;			}						/**			* onCall function			* @public			* @param 			* @return			*/			override public function onCall() : void {				trc('onExecute ::: '+base);				base.params = _oPARAMS;				base.text = _sREQUEST;				base.addEventListener( SQLEvent.RESULT , _onResults , false , 10 , true);				base.execute();				_bISRUNNING = false;				_oPARAMS = null;			}						/**			* onCancel function			* @public			* @param 			* @return			*/			override public function onRefresh() : void {				trc('onRefresh');				onCall();			}						/**			* addParameters function			* @public			* @param 			* @return			*/			public function addParameter( prop : String , value : * ) : void {								if(!_oPARAMS)					_oPARAMS = {};								_oPARAMS[prop] = value;			}					// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _onResults( e : SQLEvent ) : void {				trc('_onResults');				base.removeEventListener(SQLEvent.RESULT, _onResults, false);									var oEvent : ServiceEvent = new ServiceEvent(ServiceEvent.ON_DATAS);				BoxObject.accessorInit(oEvent, {datas:_oBASE.getResult().data, dataType:'SQLiteResults', name:'datas'});				dispatchEvent(oEvent);				onComplete();			}								// -------o misc			public static function trc(arguments : *) : void {				Logger.log(SQLLiteService, arguments);			}	}}