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
	import org.shoebox.biskwy.core.Main;
	import org.shoebox.biskwy.items.GridTile;
	import org.shoebox.patterns.commands.ICommand;
	import org.shoebox.patterns.singleton.ISingleton;
	import org.shoebox.utils.logger.Logger;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;

	/**
	 * org.shoebox.biskwy.commands.tools.ToolSelection
	* @author shoebox
	*/
	public class ToolSelection extends ATool implements ICommand , ISingleton{
		
		protected var _oSTART		:GridTile;
		protected var _vSELECTED	:Vector.<GridTile>;
		
		protected static var __instance		:ToolSelection = null;
		
		// -------o constructor
		
			public function ToolSelection( e : SingletonEnforcer ) : void {
				
			}

		// -------o public
			
			/**
			* getInstance function
			* @public
			* @param 
			* @return
			*/
			static public function getInstance() : ToolSelection {
				
				if(!__instance)
					__instance = new ToolSelection(new SingletonEnforcer());
				
				return __instance;
			}
			
			/**
			* onExecute function
			* @public
			* @param 
			* @return
			*/
			final override public function onExecute( e : Event = null ) : void {
				map.addEventListener(MouseEvent.MOUSE_DOWN , 	_onMouseEevent , true , 10 , true);				map.addEventListener(MouseEvent.MOUSE_UP , 	_onMouseEevent , true , 10 , true);
			}
			
			/**
			* onCancel function
			* @public
			* @param 
			* @return
			*/
			final override public function onCancel( e : Event = null ) : void {
				_select(false);
				map.removeEventListener(MouseEvent.MOUSE_DOWN , _onMouseEevent , true);
				map.removeEventListener(MouseEvent.MOUSE_UP , 	_onMouseEevent , true);
				__instance = null;
				_bISRUNNING = false;
			}
			
		// -------o protected

			/**
			* 
			*
			* @param 
			* @return
			*/
			protected function _onMouseEevent( e : MouseEvent ) : void {
				
				switch(e.type){
					
					case MouseEvent.MOUSE_DOWN:
						_oSTART = e.target as GridTile;
						trc('_oSTART ::: '+_oSTART.name);
						map.addEventListener(MouseEvent.MOUSE_MOVE, _onMouseEevent , true , 10 , true);
						break;
						
					case MouseEvent.MOUSE_UP:
						map.removeEventListener(MouseEvent.MOUSE_MOVE , _onMouseEevent , true);
						break;
						
					case MouseEvent.MOUSE_MOVE:
						_hl(_oSTART , e.target as GridTile);
						break;
					
				}
						
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			protected function _hl( o1 : GridTile , o2 : GridTile ) : void {
				if(o1 == o2)
					return;
				
				var p1:Vector3D;				var p2:Vector3D;
				
				if(o2.position.x < o1.position.x || o2.position.y < o1.position.y){
					p1 = o2.position;
					p2 = o1.position;
				}else{
					p1 = o1.position;
					p2 = o2.position;
				}
				
				
				var x : int = p1.x;
				var y : int = p1.y;
				
				_select();
				
				_vSELECTED = new Vector.<GridTile>();
				
				for(x ; x <= p2.x ; x++){
					
					y = p1.y;
					
					for( y ; y <= p2.y ; y++){
						_vSELECTED.push(Main.MAP.getTileAt(x , y));	
					}
					
				}
				
				_select(true);
				
			}
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			protected function _select( b : Boolean = false ) : void {
				if(_vSELECTED){
					var oFUNC : Function = function( t : GridTile , u : uint , v : Vector.<GridTile> ):void{
						if(!b)
							t.out();
						else
							t.over();
					};
					_vSELECTED.forEach(oFUNC);
				}
			}
			
		// -------o misc

			public static function trc(arguments : *) : void {
				Logger.log(ToolSelection, arguments);
			}
	}
}
internal class SingletonEnforcer{

}
