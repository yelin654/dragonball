package org.musince.actions
{
	import org.musince.core.TimeSlice;
	import org.musince.global.$athena;
	import org.musince.global.$ui;
	
	public class FadeOutTalkAndBackground extends TimeSlice
	{
		public var talkFaded:Boolean = false; 
		public var backFaded:Boolean = false;
		public var speed:Number = 0.1;
		
		public function FadeOutTalkAndBackground()
		{
			super();
			
		}
		
		override public function onStart():void
		{
			var fadeTalk:FadeOutDisplayObject = new FadeOutDisplayObject($ui.talkLayer, speed);
			var fadeBack:FadeOutDisplayObject = new FadeOutDisplayObject($ui.backgroundLayer, speed);
			fadeTalk.endHook = onFaded;
			$athena.addTimeSlice(fadeTalk);
		}
		
		private function onFaded(ts:TimeSlice):void
		{
			$ui.talkLayer.removeChildren();
			$ui.backgroundLayer.removeChildren();
			$ui.talkLayer.alpha = 1;
			$ui.backgroundLayer.alpha = 1;
			isEnd = true;
		}
	}
}