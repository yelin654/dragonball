package org.musince.actions
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	import org.musince.core.TimeSlice;
	import org.musince.data.MetaTalkText;
	import org.musince.global.$log;
	
	public class PlayTalk extends TimeSlice
	{
		private var _data:MetaTalkText;
		private var _index:int = 0;
		private var _tf:TextField;
		private var _nextTime:int;
		
		public function PlayTalk(tf:TextField)
		{
			super();
			_tf = tf;
		}
		
		override public function onStart():void
		{
			_tf.text = "";
			_data = input as MetaTalkText;
			_nextTime = _now + _data.interval[0];
			_tf.text = _data.text.charAt(0);
		}
		
		override public function onUpdate():void
		{
			if (_nextTime > _now)
				return;
			_index++;
			_tf.text = _data.text.substring(0, _index + 1);
			if (_index == _data.interval.length)
				isEnd = true;
			else
				_nextTime = _now + _data.interval[_index];
		}
		
		private function showNextChar():void
		{			

		}
		
		override public function onEnd():void
		{
			trace("play text end");
		}
	}
}