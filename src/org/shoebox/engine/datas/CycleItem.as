package org.shoebox.engine.datas {

	/**
	 * @author shoe[box]
	 */
	public class CycleItem{
		
		public var progress			:int = -1;
		public var name				:String;
		public var index				:uint;
		public var	length			:uint;
		
		/**
		* reset function
		* @public
		* @param 
		* @return
		*/
		final public function reset() : void {
			progress = -1;
		}
		
	}
}
