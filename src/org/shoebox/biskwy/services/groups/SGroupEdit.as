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

package org.shoebox.biskwy.services.groups {
	import com.adobe.images.PNGEncoder;

	import org.shoebox.biskwy.core.Facade;
	import org.shoebox.biskwy.services.SQLLiteService;
	import org.shoebox.patterns.service.IService;
	import org.shoebox.utils.logger.Logger;

	import flash.display.BitmapData;
	import flash.errors.SQLError;
	import flash.utils.ByteArray;

	/**
	 * Service wich return the group data of the specified groupID
	* 
	*  
	* org.shoebox.biskwy.services.SGroupEdit
	* @author shoebox
	*/
	public class SGroupEdit extends SQLLiteService implements IService {
		
		protected var _oPREVIEW		:BitmapData;
		protected var _oDATAS		:ByteArray;
		protected var _oPROPS		:Object;
		protected var _uGROUPID		:uint;
		
		// -------o constructor
		
			public function SGroupEdit( ) : void {
				request = 'UPDATE TB_Groups SET height=:contentH , data=:datas , baseW=:baseW , baseH=:baseH , name=:name , img=:media WHERE id=:id';
				super();
			}

		// -------o public
			
			/**
			* onCall function
			* @public
			* @param 
			* @return
			*/
			final override public function onCall( ) : void {
				trc('onCall');
				
				addParameter(':id' , _uGROUPID);				addParameter(':name' , _oPROPS.name);
				addParameter(':baseW' , _oPROPS.bWidth);
				addParameter(':baseH' , _oPROPS.bHeight);
				addParameter(':contentH' , _oPROPS.cHeight);
				addParameter(':datas' , _oDATAS);
				addParameter(':media' , PNGEncoder.encode(_oPREVIEW));
				trace(request);
				try{
					super.onCall();
				}catch( e : SQLError ){
					trc('onError ::: '+e);
					if(e.detailID == 2206 )
						Facade.getInstance().error( 'Error','Ce nom de groupe est déja utilisé. Veuillez en choisir un autre' );
						
					onComplete();
					_bISRUNNING = false;
				}
				
				onComplete();
				_bISRUNNING = false;
			}
			
			/**
			* set groupID function
			* @public
			* @param 
			* @return
			*/
			public function set groupID( u : uint) : void {
				_uGROUPID = u;
			}
			
			/**
			* onCancel function
			* @public
			* @param 
			* @return
			*/
			final override public function onRefresh( ) : void {
				
			}
			
			/**
			* set datas function
			* @public
			* @param 
			* @return
			*/
			public function set datas( o : ByteArray ) : void {
				_oDATAS = o;
			}
			
			/**
			* set props function
			* @public
			* @param 
			* @return
			*/
			public function set props( o : Object ) : void {
				_oPROPS = o;	
			}
			
			/**
			* set preview function
			* @public
			* @param 
			* @return
			*/
			public function set preview( b : BitmapData ) : void {
				_oPREVIEW = b;
			}
			
		// -------o protected
			
		// -------o misc

			public static function trc(arguments : *) : void {
				Logger.log(SGroupEdit, arguments);
			}
	}
}

