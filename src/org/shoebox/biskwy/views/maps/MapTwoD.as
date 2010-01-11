/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.views.maps {	import org.shoebox.biskwy.core.Config;	import org.shoebox.biskwy.items.GridTile;	import org.shoebox.biskwy.models.MapModel;	import org.shoebox.display.DisplayFuncs;	import org.shoebox.patterns.commands.samples.IStageable;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.patterns.mvc.events.UpdateEvent;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	import flash.geom.Vector3D;	/**	* 2D game map inherit of the <b>VMap</b> base class	* 	* 	* org.shoebox.biskwy.views.maps.MapTwoD	* @author shoebox	*/	public class MapTwoD extends VMap implements IStageable{				// -------o constructor					public function MapTwoD() : void {				trc('constructor');				super();			}		// -------o public						/**			* initialize function			* @public			* @param 			* @return			*/			final override public function initialize() : void {						}						/**			* onResize function			* @public			* @param 			* @return			*/			final override public function onStaged(e:Event = null) : void {				super.onStaged(e);				_run();				}									/**			* onRemoved function			* @public			* @param 			* @return			*/			final override public function onRemoved(e:Event = null) : void {				super.onRemoved(e);								}						/**			* update function			* @public			* @param 			* @return			*/			final override public function update( o : UpdateEvent = null ) : void {				_run();			}					// -------o protected							/**			* 			*			* @param 			* @return			*/			protected function _run() : void {								DisplayFuncs.purge(_spCONTAINER);								var w : uint = Config.GRID_WIDTH  - 1;				var h : uint = Config.GRID_HEIGHT - 1;				var x : int = -1;				var y : int = -1;				var c : GridTile;								while(x++ < w){					y = -1;					while(y++ < h){						c = Factory.build( GridTile , { 													name : 'tile'+x+'_'+y , 												x : x * Config.TILESIZE , 												y : y * Config.TILESIZE ,												position : new Vector3D( x , y , 0)											} );						_spCONTAINER.addChild( c );						(model as MapModel).register(c);					}									}								redraw();			}		// -------o misc			public static function trc(arguments : *) : void {				Logger.log(MapTwoD, arguments);			}	}}