package org.shoebox.biskwy.windows.content {	import fl.controls.Button;	import fl.controls.ComboBox;	import fl.controls.Label;	import fl.controls.NumericStepper;	import fl.controls.TextInput;	import fl.data.DataProvider;	import org.shoebox.biskwy.core.IsoGrid;	import org.shoebox.biskwy.core.TwoD;	import org.shoebox.biskwy.items.PropsPanel;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.utils.logger.Logger;	import flash.display.Sprite;	/**	 * org.shoebox.biskwy.commands.menu.CtntNewProject	* @author shoebox	*/	public class CtntNewProject extends Sprite{				protected var _oCOMBO			:ComboBox;		protected var _oBUTTONV		:Button;		protected var _oBUTTONC		:Button;		protected var _oLABELNAME		:Label;		protected var _stSIZE			:NumericStepper;		protected var _oNAME			:TextInput;		protected var _oPANEL			:PropsPanel;		protected var _oDPCAT 			:DataProvider;				// -------o constructor					public function CtntNewProject() : void {				trc('constructor');				_oDPCAT = new DataProvider();				_oDPCAT.addItem({label:'Isometric' , value : IsoGrid});				_oDPCAT.addItem({label:'2D' , value : TwoD});				_oDPCAT.addItem({label:'Platform' , value : TwoD});				_run();			}		// -------o public						/**			* get name function			* @public			* @param 			* @return			*/			public function get projectName() : String {				return _oPANEL.dataProvider..entry.( @prop == 'projName')[0].@value;			}						/**			* get tileSize function			* @public			* @param 			* @return			*/			public function get tileSize() : uint {				return _oPANEL.dataProvider..entry.( @prop == 'tileSize')[0].@value;			}						/**			* get mapType function			* @public			* @param 			* @return			*/			public function get mapType() : String {				return _oPANEL.dataProvider..entry.( @prop == 'mapType')[0].@value;			}						/**			* get prop function			* @public			* @param 			* @return			*/			final public function getProp( s : String ) : String {				return _oPANEL.dataProvider..entry.( @prop == s)[0].@value;			}					// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _run() : void {				trc('run');								var oXML : XML = <root>			      				<entry label = "PROJECT INFOS" type = "title" prop='infottl'/>			      				<entry label = 'Project name' 	prop='projName' 	type = "string" value = "My project" />			      							      				<entry label = "CAMERA CONFIG" type = "title" prop='infottl'/>			      				<entry label = 'Camera width'	 	prop='camW' 	type = "number" value = "800"  min = "0"  max = "2000"/>			      				<entry label = 'Camera height'	prop='camH' 	type = "number" value = "600"  min = "0"  max = "2000"/>			      							      				<entry label = "MAP CONFIG" 		type = "title" prop='infottl'/>			      				<entry label = 'Map type' 		prop='mapType' 	type = "combo" value = "2D" options="Isometric,2D,Platform"/>			      				<entry label = 'Tile size' 		prop='tileSize' 	type = "number" value = "32"  min = "0"  max = "2000"/>			      							      			</root>;								_oPANEL = new PropsPanel();				_oPANEL.setSize( 340 , 300 );				_oPANEL.dataProvider = oXML;				addChild( _oPANEL );								/*				//					addChild(Factory.build(Label,{ text : 'Type of the map' , x: 10 , y : 10}));					_oCOMBO = Factory.build(ComboBox, { x: 10, y : 30, width : 280});					_oCOMBO.dataProvider = _oDPCAT;					_oCOMBO.selectedIndex = 0;					addChild(_oCOMBO);									//					_oLABELNAME = Factory.build( Label , { width : 280 , x : 10 , y : 70 , text : 'Name :'} );					_oNAME = Factory.build( TextInput , { width : 280 , x : 10 , y : 90 } );					_oNAME.text = 'My project';					addChild(_oLABELNAME);					addChild(_oNAME);									//					addChild(Factory.build(Label,{ text : 'Tile size' , x: 10 , y : 130}));					_stSIZE = Factory.build(NumericStepper, { minimum : 0, maximum : 1000, x : 10, y : 150, value : 85});					addChild(_stSIZE);					_stSIZE.value = 85;					*/				//					_oBUTTONV = Factory.build(Button, { x : 5, y : 310, label:'Validate' , width : 165 , height : 30 , name:'Validate'});					_oBUTTONC = Factory.build(Button, { x : 180, y : 310, label:'Cancel' , width : 165 , height : 30 , name : 'Cancel'});					addChild(_oBUTTONV);					addChild(_oBUTTONC);							}					// -------o misc			public static function trc(arguments : *) : void {				Logger.log(CtntNewProject, arguments);			}	}	}