package org.musince.editor
{
	import logs.ILog;
	import logs.Log;
	
	public class EditorLog extends Log
	{
		override public function debug(...args):void
		{
			super.debug.apply(this, args);
		}
		
		override public function error(...args):void
		{
			super.error.apply(this, args);
		}
	}
}