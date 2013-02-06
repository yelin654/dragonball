package test
{
	import flash.display.Sprite;
	
	import org.musince.Config;
	import slices.LoadChapterResource;
	import org.musince.display.UI;
	import globals.$athena;
	import globals.$config;
	import globals.$loadManager;
	import globals.$log;
	import globals.$root;
	import globals.$ui;
	import loaders.LoadManager;
	import logs.Log;
	
	[SWF(width="1280", height="720", backgroundColor="0x000000")]
	
	public class TestLoadChapterRes extends Sprite
	{
		public function TestLoadChapterRes()
		{
			super();
			$root = this;
			$config = new Config();
			$config.ResourceRoot = "../res/";
			$ui = new UI($root);
			
			var loader:LoadChapterResource = new LoadChapterResource();
			loader.input["chapter"] = 0;
			$athena.start(stage);
			$athena.addTimeSlice(loader);
		}
	}
}