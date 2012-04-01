package org.musince.actions
{
	import org.musince.core.TimeSlice;
	import org.musince.global.$athena;
	import org.musince.global.$background;
	import org.musince.global.$talkPanel;
	import org.musince.global.$ui;
	
	public class FadeOutTalkAndBackground extends TimeSlice
	{
		public var talkFaded:Boolean = false; 
		public var backFaded:Boolean = false;
		public var speed:Number = 0.05;
		
		public function FadeOutTalkAndBackground()
		{
			super();
			
		}
		
		override public function onStart():void
		{
			var fadeTalk:FadeOutDisplayObject = new FadeOutDisplayObject($talkPanel, speed);
			$athena.addTimeSlice(fadeTalk);
			fadeTalk.endHook = onFaded;
			if ($background != null) {
				var fadeBack:FadeOutDisplayObject = new FadeOutDisplayObject($background, speed);
				$athena.addTimeSlice(fadeBack);
			}
		}
		
		private function onFaded(ts:TimeSlice):void
		{
			$ui.talkLayer.removeChildren();
			$ui.backgroundLayer.removeChildren();
			isEnd = true;
		}
	}
}