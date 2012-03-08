package org.musince.logic
{	
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.getDefinitionByName;
	
	import org.musince.util.ClassUtil;
	import org.musince.global.$finder;
	
	public class Param implements ISerializable
	{
		public static const TYPE_INT:int = 0;
		public static const TYPE_STRING:int = 1;
		public static const TYPE_OBJECT:int = 2;
		public static const TYPE_INT_ARRAY:int = 3;
		public static const TYPE_STRING_ARRAY:int = 4;
		public static const TYPE_OBJECT_ARRAY:int = 5;
		public static const TYPE_BYTE_ARRAY:int = 6;
		
		private static const _typeString:Vector.<String> = Vector.<String>([
			"Int", "String", "Object", 
			"IntArray", "StringArray", "ObjectArray", "ByteArray"]);
		
		public var content:Object;
																					
		private var _type:int;
		
		public function Param(content:Object=null)
		{
			this.content = content;
			if (content == null) return;
			if (content is int) {
				_type = TYPE_INT;
				return;
			}
			if (content is String) {
				_type = TYPE_STRING;
				return;
			}
			if (content is ISerializable) {
				_type = TYPE_OBJECT;
				return;
			}
			if (content is ByteArray)
			{
				_type = TYPE_BYTE_ARRAY;
				return;
			}
		}
		
		public function serialize(buf:IDataOutput):void {
			buf.writeByte(_type);
//			_serializeTypes[_type](buf);
			var f:Function = this["serialize"+_typeString[_type]];
			if (f != null)
			{
				f.call(this, buf);
			}
		}
		
		private function serializeInt(buf:IDataOutput):void {
			buf.writeInt(content as int);
		}
		
		private function serializeString(buf:IDataOutput):void {
			buf.writeUTF(content as String);
		}
		
		private function serializeObject(buf:IDataOutput):void {
			var ser:GameObject = content as GameObject;
			buf.writeBoolean(ser.passAsReference);
			if (ser.passAsReference) {
				buf.writeBytes(ser.getKey());
			} else {
				buf.writeUTF(GameObject.getClassName(ser));
				ser.serialize(buf);
			}
		}
		
		private function serializeIntArray(buf:IDataOutput):void {
			
		}
		
		private function serializeStringArray(buf:IDataOutput):void {
			
		}
		
		private function serializeByteArray(buf:IDataOutput):void
		{
			var bytes:ByteArray = content as ByteArray;
			buf.writeInt(bytes.length);
			bytes.position = 0;
			buf.writeBytes(bytes);
		}
		
		public function unserialize(buf:IDataInput):void {
			_type = buf.readByte();
//			_unserializeTypes[_type](buf);
			var f:Function = this["unserialize"+_typeString[_type]];
			if (f != null)
			{
				f.call(this, buf);
			}
		}
		
		private function unserializeInt(buf:IDataInput):void {
			content = buf.readInt();
		}
		
		private function unserializeString(buf:IDataInput):void {
			content = buf.readUTF();
		}
		
		private function unserializeObject(buf:IDataInput):void {
			var className:String = buf.readUTF();
			if (buf.readBoolean()) {
				var key:ParamList = new ParamList();
				key.unserialize(buf);
				content = $finder.find(key.params);
			} else {
				content = GameObject.getInstance(className);
				content.unserialize(buf);
			}
		}
		
		private function unserializeIntArray(buf:IDataInput):void {
			
		}
		
		private function unserializeStringArray(buf:IDataInput):void {
			
		}
		
		private function unserializeByteArray(buf:IDataInput):void
		{
			var len:int = buf.readInt();
			var bytes:ByteArray = new ByteArray();
			buf.readBytes(bytes, 0, len);
			content = bytes;
		}

	}
}