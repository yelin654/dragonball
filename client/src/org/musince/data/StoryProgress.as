package org.musince.data
{
	import flash.utils.IDataInput;
	
	import org.musince.logic.GameObject;

	public class StoryProgress extends GameObject
	{
		public var name:String;
		public var hasProgress:Boolean;
		
		public function StoryProgress()
		{
		}
		
		override public function unserialize(buf:IDataInput):void
		{
			name = buf.readUTF();
			hasProgress = buf.readByte() > 0;
		}
	}
}