package org.musince.actions
{
	import flash.display.DisplayObject;

	public class FadeOutDisplayObject extends FadeDisplayObject
	{
		public function FadeOutDisplayObject(target:DisplayObject, speed:Number)
		{
			super(target, speed);
		}
		
		override public function onUpdate():void
		{
			target.alpha -= speed;
			if (target.alpha <= 0)
			{
				target.alpha = 0;
				isEnd = true;
			}
		}
	}
}