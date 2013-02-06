package org.musince.rpc
{
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	import globals.$chapterResource;
	import globals.$soundManager;

	public function play_sound(meta:Dictionary):void
	{
		var sound:Sound = $chapterResource.sound[meta.rid] as Sound;
		$soundManager.playBGM(meta.rid, sound);
	}
}