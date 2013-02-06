package org.musince.rpc
{
	import slices.FadeInDisplayObject;
	import slices.FadeOutTalkAndBackground;
	import globals.$athena;
	import globals.$guideText;
	import globals.$ui;

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