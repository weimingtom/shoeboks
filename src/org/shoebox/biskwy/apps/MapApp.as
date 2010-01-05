/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.apps {	import org.shoebox.biskwy.controllers.MapController;	import org.shoebox.biskwy.core.Config;	import org.shoebox.biskwy.core.IsoGrid;	import org.shoebox.biskwy.core.TwoD;	import org.shoebox.biskwy.models.MapModel;	import org.shoebox.biskwy.views.maps.IsoMap;	import org.shoebox.biskwy.views.maps.MapTwoD;	import org.shoebox.patterns.mvc.abstracts.AApplication;	import org.shoebox.utils.logger.Logger;	/**	 * org.shoebox.biskwy.apps.MapApp	* @author shoebox	*/	public class MapApp extends AApplication{				protected static var __instance		:MapApp;				// -------o constructor					public function MapApp( e : SingletonEnforcer ) : void {				trc('constructor ::: '+Config.GRIDTYPE);				redraw();			}		// -------o public						/**			* getInstance function			* @public			* @param 			* @return			*/			static public function getInstance() : MapApp {								if(__instance == null)					__instance = new MapApp( new SingletonEnforcer() );									return __instance;			}						/**			* redraw function			* @public			* @param 			* @return			*/			public function redraw() : void {								//					if(_oCOMMAND){						_oCOMMAND.cancel();						_oCOMMAND = null;					}									//					var 	ns:Namespace = Config.GRIDTYPE; 						ns::init();				}						/**			* init function			* @public			* @param 			* @return			*/			TwoD function init() : void {				init(MapModel , MapTwoD , MapController , this);				}						/**			* init function			* @public			* @param 			* @return			*/			IsoGrid function init() : void {				init(MapModel , IsoMap , MapController , this);				}					// -------o protected		// -------o misc			public static function trc(arguments : *) : void {				Logger.log(MapApp, arguments);			}	}}internal class SingletonEnforcer{}