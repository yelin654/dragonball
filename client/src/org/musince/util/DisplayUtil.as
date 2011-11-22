package org.musince.util
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;

	public class DisplayUtil
	{
		public function DisplayUtil()
		{
		}
		
		public static function removeChildren(container:DisplayObjectContainer):void
		{
			while (container.numChildren > 0)
			{
				container.removeChildAt(0);
			}
		}
		
		public static function stopAll(mc:DisplayObjectContainer):void
		{
			if (mc is MovieClip)
			{
				(mc as MovieClip).stop();
			}
			var child:DisplayObjectContainer;
			for (var i:int = 0; i < mc.numChildren; i++) 
			{
				child = mc.getChildAt(i) as DisplayObjectContainer;
				if (child != null) 
				{
					stopAll(child);
				}
			}
		}
		
		public static function startAll(mc:DisplayObjectContainer):void
		{
			if(mc is MovieClip)
			{
				(mc as MovieClip).play();
			}
			var child:DisplayObjectContainer;
			for (var i:int = 0; i < mc.numChildren; i++) 
			{
				child = mc.getChildAt(i) as DisplayObjectContainer;
				if (child != null) 
				{
					startAll(child);
				}
			}
		}
		
		public static function nextFrameAll(container:DisplayObjectContainer):void
		{
			var mc:MovieClip = container as MovieClip;
			if (mc != null)
			{
				mc.gotoAndStop(mc.currentFrame % mc.totalFrames + 1);
			}
			var child:DisplayObjectContainer;
			for (var i:int = 0; i < mc.numChildren; i++) 
			{
				child = mc.getChildAt(i) as DisplayObjectContainer;
				if (child != null) 
				{
					nextFrameAll(child);
				}
			}
		}
	}
}