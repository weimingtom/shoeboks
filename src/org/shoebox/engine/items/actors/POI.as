/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.items.actors {	import flash.display.BlendMode;
	import org.shoebox.patterns.factory.Factory;
	import org.shoebox.engine.interfaces.IActor;
	import org.shoebox.utils.logger.Logger;		/**	* org.shoebox.engine.items.actors.POI	* @author shoebox	*/	public class POI extends AActor implements IActor {				[Embed(source="C:\\Users\\Johann\\workspace\\BISKWY\\res\\icoPOI.swf")]		protected var _cICON				: Class;				protected var _uLINECOL			: uint = 0xBFFA02;				// -------o constructor					/**			* Constructor of the POI class			*			* @public			* @return	void			*/			public function POI() : void {				alpha = .7;				blendMode = BlendMode.LIGHTEN;				redraw( );			}		// -------o public						/**			* redraw function			* @public			* @param 			* @return			*/			final override public function redraw() : void {								graphics.clear();									var uSIZE : uint = 5;					with( graphics ){												//							beginFill( _uLINECOL , 1 );							drawCircle( 0 , 0 , uSIZE * 8);							beginFill( 0 , 1 );							drawCircle( 0 , 0 , uSIZE * 6);							beginFill( _uLINECOL , 1 );							drawCircle( 0 , 0 , uSIZE * 3);							endFill();								}										//					addChild( Factory.build( _cICON , { x : -15 , y : -15 } ) );												}					// -------o protected		// -------o misc			public static function trc(...args : *) : void {				Logger.log(POI, args);			}	}}