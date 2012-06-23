package org.musince.rpc
{
	import org.musince.actions.FadeOutTalkAndBackground;
	import org.musince.actions.LoadChapterResource;
	import org.musince.global.$athena;
	import org.musince.global.$ui;
	
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