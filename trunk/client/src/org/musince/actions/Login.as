package org.musince.actions
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import org.musince.core.TimeSlice;
	import org.musince.display.LoginPanel;
	import org.musince.global.$athena;
	import org.musince.global.$config;
	import org.musince.global.$cookie;
	import org.musince.global.$log;
	import org.musince.global.$root;
	import org.musince.global.$syner;
	import org.musince.load.SimpleLoader;
	
	public class Login extends TimeSlice 
	{
		public var panel:LoginPanel;
		
		public function Login()
		{
			super();
		}
		
		override public function onStart():void
		{
			var name:String = $cookie.get("u") as String;
			if (name != null) {
				var query:LoginQuery = new LoginQuery();
				query.endHook = onQueryEnd;
				$athena.addTimeSlice(query);
			} else {
				panel = new LoginPanel();
				fadeIn();
			}
		}
		
		public function fadeIn():void
		{
			var inputName:InputLogin = new InputLogin(panel.u, panel.tip);
			var graphics:Graphics = panel.graphics;
			graphics.lineStyle(2, 0xFFFFFF);
			var drawline:DrawLine = new DrawLine(graphics, 0.04, {t:2, c:0xFFFFFF});
			drawline.input["from"] = new Point(int(panel.w/3), int(panel.h/2));
			drawline.input["to"] = new Point(int(panel.w-panel.w/3), int(panel.h/2));
			var playText:PlayTalkAvg = new PlayTalkAvg(panel.tip, 100);
			playText.input["text"] = "input login name";
			var query:LoginQuery = new LoginQuery();
			query.endHook = onQueryEnd;
			drawline.appendNext(playText);
			playText.appendNext(inputName);
			inputName.appendNext(query);
			$athena.addTimeSlice(drawline);
			$root.stage.focus = panel.u;
		}
		
		public function onQueryEnd(ts:TimeSlice):void
		{
			isEnd = true;
			appendNext(new GetGameProgress());
		}
	}
}