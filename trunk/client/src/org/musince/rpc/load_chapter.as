package org.musince.rpc
{
	import org.musince.actions.LoadChapterResource;
	import org.musince.global.$athena;
	
	public function load_chapter(idx:int):void
	{
		var load:LoadChapterResource = new LoadChapterResource();
		load.input["chapter"] = idx;
		$athena.addTimeSlice(load);
	}
	
}