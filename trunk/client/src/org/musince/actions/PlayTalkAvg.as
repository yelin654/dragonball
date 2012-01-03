package org.musince.actions
{
	import flash.text.TextField;
	
	import org.musince.core.TimeSlice;
	import org.musince.data.MetaTalkText;
	
	public class PlayTalkAvg extends PlayTalk
	{
		public static const DEFAULT_INTERVAL:int = 200; 
		
		private var _max:int; 
		private var _speed:int;
		
		public function PlayTalkAvg(tf:TextField, interval:int=DEFAULT_INTERVAL)
		{
			super(tf);
			_speed = interval;
		}
		
		override public function onStart():void
		{
			_text = input["text"] as String;
			_max = _text.length - 1;
			super.onStart();
		}
		
		override protected function isLast(index:int):Boolean
		{
			return index == _max;
		}
		
		override protected function nextInterval(index:int):int
		{
			return _speed;
		}
		
	}
}