package org.musince.actions
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import org.musince.core.TimeSlice;
	import org.musince.data.MetaTalkText;
	import org.musince.global.$athena;
	import org.musince.global.$sender;
	
	public class PlayTalkAvg extends PlayTalk
	{
		public static const DEFAULT_INTERVAL:int = 60; 
		
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
			globalMouseClick = onMouseClick;
		}
		
		public function onMouseClick(e:MouseEvent):void
		{
			_index = _max - 1;
		}
		
		override protected function isLast(index:int):Boolean
		{
			return index >= _max;
		}
		
		override protected function nextInterval(index:int):int
		{
			return _speed;
		}
		
		
	}
}