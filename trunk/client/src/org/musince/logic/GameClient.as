package org.musince.logic
{
	import flash.net.getClassByAlias;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.getDefinitionByName;
	
	import org.musince.actions.Login;
	import org.musince.net.ILocal;
	import org.musince.net.ISynchronizer;
	import org.musince.system.Log;

	public class GameClient extends GameObject implements ILocal
	{
		public var name:String = "yelin";
		public var pw:int = 8670507;
		
		private var _syn:ISynchronizer;
		
		public function on_connect(syn:ISynchronizer):void {
			_syn = syn;
			$log.debug("connected");
		}
		
		public function on_disconnect(syn:ISynchronizer):void {

		}
		
		public function login():void
		{
			var login:Login = new Login();
			$athena.addTimeSlice(login);
		}
		
//		public function login_r(result:int):void {
//			trace("login result " + result);
//		}
		
//		override public function get ClassName():String {
//			return "GameClient";
//		}
		
		override public function serialize(buf:IDataOutput):void {
			buf.writeUTF(name);
			buf.writeInt(pw);
		}
	}
}