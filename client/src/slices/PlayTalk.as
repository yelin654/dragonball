package slices
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import slices.TimeSlice;
	import org.musince.data.MetaTalkText;
	import globals.$log;
	
	public class PlayTalk extends TimeSlice
	{
		public var _index:int = 0;
		public var _tf:TextField;
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
				isDone = true;
			}
			else
			{
				_nextTime = _now + nextInterval(_index);
			}
		}
		
		protected function showText(index:int):void
		{
			var filters:Array = _tf.filters;
			_tf.text = _text.substring(0, index + 1);
			_tf.filters = filters;
		}
		
		protected function isLast(index:int):Boolean
		{
			return true;
		}
		
		protected function nextInterval(index:int):int
		{
			return  0;
		}
	}
}