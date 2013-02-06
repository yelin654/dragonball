package
{
	import flash.display.Sprite;
	
	import slices.ConnectToServer;
	import slices.GenTestMetaWork;
	import org.musince.editor.EditorClient;
	import org.musince.editor.EditorConfig;
	import org.musince.editor.EditorLog;
	import org.musince.editor.EditorLogin;
	import org.musince.editor.EditorObjectFinder;
	import org.musince.editor.LoadMetaWorks;
	import org.musince.editor.SaveMetaWork;
	import slices.Athena;
	import org.musince.net.ServerSyner;
	import org.musince.net.Tunnel;
	import utils.Cookie;
	import globals.$athena;
	import globals.$cookie;
	import globals.$eclient;
	import globals.$editorConfig;
	import globals.$finder;
	import globals.$log;
	import globals.$root;
	import globals.$syner;
	import globals.$tunnel;
	
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
			
			var connect:ConnectToServer = new ConnectToServer();
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