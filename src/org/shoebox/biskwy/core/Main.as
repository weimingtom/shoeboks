/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.core {	import org.shoebox.biskwy.apps.MapApp;	import org.shoebox.biskwy.apps.TileEditorApp;	import org.shoebox.biskwy.apps.TilesApp;	import org.shoebox.patterns.commands.samples.StageBatch;	import org.shoebox.patterns.services.MediaService;	import org.shoebox.patterns.services.ServiceEvent;	import org.shoebox.utils.display.STAGEINSTANCE;	import org.shoebox.utils.logger.Logger;	import flash.display.NativeMenu;	import flash.display.NativeMenuItem;	import flash.display.NativeWindow;	import flash.display.NativeWindowInitOptions;	import flash.display.Sprite;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.events.Event;	import flash.net.URLRequest;	import flash.system.ApplicationDomain;	import flash.system.LoaderContext;	/**	 * org.shoebox.biskwy.core.Main	* @author shoebox	*/	public class Main extends Sprite{				protected var _oMENU		:NativeMenu;		protected var _oWIN		:NativeWindow;				// -------o constructor					public function Main() : void {				STAGEINSTANCE = stage;				STAGEINSTANCE.scaleMode = StageScaleMode.NO_SCALE;				STAGEINSTANCE.align = StageAlign.TOP_LEFT;				new StageBatch().execute();				stage.nativeWindow.visible = false;				_assets();			}		// -------o public				// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _assets() : void {								var 	oSERVICE:MediaService = new MediaService( new URLRequest('assets.swf'));					oSERVICE.context = new LoaderContext(false,ApplicationDomain.currentDomain);					oSERVICE.addEventListener(ServiceEvent.ONDATAS , _onAssets , false , 10 , true);					oSERVICE.execute();			}						/**			* 			*			* @param 			* @return			*/			protected function _onAssets( e : ServiceEvent) : void {				trc('onAssets');				_run();			}						/**			* 			*			* @param 			* @return			*/			protected function _run() : void {				trc('run ::: ');				stage.nativeWindow.menu = Menu.getInstance();				stage.nativeWindow.maximize();				addChild(new MapApp());				addChild(new TilesApp());				Menu.getInstance().addEventListener(Event.SELECT , _onSelect , false , 10 , true);				}						/**			* 			*			* @param 			* @return			*/			protected function _onSelect( e : Event = null ) : void {								switch((e.target as NativeMenuItem).label){										case Menu.TILE_EDITOR:						var 	oWIN:NativeWindow = new NativeWindow( new NativeWindowInitOptions());							oWIN.stage.addChild(new TileEditorApp);							oWIN.stage.scaleMode = StageScaleMode.NO_SCALE;							oWIN.stage.align = StageAlign.TOP_LEFT;							oWIN.activate();						break;									}							}					// -------o misc			public static function trc(arguments : *) : void {				Logger.log(Main, arguments);			}	}}