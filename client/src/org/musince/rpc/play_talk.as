package org.musince.rpc
{
	import flash.filters.GlowFilter;
	import flash.utils.Dictionary;
	
	import flashx.textLayout.formats.BackgroundColor;
	
	import slices.BlankTime;
	import slices.FadeInDisplayObject;
	import slices.FadeInTalk;
	import slices.PlayTalk;
	import slices.PlayTalkAvg;
	import slices.SendLuaRPC;
	import slices.WaitingForClick;
	import globals.$athena;
	import globals.$background;
	import globals.$colorMap;
	import globals.$log;
	import globals.$talkPanel;
	import globals.$ui;

	public function play_talk(talk:Dictionary):void
	{
		var play:PlayTalk = new PlayTalkAvg($talkPanel.talkText);
		play.input = talk;
		var rpc:SendLuaRPC = new SendLuaRPC("next_main_action", null);
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