package org.musince.actions
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	import org.musince.core.TimeSlice;
	import org.musince.data.MetaTalk;
	
	public class PlayTalk extends TimeSlice
	{
		private var _data:MetaTalk;
		private var _index:int = 0;
		private var _tf:TextField;
		private var _nextTime:int;
		
		public function PlayTalk(tf:TextField, data:MetaTalk)
		{
			super();
			_tf = tf;
			_data = data;
		}
		
		override public function onStart():void
		{
			_nextTime = _now + _data.interval[0];
			showNextChar();
		}
		
		override public function onUpdate():void
		{
			if (_nextTime <= _now)
			{
				_index++;
				_tf.text = _data.text.substring(0, _index + 1);
				if (_index == _data.interval.length)
					isEnd = true;
				else
					_nextTime = _now + _data.interval[_index];
			}
		}
		
		private function showNextChar():void
		{			

		}
	}
}