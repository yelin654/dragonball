package org.musince.rpc
{
	import org.musince.actions.FadeInDisplayObject;
	import org.musince.actions.FadeOutTalkAndBackground;
	import org.musince.global.$athena;
	import org.musince.global.$guideText;
	import org.musince.global.$ui;

	public function tip_end(content:String):void
	{
		$guideText.text = content;
		$ui.guideLayer.addChild($guideText);
		$guideText.alpha = 0
		var fadeIn:FadeInDisplayObject = new FadeInDisplayObject($guideText, 0.05);
		$athena.addTimeSlice(fadeIn);
		if ($ui.backgroundLayer.numChildren != 0 || $ui.talkLayer.numChildren != 0)
		{			
			var fade:FadeOutTalkAndBackground = new FadeOutTalkAndBackground();
			$athena.addTimeSlice(fade);
		}
	}
}