package org.musince.rpc
{
	import flash.filters.GlowFilter;
	import flash.utils.Dictionary;
	
	import flashx.textLayout.formats.BackgroundColor;
	
	import org.musince.actions.BlankTime;
	import org.musince.actions.FadeInDisplayObject;
	import org.musince.actions.FadeInTalk;
	import org.musince.actions.PlayTalk;
	import org.musince.actions.PlayTalkAvg;
	import org.musince.actions.SendRPC;
	import org.musince.actions.WaitingForClick;
	import org.musince.global.$athena;
	import org.musince.global.$background;
	import org.musince.global.$colorMap;
	import org.musince.global.$log;
	import org.musince.global.$talkPanel;
	import org.musince.global.$ui;

	public function play_talk(talk:Dictionary):void
	{
		var play:PlayTalk = new PlayTalkAvg($talkPanel.talkText);
		play.input = talk;
		var rpc:SendRPC = new SendRPC("next_main_action", null);
		var click:WaitingForClick = new WaitingForClick();
		play.appendNext(click);
		click.appendNext(rpc);
		$talkPanel.clearTalk();
		$talkPanel.switchToTalk();
		$talkPanel.setFromName(talk.from);
		$talkPanel.setThoughName(talk.though);
		if (null != $colorMap.map[talk.from])
		{
			$talkPanel.talkText.filters = [new GlowFilter($colorMap.map[talk.from], 1, 5, 5, 5)];
		}
		else
		{
			$talkPanel.talkText.filters = null;
		}
		var speed:Number = 0.05;
		if ($ui.talkLayer.contains($talkPanel))
		{
			$athena.addTimeSlice(play);
		}
		else
		{
			$talkPanel.alpha = 0;
			$ui.talkLayer.addChild($talkPanel);
			var fade:FadeInDisplayObject = new FadeInDisplayObject($talkPanel, speed);
			var blank:BlankTime = new BlankTime();
			blank.last = 200;
			fade.appendNext(blank);
			blank.appendNext(play);
			$athena.addTimeSlice(fade);
		}
		if ($background != null && $ui.backgroundLayer.numChildren == 0)
		{
			trace("fade in background");
			$background.alpha = 0;
			trace($ui.backgroundLayer.alpha);
			$ui.backgroundLayer.addChild($background);
			var fadeBack:FadeInDisplayObject = new FadeInDisplayObject($background, speed);
			$athena.addTimeSlice(fadeBack);
		}
//		$log.debug("[talk]", text.from+":", text.text);
//		var rpc:SendRPC = new SendRPC("next_main_action", null);
//		var click:WaitingForClick = new WaitingForClick();
//		click.appendNext(rpc);
//		$athena.addTimeSlice(click);
	}
}