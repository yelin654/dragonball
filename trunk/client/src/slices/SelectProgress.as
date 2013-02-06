package slices
{
	import flash.events.MouseEvent;
	
	import slices.TimeSlice;
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
			if (item.selecting == item.options.length-1)
			{
				onSelectCancel();
				return;
			}
			if (item.selecting == 0)
			{
				onSelectStart();
				return;
			}
			onSelectContinue();
		}
		
		public function onSelectStart():void
		{
			
		}
		
		public function onSelectContinue():void
		{
			
		}
		
		public function onSelectCancel():void
		{
			item.cancel();
			isDone = true;
		}
		
	}
}