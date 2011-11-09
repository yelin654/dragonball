package
{
	import flash.display.Sprite;
	
	import org.musince.Config;
	import org.musince.actions.ConnectToServer;
	import org.musince.actions.GetMetaWorks;
	import org.musince.editor.EditorClient;
	import org.musince.editor.EditorConfig;
	import org.musince.editor.EditorLog;
	import org.musince.editor.EditorLogin;
	import org.musince.editor.EditorObjectFinder;
	import org.musince.logic.Athena;
	import org.musince.logic.GameClient;
	import org.musince.net.ServerSyner;
	import org.musince.net.Tunnel;
	import org.musince.system.Cookie;
	import org.musince.system.Log;
	
	public class Editor extends Sprite
	{
		public function Editor()
		{
			super();
			$root = this;
			$log = new EditorLog();
			$finder = new EditorObjectFinder();
			$syner = new ServerSyner();
			$eclient = new EditorClient();
			$editorConfig = new EditorConfig();
			$tunnel = new Tunnel();
			$cookie = new Cookie();
			$athena = new Athena();
			
			var connect:ConnectToServer = new ConnectToServer("192.168.1.122", 12222);
			var login:EditorLogin = new EditorLogin();
			connect.appendNext(new EditorLogin);
			login.appendNext(new GetMetaWorks);
				
			$athena.start();
			$athena.addAction(connect);	
		}
	}
}