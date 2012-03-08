package test
{
	import flash.display.Sprite;
	import flash.media.Sound;
	
	import org.musince.global.$loadManager;
	import org.musince.global.$log;
	import org.musince.load.LoadItem;
	import org.musince.load.LoadManager;
	import org.musince.load.SimpleLoader;
	import org.musince.system.Log;
	
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