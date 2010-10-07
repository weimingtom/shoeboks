package org.shoebox.engine.interfaces {
	
	import flash.events.IEventDispatcher;
	
	/**
	 * @author shoe[box]
	 */
	public interface IActor extends IEventDispatcher  {
		
		function redraw():void;
		
	}
}
