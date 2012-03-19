package test
{
	import flash.display.Sprite;
	
	import org.musince.Config;
	import org.musince.actions.LoadChapterResource;
	import org.musince.display.UI;
	import org.musince.global.$athena;
	import org.musince.global.$config;
	import org.musince.global.$loadManager;
	import org.musince.global.$log;
	import org.musince.global.$root;
	import org.musince.global.$ui;
	import org.musince.load.LoadManager;
	import org.musince.system.Log;
	
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
			
			var load:LoadChapterResource = new LoadChapterResource();
			load.input["chapter"] = 0;
			$athena.start(stage);
			$athena.addTimeSlice(load);
		}
	}
}