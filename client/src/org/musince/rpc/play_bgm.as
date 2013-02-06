package org.musince.rpc
{
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	import globals.$bgmPlayer;
	import globals.$chapterResource;

	public function play_bgm(rid:int):void
	{
		var sound:Sound = $chapterResource.sound[rid] as Sound;
		$bgmPlayer.play(sound);
	}
}