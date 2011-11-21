package org.musince.data
{
	import flash.utils.IDataOutput;
	
	import org.musince.logic.GameObject;
	
	public class MetaTalkText extends GameObject
	{
		public static const DEFAULT_INTERVAL:int = 200; 
		
		public var text:String = "";
		public var interval:Array = [];
		
		public function MetaTalkText()
		{
			super();
		}
		
		override public function serialize(buf:IDataOutput):void
		{
			
		}
		
		
	}
}