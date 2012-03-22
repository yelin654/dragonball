package org.musince.actions
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import mx.messaging.Channel;
	
	import org.musince.core.TimeSlice;
	import org.musince.global.$soundManager;
	
	public class StartSound extends TimeSlice
	{
		public var sound:Sound;
		public var channel:SoundChannel;
		
		public function StartSound(sound:Sound)
		{
			super();
			this.sound = sound;
		}
		
		override public function onStart():void
		{
			channel = sound.play();
			isEnd = true;
		}
		
		
	}
}