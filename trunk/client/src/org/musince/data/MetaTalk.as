package org.musince.data
{
	import flash.utils.IDataOutput;
	
	import org.musince.logic.GameObject;
	
	public class MetaTalk extends GameObject
	{
		public var text:String = "请在离去之前，叫醒我";
		public var interval:Array = [200, 400, 200, 400, 500, 0, 2000, 1000, 1000, 1000];
		
		public function MetaTalk()
		{
			super();
		}
		
		override public function serialize(buf:IDataOutput):void
		{
			
		}
		
		
	}
}