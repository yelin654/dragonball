package slices
{
	import flash.text.TextField;
	
	import org.musince.data.MetaTalkText;
	
	public class PlayTalkVar extends PlayTalk
	{
		private var _data:MetaTalkText;
		
		public function PlayTalkVar(tf:TextField)
		{
			super(tf);
		}
		
		override public function onStart():void
		{
			_data = input as MetaTalkText;
			_text = _data.text;
			
			super.onStart();
		}
		
		override protected function isLast(index:int):Boolean
		{
			return index == _data.interval.length;
		}
		
		override protected function nextInterval(index:int):int
		{
			return  _data.interval[index];
		}
	}
}