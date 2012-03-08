package org.musince.actions
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.messaging.AbstractConsumer;
	
	import org.musince.Config;
	import org.musince.core.TimeSlice;
	import org.musince.data.MetaChapterResource;
	import org.musince.data.MetaResource;
	import org.musince.global.$config;
	import org.musince.global.$loadManager;
	import org.musince.global.$ui;
	import org.musince.load.GroupLoader;
	import org.musince.load.LoadItem;
	import org.musince.load.LoadManager;
	
	public class LoadChapterResource extends TimeSlice
	{
		private var _meta:MetaChapterResource;
		private var _loader:GroupLoader;
		private var _progress:Progress;
		
		public function LoadChapterResource()
		{
			super();
		}
		
		override public function onStart():void
		{
			var url:String =  input["chapter"] + ".swf";
			$loadManager.add(url, onMetaLoad, onMetaProgress);
			_progress = new Progress();
			_progress.onEndHook = onProgressEnd;
			$ui.startProgress(_progress);
		}
		
		private function onMetaProgress(item:LoadItem):void
		{
			_progress.setNow(item.loader.getBytesLoaded()/item.loader.getBytesTotal() * 0.1);
		}
		
		private function onMetaLoad(item:LoadItem):void
		{
//			var data:ByteArray = item.loader.getContent() as ByteArray;
//			_meta = new MetaResource;
//			_meta.unserialize(data);
			output["image"] = new Dictionary;
			output["sound"] = new Dictionary;
			
			_meta = item.loader.getContent()as MetaChapterResource;
			loadImage();
		}
		
		private function loadImage():void
		{
			if (_meta.image.length == 0)
			{
				loadSound();
				return;
			}
			
			_loader = new GroupLoader();
			for each(var id:Object in _meta.image)
			{
				_loader.add($config.ResourceRoot + id +".jpg", 
					LoadManager.TYPE_DISPLAY_OBJECT, id);
				_loader.start(onImageLoad, onImageProgress);
			}
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
		
		private function onImageProgress(v:Number):void
		{
			_progress.setNow(0.1 + v * 0.4);
		}
		
		private function loadSound():void
		{
			if (_meta.sound.length == 0)
			{
				_progress.setNow(1);
				return;
			}
			_loader = new GroupLoader();
			for each(var id in in _meta.sound)
			{
				_loader.add($config.ResourceRoot + id + ".mp3", 
					LoadManager.TYPE_SOUND, id);
			}
			_loader.start(onSoundLoad, onSoundProgress);
		}
		
		private function onSoundProgress(v:Number):void
		{
			_progress.setNow(0.5 + v * 0.5);
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