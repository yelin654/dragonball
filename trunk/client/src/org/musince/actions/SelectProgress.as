package org.musince.actions
{
	import flash.events.MouseEvent;
	
	import org.musince.core.TimeSlice;
	import org.musince.display.StoryListItem;
	
	public class SelectProgress extends TimeSlice
	{
		public var item:StoryListItem; 
		
		public function SelectProgress()
		{
			super();
		}
		
		override public function onStart():void
		{
			globalMouseWheel = onMouseWheel;
			globalMouseDown = onMouseDown;
		}
		
		public function onMouseWheel(e:MouseEvent):void
		{
			if (e.delta > 0)
			{
				item;
			}
			else
			{
				item;
			}
		}
		
		public function onMouseDown(e:MouseEvent):void
		{
			item;
		}
	}
}