/**
	import flash.data.SQLResult;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.data.SQLStatement;
	import org.shoebox.biskwy.core.variables.ProjectDirectory;
	import flash.data.SQLConnection;
	import org.shoebox.utils.logger.Logger;
			final public function init( bAsynch : Boolean = false ) : void {
					open( ProjectDirectory.resolvePath('assets.db') );