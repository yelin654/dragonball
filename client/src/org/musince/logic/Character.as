package org.musince.logic
{
	import flash.utils.Dictionary;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	public class Character extends Fightable
	{
		public var name:String;
		
		public var ui:GUI = new GUI();;
		
		private static var _characters:Dictionary = new Dictionary();		
		public static function find(name:String):Character {
			return _characters[name];
		}
		
		public function Character()
		{
		}
		
		public function initialize(name:String):void {
			this.name = name;
			_characters[name] = this;
		} 
		
		override public function moveTo(x:int, y:int):void {
			trace("character move to:" + x + " y:" + y);
			super.moveTo(x, y);
		}
		
//		override public function get ClassName():String {
//			return "Character";
//		}
		
		
		override public function serialize(buf:IDataOutput):void {
			buf.writeUTF(this.name);
		}
		
		override public function unserialize(buf:IDataInput):void {
			this.name = buf.readUTF();initialize(this.name);
		}

	}
}