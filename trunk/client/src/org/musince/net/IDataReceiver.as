package org.musince.net
{
	import flash.utils.IDataInput;

	public interface IDataReceiver
	{
//		function on_connect(tunnel:Tunnel):void;
		function on_data(tunnel:Tunnel, stream:IDataInput):void;
//		function on_disconnect(tunnel:Tunnel):void;
	}
}