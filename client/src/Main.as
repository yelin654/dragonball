package
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.system.System;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.ui.Keyboard;
    
    import org.musince.actions.ConnectToServer;
    import org.musince.actions.Info;
    import org.musince.actions.LoadConfigFile;
    import org.musince.actions.Login;
    import org.musince.data.ColorMap;
    import org.musince.display.UI;
    import org.musince.global.$athena;
    import org.musince.global.$benchmark;
    import org.musince.global.$clickIcon;
    import org.musince.global.$colorMap;
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
    import org.musince.global.$talkPanel;
    import org.musince.global.$ui;
    import org.musince.global.$width;
    import org.musince.load.LoadManager;
    import org.musince.logic.ObjectFinder;
    import org.musince.net.Tunnel;
    import org.musince.query.EnterStory;
    import org.musince.rpc.ImportRPC;
    import org.musince.system.Cookie;
    import org.musince.util.TextFieldUtil;

    [SWF(width="1280", height="720", backgroundColor="0x000000")]

    public class Main extends Sprite
    {
        private var _tunnel:Tunnel;

        public function Main()
        {
			stage.color = 0x000000;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.focus = stage;
			
			ImportRPC;
			
			initGlobal();
			
			initUI();
			
			var config:LoadConfigFile = new LoadConfigFile();
			
			var info:Info = new Info();
			config.appendNext(info);
			
			var connect:ConnectToServer = new ConnectToServer();
			info.appendNext(connect);
			
			var login:Login = new Login();
			connect.appendNext(login);
			
			var enter:EnterStory = new EnterStory();
			login.appendNext(enter);
			
			$athena.start(stage);
			
			$athena.addTimeSlice(config);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
//			stage.addEventListener(MouseEvent.MIDDLE_CLICK, onMiddleClick);
        }
		
		private function onKeyDown(e:KeyboardEvent):void {
			switch (e.keyCode)
			{
				case Keyboard.E:
					System.setClipboard($log._errorlog.join("\n"));
					break;
				case Keyboard.T:
					$benchmark.traceActiveSlice();
					break;
			}
		}
		
		private function onMiddleClick(e:MouseEvent):void
		{
			$benchmark.traceActiveSlice();
		}
		
		public function initGlobal():void
		{
			$root = this;
			$finder = new ObjectFinder();
			$sender = $syner;
			$receiver = $syner;
			$cookie = new Cookie();
			$loadManager = new LoadManager();
			$ui = new UI($root);
			$colorMap = new ColorMap();
//			$colorMap.map["XYZ"] = 0xDF2B61;
			$colorMap.map["XYZ"] = 0xE75C86;
		}
		
		public function initUI():void
		{
			$stage = stage;
			$clickIcon.x = 1200;
			$clickIcon.y = 650;
			var tf:TextField = TextFieldUtil.getTextField(50);
			tf.autoSize = TextFieldAutoSize.NONE;
			tf.width = $width;
			tf.alpha = 0;
			tf.y = UI.HEIGHT/2 - tf.height/2;
			$guideText = tf;
			$talkPanel.y = 520;
		}
    }
}