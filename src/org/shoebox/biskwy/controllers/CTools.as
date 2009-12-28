/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.controllers {	import org.shoebox.biskwy.commands.tools.ToolClickClear;	import org.shoebox.biskwy.commands.tools.ToolClickEdit;	import org.shoebox.biskwy.commands.tools.ToolClickFill;	import org.shoebox.biskwy.commands.tools.ToolElevation;	import org.shoebox.biskwy.commands.tools.ToolRectFill;	import org.shoebox.biskwy.commands.tools.ToolSelection;	import org.shoebox.biskwy.core.Main;	import org.shoebox.patterns.commands.AbstractCommand;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.patterns.mvc.abstracts.AController;	import org.shoebox.patterns.mvc.interfaces.IController;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	/**	 * org.shoebox.biskwy.controllers.CTools	* @author shoebox	*/	public class CTools extends AController implements IController{				protected var _oCOMMAND		:AbstractCommand;				// -------o constructor					public function CTools() : void {			}		// -------o public						/**			* onEvent function			* @public			* @param 			* @return			*/			final override public function onEvent( e : Event ) : void {								trc('onEvent :::'+e);								if(_oCOMMAND)					_oCOMMAND.cancel();					_oCOMMAND = null;								switch( e.target.name ){										case 'ClickFill':						_oCOMMAND = Factory.build(ToolClickFill , {map : Main.currentMAP});						break;										case 'Edit':						_oCOMMAND = Factory.build(ToolClickEdit , {map : Main.currentMAP});												break;											case 'Clear':						_oCOMMAND = Factory.build(ToolClickClear , {map : Main.currentMAP});						break;											case 'Select':						_oCOMMAND = Factory.build(ToolSelection , {map : Main.currentMAP});						break;											case 'RectFill':						_oCOMMAND = Factory.build(ToolRectFill , {map : Main.currentMAP});						break;											case 'Elevation':						_oCOMMAND = Factory.build(ToolElevation , {map : Main.currentMAP});						break;									}				if(_oCOMMAND)					_oCOMMAND.execute();							}									/**			* initialize function			* @public			* @param 			* @return			*/			final override public function initialize() : void {						}						/**			* cancel function			* @public			* @param 			* @return			*/			final override public function cancel( e : Event = null ) : void {						}					// -------o protected		// -------o misc			public static function trc(arguments : *) : void {				Logger.log(CTools, arguments);			}	}}