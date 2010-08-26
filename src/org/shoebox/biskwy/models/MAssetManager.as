/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.models {	import org.shoebox.biskwy.services.SImportMedia;
	import org.shoebox.biskwy.services.SImportTile;	import org.shoebox.patterns.mvc.abstracts.AModel;	import org.shoebox.patterns.mvc.interfaces.IModel;	import org.shoebox.patterns.service.ServiceBatch;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	import flash.events.FileListEvent;	import flash.filesystem.File;	/**	 * MAssetManager model class 	* 	* org.shoebox.biskwy.models.MAssetManager	* @author shoebox	*/	public class MAssetManager extends AModel implements IModel {				protected var _oFILE			: File;		protected var _oBATCH			: ServiceBatch;				// -------o constructor					/**			* Constructor of the model class			*			* @public			* @return	void			*/			public function MAssetManager() : void {			}		// -------o public						/**			* Model initialization 			* 			* @public			* @param	e : optional initialization event (Event) 			* @return	void			*/			final override public function initialize( e : Event = null ) : void {									}									/**			* When the model and the triad is canceled			* 			* @public			* @param	e : optional cancel event (Event) 			* @return	void			*/			final override public function cancel(e:Event = null) : void {									}						/**			* import function			* @public			* @param 			* @return			*/			final public function importMedia() : void {				_oFILE = File.documentsDirectory;				_oFILE.addEventListener( FileListEvent.SELECT_MULTIPLE , _onBrowsed , false , 10 , true );				_oFILE.browseForOpenMultiple('open medias');			}					// -------o protected						/**			* 			*			* @param 			* @return			*/			protected function _onBrowsed( e : FileListEvent ) : void {								_oBATCH = new ServiceBatch();				_oBATCH.addEventListener( Event.COMPLETE , _onComplete , false , 10 , true );								//						var aFILES : Array = e.files as Array;					var l : uint = aFILES.length ;					var i : int = 0;										while( i < l ){						trc('addFile ::: '+aFILES[i]);						_oBATCH.addService( SImportMedia , { file : aFILES[i] } );						i++;					}										_oBATCH.call();					}						/**			* 			*			* @param 			* @return			*/			protected function _onComplete ( e : Event ) : void {							}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(MAssetManager, args);			}	}}