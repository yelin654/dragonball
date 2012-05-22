package org.musince.net
{
	import flash.display.InteractiveObject;
	import flash.net.getClassByAlias;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.getDefinitionByName;
	
	import org.musince.logic.Character;
	import org.musince.logic.GameEvent;
	import org.musince.logic.GameObject;
	import org.musince.logic.IObjectFinder;
	import org.musince.logic.ObjectMirror;
	import org.musince.logic.ParamList;
	
	public class DataTransfer implements IDataReceiver, IRPCSender
	{
		public static const RPC_NEW_OBJECT:int = 1;
		public static const RPC_SYNC_METHOD:int = 2;
		
		private var _rpcHandlers:Vector.<Function> = new Vector.<Function>(2);
		private var _objectFinder:IObjectFinder;
		private var _handlingTunnel:Tunnel;
		
		public function DataTransfer(finder:IObjectFinder)
		{
			_objectFinder = finder;
			_rpcHandlers[RPC_NEW_OBJECT] = newObject;
			_rpcHandlers[RPC_SYNC_METHOD] = syncMethod;
		}
		
		public function onData(buf:IDataInput, tunnel:Tunnel):void {
			_handlingTunnel = tunnel;
			var type:int = buf.readShort();
			_rpcHandlers[type](buf);
		}
		
		private function newObject(data:IDataInput):void {
			var className:String = data.readUTF();
			var _class:Class = getDefinitionByName("org.musince.logic."+className) as Class;
			var target:GameObject = new _class() as GameObject;
			target.unserialize(data);
		}
		
		private function syncMethod(data:IDataInput):void {
//			var guid:int = data.readInt();
//			var len:int = data.readShort();
			var className:String = data.readUTF();
			var findKey:ParamList = new ParamList();
			findKey.unserialize(data);
			var func:int = data.readInt();
//			var cls:Object= getDefinitionByName("org.musince.logic."+className);
//			var target:GameObject = cls.find(guid);
			var target:GameObject = _objectFinder.find(className, findKey.toArray()); 
			var params:ParamList = new ParamList();
			params.unserialize(data);
			target.synMethodPassive(func, params);
			
			var ch:Character = Character.find("yelin");
			ch.ui.addMirror(new ObjectMirror(_handlingTunnel));
			var e:GameEvent = new GameEvent(1000, new ParamList(10, 20));
			ch.ui.dispatchUIEvent(e);
		}
		
		public function on_connect(tunnel:Tunnel):void {

		}
		
		public function on_data(tunnel:Tunnel, stream:IDataInput):void {
			
		}
		
		public function on_disconnect(tunnel:Tunnel):void {
			
		}
		
		public function get_output_stream(remote:ILocal, size:int=0):OutputStream {
			return null;
//			return (remote as Server).tunnel.getOutputStream();
		}
		
	}
}