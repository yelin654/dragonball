package org.musince.util
{
	import flash.utils.Dictionary;

	public class DictionaryUtilPlus
	{
		public static function size(d:Dictionary):int
		{
			var result:int = 0;
			for (var key:Object in d)
				result++;
			return result;
		}
	}
}