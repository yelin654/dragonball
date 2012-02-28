package
{
    import flash.display.Sprite;
    
    import org.musince.Config;
    import org.musince.actions.ConnectToServer;
    import org.musince.actions.EnterStory;
    import org.musince.actions.Login;
    import org.musince.display.UI;
    import org.musince.global.$athena;
    import org.musince.global.$client;
    import org.musince.global.$config;
    import org.musince.global.$cookie;
    import org.musince.global.$finder;
    import org.musince.global.$log;
    import org.musince.global.$root;
    import org.musince.global.$syner;
    import org.musince.global.$tunnel;
    import org.musince.global.$ui;
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
			$ui = new UI($root);
			
			var connect:ConnectToServer = new ConnectToServer("192.168.1.122", 12222);
			var login:Login = new Login();
			connect.appendNext(login);
			var enter:EnterStory = new EnterStory();
			login.appendNext(enter);
			
			$athena.start(stage);
			$athena.addTimeSlice(connect);
        }
		
		public function initUI():void
		{
			
		}
    }
}