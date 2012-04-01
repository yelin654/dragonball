package org.musince.system
{
	import flash.external.ExternalInterface;

	public class Log implements ILog
	{
		public var _errorlog:Array = new Array(); 
		
		public function debug(...args):void {
			trace("[DEBUG]", args.join(" "));
		}
		
		public function error(...args):void {
			var errStr:String = "[ERROR] " + args.join(" ");
			trace(errStr);
			_errorlog.push(errStr);
			var bt:String = "";
			try {
				throw new Error;
			} catch (e:Error) {
				bt = e.getStackTrace();
				trace(bt);
			}
			alert(errStr + "\n" + bt);
		}
		
		public function alert(v:String):void
		{
			trace("[ALERT]", v);
			if (ExternalInterface.available)
			{
				ExternalInterface.call("alert", v);
			}	
		}
		
		public function flush():String {
			return "";
		}
	}
}