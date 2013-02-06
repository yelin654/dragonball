package slices
{
	import flash.display.MovieClip;
	
	import slices.TimeSlice;
	import org.musince.display.ClickIcon;
	import globals.$athena;
	
	public class PlayClickIcon extends TimeSlice
	{
		public var icon:ClickIcon;
		
		public var moveUp:MoveTo;
		
		public var moveDown:MoveTo;
		
		public var fadeIn:FadeInDisplayObject;
		
		public function PlayClickIcon()
		{
			super();
		}
		
		override public function onStart():void
		{
			icon.resetPosition();
			icon.alpha = 0;
			fadeIn = new FadeInDisplayObject(icon, 0.1);
			var s:Number = 1;
			moveUp = new MoveTo(icon.top, icon.top.x, 
				-icon.w/4, s);
			moveDown = new MoveTo(icon.top, icon.top.x, 
				0, s);

			moveUp.appendNext(moveDown);
			moveDown.appendNext(moveUp);
			
			moveUp.logLevel = 0;
			moveDown.logLevel = 0;
			moveUp.interval = 3;
			moveDown.interval = 3;

			$athena.addTimeSlice(fadeIn);
			$athena.addTimeSlice(moveUp);
		}
		
		override public function onEnd():void
		{
			moveUp.removeNext(moveDown);
			moveDown.removeNext(moveUp);
			moveUp.isDone = true;
			moveDown.isDone = true;
			moveUp = null;
			moveDown = null;
		}
	}
}