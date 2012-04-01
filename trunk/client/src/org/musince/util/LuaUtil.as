package org.musince.util
{
	import com.adobe.utils.DictionaryUtil;
	
	import flash.utils.Dictionary;

	public class LuaUtil
	{
		public static function convertToArray(dict:Dictionary):Array
		{
			var result:Array = new Array(DictionaryUtilPlus.size(dict));
			for (var i:int = 0; i < result.length; i++)
			{
				result[i] = dict[i+1];
			}
			return result;
		}
		
		public static function convertToDict(array:Array):Dictionary
		{
			var result:Dictionary = new Dictionary();
			for (var i:int = 0; i < array.length; i++)
			{
				result[i+1] = array[i];
			}
			return result;
		}
	}
}