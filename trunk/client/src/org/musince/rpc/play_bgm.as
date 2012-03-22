package org.musince.rpc
{
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	import org.musince.global.$bgmPlayer;
	import org.musince.global.$chapterResource;

	public function play_bgm(meta:Dictionary):void
	{
		var sound:Sound = $chapterResource.sound[meta.rid] as Sound;
		$bgmPlayer.play(sound);
	}
}