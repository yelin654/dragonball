package org.musince.actions
{
	import flash.display.DisplayObject;
	
	import org.musince.core.TimeSlice;
	import org.musince.global.$athena;
	
	public class FadeInOutDisplayObject extends TimeSlice
	{
		public var target:DisplayObject;
		public var speed:Number;
		public var stay:int;
		public var fin:FadeInDisplayObject;
		public var fout:FadeOutDisplayObject;
		public var blank:BlankTime;

		public function FadeInOutDisplayObject(target:DisplayObject, speed:Number, stay:int=0)
		{
			this.target = target;
			this.speed = speed;
			this.stay = stay;
		}
		
		override public function onStart():void
		{
			fin = new FadeInDisplayObject(target, speed);
			blank = new BlankTime(stay);
			fout = new FadeOutDisplayObject(target, speed);
			fin.appendNext(blank);
			blank.appendNext(fout);
			fout.endHook = onFadeEnd;
			$athena.addTimeSlice(fin);			
		}
		
		private function onFadeEnd(t:TimeSlice):void
		{
			trace("fade in out over");
			isEnd = true;
		}

	}
}