package org.musince.load
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;

	public class SoundLoader extends AbstractLoader
	{
		private var _sound:Sound; 
		
		public function SoundLoader()
		{
			
		}
		
		override protected function _load(item:LoadItem):void
		{
			if(cc != null){_sound.addEventListener(Event.COMPLETE, onComplete);}
			if(pc != null){_sound.addEventListener(ProgressEvent.PROGRESS, onProgress);}
			if(ec != null){_sound.addEventListener(IOErrorEvent.IO_ERROR, onError);}
			_sound.load(new URLRequest(item.url));
		}
		
		private function onComplete(e:Event):void
		{
			cc(this);
			if(cc != null){_sound.removeEventListener(Event.COMPLETE, onComplete);}
			if(pc != null){_sound.removeEventListener(ProgressEvent.PROGRESS, onProgress);}
			if(ec != null){_sound.removeEventListener(IOErrorEvent.IO_ERROR, onError);}
		}
			
		private function onProgress(e:Event):void
		{
			pc(this);
		}
		
		private function onError(e:IOErrorEvent):void
		{
			error = e;
			ec(this);
		}
		
		override public function stop():void
		{
			
		}
		
		override public function getContent():Object
		{
			return _sound;
		}
		
		override public function getBytesLoaded():int
		{
			return _sound.bytesLoaded;
		}
		
		override public function getBytesTotal():int
		{
			return _sound.bytesTotal;
		}
	}
}