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
	import org.shoebox.biskwy.apps.TilesApp;
	import org.shoebox.biskwy.core.Main;
	import org.shoebox.biskwy.items.GridTile;
	import org.shoebox.patterns.commands.ICommand;
	import org.shoebox.patterns.singleton.ISingleton;
	import org.shoebox.utils.logger.Logger;

	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * org.shoebox.biskwy.commands.tools.ToolRectFill
	* @author shoebox
	*/
	public class ToolRectFill extends ATool implements ICommand , ISingleton{
		protected var _bSPACE		:Boolean;
		
		protected static var __instance		:ToolRectFill = null;
		
		// -------o constructor
		
			public function ToolRectFill( e : SingletonEnforcer ) : void {
			}

		// -------o public
			
			/**
			* getInstance function
			* @public
			* @param 
			* @return
			*/
			static public function getInstance() : ToolRectFill {
				
				if(!__instance)
					__instance = new ToolRectFill(new SingletonEnforcer());
				
				return __instance;
			}
			
			/**
			* onExecute function
			* @public
			* @param 
			* @return
			*/
			final override public function onExecute( e : Event = null ) : void {
				
				map.addEventListener(MouseEvent.MOUSE_OVER , 	_onEvent , true , 10 , true );				map.addEventListener(MouseEvent.CLICK , 		_onEvent , true , 10 , true );
			}
			
			/**
			* onCancel function
			* @public
			* @param 
			* @return
			*/
			final override public function onCancel( e : Event = null ) : void {
				__instance = null;
				_bISRUNNING = false;
				Main.MAP.out();
				map.removeEventListener(MouseEvent.MOUSE_OVER , _onEvent , true );
				map.removeEventListener(MouseEvent.CLICK , 	_onEvent , true );
			}
			
		// -------o protected

			/**
			* 
			*
			* @param 
			* @return
			*/
			protected function _onEvent( e : Event ) : void {
				
				var o : GridTile = e.target as GridTile;
				var v : Vector.<GridTile> = _getTiles(o.position.x , o.position.y , 2);
				Main.MAP.out();
				switch(e.type){
					
					case MouseEvent.MOUSE_OVER:
						v.forEach( _over);
						break;
						
					case MouseEvent.CLICK:
						v.forEach(_fill);
						break;
					
				}
				
			}
			
			/**
			* Highlight on roll of the specified grild tile
			*
			* @param	g : Grid tile	(GridTile)
			* @param	u : Position in to the vector (uint)
			* @param	v : source vector	(Vector.<GridTile>) 
			* @return	void
			*/
			protected function _over( g : GridTile , u : uint , v : Vector.<GridTile> ) : void {
				g.over();
			}
			
			/**
			* On click fill the tile with the selected ID in to the Tiles App 
			*
			* @param	g : Grid tile	(GridTile)
			* @param	u : Position in to the vector (uint)
			* @param	v : source vector	(Vector.<GridTile>) 
			* @return	void
			*/
			protected function _fill( g : GridTile , u : uint , v : Vector.<GridTile> ) : void {
				g.container.fill( TilesApp.selectedID );		
			}
			
			

		// -------o misc

			public static function trc(arguments : *) : void {
				Logger.log(ToolRectFill, arguments);
			}
	}
}
internal class SingletonEnforcer{

}
