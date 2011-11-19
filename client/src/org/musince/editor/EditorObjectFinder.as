package org.musince.editor
{
	import org.musince.logic.GameObject;
	import org.musince.logic.IObjectFinder;
	import org.musince.global.$eclient;

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
		
		public function findEditorClient():EditorClient
		{
			return $eclient;
		}
	}
}