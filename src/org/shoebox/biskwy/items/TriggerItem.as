/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.items {	import org.shoebox.biskwy.core.Facade;	import org.shoebox.biskwy.data.TriggerScript;	import org.shoebox.biskwy.events.TriggerEvent;	import org.shoebox.utils.logger.Logger;	import flash.display.CapsStyle;	import flash.display.NativeMenu;	import flash.display.NativeMenuItem;	import flash.display.Sprite;	import flash.events.Event;	import flash.geom.Vector3D;	/**	 * A trigger is the base interaction item 	* The <code>shape</code> can be rectangular or spherical	* Nota : The rectangular shape is not yet implemented 	* 	* @see AScript	* org.shoebox.biskwy.items.TriggerItem	* @author shoebox	*/	public class TriggerItem extends Sprite {			protected var _nRADIUS				:Number = 100;		protected var _spRADIUS				:Sprite = new Sprite();				protected var _sSHAPE				:String;		protected var _sTRIGGERID			:String;		protected var _uLINECOL				:uint;		protected var _vPOSITION			:Vector3D;		protected var _vSCRIPTS				:Vector.<TriggerScript>;				// -------o constructor					/**			* Constructor of the TriggerItem class			*			* @public			* @param 	uLINECOL : Color of the lineStyle ( uint )				* @return	void			*/			public function TriggerItem( uLINECOL : uint = 0xFFFF00 ) : void {				trc('constructor');								//					_vSCRIPTS = new Vector.<TriggerScript>();								//					_uLINECOL = uLINECOL;					doubleClickEnabled = true;								//					var uSIZE : uint = 3;					graphics.beginFill( 0xFFFFFF , .1 );					graphics.drawCircle( 0 , 0 , uSIZE * 3);					graphics.endFill();										graphics.lineStyle( 4 , _uLINECOL , 1 , true , null , CapsStyle.SQUARE);					graphics.moveTo( -uSIZE , -uSIZE);					graphics.lineTo( +uSIZE , -uSIZE);					graphics.moveTo( 0 , -uSIZE);					graphics.lineTo( 0 , +uSIZE);								//					contextMenu = new NativeMenu();					contextMenu.addItem( new NativeMenuItem('Remove') );					contextMenu.addItem( new NativeMenuItem('Edit') );					contextMenu.addEventListener( Event.SELECT, _onMenu , false , 10 , true );								//					addChild(_spRADIUS);					draw();			}		// -------o public						/**			* Setter of the list of associated script(s)			* 			* @public			* @param 	v : TriggerScript vector (Vector.<TriggerScript>) 			* @return	void			*/			public function set scripts( v : Vector.<TriggerScript> ) : void {				_vSCRIPTS = v;			}						/**			* Getter of the list of associated script(s)			* 			* @public			* @return	TriggerScript vector (Vector.<TriggerScript>)			*/			public function get scripts() : Vector.<TriggerScript> {				return _vSCRIPTS;			}						/**			* Position of the trigger in 2D space			* 			* @public			* @param 	v : trigger position (Vector3D) 			* @return	void			*/			public function set position( v : Vector3D ) : void {				_vPOSITION = v;			}						/**			* Getter of the trigger position in 2D space			*  			* @public			* @return 	trigger position (Vector3D)			*/			public function get position() : Vector3D {				return _vPOSITION;			}						/**			* Setter of the trigger radius (for the Spherical shape)			* 			* @public			* @param	r : radius	(Number) 			* @return	void			*/			public function set radius( r : Number ) : void {				_nRADIUS  = r;				draw();			}						/**			* Getter of the trigger radius for the spherical shape			* 			* @public			* @return	trigger shpere shaped radius (Number)			*/			public function get radius() : Number {				return _nRADIUS;			}						/**			* Setter of the trigger shape (Spherical / Rectangle)			* 			* @public			* @param	s : trigger shape (String)  			* @return	void			*/			public function set shape( s : String ) : void {				_sSHAPE = s;			}						/**			* Getter of the trigger shape			* 			* @public			* @return	trigger shape (String)			*/			public function get shape() : String {				return _sSHAPE;			}							/**			* Setter of the trigger ID (the trigger ID must be unique)			* 			* @public			* @param	s : Trigger ID (String) 			* @return	void			*/			public function set triggerID( s : String ) : void {				_sTRIGGERID = s;			}						/**			* Getter of the trigger ID ( the trigger ID is unique )			* 			* @public				* @return void			*/			public function get triggerID() : String {				return _sTRIGGERID;			}						/**			* Draw of redraw the trigger shape			* 			* @see shape getter / setter			* @public			* @return void			*/			public function draw() : void {								//TODO : Rectangle shape								_spRADIUS.graphics.clear();				_spRADIUS.graphics.lineStyle( 2 , _uLINECOL , 1 , false );				_spRADIUS.graphics.drawCircle( 0 , 0 , _nRADIUS );			}					// -------o protected					/**			* When an event is received from the context menu			*				* @param 	e : menu select event (Event)			* @return	void			*/			protected function _onMenu( e : Event ) : void {				if(e.target is NativeMenuItem){										switch((e.target as NativeMenuItem).label){												case 'Remove':							if(parent)								parent.removeChild( this );							break;												case	'Edit':							Facade.getInstance().dispatchEvent( new TriggerEvent( TriggerEvent.EDIT , this ));							break;											}									}			}				// -------o misc			public static function trc(...args : *) : void {				Logger.log(TriggerItem, args);			}	}}