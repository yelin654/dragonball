package
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    
    import org.musince.Config;
    import org.musince.actions.ConnectToServer;
    import org.musince.actions.LoadConfigFile;
    import org.musince.actions.Login;
    import org.musince.display.UI;
    import org.musince.global.$athena;
    import org.musince.global.$benchmark;
    import org.musince.global.$clickIcon;
    import org.musince.global.$client;
    import org.musince.global.$config;
    import org.musince.global.$cookie;
    import org.musince.global.$finder;
    import org.musince.global.$guideText;
    import org.musince.global.$loadManager;
    import org.musince.global.$log;
    import org.musince.global.$receiver;
    import org.musince.global.$root;
    import org.musince.global.$sender;
    import org.musince.global.$stage;
    import org.musince.global.$syner;
    import org.musince.global.$tunnel;
    import org.musince.global.$ui;
    import org.musince.load.LoadManager;
    import org.musince.logic.GameClient;
    import org.musince.logic.ObjectFinder;
    import org.musince.net.ServerSyner;
    import org.musince.net.Tunnel;
    import org.musince.query.EnterStory;
    import org.musince.rpc.ImportRPC;
    import org.musince.system.Cookie;
    import org.musince.system.Log;
    import org.musince.util.TextFieldUtil;

    [SWF(width="1280", height="720", backgroundColor="0x000000")]

    public class Main extends Sprite
    {
        private var _tunnel:Tunnel;

        public function Main()
        {
			stage.color = 0x000000;
			ImportRPC;
            $root = this;
            $log = new Log();
            $finder = new ObjectFinder();
            $syner = new ServerSyner();
			$sender = $syner;
			$receiver = $syner;
            $client = new GameClient();
            $config = new Config();
            $tunnel = new Tunnel();
            $cookie = new Cookie();
			$loadManager = new LoadManager();
			$ui = new UI($root);
			
			initUI();
			
			var config:LoadConfigFile = new LoadConfigFile();			
			var connect:ConnectToServer = new ConnectToServer();
			config.appendNext(connect);
			var login:Login = new Login();
			connect.appendNext(login);
			var enter:EnterStory = new EnterStory();
			login.appendNext(enter);
			
			$athena.start(stage);
			$athena.addTimeSlice(config);
			
			stage.addEventListener(MouseEvent.MIDDLE_CLICK, onMiddleClick);
        }
		
		private function onMiddleClick(e:MouseEvent):void
		{
			$benchmark.traceActiveSlice();
		}
		
		public function initUI():void
		{
			$stage = stage;
			$clickIcon.x = 1200;
			$clickIcon.y = 650;
			
			var tf:TextField = TextFieldUtil.getTextField(50);
			tf.autoSize = TextFieldAutoSize.NONE;
			tf.width = root.stage.stageWidth;
			tf.alpha = 0;
			tf.y = UI.HEIGHT/2 - tf.height/2;
			$guideText = tf;
		}
    }
}