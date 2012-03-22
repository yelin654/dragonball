package org.musince.rpc
{
	import flash.utils.Dictionary;
	
	import org.musince.actions.BlankTime;
	import org.musince.actions.FadeInTalk;
	import org.musince.actions.PlayTalk;
	import org.musince.actions.PlayTalkAvg;
	import org.musince.actions.SendRPC;
	import org.musince.actions.WaitingForClick;
	import org.musince.global.$athena;
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
		$talkPanel.setFromName(talk.from);
		$talkPanel.setThoughName("");
		if ($ui.talkLayer.contains($talkPanel))
		{
			$athena.addTimeSlice(play);
		}
		else
		{
			$talkPanel.alpha = 0;
			$ui.talkLayer.addChild($talkPanel);
			var fade:FadeInTalk = new FadeInTalk($talkPanel);
			var blank:BlankTime = new BlankTime();
			blank.last = 500;
			fade.appendNext(blank);
			blank.appendNext(play);
			$athena.addTimeSlice(fade);
		}
//		$log.debug("[talk]", text.from+":", text.text);
//		var rpc:SendRPC = new SendRPC("next_main_action", null);
//		var click:WaitingForClick = new WaitingForClick();
//		click.appendNext(rpc);
//		$athena.addTimeSlice(click);
	}
}