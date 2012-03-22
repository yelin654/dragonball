package test
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.musince.actions.MoveTo;
	import org.musince.display.ClickIcon;
	import org.musince.global.$athena;
	import org.musince.global.$playClickIcon;
	
	[SWF(width='1280',height='720', backgroundColor='0x000000')]
	public class TestClickIcon extends Sprite
	{
		public function TestClickIcon()
		{			
			super();
			var icon:ClickIcon = new ClickIcon;
			icon.x = 1200;
			icon.y = 650;
			addChild(icon);
			
			$athena.start(stage);
			stage.color = 0x000000;
			
			$playClickIcon.icon = icon;
			$athena.addTimeSlice($playClickIcon);
			
			stage.addEventListener(MouseEvent.RIGHT_CLICK, onRightClick);
			
//			var s:Number = 1;
//			var moveUp:MoveTo = new MoveTo(icon.top, icon.top.x, 
//				-icon.w/4, s);
//			var moveDown:MoveTo = new MoveTo(icon.top, icon.top.x, 
//				0, s);
//			moveUp.appendNext(moveDown);
//			moveDown.appendNext(moveUp);
//			$athena.addTimeSlice(moveUp);
//			
//			moveUp.traceT = false;
//			moveDown.traceT = false; 
//			moveUp.interval = 2;
//			moveDown.interval = 2;
			
//			var moveTo:MoveTo = new MoveTo(icon, 600, 400, 2);
//			$athena.addTimeSlice(moveTo);
		}
		
		private function onRightClick(e:MouseEvent):void
		{
//			new TLF
		}
	}
}