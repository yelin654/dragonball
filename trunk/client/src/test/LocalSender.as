package test
{
	import org.musince.net.IRPCSender;
	
	public class LocalSender implements IRPCSender
	{
		public function LocalSender()
		{
		}
		
		public function roc(key:Array, method_name:String, params:Array=null):void
		{
		}
		
		public function rpc(method_name:String, params:Array=null):void
		{
		}
		
		public function lua_rpc(method_name:String, params:Array=null):void
		{
		}
	}
}