package org.musince.rpc
{
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	import org.musince.global.$chapterResource;
	import org.musince.global.$soundManager;

	public function play_sound(meta:Dictionary):void
	{
		var sound:Sound = $chapterResource.sound[meta.rid] as Sound;
		$soundManager.playBGM(meta.rid, sound);
	}
}