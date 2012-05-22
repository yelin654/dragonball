package
{
	import flash.display.Sprite;
	
	import org.musince.actions.ConnectToServer;
	import org.musince.actions.LoadConfigFile;
	import org.musince.global.$athena;
	import org.musince.global.$root;
	
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