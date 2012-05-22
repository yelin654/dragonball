package org.musince.net
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class Stream extends ByteArray implements IDataOutputNet
	{
		public function Stream()
		{
			super();
			endian = Endian.LITTLE_ENDIAN;
		}
		
		override public function writeUTF(value:String):void
		{
			super.writeUTF(value);
			this.writeByte(0);
		}
		
		override public function readUTF():String {
			var result:String = super.readUTF();
			readByte();
			return result;
		}
		
		public function flush():void {
			
		}
	}
}