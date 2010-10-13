/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.datas {	import org.shoebox.engine.items.actors.AActor;
	import org.shoebox.utils.logger.Logger;		/**	* org.shoebox.engine.datas.ActorsModes	* @author shoebox	*/	public class ActorsModes {				protected var _vREF  			: Vector.<RefObject>;				// -------o constructor					/**			* Constructor of the ActorsModes class			*			* @public			* @return	void			*/			public function ActorsModes() : void {				_vREF = new Vector.<RefObject>( );			}		// -------o public						/**			* setActiveMode function			* @public			* @param 			* @return			*/			final public function addActiveMode( from : AActor , s : String ) : void {				trc('addActiveMode == '+arguments);				_vREF.push( new RefObject( from , s ));								}						/**			* name function			* @public			* @param 			* @return			*/			final public function removeActiveMode( from : AActor , s : String ) : void {				trc('removeActiveMode :: '+arguments);				var oFUNC : Function = function(o : RefObject, i : uint, v : Vector.<RefObject>) : Boolean {
					return !( o.sType == s && o.from == from );				};								_vREF = _vREF.filter( oFUNC );			}						/**			* isActive function			* @public			* @param 			* @return			*/			final public function isActive( s : String ) : Boolean {								var o : RefObject;
				for each( o in _vREF )
					if( o.sType == s )						return true;										return false;							}					// -------o protected		// -------o misc			public static function trc(...args : *) : void {				Logger.log(ActorsModes, args);			}	}}import org.shoebox.engine.items.actors.AActor;
internal class RefObject{		public var from : AActor;	public var sType	: String;		/**	* RefObject function	* @public	* @param 	* @return	*/	final public function RefObject( f : AActor , s : String ) : void {		from = f;		sType = s;	}}