package
{
	import flash.display.Sprite;
	
	import org.musince.actions.ConnectToServer;
	import org.musince.actions.GenTestMetaWork;
	import org.musince.editor.EditorClient;
	import org.musince.editor.EditorConfig;
	import org.musince.editor.EditorLog;
	import org.musince.editor.EditorLogin;
	import org.musince.editor.EditorObjectFinder;
	import org.musince.editor.SaveMetaWork;
	import org.musince.logic.Athena;
	import org.musince.net.ServerSyner;
	import org.musince.net.Tunnel;
	import org.musince.system.Cookie;
	
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
			var gen:GenTestMetaWork = new GenTestMetaWork();
			var save:SaveMetaWork = new SaveMetaWork();
			
			connect.appendNext(login);
			login.appendNext(gen);
			gen.appendNext(save);
				
			$athena.start();
			$athena.addTimeSlice(connect);	
		}
	}
}