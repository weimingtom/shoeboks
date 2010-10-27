/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/
package org.shoebox.biskwy.services.assets {
	import org.shoebox.biskwy.data.TileDesc;
	import flash.filesystem.File;
	import org.shoebox.biskwy.core.DatabaseAssets;
	import org.shoebox.biskwy.core.variables.TilesDesc;
	import org.shoebox.patterns.commands.AbstractCommand;
	import org.shoebox.patterns.commands.ICommand;
	import org.shoebox.patterns.singleton.ISingleton;
	import org.shoebox.utils.logger.Logger;

	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.events.SQLEvent;	/**	* org.shoebox.biskwy.services.assets.STilesDescCacher	* @author shoebox	*/	public class STilesDescCacher extends AbstractCommand implements ICommand , ISingleton {				protected var _aDATAS				: Array;		protected var _oBASE				: DatabaseAssets;		protected var _oFILE				: File;		protected var _oLIST				: SQLStatement;		protected var _uINC				: uint;		protected var _uLEN				: uint;				// -------o constructor					/**			* Constructor of the AScript command class			*			* @public			* @return	void			*/			public function STilesDescCacher( e : SingletonEnforcer ) : void {			}		// -------o public						/**			* Execution of the command			* 			* @public			* @param	e : optional event (Event) 			* @return	void			*/			override public function onExecute( e : Event = null ) : void {				_init();			}						/**			* When the command is canceled			* 			* @public			* @param	e : optional event (Event)	 			* @return	void			*/			override public function onCancel( e : Event = null ) : void {							}					// -------o protected						/**			* 			*			* @param 			* @return			*/			final protected function _init() : void {								_oBASE = DatabaseAssets.getInstance( );	        		_list();			}						/**			* 			*			* @param 			* @return			*/
			final protected function _list() : void {
								_oBASE.addEventListener( SQLEvent.RESULT , _onList , false ,  10 , true );				_oBASE.call( 'SELECT * FROM TilesDB' );							}						/**			* 			*			* @param 			* @return			*/			final protected function _onList( e : SQLEvent ) : void {				_oBASE.removeEventListener( SQLEvent.RESULT , _onList , false);								_aDATAS = _oBASE.getResults().data;				var o : Object;				var d : TileDesc;				var p : String;
				for each( o in _aDATAS ) {										d = new TileDesc();										for( p in o )						d[p] = o[p];																TilesDesc.addItem( o.AssetID , o);				}
								_uINC = 0;				_uLEN = _aDATAS.length;				_nextMedia();			}						/**			* 			*			* @param 			* @return			*/			final protected function _nextMedia() : void {								_oFILE = File.documentsDirectory;
				_oFILE = _oFILE.resolvePath(_aDATAS[_uINC].filepath);				_oFILE.addEventListener( Event.COMPLETE , _onFileLoaded , false , 10 , true );				_oFILE.load( );								/*				_oMEDIALOADER = new Loader();				_oMEDIALOADER.contentLoaderInfo.addEventListener(Event.COMPLETE, _onMedia , false, 10, true);				_oMEDIALOADER.load( new URLRequest( _oDESC.filepath ) , oCONTEXT);				 * 				 */				 			}						/**			* 			*			* @param 			* @return			*/			final protected function _onFileLoaded( e : Event ) : void {							}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(STilesDescCacher, args);			}						/**			* Return the singleton instance of the class			* @public			* @return instance of the class (STilesDescCacher)			*/			static public function getInstance() : STilesDescCacher {								if( !__instance )					__instance = new STilesDescCacher( new SingletonEnforcer() );												return __instance;			}						protected static var __instance			: STilesDescCacher = null;	}}internal class SingletonEnforcer{	}