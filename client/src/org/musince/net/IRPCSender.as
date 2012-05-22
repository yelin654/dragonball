package org.musince.net
{
	import flash.utils.IDataOutput;

	public interface IRPCSender
	{
//		function roc(key:Array, method_name:String, params:Array=null):void;
		function rpc(method_name:String, params:Array=null):void ;
		function lua_rpc(method_name:String, params:Array=null):void;
	}
}