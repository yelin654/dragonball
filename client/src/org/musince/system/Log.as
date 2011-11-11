package org.musince.system
{
	public class Log implements ILog
	{
		public function debug(...args):void {
			trace("[DEBUG]", args.join(" "));
		}
		
		public function error(...args):void {
			trace("[ERROR]", args.join(" "));	
		}
	}
}