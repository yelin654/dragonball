package
{
	import flash.display.Sprite;
	
	import org.musince.display.LoginPanel;
	import org.musince.global.$athena;
	import org.musince.global.$root;
	
	[SWF(width='1280',height='720', backgroundColor='0x000000')]
	public class TestLogin extends Sprite
	{
		public function TestLogin()
		{
			super();
			$root = this;
			$athena.start(stage);
			var login:LoginPanel = new LoginPanel();
			addChild(login);
			login.fadeIn();
		}
		
		
	}
}