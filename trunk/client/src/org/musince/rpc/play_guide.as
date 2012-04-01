package org.musince.rpc
{
	import flash.utils.Dictionary;
	
	import org.musince.actions.FadeOutTalkAndBackground;
	import org.musince.actions.PlayGuideText;
	import org.musince.actions.SendRPC;
	import org.musince.global.$athena;
	import org.musince.global.$guideText;
	import org.musince.global.$ui;
	import org.musince.util.LuaUtil;

	public function play_guide(guide:Dictionary):void
	{
		var texts:Array = LuaUtil.convertToArray(guide["texts"]);
		var play:PlayGuideText = new PlayGuideText(texts, guide["speed"]/1000, guide["stay"]);
		var rpc:SendRPC = new SendRPC("next_main_action", []);
		play.appendNext(rpc);
		if ($ui.backgroundLayer.numChildren == 0 && $ui.talkLayer.numChildren == 0)
		{			
			$athena.addTimeSlice(play);
			return;
		}
		trace("hide and play");
		var fade:FadeOutTalkAndBackground = new FadeOutTalkAndBackground();
		fade.appendNext(play);
		$athena.addTimeSlice(fade);
//		playGuide
	}
}