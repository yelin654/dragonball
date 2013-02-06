package org.musince.editor
{
	import org.musince.core.Query;
	import globals.$eclient;
	import globals.$log;
	
	public class EditorLogin extends Query
	{
		public function EditorLogin()
		{
			super($eclient);
		}
		
		public function onQuery():void
		{
			send("EditorService", "login", ["yelin"]);
		}
		
		override public function onSuccess(result:Array):void
		{
			$log.debug("login success");
			isDone = true;	
		}
		
		override public function onFailed(reason:Array):void
		{
			
		}
	}
}