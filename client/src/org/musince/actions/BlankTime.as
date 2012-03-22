package org.musince.actions
{
	import org.musince.core.TimeSlice;

	public class BlankTime extends TimeSlice
	{
		public var last:int; 
		
		public function BlankTime(last:int = 0)
		{
			this.last = last;
		}
		
		override public function onStart():void
		{
			
		}
		
		override public function onUpdate():void
		{
			last = last - (_now - _then);
			if (last <= 0)
				isEnd = true;
		}
		
		override public function onEnd():void
		{
			output = input;
		}
	}
}