package org.shoebox.biskwy.items {
	import org.shoebox.display.DisplayFuncs;
	import org.shoebox.display.text.TextFormatter;
	import org.shoebox.patterns.commands.samples.IMouseOut;
	import org.shoebox.patterns.commands.samples.IMouseOver;
	import org.shoebox.patterns.factory.Factory;
	import org.shoebox.utils.logger.Logger;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;

	/**
	* org.shoebox.biskwy.views.MapItem
	* @author shoebox
	*/
	public class MapItem extends Sprite implements IMouseOver , IMouseOut {
		
		protected var _shBACK		:Shape;
		protected var _tfNAME		:TextField;
		protected var _oDATAS		:Object;
		protected var _uID		:uint = 1;
		
		// -------o constructor
		
			public function MapItem() : void {
				mouseChildren = false;
				mouseEnabled = true;
				useHandCursor = true;
			}

		// -------o public
			
			/**
			* over function
			* @public
			* @param 
			* @return
			*/
			public function over( e : MouseEvent ) : void {
				if(mouseEnabled)
					DisplayFuncs.setColor(_shBACK , 0xCCCCCC);
			}
			
			/**
			* out function
			* @public
			* @param 
			* @return
			*/
			public function out( e : MouseEvent ) : void {
				if(mouseEnabled)
					_shBACK.transform.colorTransform = new ColorTransform();
			}
			
			/**
			* freeze function
			* @public
			* @param 
			* @return
			*/
			public function freeze( b : Boolean ) : void {
				mouseEnabled = !b;
				if(b)
					DisplayFuncs.setColor(_shBACK , 0x6ab6f3 );
				else
					_shBACK.transform.colorTransform = new ColorTransform();
			}
				
			/**
			* set datas function
			* @public
			* @param 
			* @return
			*/
			public function set datas( o : Object ) : void {
				_oDATAS = o;
				_draw();
			}
			
			/**
			* get id function
			* @public
			* @param 
			* @return
			*/
			public function get id() : uint {
				return _uID;
			}
			
			/**
			* set id function
			* @public
			* @param 
			* @return
			*/
			public function set id( u : uint ) : void {
				trc('set id ::: '+u);
				_uID = u;
			}
			
		// -------o protected
			
			/**
			* 
			*
			* @param 
			* @return
			*/
			protected function _draw() : void {
				
				//
					_shBACK = new Shape();
					_shBACK.graphics.beginFill( (id%2==0) ? 0xEAEAEA : 0xFAFAFA );
					_shBACK.graphics.drawRect(0,0,230,30);
					addChild( _shBACK );
					
				//
					_tfNAME = Factory.build( TextField , { text : _oDATAS.name , width : 210 , x : 10 , y : 5} );
					addChild(_tfNAME);
					TextFormatter.apply(_tfNAME,10,'Verdana',TextFormatAlign.LEFT,TextFieldAutoSize.NONE);
				
			}
			
		// -------o misc

			public static function trc(arguments : *) : void {
				Logger.log(MapItem, arguments);
			}
	}



}
