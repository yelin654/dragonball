package org.musince.logic
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	public class GameEvent implements ISerializable
	{
		public var type:int;
		
		public var params:ParamList;
		
		public function GameEvent(type:int, params:ParamList)
		{
			this.type = type;
			this.params = params;
		}
		
		public function serialize(buf:IDataOutput):void
		{
			buf.writeInt(type);
			params.serialize(buf);
		}
		
		public function unserialize(buf:IDataInput):void
		{
			
		}
		
		public function get ClassName():String
		{
			return "GameEvent";
		}
	}
}