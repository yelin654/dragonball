package org.musince.net
{
	import flash.utils.IDataInput;
	
	import org.musince.logic.GameObject;
	import org.musince.logic.GameObjectNull;
	import org.musince.logic.ParamList;

	public interface ISynchronizer
	{
		function rpc(key:Array, method_name:String, params:Array):void;
		function invoke_method_recv(stream:IDataInput):void; 
	}
}