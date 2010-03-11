/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.events {	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	/**	 * org.shoebox.biskwy.events.MenuEvent	* @author shoebox	*/	public class MenuEvent extends Event{				protected var _sSELNAME		:String;				// -------o constructor						/**			* Constructor event of the MenuEvent			* @public			* @param 	sTYPE : Event type (String)			* @param 	sSELNAME : Selected menu it	em name (String)			* @return	void			*/			public function MenuEvent( sTYPE : String , sSELNAME : String ) : void {				super( sTYPE );				_sSELNAME = sSELNAME;			}		// -------o public						/**			* Getter of the name of the selected menu item			* @public			* @return selected name (String)			*/			public function get selName() : String {				return _sSELNAME;			}						/**			* toString() function			* @public			* @return to string (String)			*/			override public function toString() : String {				return "org.shoebox.biskwy.events.MenuEvent ::: type - "+_sSELNAME;			}					// -------o protected		// -------o misc			public static function trc(...args : *) : void {				Logger.log(MenuEvent, args);			}	}}