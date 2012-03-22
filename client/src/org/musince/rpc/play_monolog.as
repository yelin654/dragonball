package org.musince.rpc
{
	import flash.utils.Dictionary;
	
	import org.musince.actions.FadeOutDisplayObject;
	import org.musince.actions.FadeOutTalkAndBackground;
	import org.musince.actions.PlayGuideText;
	import org.musince.actions.PlayMonolog;
	import org.musince.global.$athena;
	import org.musince.global.$guideText;
	import org.musince.global.$ui;
	import org.musince.util.LuaUtil;

	public function play_monolog(mono:Dictionary):void
	{
		var texts:Array = LuaUtil.convertToArray(mono["texts"]);
		$ui.monoLayer.removeChildren();
		var play:PlayMonolog = new PlayMonolog($ui.monoLayer, texts);
		if ($ui.backgroundLayer.numChildren == 0 && $ui.talkLayer.numChildren == 0)
		{
			$athena.addTimeSlice(play);
			return;
		}
		var fade:FadeOutTalkAndBackground = new FadeOutTalkAndBackground();
		fade.appendNext(play);
		$athena.addTimeSlice(fade);
	}
}