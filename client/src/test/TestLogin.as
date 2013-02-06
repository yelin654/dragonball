package test
{
	import flash.display.Sprite;
	
	import slices.InputLogin;
	import org.musince.display.LoginPanel;
	import globals.$athena;
	import globals.$root;
	
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
			var input:InputLogin = new InputLogin(login.u, login.tip);
			login.fadeIn(input);
		}
		
		
	}
}