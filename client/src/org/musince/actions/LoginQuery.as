package org.musince.actions
{
	import org.musince.core.Query;
	import org.musince.global.$client;
	import org.musince.global.$syner;
	
	public class LoginQuery extends Query
	{
		public function LoginQuery()
		{
			super($client);
		}
		
		override public function onStart():void
		{
			var name:String = input["u"];
			send("LoginService", "login", [name]);
		}
		
		override public function onSuccess(result:Array):void
		{
			isEnd = true;
		}
		
		override public function onFailed(reason:Array):void
		{
			isEnd = true;
		}
	}
}