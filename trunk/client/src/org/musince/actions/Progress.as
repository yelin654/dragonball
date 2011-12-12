package org.musince.actions
{
	import org.musince.core.TimeSlice;
	
	public class Progress extends TimeSlice
	{
		public var current:Number = 0;
		private var _speed:Number = 0.02;
		private var _to:Number = 0;
		
		public var onEndHook:Function;
		
		public function Progress()
		{
			super();
		}
		
		public function setNow(v:Number):void
		{
			_to = v;
		}
		
		override public function onUpdate():void
		{
			if (current < _to)
			{
				current = Math.min(current+_speed, _to);
			}
			else
			{
				isEnd = true;
			}
		}
		
		override public function onEnd():void
		{
			trace("progress end");
			if (onEndHook != null)
			{
				onEndHook();
				onEndHook = null;
			}
		}
	}
}