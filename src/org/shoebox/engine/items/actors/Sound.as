/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.items.actors {		import flash.display.JointStyle;
	import flash.display.CapsStyle;
	import flash.display.BlendMode;	import flash.geom.Point;	
	import org.shoebox.engine.interfaces.IActor;
	import org.shoebox.utils.logger.Logger;		/**	* org.shoebox.engine.items.actors.Sound	* @author shoebox	*/	public class Sound extends AActor implements IActor {				[NVM_Variable]			public var radius				: uint = 100;				[NVM_Variable]			public var overcast				: Boolean = false;				[NVM_Variable]			public var decay					: Boolean = false;				[NVM_Variable]			public var mediaPath				: String = '';				protected var _ptPOSITION			: Point ;		protected var _uLINECOL			: uint = 0x08A6F3;				// -------o constructor					/**			* Constructor of the Sound class			*			* @public			* @return	void			*/			public function Sound() : void {								alpha = .7;				blendMode = BlendMode.LIGHTEN;				propsXML = <root>				      		<entry label = "Sound properties" prop='infottl'	type = "title" />				      		<entry label = "Radius"			prop='radius'	type = "number" />				      		<entry label = "Overcast"		prop='overcast'	type = "boolean" />				      		<entry label = "Decay"			prop='decay'	type = "boolean" />				      		<entry label = "Media path"		prop='mediaPath'	type = "string" />				      	</root>;								redraw();				doubleClickEnabled = true;							}		// -------o public						/**			* redraw function			* @public			* @param 			* @return			*/			final override public function redraw() : void {								graphics.clear();								//					var uSIZE : uint = 5;					graphics.beginFill( _uLINECOL , 1 );					graphics.drawCircle( 0 , 0 , uSIZE * 3);					graphics.endFill();								//						graphics.lineStyle( 3 , 0 , 1 , true , null , CapsStyle.SQUARE );					graphics.moveTo( -uSIZE , -uSIZE);					graphics.lineTo( +uSIZE , -uSIZE);					graphics.moveTo( -uSIZE , -uSIZE);					graphics.lineTo( -uSIZE , 0);					graphics.lineTo( +uSIZE , 0);					graphics.lineTo( +uSIZE , +uSIZE);					graphics.lineTo( -uSIZE , +uSIZE);														//					if( !overcast ){						graphics.lineStyle(10, _uLINECOL, 1, true, null, null, JointStyle.MITER);						graphics.drawCircle( 0 , 0 , radius );					}									//					_ptPOSITION = new Point( x , y );			}					// -------o protected		// -------o misc			public static function trc(...args : *) : void {				Logger.log(Sound, args);			}	}}