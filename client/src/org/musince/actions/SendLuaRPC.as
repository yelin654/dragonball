package org.musince.actions
{
	import org.musince.core.TimeSlice;
	import org.musince.global.$sender;
	
	public class SendLuaRPC extends TimeSlice
	{
		public var methodName:String;
		public var params:Array;
		
		public function SendLuaRPC(name:String, args:Array)
		{
			super();
			this.methodName = name;
			this.params = args;
		}
		
		override public function onStart():void
		{
			$sender.lua_rpc(methodName, params);
			isEnd = true;
		}
	}
}