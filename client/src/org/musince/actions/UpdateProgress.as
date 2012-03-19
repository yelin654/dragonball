package org.musince.actions
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.musince.core.TimeSlice;
	import org.musince.display.ProgressPanel;
	import org.musince.global.$root;
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
		}
		
		override public function onUpdate():void
		{
			progressPanel.update(_progress.current);
		}
	}
}