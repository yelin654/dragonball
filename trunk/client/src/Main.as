package
{
	import flash.display.Sprite;
	
	import org.musince.Config;
	import org.musince.logic.Athena;
	import org.musince.logic.GameClient;
	import org.musince.logic.ObjectFinder;
	import org.musince.net.ServerSyner;
	import org.musince.net.Tunnel;
	import org.musince.system.Cookie;
	import org.musince.system.Log;
	
	[SWF(width="1280", height="720", backgroundColor="0x000000")]
	
	public class Main extends Sprite
	{
		private var _tunnel:Tunnel; 
		
		public function Main()
		{			
			$root = this;
			$log = new Log();
			$finder = new ObjectFinder();
			$syner = new ServerSyner();
			$client = new GameClient();
			$config = new Config();
			$tunnel = new Tunnel();
			$cookie = new Cookie();
			$athena = new Athena();
		}
	}
}