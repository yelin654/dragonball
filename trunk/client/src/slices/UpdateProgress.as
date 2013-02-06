package slices
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import slices.TimeSlice;
	import org.musince.display.ProgressPanel;
	import globals.$root;
	import org.musince.util.TextFieldUtil;
	
	public class UpdateProgress extends TimeSlice
	{
		private var _progress:Progress;
		public var progressPanel:ProgressPanel;
		
		public function UpdateProgress(progress:Progress, ui:ProgressPanel)
		{
			super();
			_progress = progress;
			progressPanel = ui;
			_progress.endHook = onComplete;
		}
		
		override public function onUpdate():void
		{
			progressPanel.update(_progress.current);
		}
		
		private function onComplete(ts:TimeSlice):void
		{
			isDone = true;
		}
	}
}