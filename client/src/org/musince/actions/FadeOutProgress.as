package org.musince.actions
{
	import flash.display.Sprite;
	
	import org.musince.core.TimeSlice;
	
	public class FadeOutProgress extends TimeSlice
	{
		private var _progress:Sprite;
		private var _speed:Number = 0.05;
		
		public function FadeOutProgress(progress:Sprite)
		{
			super();
			_progress = progress;
		}
		
		override public function onUpdate():void
		{
			_progress.alpha -= _speed;
			if (_progress.alpha <= 0)
			{
				_progress.alpha = 0;
				isEnd = true;
			}
		}
		
		
	}
}