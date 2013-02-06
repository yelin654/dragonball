package org.musince.rpc
{
	import slices.FadeOutTalkAndBackground;
	import slices.LoadChapterResource;
	import globals.$athena;
	import globals.$ui;
	
	public function load_chapter(idx:int):void
	{

		var load:LoadChapterResource = new LoadChapterResource();
		load.input["chapter"] = idx;
		$athena.addTimeSlice(load);
		
		if ($ui.backgroundLayer.numChildren != 0 || $ui.talkLayer.numChildren != 0)
		{			
			var fade:FadeOutTalkAndBackground = new FadeOutTalkAndBackground();
			$athena.addTimeSlice(fade);
		}

	}
	
}