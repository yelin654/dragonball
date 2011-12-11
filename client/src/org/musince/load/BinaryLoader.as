package org.musince.load
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	public class BinaryLoader extends AbstractLoader
	{
		private var urlLoader:URLLoader = new URLLoader();
		
		public function BinaryLoader()
		{
		}
		
		override protected function _load(item:LoadItem):void
		{
			switch(item.type){
				case LoadManager.TYPE_BINARY:
					urlLoader.dataFormat = URLLoaderDataFormat.BINARY;					
					break;
				case LoadManager.TYPE_TEXT:
					urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
					break;
			}			
			if(cc != null){urlLoader.addEventListener(Event.COMPLETE, onComplete);}
			if(pc != null){urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);}
			if(ec != null){urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);}
			urlLoader.load(new URLRequest(item.url));
		}
		
		override public function stop():void
		{
		}
		
		override public function getContent():Object{
			return urlLoader.data;
		}
		
		override public function getBytesLoaded():int{
			return urlLoader.bytesLoaded;
		}
		
		override public function getBytesTotal():int{
			return urlLoader.bytesTotal;
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
		}
		
	}
}