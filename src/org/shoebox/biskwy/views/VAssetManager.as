/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.views {		import org.shoebox.collections.HashMap;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import fl.containers.ScrollPane;
	import org.shoebox.biskwy.items.AssetItem;
	import org.shoebox.biskwy.data.MediaDesc;
	import fl.controls.ScrollPolicy;
	import org.shoebox.biskwy.models.MAssetManager;
	import flash.events.MouseEvent;
	import org.shoebox.patterns.factory.Factory;
	import fl.controls.Button;
	import flash.display.Sprite;
	import org.shoebox.patterns.mvc.abstracts.AView;	import org.shoebox.patterns.mvc.events.UpdateEvent;	import org.shoebox.patterns.mvc.interfaces.IView;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	/**	 * org.shoebox.biskwy.views.VAssetManager	* @author shoebox	*/	public class VAssetManager extends AView implements IView {				public var btnImport				: Button;				public var menuDelete				: NativeMenuItem = new NativeMenuItem( 'Delete' );		public var menuConvertToTile			: NativeMenuItem = new NativeMenuItem( 'Tile' );		public var menuConvertToBmpAsset		: NativeMenuItem = new NativeMenuItem( 'Bitmap asset' );				protected var _oCONTENT_HASH			: HashMap = new HashMap( true );		protected var _oMENU				: NativeMenu;		protected var _oSCROLL				: ScrollPane;		protected var _spCONTROLS			: Sprite = new Sprite();		protected var _spCONTAINER			: Sprite = new Sprite();
		protected var _spBOTTOM			: Sprite = new Sprite();
		protected var _vCONTENT 			: Vector.<AssetItem>;		protected var _uSIZE 				: uint = 125;
				// -------o constructor					/**			* Constructor of the VAssetManager class			*			* @public			* @return	void			*/			public function VAssetManager() : void {								//					_oMENU = new NativeMenu();					_oMENU.addItem( menuDelete );				//					var 	oMENU : NativeMenu = new NativeMenu();						oMENU.addItem( menuConvertToTile );							oMENU.addItem( menuConvertToBmpAsset );						_oMENU.addSubmenu( oMENU , 'Convert to' );			}		// -------o public						/**			* View initialization			*			* @public			* @return	void			*/			override final public function initialize() : void {				trc('initialize');								//
					controller.register(_oMENU , Event.SELECT , false , 10 , true );  								//
					_controls();					controller.registerGateway( 										btnImport, 										MouseEvent.CLICK , 										(model as MAssetManager).importMedia , 										false , false , 10 , true 									);
										controller.register(_spCONTAINER, MouseEvent.MOUSE_OVER	 , true, 10 , true);
					controller.register(_spCONTAINER, MouseEvent.MOUSE_OUT	 , true, 10 , true);
					controller.register(_spCONTAINER, MouseEvent.CLICK		 , true, 10, true);
					controller.register(_spCONTAINER, MouseEvent.DOUBLE_CLICK , false, 10, true);									//												( model as MAssetManager).list();					_spCONTAINER.y = 100;					addChild( _spCONTAINER );								//					_oSCROLL = new ScrollPane();					_oSCROLL.width = 1000;					_oSCROLL.height = 600;					_oSCROLL.y = 100;
					_oSCROLL.source = _spCONTAINER;
					_oSCROLL.horizontalScrollPolicy = ScrollPolicy.OFF;					addChild( _oSCROLL );					_oSCROLL.update();								addEventListener( Event.ADDED_TO_STAGE , _onStaged , false , 10 , true );			}						/**			* When the view receive an update			* 			* @public			* @param	o : optional update event (UpdateEvent) 			* @return	void			*/			override final public function update(o:UpdateEvent = null) : void {				_align();			}												/**			* When the view is canceled			* 			* @public			* @param	e : optional cancel event (Event) 			* @return	void			*/			override final public function cancel(e:Event = null) : void {				with( controller ){					unRegisterGateway( btnImport, MouseEvent.CLICK , (model as MAssetManager).importMedia , false );					unRegister(_oMENU		, Event.SELECT 			, false );					unRegister(_spCONTAINER	, MouseEvent.MOUSE_OVER	, true );					unRegister(_spCONTAINER	, MouseEvent.MOUSE_OUT	, true );					unRegister(_spCONTAINER	, MouseEvent.CLICK		, true );				}			}						/**			* addItem function			* @public			* @param 			* @return			*/
			final public function addItem(o : MediaDesc) : void {
				trc('addItem ::: '+o.iID);				trace('_oCONTENT_HASH.containsKey(o.iID) ::: '+_oCONTENT_HASH.containsKey(o.iID));				if( !_vCONTENT )					_vCONTENT = new Vector.<AssetItem>();
								if( _oCONTENT_HASH.containsKey(o.iID) )					return;				trace('do item ::: '+o);				var 	a : AssetItem = new AssetItem();
					a.datas = o;
					a.id = o.iID;
					a.redraw();					a.contextMenu = _oMENU;					a.type = o.sType;				trace('a.contextMenu ::: '+a.contextMenu);				_spCONTAINER.addChild( a );
				_vCONTENT.push(a);
				_oCONTENT_HASH.addItem(o.iID , a );			}						/**			* removeItem function			* @public			* @param 			* @return			*/
			final public function removeItem(o : MediaDesc) : void {								if( !_oCONTENT_HASH.containsKey(o.iID) )					return;				
				var a : AssetItem = _oCONTENT_HASH.getValue(o.iID );								_spCONTAINER.removeChild( a );
				_vCONTENT.splice(_vCONTENT.indexOf(a), 1);
				_oCONTENT_HASH.removeKey(o.iID );							}						/**			* setType function			* @public			* @param 			* @return			*/			final public function setType( u : uint , sType : String ) : void {				_oCONTENT_HASH.getValue(u).type = sType;			}					// -------o protected						/**			* 			*			* @param 			* @return			*/			final protected function _onStaged( e : Event ) : void {				removeEventListener( Event.ADDED_TO_STAGE , _onStaged , false );				stage.stageWidth = 1000;				stage.stageHeight = 700;			}						/**			* 			*			* @param 			* @return			*/			final protected function _controls() : void {				trc('controls()');								//					_spCONTROLS = new Sprite();					with( _spCONTROLS.graphics ){						beginFill( 0x696969 );						drawRect( 0 , 0 , 1000 , 100 );						endFill();					}					addChild( _spCONTROLS );									//					graphics.beginFill( 0xF2F2F2 );					graphics.drawRect( 0 , 0 , 1000 , 700 );					graphics.endFill();								//					btnImport = Factory.build( Button , 	{													x : 10 , y : 10 , 													width : 150, 													height : 30,													label:'Import media(s)'												});					_spCONTROLS.addChild(btnImport);								}						/**			* 			*			* @param 			* @return			*/			final protected function _align() : void {								var a : AssetItem;				var iX : int = 0;				var iY : int = 0;				var iMAXX : uint = Math.floor( 985 / _uSIZE ) ;				var iDIFF : uint = (985 - Math.floor( _uSIZE * iMAXX )) / (iMAXX + 1);								var iID : uint = 0;				for each( a in _vCONTENT ){					a.x = iX * (_uSIZE + iDIFF ) + iDIFF;					a.y = iY * (_uSIZE + iDIFF ) + iDIFF;					a.color = ( iY % 2 ) ? 0xDADADA : 0xCACACA;					a.name = iID+'';										iX++;					if( iX >= iMAXX ){						iX = 0;						iY ++;					}										iID++;									}								if( _oSCROLL )					_oSCROLL.update();							}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(VAssetManager, args);			}	}}