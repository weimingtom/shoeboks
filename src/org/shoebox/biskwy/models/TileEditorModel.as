/**  HomeMade by shoe[box]   Redistribution and use in source and binary forms, with or without   modification, are permitted provided that the following conditions are  met:  * Redistributions of source code must retain the above copyright notice,     this list of conditions and the following disclaimer.    * Redistributions in binary form must reproduce the above copyright    notice, this list of conditions and the following disclaimer in the     documentation and/or other materials provided with the distribution.    * Neither the name of shoe[box] nor the names of its     contributors may be used to endorse or promote products derived from     this software without specific prior written permission.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/package org.shoebox.biskwy.models {	
	import flash.data.SQLStatement;
	import org.shoebox.biskwy.core.DatabaseAssets;
	import fl.data.DataProvider;	import org.shoebox.biskwy.core.variables.TilesCache;	import org.shoebox.biskwy.data.TileDesc;	import org.shoebox.biskwy.events.TileEvent;	import org.shoebox.biskwy.views.TileEditorView;	import org.shoebox.patterns.mvc.abstracts.AModel;	import org.shoebox.patterns.mvc.interfaces.IModel;	import org.shoebox.utils.logger.Logger;	import flash.events.Event;	import flash.events.SQLEvent;	/**	 * org.shoebox.biskwy.models.TileEditorModel	* @author shoebox	*/	public class TileEditorModel extends AModel implements IModel{				protected var _oBASE				:DatabaseAssets;		protected var _oCATS				:DataProvider;		protected var _oTILELIST			:SQLStatement;		protected var _oDATAS				:Object;		protected var _uTILEID				:uint;		protected var _oXML				:XML = <root>					      					<entry label = "INFOS" type = "title" prop='infottl'/>					      					<entry label = 'Active' 		prop='active' 	type = "boolean" value = "false" />					      					<entry label = 'Ground tile' 		prop='ground' 	type = "boolean" value = "false" />					      					<entry label = 'Element ID' 		prop='tileID' 	type = "string" value = "false" />					      					<entry label = 'Element Name' 	prop='name' 	type = "string" value = "false" />					      					<entry label = 'Categorie'	 	prop='cat'	 	type = "string" value = "false" />					      										      					<entry label = "MEDIA" type = "title" prop='mediattl'/>					      					<entry label = 'Source file'	 	prop='filepath' 	type = "string" value = "false" />					      					<entry label = 'X decal'	 	prop='decalX' 	type = "number" value = "0"  min = "-1500"  max = "1500"/>					      					<entry label = 'Y decal'	 	prop='decalY' 	type = "number" value = "0"  min = "-1500"  max = "1500"/>					      										      					<entry label = "COLLISIONS" type = "title" prop="colttl"/>					      					<entry prop='collide' type = "boolean"	value = "false" label = 'Collidable'>					      						<sub prop = 'collidT' type = 'boolean' value = 'false' label = 'Colldable Top'/>					      						<sub prop = 'collidL' type = 'boolean' value = 'false' label = 'Colldable Left'/>					      						<sub prop = 'collidB' type = 'boolean' value = 'false' label = 'Colldable Bottom'/>					      						<sub prop = 'collidR' type = 'boolean' value = 'false' label = 'Colldable Right'/>					      					</entry>					      										      										      				</root>;			      						// -------o constructor					public function TileEditorModel() : void {				_oTILELIST = new SQLStatement();				_oTILELIST.text = 'SELECT * FROM TilesDB WHERE AssetID=:tileID';			}		// -------o public						/**			* set tileID function			* @public			* @param 			* @return			*/			public function set tileID( u : uint ) : void {				_uTILEID = u;			}						/**			* get tileID function			* @public			* @param 			* @return			*/			public function get tileID() : uint {				return _uTILEID;			}						/**			* initialize function			* @public			* @param 			* @return			*/			final override public function initialize(e : Event = null ) : void {				trc('initialize ::: '+(e as TileEvent).tileID);								if(e == null)					return;								_uTILEID = (e as TileEvent).tileID;				_openDatabaseFile();							}									/**			* cancel function			* @public			* @param 			* @return			*/			final override public function cancel( e : Event = null ) : void {						}							/**			* update function			* @public			* @param 			* @return			*/			public function dbUpdate() : void {				trc('dbUpdate ::: '+_uTILEID);								var	oDATAS : Object = (view as TileEditorView).datas;								var	oPROPS : TileDesc = TilesCache.getValue(tileID);					oPROPS.decalX = oDATAS.decalX;					oPROPS.decalY = oDATAS.decalY;					oPROPS.update();									var 	oBASE : DatabaseAssets = DatabaseAssets.getInstance();					oBASE.addEventListener(SQLEvent.RESULT , _onComplete , false , 10 , true);					oBASE.call('UPDATE TilesDB SET decalX="'+oDATAS.decalX+							 '" , decalY="' + oDATAS.decalY +'",'+							 'collide = '+oDATAS.collide+', '+							 'cat = "'+oDATAS.cat+'", '+							 'active = '+oDATAS.active+', '+							 'ground = '+oDATAS.ground+' '+							 'WHERE id="' + _uTILEID+'"');							}						/**			* get cats function			* @public			* @param 			* @return			*/			public function get cats() : DataProvider {				return _oCATS;			}						/**			* get cat function			* @public			* @param 			* @return			*/			public function get cat() : String {				return _oDATAS.cat;			}						/**			* get desc function			* @public			* @param 			* @return			*/			public function get desc() : Object {				return '';//_oBASE.getResult().data[0];			}						/**			* get name function			* @public			* @param 			* @return			*/			public function get name() : String {				return _oDATAS.name;			}						/**			* get filename function			* @public			* @param 			* @return			*/			public function get filepath() : String {				return _oDATAS.filepath;			}						/**			* get decalX function			* @public			* @param 			* @return			*/			public function get decalX() : Number {				return _oDATAS.decalX;			}						/**			* get decalY function			* @public			* @param 			* @return			*/			public function get decalY() : Number {				return _oDATAS.decalY;			}						/**			* get property function			* @public			* @param 			* @return			*/			public function property( s : String ) : * {				return _oDATAS[s];			}						/**			* get dataProvider function			* @public			* @param 			* @return			*/			final public function get dataProvider() : XML {								if( !_oDATAS )					return _oXML;									//					var v : Vector.<String> = Vector.<String>(['tileID','name','cat','filepath','decalX','decalY']);					var u : uint = 0;					var l : uint = v.length;					for( u ; u < l ; u++ )						_oXML..entry.(String(@prop) == v[u]).@value = this[v[u]];									//					v = Vector.<String>(['collide','active','ground']);					l = v.length;					u = 0;					for( u ; u < l ; u++ )						if(property(v[u])!==null)							_oXML..entry.(String(@prop) == v[u]).@value = property(v[u]).toString(); 													return _oXML;			}					// -------o protected						/**			* 			*			* @param 			* @return			*/			final protected function _openDatabaseFile() : void {				_oBASE = DatabaseAssets.getInstance( );	        		_getTiles();			}						/**			* 			*			* @param 			* @return			*/			protected function _getTiles ( ) : void {				trc('_getTiles ::: '+tileID);				_oTILELIST.parameters[':tileID'] = tileID;				_oTILELIST.addEventListener( SQLEvent.RESULT , _onResult , false , 10 , true);				_oTILELIST.sqlConnection = _oBASE;				_oTILELIST.execute( ); 			}						/**			* 			*			* @param 			* @return			*/			protected function _onResult( e : SQLEvent ) : void {				_oTILELIST.removeEventListener( SQLEvent.RESULT , _onResult , false );				_oDATAS = _oTILELIST.getResult().data[0];
			}						/**			* 			*			* @param 			* @return			*/			protected function _onComplete ( e : SQLEvent ) : void {				e.target.removeEventListener(SQLEvent.RESULT , _onComplete , false);				(view as TileEditorView).stage.nativeWindow.close();			}					// -------o misc			public static function trc(arguments : *) : void {				Logger.log(TileEditorModel, arguments);			}	}}