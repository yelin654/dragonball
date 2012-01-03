package org.musince.actions
{
	import flash.display.DisplayObject;
	
	import org.musince.core.TimeSlice;
	
	public class AlphaFadeIn extends TimeSlice
	{
		public var target:DisplayObject;
		public var speed:Number;
		
		public function AlphaFadeIn(target:DisplayObject, speed:Number=0.05)
		{
			super();
			this.target = target;
			this.speed = speed;
		}
		
		override public function onStart():void
		{
			target.alpha = 0;
		}
		
		override public function onUpdate():void
		{
			target.alpha = (target.alpha + speed);
			if (target.alpha >= 1)
			{
				target.alpha = 1;
				isEnd = true;
			}
		}
		
		override public function onEnd():void
		{
			
		}
	}
}