/**
	import org.shoebox.biskwy.items.PropsPanel;
	import org.shoebox.biskwy.items.ActorProps;
	import org.shoebox.engine.items.actors.AActor;
	import org.shoebox.biskwy.events.ActorEvent;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.NativeWindowType;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindow;
	import org.shoebox.patterns.singleton.ISingleton;
	import org.shoebox.patterns.commands.AbstractCommand;
					_oPROPS.setSize(300, 400);
					_oPROPS.addEventListener( PropsPanel.PROP_CHANGED , _onChanged , false , 10 , true );
					_oWINDOW.stage.addChild(_oPROPS);
					actorRef = ( e as ActorEvent ).targetActor;