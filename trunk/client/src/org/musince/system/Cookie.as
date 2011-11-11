package org.musince.system
{
	import flash.net.SharedObject;

	public class Cookie
	{
		public function get(key:Object, location:String="default"):Object {
			var cookie:SharedObject = SharedObject.getLocal(location);
			return cookie.data[key];
		}
		
		public function set(key:Object, value:Object, location:String="default"):void {
			var cookie:SharedObject = SharedObject.getLocal(location);
			cookie.data[key] = value;
			cookie.flush();	
		}
	}
}