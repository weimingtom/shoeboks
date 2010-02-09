/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.commands.menu {	import org.shoebox.core.BoxMath;
	import org.shoebox.biskwy.core.Config;	import org.shoebox.biskwy.services.SMaps;	import org.shoebox.biskwy.services.STiles;	import org.shoebox.biskwy.windows.PreviewWindow;	import org.shoebox.engine.core.MainRender;	import org.shoebox.patterns.commands.AbstractCommand;	import org.shoebox.patterns.commands.ICommand;	import org.shoebox.patterns.factory.Factory;	import org.shoebox.patterns.service.ServiceEvent;	import org.shoebox.patterns.service.ServiceFactory;	import org.shoebox.patterns.singleton.ISingleton;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	import flash.filesystem.File;	import flash.filesystem.FileMode;	import flash.filesystem.FileStream;	import flash.utils.ByteArray;	/**	 * Export compress and test the project in an rendering window	*  	* org.shoebox.biskwy.commands.menu.CommandTest	* @author shoebox	*/	public class CommandTest extends AbstractCommand implements ICommand , ISingleton {				protected var _oFILE		:File;		protected var _oFILEMAP		:File;		protected var _oFILETILE	:File;				protected static var __instance		:CommandTest;				// -------o constructor					public function CommandTest( e : SingletonEnforcer ) : void {			}		// -------o public						/**			* getInstance function			* @public			* @param 			* @return			*/			static public function getInstance() : CommandTest {								if(__instance == null)					__instance = new CommandTest( new SingletonEnforcer() );									return __instance;			}						/**			* onExecute function			* @public			* @param 			* @return			*/			final override public function onExecute( e : Event = null) : void {				_createProjectFolder();				_maps();			}						/**			* onCancel function			* @public			* @param 			* @return			*/			final override public function onCancel( e : Event = null ) : void {						}					// -------o protected						/**			* Create a temporary folder in to the documents directory 			* 			* @return void			*/			protected function _createProjectFolder() : void {				_oFILE = File.documentsDirectory.resolvePath('Biskwy_'+ Config.PROJECTNAME);				if(_oFILE.exists)					_oFILE.deleteDirectory(true);									_oFILE.createDirectory();			}						/**			* Export the maps files in to the sub folder "maps" 			* of the documents directory			* Then each maps is export in that folder			*			* @return void			*/			protected function _maps() : void {								//TODO : 	Soon adding a maps verification routine to check if the maps contains all 				//		of the necessary items (player start position...)								//create folder					_oFILEMAP = _oFILE.resolvePath('maps');					_oFILEMAP.createDirectory();								//Getting the maps list					var 	oSERVICE : SMaps = ServiceFactory.getService(SMaps) as SMaps;						oSERVICE.addEventListener( ServiceEvent.ON_DATAS , _onMaps , false , 10 , true );						oSERVICE.call();			}						/**			* Generate and export the BWY map file			*			* @param e : Service response event				* @return	void			*/			protected function _onMaps(e : ServiceEvent ) : void {								(e.target as SMaps).removeEventListener( ServiceEvent.ON_DATAS , _onMaps , false );								//					var i		: uint = 0;					var aMAPS 	: Array = e.datas as Array;					var uLEN 	: uint = aMAPS.length;					var oFILE 	: File;					var oSTREAM	: FileStream;					var oDATAS	: ByteArray;										for( i ; i < uLEN ; i++ ){													//							oFILE = _oFILEMAP.resolvePath(BoxMath.toString(i, 4)+'.bwm');							oDATAS = aMAPS[i].data;												//							oSTREAM = new FileStream();							oSTREAM.open( oFILE , FileMode.WRITE );							oSTREAM.writeBytes( oDATAS , 0 , oDATAS.length );							oSTREAM.close();					}				//					_tiles();			}						/**			* Retrieving the list of tiles			* by using the TilesSerivce (STiles)			* 			* @return void			*/			protected function _tiles() : void {								//					var 	oSERVICE : STiles = ServiceFactory.getService(STiles) as STiles;						oSERVICE.addEventListener( ServiceEvent.ON_DATAS , _onTiles , false , 10 , true );						oSERVICE.call();				}						/**			* <p>Responder of the service & export the tiles into the "Tiles" folder			* <br>			* <br>The <b>BWT</b> file format is describe by :<br> 			* <ul>			* <li>First Byte an 1 / 0 value who defined is the Tile is <i>walkable</i></li>			* <li>Next a int which the <i>x decal</i> of the Tile (defined in to the Tile Editor)</li>			* <li>Next a int which the <i>y decal</i> of the Tile (defined in to the Tile Editor)</li>			* </ul>			* - Then a media File (PNG / JPG / SWF)			* All of these datas are then compressed and exported			* </p>			* @param 	e : ServiceEvent	response (ServiceEvent)			* @return	void			*/			protected function _onTiles( e : ServiceEvent ) : void {								//TODO : 	Soon check if the exported Tiles is used in any of the maps 								//create folder					_oFILETILE = _oFILE.resolvePath('tiles');					_oFILETILE.createDirectory();									//Export Tiles					var a : Array = e.datas as Array;					var b : ByteArray;					var f : File;					var i : uint;					var l : uint = a.length;					var oFS : FileStream;					var oTILE : Object;					for( i ; i < l ; i++ ){						//							oTILE = a[i] as Object;													//If the tile is not activated, we ignore it							if(!Boolean(oTILE.active))								continue;												// Resolving the path of the new Tile File							f = _oFILETILE.resolvePath( oTILE.id + '.bwt');													// Filling the ByteArray with the datas							b = new ByteArray();							b.writeUTF('BWT');							b.writeByte((Boolean(oTILE.walkable) ? 0 : 1));							b.writeInt( oTILE.decalX );							b.writeInt( oTILE.decalY );							b.writeObject(oTILE.media);							b.deflate();													//							oFS = new FileStream();							oFS.open( f , FileMode.WRITE );							oFS.writeBytes( b , 0 , b.length );							oFS.close();					}								//					_exportBWY();					}						/**			* Exporting the BWY project file 			*			* @return void			*/			protected function _exportBWY() : void {				trc('export BWY');								//					var 	oF : File = _oFILE.resolvePath('project.bwy');									//					var 	oB : ByteArray = new ByteArray();						oB.writeUTF('BWY');						oB.writeUTF(Config.PROJECTNAME);						oB.writeInt(Config.TILESIZE);							oB.compress();									//					var 	oFS : FileStream = new FileStream();						oFS.open(oF, FileMode.WRITE);						oFS.writeBytes(oB, 0, oB.length);						oFS.close();			}						/**			* Opening the preview window			*			* @return void			*/			protected function _openWindow() : void {				return;				var 	oWIN : PreviewWindow = new PreviewWindow();					oWIN.activate();					oWIN.stage.addChild( Factory.build( MainRender , { projectFile : _oFILE }) );				onComplete();			}		// -------o misc			public static function trc(...args : *) : void {				Logger.log(CommandTest, args);			}	}}internal class SingletonEnforcer{	}