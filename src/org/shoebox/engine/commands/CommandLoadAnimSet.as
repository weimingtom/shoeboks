/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.engine.commands {	import org.shoebox.patterns.commands.AbstractCommand;	import org.shoebox.patterns.commands.ICommand;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.patterns.service.MediaService;	import org.shoebox.patterns.service.ServiceEvent;	import org.shoebox.patterns.singleton.ISingleton;	import org.shoebox.utils.logger.Logger;	import flash.display.Loader;	import flash.display.MovieClip;	import flash.events.Event;	import flash.net.FileFilter;	import flash.net.FileReference;	import flash.net.URLRequest;	import flash.system.ApplicationDomain;	import flash.system.LoaderContext;	/**	 * fr.hyperfictions.sandbox.commands.CommandLoadAnimSet	* @author shoebox	*/	public class CommandLoadAnimSet extends AbstractCommand implements ICommand ,ISingleton {				protected var _oFILE				: FileReference;		protected var _oREF				: MovieClip;		protected var _oLOADER_DATAS			: Loader;		protected var _oSERVICE			: MediaService;				// -------o constructor					/**			* Constructor of the AScript command class			*			* @public			* @return	void			*/			public function CommandLoadAnimSet( e : SingletonEnforcer ) : void {				cancelable = false;			}		// -------o public						/**			* Execution of the command			* 			* @public			* @param	e : optional event (Event) 			* @return	void			*/			override public function onExecute( e : Event = null ) : void {				//_run();				_auto();			}						/**			* When the command is canceled			* 			* @public			* @param	e : optional event (Event)	 			* @return	void			*/			override public function onCancel( e : Event = null ) : void {							}					// -------o protected						/**			* 			*			* @param 			* @return			*/			final protected function _auto() : void {				_oSERVICE  = new MediaService();				_oSERVICE.request = new URLRequest('perso_human.swf');				_oSERVICE.context = new LoaderContext( false , ApplicationDomain.currentDomain );				_oSERVICE.addEventListener( ServiceEvent.ON_DATAS , _onDatas , false , 10 , true );				_oSERVICE.call();			}						/**			* 			*			* @param 			* @return			*/			final protected function _onDatas( e : ServiceEvent ) : void {				_oREF = Factory.build( 'perso_human' );					_oREF.addEventListener( Event.EXIT_FRAME , _onFrame , false , 10 , true );			}			/**			* 			*			* @param 			* @return			*/			final protected function _run() : void {								//					_oFILE = new FileReference();					_oFILE.addEventListener( Event.SELECT , _onSelected , false , 10 , true );					_oFILE.browse([new FileFilter("Animaton library SWF", "*.swf")]);							}						/**			* 			*			* @param 			* @return			*/			final protected function _onSelected( e : Event = null ) : void {				_oFILE.removeEventListener( Event.SELECT , _onSelected , false );				_oFILE.addEventListener( Event.COMPLETE , _onComplete , false , 10 , true );				_oFILE.load();			}						/**			* 			*			* @param 			* @return			*/			final protected function _onComplete( e : Event ) : void {								var o : LoaderContext = new LoaderContext( false , ApplicationDomain.currentDomain );					o.allowCodeImport = true;								_oLOADER_DATAS = new Loader();				_oLOADER_DATAS.contentLoaderInfo.addEventListener( Event.COMPLETE , _onMediaLoaded , false , 10 , true );				_oLOADER_DATAS.loadBytes( _oFILE.data , o );			}						/**			* 			*			* @param 			* @return			*/			final protected function _onMediaLoaded( e : Event ) : void {								_oLOADER_DATAS.contentLoaderInfo.removeEventListener( Event.COMPLETE , _onMediaLoaded , false );								_oREF = Factory.build( _oFILE.name.split('.')[0] );					_oREF.addEventListener( Event.EXIT_FRAME , _onFrame , false , 10 , true );							}						/**			* 			*			* @param 			* @return			*/			final protected function _onFrame( e : Event ) : void {				if(!_oREF.cController)					return;				_oREF.removeEventListener( Event.EXIT_FRAME , _onFrame , false );				Facade.getInstance().addLib( _oREF , _oREF.cController );				onComplete();			}		// -------o misc			public static function trc(...args : *) : void {				Logger.log(CommandLoadAnimSet, args);			}						/**			* Return the singleton instance of the class			* @public			* @return instance of the class (CommandLoadAnimSet)			*/			static public function getInstance() : CommandLoadAnimSet {								if( !__instance )					__instance = new CommandLoadAnimSet( new SingletonEnforcer() );												return __instance;			}					protected static var __instance			: CommandLoadAnimSet = null;	}}internal class SingletonEnforcer{	}