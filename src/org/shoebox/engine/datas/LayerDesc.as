package org.shoebox.engine.datas {
	import org.shoebox.utils.logger.Logger;

	import flash.geom.Point;
	import flash.utils.ByteArray;

	/**
	 * org.shoebox.engine.datas.MapData
	* @author shoebox
	*/
	public class LayerDesc {
		
		public var bMEDIA				: ByteArray;
		public var isPARALLAX				: Boolean;
		public var isTILEABLE				: Boolean;
		public var isGAME_LAYER			: Boolean;
		public var iSPEED_FACTOR			: Number;
		public var sLAYER_NAME				: String;
		public var ptDECAL				: Point;
				
		// -------o constructor
		
			/**
			* Constructor of the LayerDesc class
			*
			* @public
			* @return	void
			*/
			public function LayerDesc( b : Boolean , s : String , iDX : int , iDY : int , bP : Boolean , bT : Boolean , iS : Number , bDATAS: ByteArray ) : void {
				isGAME_LAYER = b;
				sLAYER_NAME = s;
				ptDECAL = new Point( iDX , iDY );
				isPARALLAX = bP;
				isTILEABLE = bT;
				iSPEED_FACTOR = iS;
				bMEDIA = bDATAS;
			}

		// -------o public
		
		// -------o protected

		// -------o misc

			public static function trc(...args : *) : void {
				Logger.log(LayerDesc, args);
			}
	}
}
