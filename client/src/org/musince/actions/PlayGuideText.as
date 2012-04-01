package org.musince.actions
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.musince.core.TimeSlice;
	import org.musince.core.UIAction;
	import org.musince.global.$athena;
	import org.musince.global.$guideText;
	import org.musince.global.$sender;
	import org.musince.global.$ui;
	
	public class PlayGuideText extends TimeSlice
	{
		public var texts:Array;
		public var fadeInOut:FadeInOutDisplayObject;
		public var fadeIn:FadeInDisplayObject;
		public var speed:Number;
		public var stay:int;
		
		public function PlayGuideText(texts:Array, speed:Number=0.05, stay:int=1000)
		{
			super();
			this.texts = texts;
			this.speed = speed;
			this.stay = stay;
		}
		
		override public function onStart():void
		{
			$ui.guideLayer.addChild($guideText);
			fadeInOut = new FadeInOutDisplayObject($guideText, speed, stay);
			fadeInOut.endHook = onInOutEnd;
			fadeIn = new FadeInDisplayObject($guideText, speed);
			showNext();
		}
		
		private function onInOutEnd(t:TimeSlice):void
		{
			showNext();
		}
		
		private function showNext():void
		{
			$guideText.alpha = 0;
			$guideText.text = texts[0];
			if (texts.length == 1)
			{
				$athena.addTimeSlice(fadeIn);
				fadeIn.endHook = onPlayOver;
			}
			else
			{
				$athena.addTimeSlice(fadeInOut);
			}
			texts.shift();
		}
		
		private function onPlayOver(t:TimeSlice):void
		{
			var click:WaitingForClick = new WaitingForClick();
			click.endHook = onClick;
			$athena.addTimeSlice(click);
		}
		
		public function onClick(ts:TimeSlice):void
		{
			$ui.guideLayer.removeChildren();
			isEnd = true;
		}
	}
}