package org.musince.actions
{
	import org.musince.core.TimeSlice;
	import org.musince.data.MetaTalkText;
	
	public class LoadMetaStory extends TimeSlice
	{
		public function LoadMetaStory()
		{
			super();
		}
		
		override public function onStart():void
		{
			var meta:MetaTalkText = new MetaTalkText();
			
		}
		
		
	}
}