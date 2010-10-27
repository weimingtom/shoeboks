/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.models {
	import org.shoebox.biskwy.core.TilesCacher;
	import org.shoebox.biskwy.core.variables.TilesCache;
	import org.shoebox.biskwy.core.DatabaseAssets;
	import org.shoebox.biskwy.core.Schemas;
	import org.shoebox.biskwy.core.variables.LastFile;
	import org.shoebox.biskwy.core.variables.ProjectDirectory;
	import org.shoebox.biskwy.data.MediaDesc;
	import org.shoebox.biskwy.services.SImportMedia;
	import org.shoebox.biskwy.services.assets.SAssets;
	import org.shoebox.biskwy.views.VAssetManager;
	import org.shoebox.patterns.mvc.abstracts.AModel;
	import org.shoebox.patterns.mvc.interfaces.IModel;
	import org.shoebox.patterns.service.ServiceBatch;
	import org.shoebox.patterns.service.ServiceEvent;
	import org.shoebox.patterns.service.ServiceFactory;
	import org.shoebox.utils.logger.Logger;

	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.FileListEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;	/**	 * MAssetManager model class 	* 	* org.shoebox.biskwy.models.MAssetManager	* @author shoebox	*/	public class MAssetManager extends AModel implements IModel {				public static const ON_DATAS		: String = 'MAssetManager-ON_DATAS';				protected var _aDATAS				: Array;		protected var _aINIT				: Array;		protected var _bINIT				: Boolean;		protected var _oBASE				: DatabaseAssets;		protected var _oFILE				: File;		protected var _oBATCH				: ServiceBatch;		protected var _oSTATMT				: SQLStatement;		protected var _vRESULTS			: Vector.<MediaDesc>;				// -------o constructor					/**			* Constructor of the model class			*			* @public			* @return	void			*/			public function MAssetManager() : void {			}		// -------o public						/**			* Model initialization 			* 			* @public			* @param	e : optional initialization event (Event) 			* @return	void			*/			final override public function initialize( e : Event = null ) : void {
								_oFILE = ProjectDirectory.resolvePath('assets.db');								if( !_oFILE.exists )					_createDabaseFile();				else					_openDatabaseFile();									
			}									/**			* When the model and the triad is canceled			* 			* @public			* @param	e : optional cancel event (Event) 			* @return	void			*/			final override public function cancel(e:Event = null) : void {									}						/**			* import function			* @public			* @param 			* @return			*/			final public function importMedia() : void {
				trc('importMedia');
				_oFILE = LastFile;				_oFILE.addEventListener( FileListEvent.SELECT_MULTIPLE , _onBrowsed , false , 10 , true );				_oFILE.browseForOpenMultiple('open medias');			}						/**			* list function			* @public			* @param 			* @return			*/
			final public function list(sCAT : String = '') : void {
				trc('list ::: ' + _bINIT);								if( !_bINIT )					return;								var 	oLIST : SAssets = ServiceFactory.getService( SAssets ) as SAssets;				if( oLIST.isRunning)					return;					
					oLIST.filter = sCAT;
					oLIST.addEventListener(ServiceEvent . ON_DATAS ,  _onList , false , 10 , true );					oLIST.call( );							}						/**			* get datasLength function			* @public			* @param 			* @return			*/			final public function get datasLength() : uint {								if( _aDATAS )					return _aDATAS.length;				else					return 0;			}						/**			* get dataProvider function			* @public			* @param 			* @return			*/			final public function get dataProvider() : Vector.<MediaDesc> {				return _vRESULTS;			}						/**			* delAssets function			* @public			* @param 			* @return			*/			final public function delAssets( v : Vector.<uint> ) : void {								var s : String = '';				var u : uint;				for each( u in v ) 					if( s !== '')						s = s + ','+ u;					else						s = u+'';								trc('delAsset ::: '+s);								_oBASE.addEventListener( SQLEvent.RESULT , _onChanged , false , 10 , true);				_oBASE.call( 'DELETE FROM TB_Assets WHERE id IN ( '+s+')');							}						/**			* convertAs function			* @public			* @param 			* @return			*/			final public function convertAs( v : Vector.<uint> , sType : String ) : void {				trc('convertAs ::: '+v+' /// '+sType);								var s : String = '';				var u : uint;				for each( u in v ){ 					if( s !== '')						s = s + ','+ u;					else						s = u+'';					(view as VAssetManager).setType( u , sType );				}												_oBASE.call( 'UPDATE TB_Assets SET type="'+sType+'" WHERE id IN ('+s+')' );							}
					// -------o protected						/**			* 			*			* @param 			* @return			*/			final protected function _openDatabaseFile() : void {				trc('_openDatabaseFile');
				_oBASE = DatabaseAssets.getInstance();
				_bINIT = true;	        		list( );			}						/**			* 			*			* @param 			* @return			*/			final protected function _createDabaseFile() : void {				trc('_createDabaseFile');								 var 	oS:FileStream = new FileStream();	        			oS.open(_oFILE, FileMode.WRITE);	        			oS.writeUTFBytes('');	        			oS.close();	        				        		_oBASE = DatabaseAssets.getInstance( );	        			        		if( _oBASE.connected )	        			_onConnection();	        		else{		        		_oBASE.addEventListener( SQLEvent.OPEN , _onDBAsset , false , 10 , true );					_oBASE.init();	        		}			}						/**			* 			*			* @param 			* @return			*/			final protected function _onDBAsset( e : SQLEvent ) : void {								_oBASE.removeEventListener( SQLEvent.OPEN , _onDBAsset , false );				_onConnection();			}						/**			* 			*			* @param 			* @return			*/			final protected function _onConnection() : void {								var 	aTMP : Array = Schemas.SCHEMA_ASSETS.split(';');					aTMP.push( Schemas.TRIGGER1 );					aTMP.push( Schemas.TRIGGER2 );					aTMP.push( Schemas.TRIGGER3 );					aTMP.push( Schemas.TRIGGER4 );				_aINIT = aTMP;				/*					var s : String;				for each( s in aTMP ){										if( s=='' )						continue;										trace('run ::: '+s+'|');					oSTAT = new SQLStatement();					oSTAT.sqlConnection = _oBASE;					oSTAT.text = s;					oSTAT.execute();									}				oSTAT.addEventListener( SQLEvent.RESULT , _onCompleteInit , false , 10 , true );				*/				_next();			}						/**			* 			*			* @param 			* @return			*/			final protected function _next( e : SQLEvent = null ) : void {				trc('next ::: '+e);								//					if( _aINIT.length == 0 ){						_onCompleteInit();						return;					}								//					var s : String = _aINIT.shift();					trc('next ::: '+s);					if( s== ''){						_next();						return;					}								//					_oSTATMT = new SQLStatement();					_oSTATMT.sqlConnection = _oBASE;					_oSTATMT.text = s;					_oSTATMT.addEventListener( SQLEvent.RESULT , _next , false , 10 , true );					_oSTATMT.execute();			}						/**			* 			*			* @param 			* @return			*/			final protected function _onCompleteInit(  ) : void {
				trc('_onCompleteInit');
				TilesCache = new TilesCacher( );				TilesCache.init( );				_bINIT = true;				list();			}						/**			* SQL response listener			*			* @param 	e : SQL response ( SQLEvent )			* @return	void			*/			final protected function _onList( e : ServiceEvent ) : void {				trc('onList ::: '+e.datas);								if( (e.datas as SQLResult) == null ){					return;				}				
				_aDATAS = (e.datas as SQLResult).data;
								//					var vOLD : Vector.<MediaDesc>;					if( _vRESULTS )						vOLD = _vRESULTS.slice( );													//					_vRESULTS = new Vector.<MediaDesc>();										var o : Object;					var b : BitmapData;					var v : Vector.<uint>;
					var d : MediaDesc;
										for each( o in _aDATAS	) {												v = o.preview as Vector.<uint>;						b = new BitmapData( v.shift() , v.shift() , true );						b.setVector( b.rect , v );						trace('MediaDesc:::'+o.id+' / '+o.label+' . '+o.type+' - '+o.filePath );												for( var prop : String in o )							if( prop !== 'preview' )								trace(prop+'  /// '+o[prop]);																		d = new MediaDesc( o.id , o.label , o.type , b , o.filePath );												_vRESULTS.push( d );					}									// 					for each( d in _vRESULTS )						(view as VAssetManager).addItem( d );								//										if( vOLD ){						var t : MediaDesc;						var bTMP : Boolean;						for each( d in vOLD ){														bTMP = false;							for each( t in _vRESULTS ) {
																if( t.iID == d.iID ){									bTMP = true;										break;								}															}														if( !bTMP ){								
								(view as VAssetManager).removeItem(d);
								var 	oFILE : File = File.documentsDirectory;
									oFILE = oFILE.resolvePath( d.sPath );																	if( oFILE.exists )									oFILE.deleteFile();																							}													}					}													update( ON_DATAS );			}						/**			* 			*			* @param 			* @return			*/			protected function _onBrowsed( e : FileListEvent ) : void {								trc('_onBrowsed ::: '+e);								_oBATCH = new ServiceBatch();				_oBATCH.addEventListener( Event.COMPLETE , _onComplete , false , 10 , true );								//						var aFILES : Array = e.files as Array;					var l : uint = aFILES.length ;					var i : int = 0;										LastFile = (aFILES[0] as File).parent;										while( i < l ){						trc('addFile ::: '+aFILES[i]);						_oBATCH.addService( SImportMedia , { file : aFILES[i] } );						i++;					}										_oBATCH.call();								_oFILE = _oFILE.resolvePath( _oFILE.nativePath );			}						/**			* 			*			* @param 			* @return			*/			protected function _onComplete ( e : Event ) : void {				trc('_onComplete ::: '+e);				list( );			}						/**			* 			*			* @param 			* @return			*/			protected function _onChanged(event : SQLEvent) : void {				_oBASE.removeEventListener( SQLEvent.RESULT , _onChanged , false );				list( );			}					// -------o misc			public static function trc(...args : *) : void {				Logger.log(MAssetManager, args);
		}

	}}