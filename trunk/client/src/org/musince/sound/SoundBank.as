package org.musince.sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;

	public class SoundBank
	{
		private static var _sound:Dictionary = new Dictionary();  
		private static var _playing:Dictionary = new Dictionary()
		
		public function SoundBank()
		{	
		}
		
		public static function add(id:Object, sound:Sound):void
		{
			_sound[id] = sound;
		}
		
		public static function remove(id:Object):void
		{
			delete _sound[id];
			delete _playing[id];
		}
		
		public static function play(id:Object, startTime:Number = 0, loops:int = 0):void
		{
			return;
			var sound:Sound = _sound[id];
			if (sound != null)
			{
				_playing[id] = sound.play(startTime, loops);
			}
		}
		
		public static function stop(id:Object):void
		{
			var channel:SoundChannel = _playing[id];
			if (channel != null)
			{
				channel.stop();
			}
		}
	}
}