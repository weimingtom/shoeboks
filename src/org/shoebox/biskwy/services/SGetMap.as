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
	import org.shoebox.patterns.service.IService;
	import org.shoebox.patterns.singleton.ISingleton;
	import org.shoebox.utils.logger.Logger;

	/**
	 * Service to obtains the list of all the tiles registered for the project
	* 
	*  
	* org.shoebox.biskwy.services.SGetMap
	* @author shoebox
	*/
	public class SGetMap extends SQLLiteService implements IService , ISingleton {
		
		protected static var __instance		:SGetMap;
		
		protected var _uMAPID		:uint;
		
		// -------o constructor
		
			public function SGetMap( ) : void {
				super();				
			}

		// -------o public
			
			/**
			* get mapID function
			* @public
			* @param 
			* @return
			*/
			public function get mapID() : uint {
				return _uMAPID;
			}
			
			/**
			* set mapID function
			* @public
			* @param 
			* @return
			*/
			public function set mapID( u : uint ) : void {
				_uMAPID = u;
			}
			
			/**
			* onCall function
			* @public
			* @param 
			* @return
			*/
			final override public function onCall( ) : void {
				request = 'SELECT * FROM TB_Maps WHERE id='+_uMAPID;
				trc('onCall ::: '+request);
				super.onCall();
			}
			
			/**
			* onRefresh function
			* @public
			* @param 
			* @return
			*/
			final override public function onRefresh() : void {
			
			}
			
		// -------o protected
			
		// -------o misc

			public static function trc(arguments : *) : void {
				Logger.log(SGetMap, arguments);
			}
	}
}

