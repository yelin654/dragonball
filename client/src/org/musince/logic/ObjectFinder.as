package org.musince.logic
{
	import org.musince.actions.Login;
	import org.musince.global.$client;
	import org.musince.global.$login;

	public class ObjectFinder implements IObjectFinder
	{
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
		
		private function findCharacter(name:String):GameObject {
			return Character.find(name);
		}
		
		private function findClient():GameClient {
			return $client;
		}
		
		private function findLogin():Login {
			return $login;
		}
	}
}