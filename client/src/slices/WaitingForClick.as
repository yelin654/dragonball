package slices
{
	import flash.events.MouseEvent;
	
	import slices.TimeSlice;
	import org.musince.core.UIAction;
	import org.musince.display.UI;
	import globals.$athena;
	import globals.$clickIcon;
	import globals.$playClickIcon;
	import globals.$sender;
	import globals.$ui;
	
	public class WaitingForClick extends TimeSlice
	{
		public function WaitingForClick()
		{
			super();
		}
		
		override public function onStart():void
		{
			$ui.clickIconLayer.addChild($clickIcon);
			$playClickIcon.icon = $clickIcon;
			$athena.addTimeSlice($playClickIcon);
			globalMouseClick = onClick;
		}
		
		public function onClick(e:MouseEvent):void
		{
			var ui:UI = $ui;
			$playClickIcon.isDone = true;
			$ui.clickIconLayer.removeChild($clickIcon);			
			isDone = true;
		}			
	}
}