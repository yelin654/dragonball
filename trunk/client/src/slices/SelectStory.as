package slices
{
	import flash.events.MouseEvent;
	
	import slices.TimeSlice;
	import org.musince.display.StoryList;
	import globals.$athena;
	
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
				list.focusPre();
			}
			else
			{
				list.focusNext();
			}
		}
		
		public function onMouseDown(e:MouseEvent):void
		{
			list.enter();
			isDone = true;
			var sp:SelectProgress = new SelectProgress(list.selectingItem, list);
			sp.appendNext(this);
			$athena.addTimeSlice(sp);
		}
	}
}