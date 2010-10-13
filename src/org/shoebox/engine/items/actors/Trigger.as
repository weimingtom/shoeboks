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

package org.shoebox.engine.items.actors {
	import org.shoebox.engine.core.variables.PlayerSize;
	import flash.geom.Rectangle;
	import org.shoebox.engine.core.variables.Position2D;
	import org.shoebox.engine.events.actorsEvents.TriggerEvents;
	import org.shoebox.engine.interfaces.IActor;
	import org.shoebox.engine.interfaces.IMoveListener;
	import org.shoebox.utils.logger.Logger;

	import flash.display.BlendMode;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.geom.Point;
	
	[NVM_Desc( type = 'Actor' , name = 'Trigger') ]

	[Event( name = "Touched"	, type = "org.shoebox.engine.events.actorsEvents.TriggerEvents" , NVM_Output = 'true')]	[Event( name = "Clicked"	, type = "org.shoebox.engine.events.actorsEvents.TriggerEvents" , NVM_Output = 'true')]
	[Event( name = "unTouched"	, type = "org.shoebox.engine.events.actorsEvents.TriggerEvents" , NVM_Output = 'true')]
	
	/**
	* org.shoebox.engine.items.actors.Trigger
	* @author shoebox
	*/
	public class Trigger extends AActor implements IActor , IMoveListener {
		
		[NVM_Variable]	
		public var radius				: uint = 100;
		
		[NVM_Variable]			public var recWidth				: uint = 100;
		
		[NVM_Variable]			public var recHeight				: uint = 100;
		
		[NVM_Variable]	
		public var shape					: String = 'circle';
		
		protected var _bTOUCHED			: Boolean = false;
		protected var _ptPOSITION			: Point ;
		protected var _oREC				: Rectangle;
		protected var _uLINECOL			: uint = 0xFFFF00;
		
		// -------o constructor
		
			/**
			* Constructor of the Trigger class
			*
			* @public
			* @return	void
			*/
			public function Trigger() : void {
				TriggerEvents;

				alpha = .7;
				blendMode = BlendMode.LIGHTEN;

				propsXML = <root>
				      		<entry label = "Trigger properties" prop='infottl'	type = "title" />
				      		<entry label = 'Shape' 			prop='shape' 	type = "combo" 	value = "circle" options="circle,rectangle" />
				      		
				      		<entry label = "Circle shape"		prop='infottl'	type = "title" >
				      			<entry label = 'raduis' 	prop='radius' 	type = "number" 	value = "100" />
				      		</entry>
				      		
				      		<entry label = "Rectangle shape"	prop='infottl'	type = "title" >
				      			<sub label = 'width' 		prop='recWidth' 	type = "number" 	value = "100" />				      			<sub label = 'height' 		prop='recHeight' 	type = "number" 	value = "100" />
				      		</entry>
				      	</root>;
				
				redraw();
				doubleClickEnabled = true;
			}

		// -------o public
			
			/**
			* onMove function
			* @public
			* @param 
			* @return
			*/
			final public function onMove() : void {
				
				var b : Boolean = false;
				
				switch( shape ){
					
					case 'circle':
						var nDIS : Number = Point.distance( new Point( x , y ) , new Point(Position2D.x, Position2D.y));
						var bINS : Boolean = ( nDIS < radius );
							
						if( !_bTOUCHED && bINS )
							b = true;
						else if( _bTOUCHED && !bINS )
							b = false;
						else if( bINS )
							b = true;
					
						break;
						
				case 'rectangle':
					var 	oREC : Rectangle = PlayerSize.clone();
						oREC.offset(Position2D.x, Position2D.y);
					
					var 	oREC2 : Rectangle = _oREC.clone();
						oREC2.offsetPoint( _ptPOSITION );
							
					b = oREC.intersects( oREC2 );
					
					break;
				}
				
				if( _bTOUCHED !== b ){
					dispatchEvent(new TriggerEvents( b ? TriggerEvents.Touched : TriggerEvents.unTouched ));
					_bTOUCHED = b;
				}
			}
			
			/**
			* redraw function
			* @public
			* @param 
			* @return
			*/
			final override public function redraw() : void {
				trc('redraw ::: '+shape);
				graphics.clear();
				
				//
					var uSIZE : uint = 5;
					graphics.beginFill( _uLINECOL , 1 );
					graphics.drawCircle( 0 , 0 , uSIZE * 3);
					graphics.endFill();
				
				//	
					graphics.lineStyle( 3 , 0 , 1 , true , null , CapsStyle.SQUARE );
					graphics.moveTo( -uSIZE , -uSIZE);
					graphics.lineTo( +uSIZE , -uSIZE);
					graphics.moveTo( 0 , -uSIZE);
					graphics.lineTo( 0 , +uSIZE);
					
				//
					graphics.lineStyle(10, _uLINECOL, 1, true, null, null, JointStyle.MITER);
					
					switch( shape ){
						
						case 'circle':
							graphics.drawCircle( 0 , 0 , radius );
							break;
							
						case 'rectangle':
							_oREC = new Rectangle( -recWidth / 2 , -recHeight / 2 , recWidth , recHeight );
							graphics.drawRect(_oREC.x, _oREC.y, _oREC.width, _oREC.height);
							_oREC.offset(_ptPOSITION.x, _ptPOSITION.y );
							break;
							
					}
					
					
				//
					_ptPOSITION = new Point( x , y );
			}
					
		// -------o protected

		// -------o misc

			public static function trc(...args : *) : void {
				Logger.log(Trigger, args);
			}
	}
}
