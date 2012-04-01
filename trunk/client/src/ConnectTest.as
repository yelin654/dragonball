package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.musince.actions.ConnectToServer;
	import org.musince.actions.LoadConfigFile;
	import org.musince.core.TimeSlice;
	import org.musince.global.$athena;
	import org.musince.global.$log;
	import org.musince.global.$loginName;
	import org.musince.util.TextFieldUtil;
	
	[SWF(width="1280", height="720", backgroundColor="0x000000")]
	
	public class ConnectTest extends Sprite
	{
		public var tip:TextField = TextFieldUtil.getTextField();
		
		public function ConnectTest()
		{
			super();
			var config:LoadConfigFile = new LoadConfigFile();
			var connect:ConnectToServer = new ConnectToServer();
			config.appendNext(connect);
			$athena.start(stage);
			$athena.addTimeSlice(config);
			tip.autoSize = TextFieldAutoSize.NONE;
			tip.width = 1280;
			tip.y = 300; 
			tip.text = "loading config file";
			config.endHook = onConfigLoad;
			connect.endHook = onConnect;
			addChild(tip);
			stage.addEventListener(MouseEvent.MIDDLE_CLICK, onMiddleClick);
		}
		
		public function onConfigLoad(ts:TimeSlice):void
		{
			tip.text = "connecting to socket server";
		}
		
		public function onConnect(ts:TimeSlice):void
		{
			tip.text = "connect success";
		}
		
		public function onMiddleClick(e:Event):void
		{
//			$log.error("abc");
//			$log.error("def");
			System.setClipboard($log._errorlog.join("\n"));
		}
	}
}