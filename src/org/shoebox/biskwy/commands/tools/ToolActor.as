/**
	import org.shoebox.display.DisplayFuncs;
	import org.shoebox.biskwy.core.Config;
	import org.shoebox.biskwy.core.IsoGrid;
	import org.shoebox.biskwy.core.TwoD;
	import org.shoebox.biskwy.core.variables.CurrentMap;
	import org.shoebox.biskwy.core.variables.GizmoContainer;
	import org.shoebox.biskwy.core.variables.SelectedActor;
	import org.shoebox.biskwy.events.GridTileEvent;
	import org.shoebox.biskwy.items.GridTile;
	import org.shoebox.biskwy.utils.Transformer;
	import org.shoebox.biskwy.windows.ActorsWindow;
	import org.shoebox.core.BoxMath;
	import org.shoebox.engine.items.actors.AActor;
	import org.shoebox.events.EventCentral;
	import org.shoebox.patterns.factory.Factory;
	import org.shoebox.patterns.singleton.ISingleton;
	import org.shoebox.utils.logger.Logger;

	import flash.events.Event;
	import flash.geom.Vector3D;
				var 	vPOSWLD : Vector3D;
						