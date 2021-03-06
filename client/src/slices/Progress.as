package slices
{
	import slices.TimeSlice;
	
	public class Progress extends TimeSlice
	{
		public var current:Number = 0;
		private var _speed:Number = 0.02;
		private var _to:Number = 0;
		
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
			if (current < 1)
			{
				current = Math.min(current+_speed, _to);
//				trace("progress", current);
			}
			else
			{
				isDone = true;
			}
		}
	}
}