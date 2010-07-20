/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.models {	import flash.utils.Dictionary;
	import org.shoebox.biskwy.data.ANevermindLib;	import org.shoebox.biskwy.data.LinkItem;	import org.shoebox.biskwy.items.scriptsEditor.Anchor;	import org.shoebox.biskwy.views.VNevermind;	import org.shoebox.patterns.mvc.abstracts.AModel;	import org.shoebox.patterns.mvc.interfaces.IModel;	import org.shoebox.patterns.service.MediaService;	import org.shoebox.patterns.service.ServiceEvent;	import org.shoebox.utils.DescribeTypeCache;	import org.shoebox.utils.logger.Logger;	import flash.display.Loader;	import flash.events.Event;	import flash.net.URLRequest;	/**	 * MNevermind model class 	* 	* org.shoebox.biskwy.models.MNevermind	* @author shoebox	*/	public class MNevermind extends AModel implements IModel {				protected var _oLIB			: MediaService;		protected var _dCLASSES			: Dictionary;		protected var _vCODES			: Vector.<String>;		protected var _vCLASSES			: Vector.<Class> 		= Vector.<Class>([]);		protected var _vLINKS			: Vector.<LinkItem> 	= Vector.<LinkItem>([]);				// -------o constructor					/**			* Constructor of the model class			*			* @public			* @return	void			*/			public function MNevermind() : void {			}		// -------o public						/**			* Model initialization 			* 			* @public			* @param	e : optional initialization event (Event) 			* @return	void			*/			final override public function initialize( e : Event = null ) : void {				_getLib();				}									/**			* When the model and the triad is canceled			* 			* @public			* @param	e : optional cancel event (Event) 			* @return	void			*/			final override public function cancel(e:Event = null) : void {									}						/**			* registerLink function			* @public			* @param 			* @return			*/			final public function registerLink( o1 : Anchor , o2 : Anchor ) : void {				trc('registerLink');								if( o1.reference is Function && o2.reference is Function )					trc('invalid link cannot link a function to a function');				else{					_vLINKS.push( new LinkItem( o1 , o2 ) );					update( VNevermind.REDRAW );				}			}						/**			* get links function			* @public			* @param 			* @return			*/			final public function get links() : Vector.<LinkItem> {				return _vLINKS;			}						/**			* getClassCodeName function			* @public			* @param 			* @return			*/			final public function getClassCodeName( c : Class ) : String {				return DescribeTypeCache.getDesc( c )..metadata.(@name=='NVM_Desc')[0]..arg.(@key == 'name').@value;			}						/**			* getClassCodeName function			* @public			* @param 			* @return			*/			final public function getClassCodeType( c : Class ) : String {				return DescribeTypeCache.getDesc( c )..metadata.(@name=='NVM_Desc')[0]..arg.(@key == 'type').@value;			}									/**			* get classes function			* @public			* @param 			* @return			*/			final public function get codesList() : Vector.<String> {							//					if( _vCODES )						return _vCODES;								//					var c : Class;					_vCODES = Vector.<String>([]);					for each( c in _vCLASSES )						_vCODES.push( getClassCodeName(c) );								return _vCODES;							}						/**			* get classes function			* @public			* @param 			* @return			*/			final public function get classes() : Vector.<Class> {				return _vCLASSES;			}						/**			* getClassByCode function			* @public			* @param 			* @return			*/			final public function getClassByCode( s : String ) : Class {				return _dCLASSES[s];			}		// -------o protected						/**			* 			*			* @param 			* @return			*/			final protected function _getLib() : void {				_oLIB = new MediaService();				_oLIB.addEventListener( ServiceEvent.ON_DATAS , _onDatas , false , 10 , true );				_oLIB.request = new URLRequest('libs/LibTest.swf');				_oLIB.call();				}						/**			* 			*			* @param 			* @return			*/			final protected function _onDatas( e : ServiceEvent ) : void {								_oLIB.removeEventListener( ServiceEvent.ON_DATAS , _onDatas , false );								_dCLASSES = new Dictionary( true );				_vCLASSES = ((e.datas as Loader).content as ANevermindLib).classes;								var c : Class , x : XML , s : String ;				for each( c in _vCLASSES ){										x = DescribeTypeCache.getDesc( c );					s = x..metadata.(@name=='NVM_Desc')[0]..arg.(@key == 'name').@value;										_dCLASSES[s] = c;				}								update('osef');							}		// -------o misc			public static function trc(...args : *) : void {				Logger.log(MNevermind, args);			}	}}