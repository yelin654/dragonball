package org.musince.actions
{
	import org.musince.core.TimeSlice;
	import org.musince.display.TalkPanel;
	
	public class FadeInTalk extends TimeSlice
	{	
		public var panel:TalkPanel;
		
		private var tyEnd:int = 600;
		private var tyStart:int = 600;
		
		public var va:Number = 0.05;
		public var vy:Number = 0.1;
				
		public function FadeInTalk(panel:TalkPanel)
		{
			super();
			this.panel = panel; 
		}
		
		override public function onStart():void
		{
			
		}
		
		override public function onUpdate():void
		{
			var dt:int = _now - _then;
			panel.y += vy * dt;
			panel.alpha = (panel.y-tyStart) / (tyEnd - tyStart);
			if (panel.y <= tyEnd)
			{
				panel.alpha = 1;
				panel.y = tyEnd;
				isEnd = true;
			}
		}
		
		
	}
}