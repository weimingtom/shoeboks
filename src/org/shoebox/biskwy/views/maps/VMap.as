/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.views.maps {	import fl.containers.ScrollPane;	import fl.controls.ComboBox;	import fl.controls.Label;	import fl.data.DataProvider;	import org.shoebox.biskwy.core.Config;	import org.shoebox.biskwy.core.Facade;	import org.shoebox.biskwy.core.Grid;	import org.shoebox.biskwy.core.Menu;	import org.shoebox.biskwy.core.variables.GizmoContainer;	import org.shoebox.biskwy.core.variables.LightMapContainer;	import org.shoebox.biskwy.core.variables.MapContainer;	import org.shoebox.biskwy.core.variables.PolyContainer;	import org.shoebox.biskwy.core.variables.SoundsContainer;	import org.shoebox.biskwy.items.GridTile;	import org.shoebox.display.DisplayFuncs;	import org.shoebox.patterns.commands.samples.IResizeable;	import org.shoebox.patterns.commands.samples.IStageable;	import org.shoebox.patterns.commands.samples.StageResize;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.patterns.mvc.abstracts.AView;	import org.shoebox.patterns.mvc.events.UpdateEvent;	import org.shoebox.patterns.mvc.interfaces.IView;	import org.shoebox.utils.logger.Logger;	import flash.display.BlendMode;	import flash.display.MovieClip;	import flash.display.Shape;	import flash.display.Sprite;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.geom.Matrix;	import flash.text.TextFormat;	/**	 * Base class for all the map types	* @see MapTwoD	* @see IsoMap	* 	* org.shoebox.biskwy.views.maps.VMap	* @author shoebox	*/	public class VMap extends AView implements IView , IStageable , IResizeable{				public var nSCALE				:Number = 1;				protected var _uMARGIN			:uint = 250;		protected var _oSCROLL			:ScrollPane = new ScrollPane();		protected var _spGRID			:Grid = new Grid();		protected var _spCONTENT		:Sprite = new Sprite();		protected var _spCONTAINER		:Sprite = new Sprite();		protected var _spLIGHTMAP		:Sprite = new Sprite();		protected var _spSOUNDS		:Sprite = new Sprite();		protected var _spPOLY			:Sprite = new Sprite();		protected var _spGIZMO			:Sprite = new Sprite();		protected var _shBACK			:Shape = new Shape();		protected var _shCONTROLS		:MovieClip = new MovieClip();		protected var _oCOMBO			:ComboBox;				// -------o constructor					public function VMap() : void {				MapContainer = _spCONTAINER;				LightMapContainer = _spLIGHTMAP;				LightMapContainer.blendMode = BlendMode.OVERLAY;				SoundsContainer = _spSOUNDS;				GizmoContainer = _spGIZMO;				PolyContainer = _spPOLY;			}		// -------o public						/**			* set margin function			* @public			* @param 			* @return			*/			public function set margin( u : uint ) : void {				_uMARGIN = u;			}						/**			* get container function			* @public			* @param 			* @return			*/			public function get container() : Sprite {				return _spCONTAINER;			}						/**			* When the map view is added to the stage			* @public				* @param 	e : add to stage event (Event)			* @return	void			*/			public function onStaged(e:Event = null) : void {								//						var 	oDP : DataProvider = new DataProvider();					var v:Vector.<uint> = Vector.<uint>([ 50 , 100 , 125 , 150 , 200 ]);					var u : uint;					for each( u in v)						oDP.addItem({label : u+'%' , value : u});										_oCOMBO = Factory.build( ComboBox , { x : 60 , x : 10 , y : 4} );					_oCOMBO.dataProvider = oDP;					_oCOMBO.selectedIndex = 1;					_shCONTROLS.addChild(_oCOMBO);					controller.register( _oCOMBO , Event.CHANGE ,  false , 10 , true );								//					var 	oLABEL : Label = Factory.build( Label , { x : 10 , text : 'ZOOM' , y : 6} );						oLABEL.setStyle('textFormat', new TextFormat('PF Tempesta Seven',8,0) );					_shCONTROLS.addChild( oLABEL );										_shBACK.graphics.beginFill(0x2A2A2A);					_shBACK.graphics.drawRect(0,0,800,600);					_shBACK.graphics.endFill();					addChild(_shBACK);					//					_spGRID.visible = Menu.getInstance().showGrid;										_spCONTENT.addChild(_spCONTAINER);					_spCONTENT.addChild(_spGRID);					_spCONTENT.addChild(_spGIZMO);					_spCONTENT.addChild(_spLIGHTMAP);					_spCONTENT.addChild(_spSOUNDS);					_spCONTENT.addChild(_spPOLY);					addChild(_spCONTENT);									//					addChild(_oSCROLL);					addChild(_shCONTROLS);								_oSCROLL.useBitmapScrolling = false;				_oSCROLL.y = _spCONTENT.y = Config.HEADDECAL;				_oSCROLL.source = _spCONTENT;								//STAGEINSTANCE.addEventListener( MouseEvent.MOUSE_WHEEL , _onWheel , false , 10 ,true);					controller.register(_spCONTAINER , 	MouseEvent.MOUSE_OVER , true ,10 , false);				controller.register(_spCONTAINER , 	MouseEvent.MOUSE_OUT , true ,10 , false);				controller.register(_spCONTAINER , 	MouseEvent.CLICK , true ,10 , false);				controller.register(_spGIZMO , 	MouseEvent.DOUBLE_CLICK , true , 10 , false );				StageResize.register(this);				onResize();					}						/**			* On stage Resize			* @public				* @param 	e : Event 			* @return	void			*/			public function onResize( e : Event = null ) : void {				_shBACK.width = _oSCROLL.width = StageResize.rect.width ;				_shBACK.height = StageResize.rect.height;// * .75;				_oSCROLL.height = StageResize.rect.height * .75 - Config.HEADDECAL;								_shCONTROLS.graphics.clear();				_shCONTROLS.graphics.beginFill(0xEAEAEA);				_shCONTROLS.graphics.drawRect( 0 , 0 , StageResize.rect.width , Config.HEADDECAL);				_shCONTROLS.graphics.endFill();								_shCONTROLS.graphics.beginFill(0);				_shCONTROLS.graphics.drawRect( 175 , 0 , StageResize.rect.width - 175 , Config.HEADDECAL);				_shCONTROLS.graphics.endFill();							}			/**			* onRemoved function			* @public			* @param 			* @return			*/			public function onRemoved(e:Event = null) : void {												}						/**			* update function			* @public			* @param 			* @return			*/			override public function update( o : UpdateEvent = null ) : void {						}						/**			* Initialization of the view			* @public			* @return			*/			override public function initialize() : void {				Facade.getInstance().addEventListener(Menu.VIEW_GRID , _onViewGrid , false , 10 , true );			}									/**			* cancel function			* @public			* @param 			* @return			*/			override public function cancel( e : Event = null ) : void {				Facade.getInstance().removeEventListener(Menu.VIEW_GRID , _onViewGrid , false);			}						/**			* Redraw the map container to applying the zoom modification via Matrix scale			* @public				* @return	void			*/			public function redraw() : void {								DisplayFuncs.purge( _spGIZMO );								//					var 	oMAT:Matrix = _spCONTAINER.transform.matrix;						oMAT.identity();						oMAT.scale(nSCALE , nSCALE);											_spCONTAINER.transform.matrix = oMAT;								//					oMAT = _spGRID.transform.matrix;					oMAT.identity();					oMAT.scale(nSCALE , nSCALE);					_spGRID.transform.matrix = oMAT;					_spGRID.draw();									//					_oSCROLL.update();			}						/**			* Clear the content of all the tiles of the map			* @public				* @return	void			*/			public function clear() : void {								var o : GridTile;				var l : uint = _spCONTAINER.numChildren;				var i : int = 0;				for( i ; i < l ; i ++ ){					o = _spCONTAINER.getChildAt(i) as GridTile;					o.clear();				}			}						/**			* reset function			* @public			* @param 			* @return			*/			public function reset() : void {				DisplayFuncs.purge( _spGIZMO );				DisplayFuncs.purge( _spCONTAINER );			}						/**			* Reset the state of all Tiles in to the currentMAP			* @public			* @return	void			*/			public function out() : void {				//trc('clear');				var o : GridTile;				var l : uint = _spCONTAINER.numChildren;				var i : int = 0;				for( i ; i < l ; i ++ ){					o = _spCONTAINER.getChildAt(i) as GridTile;					o.out();				}			}						/**			* Get the GridTile instance at the specified position			* @public			* @param 	iX : x isometric position			* @param 	iY : y isometric position			* @return	Grid Tile instance at the position	(GridTile)			*/			public function getTileAt( iX : uint , iY : uint ) : GridTile {				return _spCONTAINER.getChildByName('tile'+iX+'_'+iY) as GridTile;			}						/**			* setScale function			* @public			* @param 			* @return			*/			public function setScale( n : Number ) : void {				trc('setScale ::: '+n);				nSCALE = n;				redraw();			}						/**			* pan function			* @public			* @param 			* @return			*/			public function pan( x : int , y : int ) : void {				_oSCROLL.move( x , y);			}				// -------o protected						/**			* On mouse wheel			*			* @param 	e : Mousewheel event (MouseEvent)			* @return	void			*/			protected function _onWheel( e : MouseEvent ) : void {								nSCALE+= (e.delta > 0) ? +.1 : -.1;				nSCALE = Math.min(Math.abs(nSCALE) , 2) * nSCALE/nSCALE;				redraw();			}						/**			* 			*			* @param 			* @return			*/			protected function _onViewGrid( e : Event ) : void {				Menu.getInstance().showGrid = !Menu.getInstance().showGrid;				_spGRID.visible = Menu.getInstance().showGrid;			}						// -------o misc			public static function trc(arguments : *) : void {				Logger.log(VMap, arguments);			}	}}