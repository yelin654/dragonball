package org.musince.rpc
{
	import flash.utils.Dictionary;
	
	import org.musince.actions.BlankTime;
	import org.musince.actions.FadeInDisplayObject;
	import org.musince.actions.FadeInTalk;
	import org.musince.actions.PlayChoice;
	import org.musince.global.$athena;
	import org.musince.global.$background;
	import org.musince.global.$talkPanel;
	import org.musince.global.$ui;

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