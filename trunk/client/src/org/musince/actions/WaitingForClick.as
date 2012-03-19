package org.musince.actions
{
	import flash.events.MouseEvent;
	
	import org.musince.core.TimeSlice;
	import org.musince.core.UIAction;
	import org.musince.global.$athena;
	import org.musince.global.$clickIcon;
	import org.musince.global.$playClickIcon;
	import org.musince.global.$sender;
	import org.musince.global.$ui;
	
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
			$playClickIcon.isEnd = true;
			$ui.clickIconLayer.removeChild($clickIcon);			
			isEnd = true;
		}			
	}
}