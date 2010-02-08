/**
  HomeMade by shoe[box]
 
  Redistribution and use in source and binary forms, with or without 
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the 
    documentation and/or other materials provided with the distribution.
  
  * Neither the name of shoe[box] nor the names of its 
    contributors may be used to endorse or promote products derived from 
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

package org.shoebox.biskwy.core {
	import flash.text.TextFieldAutoSize;
	import fl.controls.Button;
	import fl.managers.StyleManager;

	import org.shoebox.biskwy.apps.AppMaps;
	import org.shoebox.biskwy.apps.AppTileContent;
	import org.shoebox.biskwy.apps.AppToolProps;
	import org.shoebox.biskwy.apps.AppTools;
	import org.shoebox.biskwy.apps.AppWelcome;
	import org.shoebox.biskwy.apps.MapApp;
	import org.shoebox.biskwy.apps.TileEditorApp;
	import org.shoebox.biskwy.apps.TilesApp;
	import org.shoebox.biskwy.commands.AboutCommand;
	import org.shoebox.biskwy.commands.menu.CommandCloseProject;
	import org.shoebox.biskwy.commands.menu.CommandNewProject;
	import org.shoebox.biskwy.commands.menu.CommandOpenLastProject;
	import org.shoebox.biskwy.commands.menu.CommandOpenProject;
	import org.shoebox.biskwy.views.maps.VMap;
	import org.shoebox.io.font.FontList;
	import org.shoebox.libs.pimpmyair.containers.SplashScreen;
	import org.shoebox.libs.pimpmyair.utils.NativeWindowUtils;
	import org.shoebox.patterns.commands.events.CommandEvents;
	import org.shoebox.patterns.commands.samples.StageBatch;
	import org.shoebox.patterns.service.MediaService;
	import org.shoebox.patterns.service.ServiceEvent;
	import org.shoebox.utils.display.STAGEINSTANCE;
	import org.shoebox.utils.logger.Logger;

	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;

	/**
	 * First version of the Facade of the application
	* To be redone soon*
	* 
	*  
	* org.shoebox.biskwy.core.Main
	* @author shoebox
	*/
	public class Main extends Sprite{
		
		public static var MAP			:VMap;
		public static var RIGHTCONTAINER	:Sprite = new Sprite();
		public static var currentMAP	:Sprite;
		
		protected var _oAPPW		:AppWelcome;
		protected var _oMAPS		:AppMaps;
		protected var _oSPLASH		:SplashScreen;
		protected var _oMENU		:NativeMenu;
		protected var _oWIN		:NativeWindow;
		protected var _oTILES		:TilesApp;
		protected var _oTOOLS		:NativeWindow;
		protected var _oTILECONTENT	:AppTileContent;
		protected var _oAPPTOOLPROPS	:AppToolProps;
		
		// -------o constructor
		
			public function Main() : void {
				STAGEINSTANCE = stage;
				STAGEINSTANCE.scaleMode = StageScaleMode.NO_SCALE;
				STAGEINSTANCE.align = StageAlign.TOP_LEFT;
				new StageBatch(stage).execute();
				stage.nativeWindow.visible = false;
				_assets();
			}

		// -------o public
		
		// -------o protected
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			protected function _assets() : void {
				
				var 	oSERVICE:MediaService = new MediaService();
					oSERVICE.request = new URLRequest('assets.swf');
					oSERVICE.context = new LoaderContext(false,ApplicationDomain.currentDomain);
					oSERVICE.addEventListener(ServiceEvent.ON_DATAS, _onAssets , false , 10 , true);
					oSERVICE.call();
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			protected function _onAssets( e : ServiceEvent) : void {
				trc('onAssets');
				e.target.removeEventListener(ServiceEvent.ON_DATAS , _onAssets , false);
				Font.registerFont(getDefinitionByName('PFTempesta') as Class);
				FontList.list();
				
				//PF Tempesta Seven_8pt_st
      		      StyleManager.setStyle('textFormat', new TextFormat('PF Tempesta Seven_8pt_st',8,0x000000) );
      		      StyleManager.setStyle('embedFonts', true );
      		     	StyleManager.setComponentStyle(Button, 'textFormat', new TextFormat('PF Tempesta Seven_8pt_st',8,0xFFFFFF));
      		      
      		      //
      		      stage.nativeWindow.maximize();
      		      
				_run();
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			protected function _run() : void {
				trc('run ::: ');
				
				var 	oCOM : AboutCommand = AboutCommand.getInstance();
					oCOM.addEventListener( CommandEvents.COMPLETE , _onSplashed , false , 10 , true);
					oCOM.execute();
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			protected function _onSplashed( e : Event ) : void {
				e.target.removeEventListener(CommandEvents.COMPLETE , _onSplashed , false);
				
				//
					if(!NativeWindow.supportsMenu)
						NativeApplication.nativeApplication.menu = Menu.getInstance();
					else
						stage.nativeWindow.menu = Menu.getInstance();
					 
				//				
					CommandNewProject.getInstance().addEventListener(CommandEvents.COMPLETE , _onProject , false , 10 , true);
					CommandOpenProject.getInstance().addEventListener(CommandEvents.COMPLETE , _onProject , false , 10 , true);
					CommandOpenLastProject.getInstance().addEventListener(CommandEvents.COMPLETE , _onProject , false , 10 , true);
					CommandCloseProject.getInstance().addEventListener(CommandEvents.COMPLETE , _onCloseProject , false , 10 , true);
					
				//
					stage.nativeWindow.visible = false;
					_welcome();	
					Menu.getInstance().addEventListener(Event.SELECT , _onSelect , false , 10 , true);
					stage.nativeWindow.addEventListener(Event.CLOSE , _onClose , false , 10 , true);
					
					stage.nativeWindow.visible = true;
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			protected function _welcome() : void {
				_oAPPW = new AppWelcome();
				addChild(_oAPPW);
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			protected function _onSelect( e : Event = null ) : void {
				
				if(!(e.target is NativeMenuItem))
					return;
				
				switch((e.target as NativeMenuItem).label){
					
					case Menu.TILE_EDITOR:
						var 	oWIN:NativeWindow = new NativeWindow( new NativeWindowInitOptions());
							oWIN.width = 900;
							oWIN.height = 600;
							oWIN.title = 'Sprite Editor';
							//oWIN.stage.addChild(new TileEditorApp);
							oWIN.stage.scaleMode = StageScaleMode.NO_SCALE;
							oWIN.stage.align = StageAlign.TOP_LEFT;
							oWIN.activate();
						break;
					
				}
				
			}
			
			/**
			* 
			*
			* @param 
			* @return
			 */
			protected function _onClose(e : Event) : void {
				e.preventDefault();
				var i : int = NativeApplication.nativeApplication.openedWindows.length - 1;
				for (i ;i >= 0; --i) 
					NativeWindow(NativeApplication.nativeApplication.openedWindows[i]).close();
				
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			protected function _onProject( e : Event ) : void {
				trc('onProject ::: '+e);
				
				
				
				if(_oAPPW)
					if(contains(_oAPPW))
						removeChild(_oAPPW);
				
				if(_oTILES)
					if(contains(_oTILES))
						removeChild(_oTILES);
				
				_oTILES = new TilesApp();
				//addChild(Controls.getInstance());
				addChild(MapApp.getInstance());
				addChild(RIGHTCONTAINER);
				addChild(_oTILES);
				_oAPPTOOLPROPS = new AppToolProps();
				addChild( _oAPPTOOLPROPS);
				_tools();	
				Menu.getInstance().activate();
				
				_oMAPS = new AppMaps();
				addChild(_oMAPS);
				
				_oTILECONTENT = AppTileContent.getInstance();
				addChild(_oTILECONTENT);
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			protected function _tools() : void {
				
				var	oOPT:NativeWindowInitOptions = new NativeWindowInitOptions();
					oOPT.resizable = oOPT.maximizable = oOPT.minimizable =  false;
					oOPT.systemChrome = NativeWindowSystemChrome.STANDARD;
					oOPT.type = NativeWindowType.UTILITY;
					
				var	oWIN:NativeWindow = new NativeWindow( oOPT );
					oWIN.title = 'Tools';
					oWIN.alwaysInFront = true;
					oWIN.stage.addChild(new AppTools());
					oWIN.stage.scaleMode = StageScaleMode.NO_SCALE;
					oWIN.stage.align = StageAlign.TOP_LEFT;
					oWIN.activate();		
					oWIN.visible = false;
				
				_oTOOLS = oWIN;
				
				NativeWindowUtils.resizeWindow(oWIN,100,200);
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			protected function _onCloseProject( e : CommandEvents ) : void {
				trc('onCloseProject ::: '+e);
				_oTOOLS.close();
				removeChild(MapApp.getInstance());
				MapApp.drop();
				removeChild(RIGHTCONTAINER);
				removeChild(_oTILES);
				removeChild(_oMAPS);
				_oTILES = null;
				_welcome();
			}
			
		// -------o misc

			public static function trc(arguments : *) : void {
				Logger.log(Main, arguments);
			}
	}
}
