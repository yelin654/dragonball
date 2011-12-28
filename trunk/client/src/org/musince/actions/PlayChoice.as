package org.musince.actions
{
	import flash.text.TextField;
	
	import org.musince.core.TimeSlice;
	import org.musince.display.TalkPanel;
	
	public class PlayChoice extends TimeSlice
	{
		private var _panel:TalkPanel; 
		
		private var _speed:Number = 0.1;
		
		public function PlayChoice(panel:TalkPanel)
		{
			super();
			_panel = panel;
		}
		
		override public function onStart():void
		{
			var texts:Array = input as Array;
			var tfs:Vector.<TextField> = _panel.createChoice(texts);
			for each (var tf:TextField in tfs)
			{
				tf.alpha = 0;
			}
		}
		
		override public function onUpdate():void
		{
			for each (var tf:TextField in _panel.choices)
			{
				tf.alpha = Math.min(tf.alpha + _speed, 1);
			}
			
			if (_panel.choices[0].alpha >= 1)
			{
				isEnd = true;
			}
		}
		
		override public function onEnd():void
		{
			trace("play choice end");
		}
	}
}