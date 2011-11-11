package org.musince.net
{
	import flash.utils.IDataInput;

	public interface ILocal
	{
		function on_connect(syn:ISynchronizer):void;
		function on_disconnect(syn:ISynchronizer):void;
	}
}