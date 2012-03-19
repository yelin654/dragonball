package org.musince.core
{

	public class UIMainActionQueue
	{
		public var queue:Array = new Array(); 
		
		public function UIMainActionQueue()
		{
		}
		
		public function push(action:TimeSlice):void
		{
			action.endHook = onEnd;
			queue.push(action);
		}
		
		public function onEnd(action:TimeSlice):void
		{
			
		}
	}
}