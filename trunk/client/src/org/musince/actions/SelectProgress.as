package org.musince.actions
{
	import flash.events.MouseEvent;
	
	import org.musince.core.TimeSlice;
	import org.musince.display.StoryList;
	import org.musince.display.StoryListItem;
	
	public class SelectProgress extends TimeSlice
	{
		public var item:StoryListItem;
		public var list:StoryList;

		public function SelectProgress(item:StoryListItem, list:StoryList)
		{
			super();
			this.item = item;
			this.list =  list;
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
				item.selectUp();
			}
			else
			{
				item.selectDown();
			}
		}
		
		public function onMouseDown(e:MouseEvent):void
		{
			this["onSelect"+item.selecting]();
//			isEnd = true;
		}
		
		public function onSelect0():void
		{
			
		}
		
		public function onSelect1():void
		{
			
		}
		
		public function onSelect2():void
		{
			
		}
		
	}
}