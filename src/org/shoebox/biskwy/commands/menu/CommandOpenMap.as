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

package org.shoebox.biskwy.commands.menu {
	import org.shoebox.biskwy.controllers.CMaps;
	import org.shoebox.biskwy.core.Database;
	import org.shoebox.biskwy.core.Facade;
	import org.shoebox.biskwy.models.MMaps;
	import org.shoebox.biskwy.views.VMaps;
	import org.shoebox.biskwy.windows.MapsWindow;
	import org.shoebox.biskwy.windows.content.CtntNewProject;
	import org.shoebox.patterns.commands.AbstractCommand;
	import org.shoebox.patterns.commands.ICommand;
	import org.shoebox.patterns.mvc.commands.MVCCommand;
	import org.shoebox.patterns.singleton.ISingleton;
	import org.shoebox.utils.logger.Logger;

	import flash.events.Event;
	import flash.filesystem.File;

	/**
	* Open a map if no mapID is specified, the map choice popup is opened
	* @see <code>Menu</code>
	* 	* org.shoebox.biskwy.commands.menu.CommandOpenMap
	* @author shoebox
	*/
	public class CommandOpenMap extends AbstractCommand implements ICommand , ISingleton {
		
		protected var _oCONTENT		:CtntNewProject;
		protected var _oBASE		:Database;
		protected var _oMVC		:MVCCommand;
		protected var _oFILE		:File;
		protected var _iMAPID		:int = -1;
		protected var _oWINDOW		:MapsWindow;
		
		// -------o constructor
			
			/**
			* Command constructor
			* 
			* @public
			* @return	void
			*/
			public function CommandOpenMap( e : SingletonEnforcer ) : void {
				cancelable = false;
			}

		// -------o public
		
			/**
			* Execution of the command
			* 
			* @public
			* @param	e : optional execute event (Event) 
			* @return	void
			*/
			override public function onExecute( e : Event = null ) : void {
				trc('openMap ::: '+_iMAPID);
				_openWindow();
			}
			
			/**
			* When the command is canceled
			* 
			* @public
			* @param	e : optional cancel event (Event)	 
			* @return	void
			*/
			override public function onCancel( e : Event = null ) : void {
			
			}
			
			/**
			* close function
			* @public
			* @param 
			* @return
			*/
			final public function close() : void {
				_oMVC.cancel();
				_oWINDOW.close();
			}
			
		// -------o protected
			
			/**
			* Open the map selection window
			*
			* @return	void
			*/
			final protected function _openWindow() : void {
				trc('openWindow');
				
				// Freezing the app
					Facade.getInstance().freeze();
					
				// Opening the window	
					_oWINDOW = new MapsWindow();
					_oWINDOW.addEventListener( Event.CLOSE , _onClosedWindow , false , 10 , true );
					_oWINDOW.activate();
				
				// Executing the maps triad
					_oMVC = new MVCCommand( { modelClass : MMaps , viewClass : VMaps , controllerClass : CMaps } );
					_oMVC.container =  _oWINDOW.stage;
					_oMVC.execute();
			}
			
			/**
			* When the map selection windows is closed manually
			*
			* @param 	e : event close (Event)
			* @return	void
			*/
			final protected function _onClosedWindow( e : Event ) : void {
				trc('_onClosedWindow');
				Facade.getInstance().unfreeze();
				cancel();
			}
			
		// -------o misc

			public static function trc(arguments : *) : void {
				Logger.log(CommandOpenMap, arguments);
			}
			
			/**
			* Return the singleton instance of the class
			* @public
			* @return instance of the class (CommandOpenMap)
			*/
			static public function getInstance() : CommandOpenMap {				
				if( !__instance )
					__instance = new CommandOpenMap( new SingletonEnforcer() );
								
				return __instance;
			}
			
		protected static var __instance		:CommandOpenMap = null;
	}
}





internal class SingletonEnforcer{
	
}
