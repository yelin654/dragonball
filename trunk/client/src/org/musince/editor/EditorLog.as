package org.musince.editor
{
	import org.musince.system.ILog;
	import org.musince.system.Log;
	
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