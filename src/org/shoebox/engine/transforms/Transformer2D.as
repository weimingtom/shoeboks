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

package org.shoebox.engine.transforms {
	import org.shoebox.biskwy.utils.ITransform;
	import org.shoebox.engine.core.variables.TileSize;
	import org.shoebox.utils.logger.Logger;

	import flash.geom.Vector3D;

	/**
	 * org.shoebox.engine.utils.IsoTransform
	* @author shoebox
	*/
	public class Transformer2D implements ITransform {
		
		protected var _nRATIO	:Number;
		protected var _nAXEPROJ	:Number = Math.cos(Math.atan(0.5));
		protected var _bAXO	:Boolean = false;
		
		
		// -------o constructor
		
			/**
			* Constructor of the IsoTransform class
			*
			* @public
			* @return	void
			*/
			public function Transformer2D() : void {
				_nRATIO = 2;
			}

		// -------o public
			
			/**
			* screenToWorld function
			* @public
			* @param 
			* @return
			*/
			public function screenToWorld( v : Vector3D ) : Vector3D {
				var 	vRES : Vector3D = v.clone();
					vRES.scaleBy( TileSize );
				return vRES;
			}
			
			/**
			* worldToScreen function
			* @public
			* @param 
			* @return
			*/
			public function worldToScreen( v : Vector3D ) : Vector3D {
				var 	vRES : Vector3D = v.clone();
					vRES.x = (vRES.x / TileSize);
					vRES.y = (vRES.y / TileSize);
				return vRES;
			}
			
		// -------o protected

		// -------o misc

			public static function trc(...args : *) : void {
				Logger.log(Transformer2D, args);
			}
	}
}
