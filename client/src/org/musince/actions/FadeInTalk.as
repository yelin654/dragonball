package org.musince.actions
{
	import org.musince.core.TimeSlice;
	import org.musince.display.TalkPanel;
	
	public class FadeInTalk extends TimeSlice
	{	
		public var panel:TalkPanel;
		
		public var yEnd:int = 520;
		public var yStart:int = 600;
		
		public var va:Number = 0.05;
		public var vy:Number = 0.4;
				
		public function FadeInTalk(panel:TalkPanel)
		{
			super();
			this.panel = panel; 
		}
		
		override public function onStart():void
		{
			panel.y = yStart;
			vy = yStart>yEnd ? -vy:vy;
			trace("start:", _now);
		}
		
		override public function onUpdate():void
		{
			var dt:int = _now - _then;
			panel.y += int(vy * dt);
			panel.alpha = (panel.y-yStart) / (yEnd - yStart);
			trace("now:", _now, "dt:", dt, "  y:", panel.y, "  a:", panel.alpha);
			if (panel.y <= yEnd)
			{
				panel.alpha = 1;
				panel.y = yEnd;
				isEnd = true;
			}
		}
		
		override public function onEnd():void
		{
			output = input;
			trace("fade in talk end");
		}
	}
}