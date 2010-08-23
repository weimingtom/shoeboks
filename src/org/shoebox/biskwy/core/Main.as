/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list  of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.core {	import fl.controls.Button;	import fl.managers.StyleManager;	import org.shoebox.biskwy.commands.AboutCommand;	import org.shoebox.errors.Errors;	import org.shoebox.io.font.FontList;	import org.shoebox.libs.pimpmyair.behaviors.ZWindow;	import org.shoebox.patterns.commands.events.CommandEvents;	import org.shoebox.patterns.commands.samples.StageBatch;	import org.shoebox.patterns.service.MediaService;	import org.shoebox.patterns.service.ServiceEvent;	import org.shoebox.utils.display.STAGEINSTANCE;	import org.shoebox.utils.logger.Logger;	import flash.desktop.NativeApplication;	import flash.display.NativeWindow;	import flash.display.Sprite;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.events.Event;	import flash.events.UncaughtErrorEvent;	import flash.net.URLRequest;	import flash.system.ApplicationDomain;	import flash.system.LoaderContext;	import flash.text.Font;	import flash.text.TextFormat;	import flash.utils.getDefinitionByName;	/**	 * org.shoebox.biskwy.core.Main	* @author shoebox	*/	public class Main extends Sprite{				protected var _oFACADE		:Facade;					// -------o constructor					public function Main() : void {				_init();			}		// -------o public				// -------o protected						/**			* Initializing			*			* @return void			*/			protected function _init() : void {								//Logger.exclude('org.shoebox');				Logger.level = Logger.LOGLEVEL_LOG;				stage.nativeWindow.addEventListener(Event.CLOSE , _onClose , false , 10 , true);				ZWindow.getInstance().register( stage.nativeWindow , 0 );				NativeApplication.nativeApplication.autoExit = true;				loaderInfo.uncaughtErrorEvents.addEventListener( UncaughtErrorEvent.UNCAUGHT_ERROR , _onError );				STAGEINSTANCE = stage;				STAGEINSTANCE.scaleMode = StageScaleMode.NO_SCALE;				STAGEINSTANCE.align = StageAlign.TOP_LEFT;				new StageBatch(stage).execute();				stage.nativeWindow.visible = false;				_assets();			}						/**			* 			*			* @param 			* @return			*/			final protected function _onError( e : UncaughtErrorEvent ) : void {				Errors.throwError(e);			}			 			/**			* Loading the biskwy's assets			*			* @return void			*/			protected function _assets() : void {								var 	oSERVICE:MediaService = new MediaService();					oSERVICE.request = new URLRequest('assets.swf');					oSERVICE.context = new LoaderContext(false,ApplicationDomain.currentDomain);					oSERVICE.addEventListener(ServiceEvent.ON_DATAS, _onAssets , false , 10 , true);					oSERVICE.call();			}						/**			* When the assets are loaded			*			* @param 	e : event (ServiceEvent)			* @return	void			*/			protected function _onAssets( e : ServiceEvent) : void {				trc('onAssets');								//					(e.target as MediaService).removeEventListener(ServiceEvent.ON_DATAS , _onAssets , false);					Font.registerFont(getDefinitionByName('PFTempesta') as Class);					Font.registerFont(getDefinitionByName('PFTempestaBold') as Class);					FontList.list();								//	      		      StyleManager.setStyle('textFormat', new TextFormat('PF Tempesta Seven',8,0x000000) );	      		      StyleManager.setStyle('embedFonts', true );	      		      StyleManager.setStyle('verticalAlign', 'middle' );	      		     	StyleManager.setComponentStyle(Button, 'textFormat', new TextFormat('PF Tempesta Seven',8,0xFFFFFF));	      		     	StyleManager.setComponentStyle(Button, 'disabledTextFormat', new TextFormat('PF Tempesta Seven',8,0x696969));	      		            		      //      		      	stage.nativeWindow.maximize();	      		      //_run();	      		      _runFacade();			}						/**			* Running the Splashscreen before launching the main app 			*			* @return			*/			protected function _run() : void {				trc('run ::: ');								var 	oCOM : AboutCommand = AboutCommand.getInstance();					oCOM.addEventListener( CommandEvents.COMPLETE , _onSplashed , false , 10 , true);					oCOM.execute();			}						/**			* When the splashscreen is complete			*			* @param 	e : CommandsEvent complete (CommandEvents)			* @return	void			*/			protected function _onSplashed( e : Event ) : void {				(e.target as AboutCommand).removeEventListener(CommandEvents.COMPLETE , _onSplashed , false);		 						//					_runFacade();			}						/**			* 			*		 	* @param 			* @return			*/			protected function _runFacade() : void {								//						if(!NativeWindow.supportsMenu)						NativeApplication.nativeApplication.menu = Menu.getInstance();					else						stage.nativeWindow.menu = Menu.getInstance();								//						_oFACADE = Facade.getInstance();					_oFACADE.owner = this;					_oFACADE.init();					_oFACADE.state = Facade.STATE_WELCOME;					stage.nativeWindow.visible = true;									//addChild( new Perf());			}						/**			* When the main windows is closed, we close all the opened windows of the <code>NativeApplication</code>			*			* @param 	e : Close Event (Event)			* @return	void			*/			protected function _onClose(e : Event) : void {				e.preventDefault();				var i : int = NativeApplication.nativeApplication.openedWindows.length - 1;				for (i ;i >= 0; --i) 					NativeWindow(NativeApplication.nativeApplication.openedWindows[i]).close();							}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(Main, args);			}	}}