package org.musince.sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	
	import org.musince.actions.FadeStopSound;
	import org.musince.global.$log;

	public class SoundManager
	{
		public var playingBGM:SoundChannel;
		public var sounds:Dictionary = new Dictionary();
		public var playings:Dictionary = new Dictionary();

		public function SoundManager()
		{
			
		}
		
		public function playBGM(id:Object, sound:Sound, startTime:int=0):void
		{
			if (playingBGM != null)
			{
				playingBGM.stop();
			}
			var st:SoundTransform = new SoundTransform(0.2, 0);
			playingBGM = sound.play(startTime, 0, st);
			playings[id] = playingBGM;
			$log.debug("play sound", id);
		}
		
		public function stop(id:Object):void
		{
			var channel:SoundChannel = playings[id];
			channel.stop();
		}
		
		public function stopAll():void
		{
			if (playingBGM != null) {
				playingBGM.stop();
			}
			for each (var channel:SoundChannel in playings) {
				channel.stop();
			}
		}
	}
}