/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.views {	import org.shoebox.biskwy.core.Config;	import org.shoebox.engine.items.Tile;	import org.shoebox.engine.models.MMapRenderer;	import org.shoebox.libs.nevermind.geom.IsoMath;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.patterns.mvc.abstracts.AView;	import org.shoebox.patterns.mvc.events.UpdateEvent;	import org.shoebox.patterns.mvc.interfaces.IView;	import org.shoebox.tools.Perf;	import org.shoebox.utils.logger.Logger;	import flash.display.Sprite;	import flash.events.Event;	import flash.geom.Rectangle;	import flash.geom.Vector3D;	import flash.text.TextField;	/**	 * org.shoebox.engine.views.VMapRenderer	* @author shoebox	*/	public class VMapRenderer extends AView implements IView{				protected var _spCONTAINER	:Sprite = new Sprite();		protected var _uISOSIZE		:uint = 4;		protected var _vPOSITION	:Vector3D = new Vector3D(2,0,2);		protected var _uWIDTH		:uint = 20;		protected var _uHEIGHT		:uint = 20;		protected var _vTILES		:Vector.<Tile> = new Vector.<Tile>();				// -------o constructor					public function VMapRenderer() : void {				addChild(_spCONTAINER);				addChild(new Perf());			}		// -------o public						/**			* update function			* @public			* @param 			* @return			*/			final override public function update( o : UpdateEvent = null ) : void {				_draw();			}									/**			* cancel function			* @public			* @param 			* @return			*/			final override public function cancel( e : Event = null ) : void {									}						/**			* initialize function			* @public			* @param 			* @return			*/			final override public function initialize() : void {							}						/**			* scroll function			* @public			* @param 			* @return			*/			public function scroll( iX : int , iY : int) : void {				position.x += iX;				position.z += iY;				_vPOSITION.x = Math.max( position.x , 0 );				_vPOSITION.z = Math.max( position.z , 0 );				_vPOSITION.x = Math.min( position.x , _uWIDTH );				_vPOSITION.z = Math.min( position.z , _uHEIGHT );				_draw();			}			/**			* addItem function			* @public			* @param 			* @return			*/			public function addItem( x : int , y : int , v : Vector.<int> ) : void {							}						/**			* get position function			* @public			* @param 			* @return			*/			public function get position() : Vector3D {				return _vPOSITION;			}						/**			* set position function			* @public			* @param 			* @return			*/			public function set position( v : Vector3D ) : void {				_vPOSITION = v;			}		// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _draw() : void {				//trc('draw ::: ' +position);				var c : Tile;				var iX : int = 0;				var iZ : int = 0;				var i : int = 0;				var l : int;				var vDATAS : Vector.<int>;				var v : Vector3D = new Vector3D();				var sNAME : String;				for( iX = -_uISOSIZE; iX < (_uISOSIZE + 1) ; iX++){										for(iZ = -_uISOSIZE ; iZ < (_uISOSIZE+1) ; iZ++){						if((position.x + iX) < 0 || (position.z + iZ) < 0 || (position.x + iX) > _uWIDTH || (position.z + iZ) > _uWIDTH)							continue;												v = IsoMath.screenToIso( new Vector3D( iX + position.x , 0 , iZ + position.z ));																		sNAME = 'tile'+(position.x + iX)+'_'+(position.z + iZ);							c = _spCONTAINER.getChildByName(sNAME) as Tile;						if(c == null){														c = new Tile();								c.name = sNAME; 							c.position = new Vector3D( iX + position.x , iZ + position.z , 0);														//								vDATAS = (model as MMapRenderer).getAt(iX + position.x , iZ + position.z );								if(vDATAS){									l = vDATAS.length;									i = 0;									while( i < l ){										c.layers.addItem(vDATAS[i],vDATAS[i+1]);										i+=2;									}								}															_spCONTAINER.addChild( c );							c.draw();							c.addChild( Factory.build(TextField,{text:c.position.x+'/'+c.position.y , y : 15 , x : 25 }));							_vTILES.push(c);						}						c.x = v.x * Config.TILESIZE / 2;						c.y = v.y * Config.TILESIZE/2;					}									}								var vTMP : Vector.<Tile> = new Vector.<Tile>();				for each( c in _vTILES){										if(c.position.x < (position.x - _uISOSIZE) || c.position.y < (position.z - _uISOSIZE))							_spCONTAINER.removeChild(c);					else if(c.position.x > (position.x + _uISOSIZE) || c.position.y > (position.z + _uISOSIZE))						_spCONTAINER.removeChild(c);					else						vTMP.push(c);						}								_vTILES = vTMP;								var oPOS : Rectangle = _spCONTAINER.getChildByName('tile'+position.x+'_'+position.z).getRect(_spCONTAINER);				_spCONTAINER.x = -oPOS.x + 400 - Config.TILESIZE / 2;				_spCONTAINER.y = -oPOS.y + 300 - Config.TILESIZE / 4;							}					// -------o misc			public static function trc(arguments : *) : void {				Logger.log(VMapRenderer, arguments);			}	}}