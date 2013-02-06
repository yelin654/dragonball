package org.musince.core
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import globals.$athena;
	import globals.$log;
	
	import slices.FadeStopSound;
	import slices.StartSound;
	import slices.TimeSlice;

	public class BGMPlayer
	{
		public var playing:SoundChannel;
		
		public var pending:Sound;
		
		public function BGMPlayer()
		{
		}
		
		public function play(sound:Sound):void
		{
			if (playing != null)
			{
				var fade:FadeStopSound = new FadeStopSound(playing);
				fade.endHook = onFadeEnd;
				$athena.addTimeSlice(fade);
				pending = sound;
			}
			else
			{
				_play(sound);
			}
		}
		
		public function _play(sound:Sound):void
		{
			var st:SoundTransform = new SoundTransform();
			playing = sound.play(0, 0, st);
			playing.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		
		public function onSoundComplete(e:Event):void
		{
			if (e.currentTarget == playing)
			{
				playing = null;
			}
		}
		
		public function onFadeEnd(ts:TimeSlice):void
		{
			_play(pending);
			pending = null;
		}
		
		public function stop():void
		{
			if (playing != null) {
				playing = null;
				var fade:FadeStopSound = new FadeStopSound(playing);
			}
		}
	}
}