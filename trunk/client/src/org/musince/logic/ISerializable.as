package org.musince.logic
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public interface ISerializable
	{
		function serialize(buf:IDataOutput):void;
		function unserialize(buf:IDataInput):void;
//		function get ClassName():String;
//		function length():int;
	}
}