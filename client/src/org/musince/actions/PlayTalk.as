package org.musince.actions
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	import org.musince.core.TimeSlice;
	import org.musince.data.MetaTalkText;
	import org.musince.global.$log;
	
	public class PlayTalk extends TimeSlice
	{
		private var _index:int = 0;
		private var _tf:TextField;
		private var _nextTime:int;
		protected var _text:String;
		
		public function PlayTalk(tf:TextField)
		{
			super();
			_tf = tf;
		}
		
		override public function onStart():void
		{
			_index = 0;
			showText(_index);
			next();
		}
		
		override public function onUpdate():void
		{
			if (_nextTime > _now) return;
			
			_index++;
			
			showText(_index);
			
			next();

		}
		
		private function next():void
		{
			if (isLast(_index))
			{
				isEnd = true;
			}
			else
			{
				_nextTime = _now + nextInterval(_index);
			}
		}
		
		protected function showText(index:int):void
		{
			_tf.text = _text.substring(0, index + 1);
		}
		
		protected function isLast(index:int):Boolean
		{
			return true;
		}
		
		protected function nextInterval(index:int):int
		{
			return  0;
		}
		
		override public function onEnd():void
		{
			trace("play text end");
		}
	}
}