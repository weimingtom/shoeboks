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

package org.shoebox.biskwy.commands.tools {
	import org.shoebox.biskwy.controllers.CTileContent;
	import org.shoebox.biskwy.events.GridTileEvent;
	import org.shoebox.biskwy.models.MTileContent;
	import org.shoebox.biskwy.views.VTileContent;
	import org.shoebox.biskwy.windows.EditWindow;
	import org.shoebox.events.EventCentral;
	import org.shoebox.patterns.commands.ICommand;
	import org.shoebox.patterns.mvc.commands.MVCCommand;
	import org.shoebox.patterns.singleton.ISingleton;
	import org.shoebox.utils.logger.Logger;

	import flash.events.Event;

	/**
	 * org.shoebox.biskwy.commands.tools.ToolClickEdit
	* @author shoebox
	*/
	public class ToolClickEdit extends ATool implements ICommand , ISingleton{
		
		protected var _oWINDOW				:EditWindow;
		protected var _oMVC				:MVCCommand;
		
		protected static var __instance		:ToolClickEdit = null;
		
		// -------o constructor
		
			public function ToolClickEdit( e : SingletonEnforcer ) : void {
				
			}

		// -------o public
			
			/**
			* getInstance function
			* @public
			* @param 
			* @return
			*/
			static public function getInstance() : ToolClickEdit {
				
				if(!__instance)
					__instance = new ToolClickEdit(new SingletonEnforcer());
				
				return __instance;
			}
			
			/**
			* onExecute function
			* @public
			* @param 
			* @return
			*/
			final override public function onExecute( e : Event = null ) : void {
				
				
				//
					_oWINDOW = new EditWindow();
					_oWINDOW.activate();
					
				//
					_oMVC = new MVCCommand( { modelClass : MTileContent , viewClass : VTileContent , controllerClass : CTileContent } );
					_oMVC.container = _oWINDOW.stage;
					_oMVC.execute();
				
				EventCentral.getInstance().addEventListener( GridTileEvent.GRIDTILE_CLICK, _onClick , false , 10 , true );
			}
			
			/**
			* onCancel function
			* @public
			* @param 
			* @return
			*/
			final override public function onCancel( e : Event = null ) : void {
				
				if( _oMVC )
					_oMVC.cancel();
				
				_oWINDOW.close();
				
				EventCentral.getInstance().removeEventListener( GridTileEvent.GRIDTILE_CLICK, _onClick , false );
				EventCentral.getInstance().dispatchEvent( new GridTileEvent( GridTileEvent.GRIDTILE_EDITEND , null) );
				
				_bISRUNNING = false;
				_bISCANCEL = false;
			}
			
		// -------o protected

			/**
			* 
			*
			* @param 
			* @return
			*/
			protected function _onClick( e : GridTileEvent ) : void {
				EventCentral.getInstance().dispatchEvent( new GridTileEvent( GridTileEvent.GRIDTILE_EDIT , e.gridTile) );								
			}

		// -------o misc

			public static function trc(arguments : *) : void {
				Logger.log(ToolClickEdit, arguments);
			}
	}
}
internal class SingletonEnforcer{

}
