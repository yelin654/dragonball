package slices
{
	import slices.TimeSlice;
	import globals.$sender;
	
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
			isDone = true;
		}
	}
}