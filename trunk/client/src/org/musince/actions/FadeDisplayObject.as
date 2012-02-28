package org.musince.actions
{
	import flash.display.DisplayObject;
	
	import org.musince.core.TimeSlice;

	public class FadeDisplayObject extends TimeSlice
	{
		public var speed:Number;
		public var target:DisplayObject;
		
		public function FadeDisplayObject(target:DisplayObject, speed:Number)
		{
			this.target = target;
			this.speed = speed;
		}
		
		
	}
}