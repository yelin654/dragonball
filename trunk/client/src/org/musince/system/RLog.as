package org.musince.system
{
	public class RLog extends Log
	{
		private var _logs:Array = new Array();
		private var _txt:String = new String();
		
		public function RLog()
		{
			super();
		}
		
		override public function debug(...args):void
		{
			var str:String = "[DEBUG] " + args.join(" ");
			trace(str);
			_logs.push(str);
		}
		
		override public function error(...args):void
		{
			var str:String = "[ERROR] " + args.join(" ");
			trace(str);
			_logs.push(str);
		}
		
		override public function flush():String
		{
			var result:String = "";
			for each (var str:String in _logs)
			{
				result += str + "\n";
			}
			_logs = new Array();
			return result;
		}
	}
}