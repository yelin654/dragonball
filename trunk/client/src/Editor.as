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
	import org.musince.editor.LoadMetaWorks;
	import org.musince.editor.SaveMetaWork;
	import org.musince.logic.Athena;
	import org.musince.net.ServerSyner;
	import org.musince.net.Tunnel;
	import org.musince.system.Cookie;
	import org.musince.global.$athena;
	import org.musince.global.$cookie;
	import org.musince.global.$eclient;
	import org.musince.global.$editorConfig;
	import org.musince.global.$finder;
	import org.musince.global.$log;
	import org.musince.global.$root;
	import org.musince.global.$syner;
	import org.musince.global.$tunnel;
	
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
			var load:LoadMetaWorks = new LoadMetaWorks();
			
			connect.appendNext(login);
			login.appendNext(gen);
			gen.appendNext(save);
			save.appendNext(load);
				
			$athena.start(stage);
			$athena.addTimeSlice(connect);	
		}
	}
}