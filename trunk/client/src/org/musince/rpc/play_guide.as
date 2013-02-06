package org.musince.rpc
{
	import flash.utils.Dictionary;
	
	import slices.FadeOutTalkAndBackground;
	import slices.PlayGuideText;
	import slices.SendLuaRPC;
	import globals.$athena;
	import globals.$guideText;
	import globals.$ui;
	import org.musince.util.LuaUtil;

	public function play_guide(guide:Dictionary):void
	{
		var texts:Array = LuaUtil.convertToArray(guide["texts"]);
		var play:PlayGuideText = new PlayGuideText(texts, guide["speed"]/1000, guide["stay"]);
		var rpc:SendLuaRPC = new SendLuaRPC("next_main_action", []);
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