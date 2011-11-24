package org.musince.actions
{
	import flash.text.TextField;
	
	import org.musince.core.TimeSlice;
	import org.musince.data.MetaTalkText;
	
	public class PlayTalkAvg extends PlayTalk
	{
		private var _max:int; 
		
		public function PlayTalkAvg(tf:TextField)
		{
			super(tf);
		}
		
		override public function onStart():void
		{
			_text = input as String;
			_max = _text.length - 1;
			super.onStart();
		}
		
		override protected function isLast(index:int):Boolean
		{
			return index == _max;
		}
		
		override protected function nextInterval(index:int):int
		{
			return MetaTalkText.DEFAULT_INTERVAL;
		}
		
	}
}