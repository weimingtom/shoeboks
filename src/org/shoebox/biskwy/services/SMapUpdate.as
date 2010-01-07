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

package org.shoebox.biskwy.services {
	import org.shoebox.biskwy.services.SQLLiteService;
	import org.shoebox.patterns.commands.ICommand;
	import org.shoebox.patterns.singleton.ISingleton;
	import org.shoebox.utils.logger.Logger;

	import flash.events.Event;
	import flash.utils.ByteArray;

	/**
	 * Service to obtains the list of all the tiles registered for the project
	* 
	*  
	* org.shoebox.biskwy.services.SMapUpdate
	* @author shoebox
	*/
	public class SMapUpdate extends SQLLiteService implements ICommand  {
		
		protected var _bDATAS		:ByteArray;
		protected var _uID		:uint;
		
		// -------o constructor
		
			public function SMapUpdate( ) : void {
						
			}

		// -------o public
			
			/**
			* set datas function
			* @public
			* @param 
			* @return
			*/
			public function set datas( o :ByteArray ) : void {
				_bDATAS = o;
			}
			
			/**
			* set id function
			* @public
			* @param 
			* @return
			*/
			public function set id( u : uint ) : void {
				_uID = u;
			}
			
			/**
			* onCall function
			* @public
			* @param 
			* @return
			*/
			final override public function onExecute( e : Event = null ) : void {
				request = 'UPDATE TB_Maps SET data=:datas WHERE id=:id';
				addParameter(':datas',_bDATAS);				addParameter(':id',_uID);
				trc('onExecute ::: '+request);
				super.onExecute();
			}
			
			/**
			* onCancel function
			* @public
			* @param 
			* @return
			*/
			final override public function onCancel( e : Event = null ) : void {
				super.onCancel();
			}
			
		// -------o protected
			
		// -------o misc

			public static function trc(arguments : *) : void {
				Logger.log(SMapUpdate, arguments);
			}
	}
}
