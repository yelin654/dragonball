package
{
	import flash.display.Sprite;
	
	import slices.ConnectToServer;
	import slices.LoadConfigFile;
	import globals.$athena;
	import globals.$root;
	
	import test.ConnectToTestServer;
	import test.TestNet;
	
	[SWF(width="1280", height="720", backgroundColor="0x000000")]
	
	public class NetTest extends Sprite
	{
		public function NetTest()
		{
			super();
			
			$root = this;
			
//			var config:LoadConfigFile = new LoadConfigFile();			
						
			var connect:ConnectToTestServer= new ConnectToTestServer();
			
			var test:TestNet = new TestNet();
			
//			config.appendNext(connect);
			connect.appendNext(test);
			
			$athena.start(stage);
			
			$athena.addTimeSlice(connect);
		}
	}
}