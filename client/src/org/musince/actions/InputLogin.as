package org.musince.actions
{
	import com.adobe.utils.StringUtil;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	import org.musince.core.TimeSlice;
	import org.musince.display.LoginPanel;
	import org.musince.global.$athena;
	import org.musince.global.$width;
	import org.musince.util.TextFieldUtil;
	
	public class InputLogin extends TimeSlice
	{
		public var u:TextField;
		public var tip:TextField;
		public var showEnter:PlayTalkAvg;
		
		public function InputLogin(text:TextField, tip:TextField)
		{
			super();
			this.u = text;
			this.tip = tip;
		}
		
		override public function onStart():void
		{
			u.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			u.addEventListener(Event.CHANGE, onInput);
		}
		
		private function onInput(e:Event):void
		{
			var ipt:String = StringUtil.trim(u.text);
			if (ipt == "")
			{
				return;
			}
			if (showEnter == null)
			{
				TextFieldUtil.layCenter($width, tip, "press enter to submit");
				showEnter = new PlayTalkAvg(tip, 60);
				showEnter.input = new Dictionary();
				showEnter.input["text"] = "press enter to submit";
				$athena.addTimeSlice(showEnter);
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			var ipt:String = StringUtil.trim(u.text);
			if (ipt == "")
			{
				return;
			}
			if (e.keyCode == Keyboard.ENTER)
			{
				output = new Dictionary();
				output["u"] = u.text;
				isEnd = true;
			}
		}
		
		override public function onEnd():void
		{
			u.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			u.removeEventListener(Event.CHANGE, onInput);
			trace("input over");
		}
	}
}