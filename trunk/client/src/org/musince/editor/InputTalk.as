package org.musince.editor
{
	import com.adobe.utils.StringUtil;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import org.musince.core.TimeSlice;
	import org.musince.data.MetaTalkText;
	import org.musince.global.$log;
	
	public class InputTalk extends TimeSlice
	{
		public var inputText:TextField;
		public var outputText:TextField;
		
		public var meta:MetaTalkText;
		
		private var _last:int;
		
		
		public function InputTalk(input:TextField, output:TextField)
		{
			super();
			inputText = input;
			outputText = output;
		}
		
		override public function onStart():void
		{
			meta = new MetaTalkText();
			_last = 0;
			inputText.addEventListener(KeyboardEvent.KEY_DOWN, onClickEnter);
			outputText.text = "";
		}
		
		public function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.ENTER)
			{
				onClickEnter(e);
			}
			if (e.keyCode == 117)
			{
				onFinish(e);
			}
		}
		
		public function onClickEnter(e:KeyboardEvent):void
		{
			if (StringUtil.trim(inputText.text) != "")
			{
				var str:String = inputText.text;
				var now:int = getTimer();
				meta.interval.push(now-_last);				
				_last = now;
				for (var i:int = 1; i < str.length; i++)
				{
					meta.interval.push(MetaTalkText.DEFAULT_INTERVAL);
				}
				outputText.appendText(inputText.text);
			}
			inputText.text = "";
		}
		
		public function onFinish(e:KeyboardEvent):void
		{
			meta.interval.shift();
			meta.text = outputText.text;
			output = meta;
			isEnd = true;
		}
		
		override public function onEnd():void
		{
			trace("input text end");
		}
	}
}