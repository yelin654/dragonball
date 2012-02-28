package org.musince.actions
{
	import flash.display.DisplayObject;
	
	import org.musince.core.TimeSlice;

	public class FadeInDisplayObject extends FadeDisplayObject
	{
		public function FadeInDisplayObject(target:DisplayObject, speed:Number)
		{
			super(target, speed);
		}
		
		override public function onStart():void
		{
			
		}
		
		override public function onUpdate():void
		{
			target.alpha += speed;
			if (target.alpha >= 1)
			{
				target.alpha = 1;
				isEnd = true;
			}
		}
	}
}