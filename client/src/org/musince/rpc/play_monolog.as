package org.musince.rpc
{
	import flash.utils.Dictionary;
	
	import org.musince.actions.PlayGuideText;
	import org.musince.global.$athena;
	import org.musince.global.$guideText;
	import org.musince.global.$ui;
	import org.musince.util.LuaUtil;

	public function play_monolog(mono:Dictionary):void
	{
		var texts:Array = LuaUtil.convertToArray(mono["texts"]);
		var playGuide:PlayGuideText = new PlayGuideText(texts, 100, 100);
		$ui.contentLayer.addChild($guideText);
		$athena.addTimeSlice(playGuide);
	}
}