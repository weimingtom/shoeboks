package org.shoebox.biskwy.windows.content {	import fl.controls.Button;	import fl.controls.ComboBox;	import fl.controls.Label;	import fl.controls.NumericStepper;	import fl.controls.TextInput;	import fl.data.DataProvider;	import org.shoebox.biskwy.core.IsoGrid;	import org.shoebox.biskwy.core.TwoD;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.utils.logger.Logger;	import flash.display.Sprite;	/**	 * org.shoebox.biskwy.commands.menu.NewMapWindowContent	* @author shoebox	*/	public class NewMapWindowContent extends Sprite{				protected var _oCOMBO			:ComboBox;		protected var _oBUTTONV		:Button;		protected var _oBUTTONC		:Button;		protected var _oLABELNAME		:Label;		protected var _stSIZE			:NumericStepper;		protected var _oNAME			:TextInput;		protected var _oDPCAT 			:DataProvider;				// -------o constructor					public function NewMapWindowContent() : void {				trc('constructor');				_oDPCAT = new DataProvider();				_oDPCAT.addItem({label:'Isometric' , value : IsoGrid});				_oDPCAT.addItem({label:'2D' , value : TwoD});				_oDPCAT.addItem({label:'Platform' , value : TwoD});				_run();			}		// -------o public						/**			* get name function			* @public			* @param 			* @return			*/			public function get projectName() : String {				return _oNAME.text;			}						/**			* get tileSize function			* @public			* @param 			* @return			*/			public function get tileSize() : uint {				return _stSIZE.value;			}						/**			* get mapType function			* @public			* @param 			* @return			*/			public function get mapType() : String {				return _oCOMBO.selectedItem.label;			}					// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _run() : void {				trc('run');								//					addChild(Factory.build(Label,{ text : 'Type of the map' , x: 10 , y : 10}));					_oCOMBO = Factory.build(ComboBox, { x: 10, y : 30, width : 280});					_oCOMBO.dataProvider = _oDPCAT;					_oCOMBO.selectedIndex = 0;					addChild(_oCOMBO);									//					_oLABELNAME = Factory.build( Label , { width : 280 , x : 10 , y : 70 , text : 'Name :'} );					_oNAME = Factory.build( TextInput , { width : 280 , x : 10 , y : 90 } );					_oNAME.text = 'My project';					addChild(_oLABELNAME);					addChild(_oNAME);									//					addChild(Factory.build(Label,{ text : 'Tile size' , x: 10 , y : 130}));					_stSIZE = Factory.build(NumericStepper, { minimum : 0, maximum : 1000, x : 10, y : 150, value : 85});					addChild(_stSIZE);					_stSIZE.value = 85;									//					_oBUTTONV = Factory.build(Button, { x : 10, y : 190, label:'Validate' , width : 130 , name:'Validate'});					_oBUTTONC = Factory.build(Button, { x : 160, y : 190, label:'Cancel' , width : 130 , name : 'Cancel'});					addChild(_oBUTTONV);					addChild(_oBUTTONC);			}					// -------o misc			public static function trc(arguments : *) : void {				Logger.log(NewMapWindowContent, arguments);			}	}	}