package org.musince.net
{
	import flash.utils.IDataOutput;

	public interface IDataSender
	{
		function get_output_stream(remote:ILocal, size:int=0):OutputStream;
	}
}