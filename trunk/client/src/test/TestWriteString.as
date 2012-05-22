package test
{
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	public class TestWriteString extends Sprite
	{
		public function TestWriteString()
		{
			super();
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes("123");
			trace(bytes.length);
		}
	}
}