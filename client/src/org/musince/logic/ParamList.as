package org.musince.logic
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	import globals.$finder;
	import org.musince.util.DataInputUtil;

	public class ParamList implements ISerializable
	{
		private var _params:Vector.<Param>;
		
		public static const TYPE_INT:int = 0;
		public static const TYPE_STRING:int = 1;
		public static const TYPE_OBJECT:int = 2;
		public static const TYPE_INT_ARRAY:int = 3;
		public static const TYPE_STRING_ARRAY:int = 4;
		public static const TYPE_OBJECT_ARRAY:int = 5;
		public static const TYPE_BYTE_ARRAY:int = 6;
		public static const TYPE_LUA_TABLE:int = 7;
		

		
		public var params:Array;
		
		private static const _typeString:Vector.<String> = Vector.<String>([
			"Int", "String", "Object", 
			"IntArray", "StringArray", "ObjectArray", "ByteArray", "LuaTable"]);
		
		public function ParamList(params:Array=null)
		{
			super();
//			if (null != params) {
//				_params = new Vector.<Param>(params.length);
//				for (var i:int = 0; i < params.length; i++) {
//					_params[i] = new Param(params[i]);
//				}
//			}
			this.params = params;
		}
		
		public function parseType(content:Object):int {
			if (content is int) {
				return TYPE_INT;
			}
			if (content is String) {
				return TYPE_STRING;
			}
			if (content is ISerializable) {
				return TYPE_OBJECT;
			}
			if (content is ByteArray) {
				return TYPE_BYTE_ARRAY;
			}
			return 0;
		}
		
		public function serialize0(buf:IDataOutput):void {
			if (_params == null) {
				buf.writeByte(0);
				return;
			}
			buf.writeByte(_params.length);
			
			for each (var param:Param in _params) {
				param.serialize(buf);
			} 
		}
		
		public function serialize(buf:IDataOutput):void {
			if (params == null) {
				buf.writeByte(0);
				return;
			}
			var param:Object;
			var type:int;
			var f:Function;
			buf.writeByte(params.length);
			for (var i:int = 0; i < params.length; i++)
			{
				param = params[i];
				type = parseType(param);
				buf.writeByte(type);
				f = this["serialize"+_typeString[type]];
				f.call(this, param, buf);
			}
		}
		
		private function serializeInt(content:Object, buf:IDataOutput):void {
			buf.writeInt(content as int);
		}
		
		private function serializeString(content:Object, buf:IDataOutput):void {
			buf.writeUTF(content as String);
		}
		
		private function serializeObject(content:Object, buf:IDataOutput):void {
			var ser:GameObject = content as GameObject;
			buf.writeBoolean(ser.passAsReference);
			if (ser.passAsReference) {
				buf.writeBytes(ser.getKey());
			} else {
				buf.writeUTF(GameObject.getClassName(ser));
				ser.serialize(buf);
			}
		}
		
		private function serializeIntArray(content:Object, buf:IDataOutput):void {
			
		}
		
		private function serializeStringArray(content:Object, buf:IDataOutput):void {
			
		}
		
		private function serializeByteArray(content:Object, buf:IDataOutput):void
		{
			var bytes:ByteArray = content as ByteArray;
			buf.writeInt(bytes.length);
			bytes.position = 0;
			buf.writeBytes(bytes);
		}
		
		public function unserialize0(buf:IDataInput):void {
			var paramNum:int = buf.readByte();
			if (0 == paramNum)
				return;
			_params = new Vector.<Param>(paramNum);
			for (var i:int = 0; i < paramNum; i++) {
				_params[i] = new Param();
				_params[i].unserialize(buf);
			}
		}
		
		public function unserialize(buf:IDataInput):void {
			var paramNum:int = buf.readByte();
			if (0 == paramNum)
				return;
			params = new Array(paramNum);
			var type:int;
			var f:Function; 
			for (var i:int = 0; i < paramNum; i++) {
				type = buf.readByte();
				f = this["unserialize"+_typeString[type]];
				params[i] = f.call(this, buf);
			}
		}
		
		private function unserializeInt(buf:IDataInput):Object {
			return buf.readInt();
		}
		
		private function unserializeString(buf:IDataInput):Object {
			return buf.readUTF();
		}
		
		private function unserializeObject(buf:IDataInput):Object {
			var className:String = buf.readUTF();
			if (buf.readBoolean()) {
				var key:ParamList = new ParamList();
				key.unserialize(buf);
				return $finder.find(key.params);
			} else {
				var content:GameObject = GameObject.getInstance(className);
				content.unserialize(buf);
				return content;
			}
		}
		
		private function unserializeIntArray(buf:IDataInput):Object {
			return DataInputUtil.readIntArray(buf);
		}
		
		private function unserializeStringArray(buf:IDataInput):Object {
			return null;
		}
		
		private function unserializeByteArray(buf:IDataInput):Object {
			var len:int = buf.readInt();
			var bytes:ByteArray = new ByteArray();
			buf.readBytes(bytes, 0, len);
			return bytes;
		}
		
		private function unserializeLuaTable(buf:IDataInput):Object {
			var dict:Dictionary = new Dictionary();
			var size:int = buf.readByte();
			var key:Object;
			var value:Object;
			for (var i:int = 0; i < size; i++)
			{
				key = unserializeLuaParam(buf);
				value = unserializeLuaParam(buf);
				dict[key] = value;
			}
			return dict;
		}
		
		private function unserializeLuaParam(buf:IDataInput):Object {
			var type:int = buf.readByte();
			var f:Function = this["unserialize"+_typeString[type]];
			return f.call(this, buf);
		}
			
		
//		public function toArray():Array {
//			if (_params == null)
//				return null;
//			var array:Array = new Array(_params.length);
//			for (var i:int = 0; i < _params.length; i++) {
//				array[i] = _params[i].content;
//			}
//			return array;
//		}
		
//		public function get ClassName():String {
//			return "ParamList";
//		}
	}
}