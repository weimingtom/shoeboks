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
	import org.shoebox.patterns.commands.AbstractCommand;
	import org.shoebox.patterns.commands.ICommand;
	import org.shoebox.patterns.singleton.ISingleton;
	import org.shoebox.utils.logger.Logger;

	import flash.events.Event;
	import flash.events.SQLEvent;

	/**
	 * org.shoebox.biskwy.commands.menu.CommandSaveMap
	* @author shoebox
	*/
	public class CommandSaveMap extends AbstractCommand implements ICommand , ISingleton{
		
		protected static var __instance		:CommandSaveMap = null;
		
		// -------o constructor
		
			public function CommandSaveMap( e : SingletonEnforcer ) : void {
			}

		// -------o public
			
			/**
			* getInstance function
			* @public
			* @param 
			* @return
			*/
			static public function getInstance() : CommandSaveMap {
				
				if(__instance == null)
					__instance = new CommandSaveMap(new SingletonEnforcer());
					
				return __instance;
				
			}
						
			/**
			* onExecute function
			* @public
			* @param 
			* @return
			*/
			override public function onExecute( e : Event = null ) : void {
				
			}
			
			/**
			* onCancel function
			* @public
			* @param 
			* @return
			*/
			override public function onCancel( e : Event = null ) : void {
			
			}
			
		// -------o protected
				
				
			/**
			* 
			*
			* @param 
			* @return
			*/
			protected function _onResults( e : SQLEvent ) : void {
				trc('onResult');
				onComplete();
			}
			
			
		// -------o misc

			public static function trc(arguments : *) : void {
				Logger.log(CommandSaveMap, arguments);
			}
	}
}

internal class SingletonEnforcer{
	
}
