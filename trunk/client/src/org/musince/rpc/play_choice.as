package org.musince.rpc
{
	import flash.utils.Dictionary;
	
	import slices.BlankTime;
	import slices.FadeInDisplayObject;
	import slices.FadeInTalk;
	import slices.PlayChoice;
	import globals.$athena;
	import globals.$background;
	import globals.$talkPanel;
	import globals.$ui;

	public function play_choice(meta:Dictionary):void
	{
		var play:PlayChoice = new PlayChoice($talkPanel);
		play.input = meta;
		$talkPanel.switchToChoice();
		var speed:Number = 0.1;
		$ui.talkLayer.addChild($talkPanel);
		$athena.addTimeSlice(play);
		if ($background != null && $ui.backgroundLayer.numChildren == 0)
		{
			$background.alpha = 0;
			$ui.backgroundLayer.addChild($background);
			var fadeBack:FadeInDisplayObject = new FadeInDisplayObject($background, speed);
			$athena.addTimeSlice(fadeBack);
		}
	}
}