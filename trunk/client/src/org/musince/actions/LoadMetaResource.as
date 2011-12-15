package org.musince.actions
{
	import org.musince.core.TimeSlice;
	import org.musince.global.$loadManager;
	
	public class LoadMetaResource extends TimeSlice
	{
		public function LoadMetaResource()
		{
			super();
		}
		
		override public function onStart():void
		{
			var url:String = input as String;
		}
		
		
	}
}