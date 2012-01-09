package org.musince.actions
{
	import flash.events.MouseEvent;
	
	import org.musince.core.TimeSlice;
	import org.musince.display.StoryList;
	
	public class SelectStory extends TimeSlice
	{
		public var list:StoryList; 
		
		public function SelectStory(list:StoryList)
		{
			super();
			this.list = list;
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
				list.focusUp();
			}
			else
			{
				list.focusDown();
			}
		}
		
		public function onMouseDown(e:MouseEvent):void
		{
			list.enter();
			isEnd = true;
			appendNext(new SelectProgress(list.selectingItem, list)); 
		}
	}
}