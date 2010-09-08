/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.models {	import org.shoebox.engine.views.VPlayerArray;
	import org.shoebox.engine.datas.CycleItem;	import org.shoebox.engine.interfaces.IAnimSetController;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.patterns.mvc.abstracts.AModel;	import org.shoebox.patterns.mvc.interfaces.IModel;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	import flash.geom.Point;	import flash.utils.Dictionary;	/**	 * MPlayerArray model class 	* 	* org.shoebox.engine.models.MPlayerArray	* @author shoebox	*/	public class MPlayerArray extends AModel implements IModel {				protected var _aCYCLE_ARRAY			: Array;		protected var _aSUB_CYCLES			: Array;		protected var _bDOWN				: Boolean = false;		protected var _bLEFT				: Boolean = true;		protected var _bLOOK_LEFT			: Boolean = true;			protected var _bFREEZE				: Boolean = false;			protected var _ptMOUSE				: Point;		protected var _iTURNBACK_L			: uint;		protected var _iTURNBACK_R			: uint;							protected var _oCURRENT			: CycleItem;		protected var _dINDICES			: Dictionary; 		protected var _iCYCLE				: int = -1; 		protected var _iCURRENT			: int = -1; 		protected var _iGOTO				: int = 0;		protected var _vCYCLES				: Vector.<CycleItem> = new Vector.<CycleItem>();				// -------o constructor					/**			* Constructor of the model class			*			* @public			* @return	void			*/			public function MPlayerArray() : void {				_iGOTO = 0;			}		// -------o public						/**			* Model initialization 			* 			* @public			* @param	e : optional initialization event (Event) 			* @return	void			*/			final override public function initialize( e : Event = null ) : void {				//Relegate.afterFrame( STAGEINSTANCE , _drawGizmos , 20 );			}									/**			* When the model and the triad is canceled			* 			* @public			* @param	e : optional cancel event (Event) 			* @return	void			*/			final override public function cancel(e:Event = null) : void {									}						/**			* set cycleArray function			* @public			* @param 			* @return			*/			final public function set cycleArray( a : Array ) : void {				_aCYCLE_ARRAY = a;			}						/**			* set subCycleArray function			* @public			* @param 			* @return			*/			final public function set subCycleArray( a : Array ) : void {				//trace('subCycleArray ::: '+a);				_aSUB_CYCLES = a;				_dINDICES = new Dictionary( true );								var i : int = 0;				var s : String;				for each( s in _aSUB_CYCLES ){					_dINDICES[s] = i;					i++;				}								_iCYCLE = _getIndice('static');								_vCYCLES = new Vector.<CycleItem>( i , true );			}						/**			* addCycle function			* @public			* @param 			* @return			*/			final public function addCycle( s : String , i : uint , l : uint ) : void {												if( _dINDICES[s] == undefined )					return;								_vCYCLES[_dINDICES[s]] = Factory.build( CycleItem , { name : s , length : l , index : i } ); 			}						/**			* get currentFrame function			* @public			* @param 			* @return			*/			final public function get currentFrame() : uint {								if( !_aCYCLE_ARRAY )					return 0;								if( !_oCURRENT )					_nextCycle();								_oCURRENT.progress ++; 								if( _oCURRENT.progress > _oCURRENT.length ){					_nextCycle();					return currentFrame;				}								return _oCURRENT.index + _oCURRENT.progress;			}						/**			* goTo function			* @public			* @param 			* @return			*/			final public function set goTo( i : int ) : void {				if( i == _iGOTO )					return;								_iGOTO = i;				_nextCycle();			}						/**			* get goTO function			* @public			* @param 			* @return			*/			final public function get goTo() : int {				return _iGOTO;			}						/**			* onMove function			* @public			* @param 			* @return			*/			final public function onMove( pt : Point , bDown : Boolean ) : void {																//					(view as VPlayerArray).mouseMove( );			}						/**			* get currentCycleID function			* @public			* @param 			* @return			*/			final public function get currentCycleID() : uint {				return _iCYCLE;			}						/**			* getIndice function			* @public			* @param 			* @return			*/			final public function getIndice( s: String ) : uint {				return _getIndice( s );			}		// -------o protected						/**			* 			*			* @param 			* @return			*/			final protected function _nextCycle() : void {								(controller as IAnimSetController).nextCycle();				_iCYCLE = _getIndice( _aCYCLE_ARRAY[ _iCYCLE ][ _iGOTO ] );								_oCURRENT = _vCYCLES[_iCYCLE];				_oCURRENT.progress = 0;												(controller as IAnimSetController).cycleEnd();			}						/**			* _getIndice function			* @public			* @param 			* @return			*/			final public function _getIndice( s : String ) : uint {				return _dINDICES[s];			}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(MPlayerArray, args);			}	}}