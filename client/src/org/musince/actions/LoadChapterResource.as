package org.musince.actions
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.messaging.AbstractConsumer;
	
	import org.musince.core.TimeSlice;
	import org.musince.data.MetaResource;
	import org.musince.global.$loadManager;
	import org.musince.global.$ui;
	import org.musince.load.GroupLoader;
	import org.musince.load.LoadItem;
	import org.musince.load.LoadManager;
	
	public class LoadChapterResource extends TimeSlice
	{
		private var _meta:MetaResource;
		private var _loader:GroupLoader;
		private var _progress:Progress;
		
		public function LoadChapterResource()
		{
			super();
		}
		
		override public function onStart():void
		{
			var url:String =  input as String;
			$loadManager.add(url, onMetaLoad, onMetaProgress, null, LoadManager.TYPE_BINARY);
			_progress = new Progress();
			_progress.onEndHook = onProgressEnd;
			$ui.startProgress(_progress);
		}
		
		private function onMetaProgress(item:LoadItem):void
		{
			_progress.setNow(item.loader.getBytesLoaded()/item.loader.getBytesTotal());
		}
		
		private function onMetaLoad(item:LoadItem):void
		{
			var data:ByteArray = item.loader.getContent() as ByteArray;
			_meta = new MetaResource;
			_meta.unserialize(data);
			output["image"] = new Dictionary;
			output["sound"] = new Dictionary;
			loadImage();
		}
		
		private function loadImage():void
		{
			_loader = new GroupLoader();
			for (var id:Object in _meta.img_url)
			{
				_loader.add(_meta.img_url[id], 
					LoadManager.TYPE_DISPLAY_OBJECT, id);
			}
			if (_loader.count > 0)
			{
				_loader.start(onImageLoad, onImageProgress);
			}
			else
			{
				loadSound();
			}	
		}
		
		private function onImageProgress(v:Number):void
		{
			_progress.setNow(v / 2);
		}
		
		private function loadSound():void
		{
			_loader = new GroupLoader();
			for (var id:Object in _meta.sound_url)
			{
				_loader.add(_meta.sound_url[id], 
					LoadManager.TYPE_DISPLAY_OBJECT, id);
			}
			if (_loader.count > 0)
			{
				_loader.start(onSoundLoad, onSoundProgress);
			}
			else
			{
				isEnd = true;
			}
		}
		
		private function onSoundProgress(v:Number):void
		{
			_progress.setNow(0.5 + v/2);
		}
		
		private function onImageLoad(loader:GroupLoader):void
		{
			var image:Dictionary = output.image;
			for each (var item:LoadItem in _loader.items)
			{
				image[item.param] = item.loader.getContent();
			}
			loadSound();
		}
		
		private function onSoundLoad(loader:GroupLoader):void
		{
			var sound:Dictionary = output.sound;
			for each (var item:LoadItem in _loader.items)
			{
				sound[item.param] = item.loader.getContent();
			}
			_progress.setNow(1);
		}
		
		private function onProgressEnd():void
		{
			isEnd = true;
		}
	}
}