/**
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
	import flash.events.SQLEvent;
			final protected function _list() : void {
				
				for each( o in _aDATAS ) {
				
				_oFILE = _oFILE.resolvePath(_aDATAS[_uINC].filepath);