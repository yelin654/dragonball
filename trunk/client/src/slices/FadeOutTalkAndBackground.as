package slices
{
	import globals.$athena;
	import globals.$background;
	import globals.$talkPanel;
	import globals.$ui;
	
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
			isDone = true;
		}
	}
}