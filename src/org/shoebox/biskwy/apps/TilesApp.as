/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.apps {	import org.shoebox.biskwy.controllers.TilesController;	import org.shoebox.biskwy.models.TilesModel;	import org.shoebox.biskwy.views.TilesView;	import org.shoebox.patterns.mvc.abstracts.AApplication;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	/**	 * org.shoebox.biskwy.apps.TilesApp	* @author shoebox	*/	public class TilesApp extends AApplication{				public static const	ON_DATAS 		:String = 'ON_DATAS';				protected static var __instance		:TilesApp;				// -------o constructor					public function TilesApp() : void {				__instance = this;				addEventListener(Event.ADDED_TO_STAGE , _onStaged , false , 10 , true);				}		// -------o public					/**			* get selected function			* @public			* @param 			* @return			*/			static public function get selected() : String {				return (getInstance().model as TilesModel).selected;			}						/**			* getInstance function			* @public			* @param 			* @return			*/			static public function getInstance() : TilesApp {				return __instance;			}					// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _onStaged( e : Event = null ) : void {				init(TilesModel , TilesView , TilesController , this);			}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(TilesApp, args);			}	}}