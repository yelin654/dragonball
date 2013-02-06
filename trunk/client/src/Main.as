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
    
    import slices.ConnectToServer;
    import slices.Info;
    import slices.LoadConfigFile;
    import slices.Login;
    import org.musince.data.ColorMap;
    import org.musince.display.UI;
    import globals.$athena;
    import globals.$benchmark;
    import globals.$clickIcon;
    import globals.$colorMap;
    import globals.$cookie;
    import globals.$finder;
    import globals.$guideText;
    import globals.$loadManager;
    import globals.$log;
    import globals.$receiver;
    import globals.$root;
    import globals.$sender;
    import globals.$stage;
    import globals.$syner;
    import globals.$talkPanel;
    import globals.$tunnel;
    import globals.$ui;
    import globals.$width;
    import loaders.LoadManager;
    import org.musince.logic.ObjectFinder;
    import org.musince.query.EnterStory;
    import org.musince.rpc.ImportRPC;
    import utils.Cookie;
    import org.musince.util.TextFieldUtil;

	[SWF(width="1280", height="720", backgroundColor="0x000000")]

    public class Main extends Sprite
    {

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
			
//			var info:Info = new Info();
//			config.appendNext(info);
			
			var connect:ConnectToServer = new ConnectToServer();
			config.appendNext(connect);
			
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
					System.setClipboard($log._errorCache.join("\n"));
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
			$tunnel.attachReceiver($syner);
			$syner.bind($tunnel);
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