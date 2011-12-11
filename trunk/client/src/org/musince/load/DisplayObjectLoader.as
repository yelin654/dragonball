package org.musince.load
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	public class DisplayObjectLoader extends AbstractLoader
	{
		private var loader:Loader = new Loader();
		
		public function DisplayObjectLoader()
		{
		}
		
		override protected function _load(item:LoadItem):void
		{
			if(cc != null){loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);}
			if(pc != null){loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);}
			if(ec != null){loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);}
			loader.load(new URLRequest(item.url), item.context);
		}
				
		override public function stop():void
		{
		}
		
		override public function getContent():Object{
			return loader.contentLoaderInfo.content;
		}
		
		override public function getBytesLoaded():int{
			return loader.contentLoaderInfo.bytesLoaded;
		}
		
		override public function getBytesTotal():int{
			return loader.contentLoaderInfo.bytesTotal;
		}
		
		private function onError(e:IOErrorEvent):void{
			error = e;
			ec(this);
		}
		
		private function onProgress(e:ProgressEvent):void{
			pc(this);
		}
		
		private function onComplete(e:Event):void{			
			cc(this);
			if(cc != null){loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);}
			if(pc != null){loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);}
			if(ec != null){loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);}
		}
	}
}