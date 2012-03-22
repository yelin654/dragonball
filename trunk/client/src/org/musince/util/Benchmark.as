package org.musince.util
{
	import flash.utils.Dictionary;
	
	import org.musince.core.TimeSlice;
	import org.musince.global.$athena;
	import org.musince.global.$log;

	public class Benchmark
	{
		public function Benchmark()
		{
		}
		
		public function traceActiveSlice():void
		{
			var slices:Dictionary = $athena.getActiveSlice();
			$log.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>ACTIVE SLICES");
			for each (var slice:TimeSlice in slices) 
			{
				$log.debug(slice.toString());
			}
			$log.debug("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<ACTIVE SLICES");
		}
	}
}