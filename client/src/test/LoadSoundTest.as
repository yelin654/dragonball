package test
{
	import flash.display.Sprite;
	import flash.media.Sound;
	
	import globals.$loadManager;
	import globals.$log;
	import loaders.LoadItem;
	import loaders.LoadManager;
	import loaders.SimpleLoader;
	import logs.Log;
	
	public class LoadSoundTest extends Sprite
	{
		public function LoadSoundTest()
		{
			super();
			$log = new Log;
			$loadManager = new LoadManager();
			$loadManager.add("../res/1.mp3", onLoad, null, null, LoadManager.TYPE_SOUND);
		}
		
		public function onLoad(item:LoadItem):void
		{
			trace(item.loader.getContent());
		}
	}
}