package org.musince.actions
{
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import org.musince.core.TimeSlice;
	
	public class FadeStopSound extends TimeSlice
	{
		public var channel:SoundChannel;
		public var speed:Number;
//		public var trans:SoundTransform;
		
		public function FadeStopSound(channel:SoundChannel, speed:Number=0.01)
		{
			super();
			this.channel = channel;
			this.speed = speed;
		}
		
		override public function onStart():void 
		{
//			trans = new SoundTransform(channel.soundTransform.volume);
//			trans.volume = 
		}
		
		override public function onUpdate():void
		{
			var t:Number = Math.max(0, channel.soundTransform.volume-speed);
			var trans:SoundTransform = channel.soundTransform;
			trans.volume = t;
			channel.soundTransform = trans;
			trace("channl volume", channel.soundTransform.volume);
			if (t == 0)
			{
				channel.stop();
				isEnd = true;
			}
		}
		
		
	}
}