package org.musince.rpc
{
	import flash.utils.Dictionary;
	
	import org.musince.actions.PlayGuideText;
	import org.musince.global.$athena;
	import org.musince.global.$guideText;
	import org.musince.global.$ui;
	import org.musince.util.LuaUtil;

	public function play_guide(guide:Dictionary):void
	{
		var texts:Array = LuaUtil.convertToArray(guide["texts"]);
		var playGuide:PlayGuideText = new PlayGuideText(texts, guide["speed"]/1000, guide["stay"]);
		$ui.guideLayer.addChild($guideText);
		$athena.addTimeSlice(playGuide);
//		playGuide
	}
}