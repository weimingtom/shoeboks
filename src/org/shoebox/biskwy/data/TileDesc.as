/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.data {	import org.shoebox.biskwy.events.TileEvent;	import org.shoebox.utils.logger.Logger;	import flash.display.BitmapData;	import flash.display.DisplayObject;	import flash.events.Event;	import flash.events.EventDispatcher;	import flash.utils.ByteArray;	/**	 * org.shoebox.biskwy.data.TileDesc	* @author shoebox	*/	public class TileDesc extends EventDispatcher {				public var img			: BitmapData;		public var active		: Boolean;		public var collide		: Boolean;		public var collideL		: Boolean;		public var collideR		: Boolean;		public var collideT		: Boolean;		public var collidB		: Boolean;		public var rigidbody		: Boolean;		public var ground		: Boolean;		public var media			: ByteArray;		public var mediaSource		: DisplayObject;		public var decalX		: int;		public var decalY		: int;		public var mass			: Number;		public var cat			: String;		public var filepath		: String;		public var name			: String;		public var id			: uint;		public var mediaW		: uint;		public var mediaH		: uint;		public var preview		: Vector.<uint>;						// -------o constructor					/**			* Constructor of the TileDesc class			*			* @public			* @return	void			*/			public function TileDesc() : void {			}		// -------o public						/**			* update function			* @public			* @param 			* @return			*/			final public function update() : void {				dispatchEvent( new Event( Event.CHANGE ));			}						/**			* delete function			* @public			* @param 			* @return			*/			final public function del() : void {				dispatchEvent( new Event( TileEvent.DELETE ));			}					// -------o protected		// -------o misc			public static function trc(...args : *) : void {				Logger.log(TileDesc, args);			}	}}