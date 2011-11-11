package org.musince.logic
{
	import org.musince.net.Stream;

	public class GameObjectNull extends GameObject
	{
		public static const i:GameObjectNull = new GameObjectNull; 
		
		public function GameObjectNull()
		{
			super();			
		}
		
		override public function get key():Stream{
			return null;
		}
		
		override public function get ClassName():String {
			return "GameObjectNull";
		}
	}
}