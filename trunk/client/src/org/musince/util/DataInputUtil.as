package org.musince.util
{
	import flash.utils.IDataInput;

	public class DataInputUtil
	{
		public static function readIntArray(data:IDataInput):Object
		{
			var len:int = data.readShort();
			var arr:Vector.<int> = new Vector.<int>(len);
			for (var i:int = 0; i < len; i++)
			{
				arr[i] = data.readInt();
			}
			return arr;
		}
	}
}