package org.musince.editor
{
	import globals.$eclient;
	import org.musince.logic.GameObject;
	import org.musince.logic.IObjectFinder;

	public class EditorObjectFinder implements IObjectFinder
	{
		public function EditorObjectFinder()
		{
			
			
		}
		
		public function find(key:Array, context:Object=null):GameObject {
			var className:String = key.shift();
			var finder:Function = this["find"+className];
			if (finder != null)
			{
				return finder.apply(this, key) as GameObject;
			}
			else
			{
				return null;
			}
		}
		
		public function findClient():GameObject
		{
			return $eclient;
		}
	}
}