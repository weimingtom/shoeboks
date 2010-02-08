/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.views {	import fl.containers.ScrollPane;	import org.shoebox.biskwy.items.ItemTileContent;	import org.shoebox.biskwy.items.TileLayer;	import org.shoebox.biskwy.models.MTileContent;	import org.shoebox.display.DisplayFuncs;	import org.shoebox.patterns.commands.samples.IResizeable;	import org.shoebox.patterns.commands.samples.StageResize;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.patterns.mvc.abstracts.AView;	import org.shoebox.patterns.mvc.events.UpdateEvent;	import org.shoebox.patterns.mvc.interfaces.IView;	import org.shoebox.utils.logger.Logger;	import flash.display.MovieClip;	import flash.events.Event;	import flash.events.MouseEvent;	/**	 * org.shoebox.biskwy.views.VTileContent	* @author shoebox	*/	public class VTileContent extends AView implements IView , IResizeable{				protected var _oSCROLL			:ScrollPane = new ScrollPane();		protected var _oCONTAINER		:MovieClip = new MovieClip();				// -------o constructor					public function VTileContent() : void {				StageResize.register(this);				addChild(_oCONTAINER);					addChild(_oSCROLL);					_oSCROLL.source = _oCONTAINER;				}		// -------o public						/**			* onResize function			* @public			* @param 			* @return			*/			public function onResize( e : Event = null ) : void {				x = StageResize.rect.width - 250;				y = 300;				_oSCROLL.width = 250 ;				_oSCROLL.height = StageResize.rect.height * .75 - 300;				_oSCROLL.update();			}			/**			* initialize function			* @public			* @param 			* @return			*/			final override public function initialize() : void {				StageResize.register(this);				onResize();								controller.register(_oCONTAINER , MouseEvent.CLICK , true , 10 , true);				controller.register(_oCONTAINER , Event.CHANGE , true , 10 , true);				//Main.currentMAP			}						/**			* update function			* @public			* @param 			* @return			*/			final override public function update( o : UpdateEvent = null ) : void {				_redraw();			}									/**			* cancel function			* @public			* @param 			* @return			*/			final override public function cancel( e : Event = null ) : void {									}						/**			* redraw function			* @public			* @param 			* @return			*/			public function redraw() : void {				_redraw();			}						/**			* clear function			* @public			* @param 			* @return			*/			public function clear() : void {				DisplayFuncs.purge(_oCONTAINER);			}					// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _redraw() : void {								clear();								var 	vCONTENT : Vector.<TileLayer> = (model as MTileContent).target.container.layers.slice();					vCONTENT.reverse();								var uY : uint = 0;					var l : TileLayer;				for each( l in vCONTENT){										_oCONTAINER.addChild(Factory.build( ItemTileContent , { id : l.id  , y : uY , decal : l.decal , target : l }));												uY+=75;				}				onResize();			}						/**			* 			*			* @param 			* @return			*/			protected function _onAlign( e : Event ) : void {				DisplayFuncs.distributeY(_oCONTAINER , 10);				_oSCROLL.update();			}					// -------o misc			public static function trc(arguments : *) : void {				Logger.log(VTileContent, arguments);			}	}}