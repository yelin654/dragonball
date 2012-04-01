package org.musince.actions
{
	import org.musince.core.TimeSlice;
	import org.musince.global.$athena;
	
	public class Info extends TimeSlice
	{
		public function Info()
		{
			super();
		}
		
		override public function onStart():void
		{
			var g:PlayGuideText = new PlayGuideText(["请戴上耳机或打开音箱"], 0.02);
			g.endHook = onGuideEnd;
			$athena.addTimeSlice(g);
		}
		
		public function onGuideEnd(ts:TimeSlice):void
		{
			isEnd = true;
		}
	}
}