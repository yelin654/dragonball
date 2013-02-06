package slices
{
	import flash.display.MovieClip;
	
	import slices.TimeSlice;
	import utils.DisplayUtil;

	public class PlayMovieClip extends TimeSlice
	{
		private var _mc:MovieClip; 
		
		public function PlayMovieClip(mc:MovieClip)
		{
			_mc = mc;
			
		}
		
		override public function onStart():void
		{
			
		}
		
		override public function onUpdate():void
		{
			DisplayUtil.nextFrameAll(_mc);
		}
	}
}