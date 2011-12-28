package org.musince.actions
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.musince.core.TimeSlice;
	import org.musince.global.$config;
	import org.musince.global.$cookie;
	import org.musince.global.$log;
	import org.musince.global.$root;
	import org.musince.global.$syner;
	import org.musince.load.SimpleLoader;
	
	public class Login extends TimeSlice 
	{
		private var _loader:SimpleLoader = new SimpleLoader();
		private var _mc:MovieClip;
		
		public function Login()
		{
			super();
		}
		
		override public function onStart():void
		{
			var name:String = $cookie.get("u") as String;
			if (name != null) {
				send(name);
			} else {
				_loader.load($config.ResourceRoot+"login.swf", onLoaded);
			}
		}
		
		override public function onUpdate():void
		{
			
		}
		
		override public function onEnd():void
		{
			
		}
		
		private function onLoaded(content:MovieClip):void 
		{
			_mc = content;
			_mc.txt_name.addEventListener(KeyboardEvent.KEY_DOWN, onEnterDown);
			$root.addChild(_mc);
			_loader = null;
		}
		
		private function onEnterDown(e:KeyboardEvent):void
		{	
			if (e.keyCode != Keyboard.ENTER) return;
			$cookie.set("u", _mc.txt_name.text);
			send(_mc.txt_name.text);
			_mc.txt_name.selectable = false;
		}
		
		private function send(name:String):void
		{
			$syner.rpc(["LoginService"], "login", [name]);
		}
		
		public function login_r(result:int):void
		{
			$log.debug("login result:", result);
		}
	}
}