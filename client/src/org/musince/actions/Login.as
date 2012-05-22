package org.musince.actions
{
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;
	
	import org.musince.core.TimeSlice;
	import org.musince.display.LoginPanel;
	import org.musince.global.$athena;
	import org.musince.global.$cookie;
	import org.musince.global.$loginName;
	import org.musince.global.$root;
	import org.musince.global.$width;
	import org.musince.query.LoginQuery;
	import org.musince.util.TextFieldUtil;
	
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
			name = null;
			if (name != null) {
				var query:LoginQuery = new LoginQuery();
				query.input["u"] = name;
				query.endHook = onQueryEnd;
				$athena.addTimeSlice(query);
			} else {
				panel = new LoginPanel();
				$root.addChild(panel);
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
			var playText:PlayTalkAvg = new PlayTalkAvg(panel.tip, 60);
			TextFieldUtil.layCenter($width, panel.tip, "input login name");
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
			if (panel != null && $root.contains(panel)) 
			{
				var fade:FadeOutDisplayObject = new FadeOutDisplayObject(panel, 0.05);
				fade.endHook = onLoginFade;
				$athena.addTimeSlice(fade);				
			}
			if (ts.output["r"])
			{
				$loginName = ts.output["u"];
				$cookie.set("u", $loginName);
				isEnd = true;
			}
		}
		
		private function onLoginFade(ts:TimeSlice):void
		{
			if ($root.contains(panel))
				$root.removeChild(panel);
		}
	}
}