/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.services.assets {	import flash.events.SQLEvent;
	import flash.events.Event;
	import org.shoebox.biskwy.core.DatabaseAssets;
	import org.shoebox.patterns.service.IService;
	import org.shoebox.patterns.service.AbstractService;
	import org.shoebox.utils.logger.Logger;	/**	 * Service to obtains the list of all the tiles registered for the project	* 	*  	* org.shoebox.biskwy.services.STiles	* @author shoebox	*/	public class STiles extends AbstractService implements IService {				protected var _oBASE			: DatabaseAssets;		protected var _sFILTER			: String;				// -------o constructor					public function STiles( ) : void {				super();				useCaching = false;			}		// -------o public						/**			* onCall function			* @public			* @param 			* @return			*/			final override public function onCall() : void {				_open();			}						/**			* onRefresh function			* @public			* @param 			* @return			*/			final override public function onRefresh() : void {						}						/**			* set filter function			* @public			* @param 			* @return			*/			public function set filter( s : String ) : void {				_sFILTER = s;			}								// -------o protected						/**			* 			*			* @param 			* @return			*/			final protected function _open() : void {				_oBASE = DatabaseAssets.getInstance( );				_oBASE.addEventListener( SQLEvent.RESULT , _onResults , false , 10 , true );				if( _sFILTER !=='' && _sFILTER!=='null')					_oBASE.call('SELECT * FROM TilesDB WHERE cat="'+_sFILTER+'"' );				else					_oBASE.call('SELECT * FROM TilesDB' );									_sFILTER = null;			}						/**			* 			*			* @param 			* @return			*/			final protected function _onResults( e : SQLEvent ) : void {				trc('onResults');								dispatch( _oBASE.getResults() );				_oBASE.removeEventListener(SQLEvent.RESULT , _onResults , false );				_oBASE.close( );				onComplete();			}					// -------o misc			public static function trc(arguments : *) : void {				Logger.log(STiles, arguments);			}	}}