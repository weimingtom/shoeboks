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
	import org.shoebox.biskwy.events.GridTileEvent;
	import org.shoebox.biskwy.items.GridTile;
	import org.shoebox.events.EventCentral;
	import org.shoebox.patterns.commands.ICommand;
	import org.shoebox.patterns.singleton.ISingleton;
	import org.shoebox.utils.logger.Logger;

	import flash.events.Event;

	/**
	 * org.shoebox.biskwy.commands.tools.ToolRectFill
	* @author shoebox
	*/
	public class ToolRectFill extends ATool implements ICommand , ISingleton{
		
		protected var _bSPACE		:Boolean;
		protected var _sSHAPE		:String;
		
		protected static var __instance		:ToolRectFill = null;
		
		// -------o constructor
		
			public function ToolRectFill( e : SingletonEnforcer ) : void {
			
				/*
				var 	oDP : DataProvider = new DataProvider();
					oDP.addItem( {label : 'Rectangle'} );					oDP.addItem( {label : 'Circle'} );
			 
				addProperty(ATool.P_STEPPER, 		{ label : 'Size' } , 'size');
				addProperty(ATool.P_COMBOBOX , 	{ label : 'shape' } , 'shape' , oDP);				addProperty( ATool.P_CHECKBOX , 	{ label : 'Replace content' } , 'replace');
				*/
			}

		// -------o public
			
			/**
			* redraw function
			* @public
			* @param 
			* @return
			*/
			final override public function redraw() : void {
				
			}
			
			/**
			* Setter of the tool shape
			* @public	
			* @param 	s : tool shape (String)	
			* @return	void
			*/
			public function set shape ( s : String ) : void {
				_sSHAPE = s;
			}
			
			/**
			* Getter of the tool shape
			* @public
			* @return tool shape (String)
			*/
			public function get shape() : String {
				return _sSHAPE;
			}
			
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
				
				EventCentral.getInstance().addEventListener( GridTileEvent.GRIDTILE_OVER, _onEvent , false , 10 , true );				EventCentral.getInstance().addEventListener( GridTileEvent.GRIDTILE_CLICK, _onEvent , false , 10 , true);
				
			}
			
			/**
			* onCancel function
			* @public
			* @param 
			* @return
			*/
			final override public function onCancel( e : Event = null ) : void {
				_bISRUNNING = false;
				_bISCANCEL = false;
				if(map)
					map.out();
				EventCentral.getInstance().removeEventListener( GridTileEvent.GRIDTILE_OVER, _onEvent , false );
				EventCentral.getInstance().removeEventListener( GridTileEvent.GRIDTILE_CLICK, _onEvent , false );
			}
			
		// -------o protected

			/**
			* 
			*
			* @param 
			* @return
			*/
			protected function _onEvent( e : GridTileEvent ) : void {
				trc('onEvent ::: '+e.gridTile);
				if(!e.gridTile)
					return;
				var v : Vector.<GridTile> = _getTiles(e.gridTile.position.x , e.gridTile.position.y, size);
				if(map)
					map.out();
				switch(e.type){
					
					case GridTileEvent.GRIDTILE_OVER:
						v.forEach( _over);
						break;
						
					case GridTileEvent.GRIDTILE_CLICK:
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
				if(_bREPLACE)
					g.clear();
				g.container.fill( _oTILEDESC );		
			}
			
			

		// -------o misc

			public static function trc(arguments : *) : void {
				Logger.log(ToolRectFill, arguments);
			}
	}
}
internal class SingletonEnforcer{

}
