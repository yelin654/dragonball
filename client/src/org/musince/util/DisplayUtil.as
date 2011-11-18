package org.musince.util
{
	import flash.display.DisplayObjectContainer;

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
	}
}