/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.core {	import org.shoebox.biskwy.commands.AboutCommand;	import org.shoebox.biskwy.commands.menu.CommandCloseProject;	import org.shoebox.biskwy.commands.menu.CommandNewProject;	import org.shoebox.biskwy.commands.menu.CommandOpenProject;	import org.shoebox.biskwy.commands.menu.CommandTest;	import org.shoebox.biskwy.commands.menu.CommandUpdater;	import org.shoebox.biskwy.events.MenuEvent;	import org.shoebox.patterns.singleton.ISingleton;	import org.shoebox.utils.logger.Logger;	import flash.display.NativeMenu;	import flash.display.NativeMenuItem;	import flash.events.Event;	/**	 * org.shoebox.biskwy.core.Menu	* @author shoebox	*/	public class Menu extends NativeMenu implements ISingleton{				public static const MAP_OPEN			: String = 'Open map';		public static const MAP_NEWMAP		: String = 'New map';		public static const MAP_SAVE			: String = 'Save';		public static const MAP_SAVEAS		: String = 'Save as';				public static const PROJECT_NEW		: String = 'New';		public static const PROJECT_OPEN		: String = 'Open';		public static const PROJECT_CLOSE		: String = 'Close';				public static const ABOUT_UPDATE		: String = 'Check for update';		public static const ABOUT_ABOUT		: String = 'About Biskwy';				public static const COMPILE_TEST		: String = 'Test';				public static const WINDOW_TOOLS		: String = 'Tools';				protected var _oSUBMENUP			: NativeMenuItem = new NativeMenuItem('Project');		protected var _oSUBMENUM			: NativeMenuItem = new NativeMenuItem('Map');		//protected var _oSUBMENUT			: NativeMenuItem = new NativeMenuItem('Sprites');		protected var _oSUBMENUC			: NativeMenuItem = new NativeMenuItem('Compile');		protected var _oSUBMENUW			: NativeMenuItem = new NativeMenuItem('Windows');		protected var _oSUBMENUA			: NativeMenuItem = new NativeMenuItem('About');		protected var _oTOOL				: NativeMenuItem;		protected static var __instance		:Menu  = null;				// -------o constructor					public function Menu( e : SingletonEnforcer ) : void {				_init();				}		// -------o public						/**			* getInstance function			* @public			* @param 			* @return			*/			static public function getInstance() : Menu {								if(__instance == null )					__instance = new Menu( new SingletonEnforcer() );								return __instance;							}						/**			* activate function			* @public			* @param 			* @return			*/			public function activate() : void {				_oSUBMENUM.enabled = true;				//_oSUBMENUT.enabled = true;				_oSUBMENUC.enabled = true;			}						/**			* set toolState function			* @public			* @param 			* @return			*/			public function set toolState( b : Boolean ) : void {				_oTOOL.checked = b;			}					// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _init() : void {								//					removeAllItems();								//					_oSUBMENUP.enabled = true;					_oSUBMENUM.enabled = false;					//_oSUBMENUT.enabled = false;					_oSUBMENUC.enabled = false;								//					_oSUBMENUP.submenu = new NativeMenu();					_oSUBMENUP.submenu.addItem( new NativeMenuItem( PROJECT_NEW ) );					_oSUBMENUP.submenu.addItem( new NativeMenuItem( PROJECT_OPEN ) );							_oSUBMENUP.submenu.addItem( new NativeMenuItem( PROJECT_CLOSE ) );										//					/*					_oSUBMENUT.submenu = new NativeMenu();					_oSUBMENUT.submenu.addItem( new NativeMenuItem( TILE_IMPORTFROMDIR ) );					_oSUBMENUT.submenu.addItem( new NativeMenuItem( TILE_EDITOR ) );									*/				//					_oSUBMENUM.submenu = new NativeMenu();					//_oSUBMENUM.submenu.addItem ( new NativeMenuItem(MAP_NEWMAP));					//_oSUBMENUM.submenu.addItem ( new NativeMenuItem(MAP_OPEN));					_oSUBMENUM.submenu.addItem ( new NativeMenuItem(MAP_SAVE));					//_oSUBMENUM.submenu.addItem ( new NativeMenuItem(MAP_SAVEAS));								//					_oSUBMENUC.submenu = new NativeMenu();					_oSUBMENUC.submenu.addItem( new NativeMenuItem(COMPILE_TEST));								//					_oSUBMENUW.submenu = new NativeMenu();					_oTOOL = new NativeMenuItem(WINDOW_TOOLS);					_oTOOL.checked = true;					_oSUBMENUW.submenu.addItem( _oTOOL );								//					_oSUBMENUA.submenu = new NativeMenu();					_oSUBMENUA.submenu.addItem( new NativeMenuItem(ABOUT_UPDATE));					_oSUBMENUA.submenu.addItem( new NativeMenuItem(ABOUT_ABOUT));								//					addItem(_oSUBMENUP);					addItem(_oSUBMENUM);					addItem(_oSUBMENUC);					addItem(_oSUBMENUW);					addItem(_oSUBMENUA);								//					addEventListener(Event.SELECT , _onMenuSelection , false , 10 , true);			}						/**			* 			*			* @param 			* @return			*/			protected function _onMenuSelection ( e : Event ) : void {								if(!(e.target is NativeMenuItem))					return;								Facade.getInstance().dispatchEvent( new Event( (e.target as NativeMenuItem ).label ));				dispatchEvent(e);			}					// -------o misc			public static function trc(arguments : *) : void {				Logger.log(Menu, arguments);			}	}}internal class SingletonEnforcer{	}