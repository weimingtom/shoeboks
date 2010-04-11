/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.models {	import org.shoebox.engine.datas.MapData;
	import org.shoebox.engine.services.SMap;	import org.shoebox.patterns.mvc.abstracts.AModel;	import org.shoebox.patterns.mvc.interfaces.IModel;	import org.shoebox.patterns.service.ServiceEvent;	import org.shoebox.patterns.service.ServiceFactory;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	/**	 * org.shoebox.engine.models.MMap	* @author shoebox	*/	public class MMap extends AModel implements IModel {				protected var _oDATAS		:MapData;				// -------o constructor					/**			* Constructor of the MMap class			*			* @public			* @return	void			*/			public function MMap() : void {			}		// -------o public						/**			* Model initialization			* 			* @public			* @param	e : optional initialization event (Event) 			* @return	void			*/			final override public function initialize( e : Event = null ) : void {				trc('initialize ::: '+e);				ServiceFactory.getService( SMap ).addEventListener( ServiceEvent.ON_DATAS , _onDatas , false , 10 , true );			}			/**			* When the model is canceled			* 			* @public			* @param	e : optional cancel event (Event) 			* @return	void			*/			final override public function cancel(e:Event = null) : void {				ServiceFactory.getService( SMap ).removeEventListener( ServiceEvent.ON_DATAS , _onDatas , false);			}					// -------o protected						/**			* When the map datas are loaded			*			* @param 	e : service response event ( ServiceEvent )			* @return	void			*/			protected function _onDatas( e : ServiceEvent ) : void {				trc('onDatas ::: '+e.datas );				_oDATAS = e.datas;				update('osef');			}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(MMap, args);			}	}}