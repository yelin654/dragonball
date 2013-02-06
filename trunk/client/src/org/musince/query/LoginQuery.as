package org.musince.query
{
	import org.musince.core.Query;
	import globals.$client;
	import globals.$log;
	import globals.$syner;
	
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
			$log.debug("start login");
		}
		
		override public function onSuccess(result:Array):void
		{
			isDone = true;
			output["r"] = true;
			output["u"] = input["u"];
			$log.debug("login success");
		}
		
		override public function onFailed(reason:Array):void
		{
			isDone = true;
			output["r"] = false;
			output["u"] = input["u"];
		}
	}
}