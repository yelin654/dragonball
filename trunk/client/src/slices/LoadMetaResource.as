package slices
{
	import slices.TimeSlice;
	import globals.$loadManager;
	
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