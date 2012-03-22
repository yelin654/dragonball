package test
{
	import flash.display.Sprite;
	
	import org.musince.actions.PlayMonolog;
	import org.musince.global.$athena;
	import org.musince.global.$stage;
	
	[SWF(width='1280',height='800', backgroundColor='0x000000')]
	
	public class TestMonolog extends Sprite
	{
		public function TestMonolog()
		{
			super();
			$stage = stage;
			var mono:PlayMonolog = new PlayMonolog(this, ["不得不辞去了上一份工作", 
				"折腾了两三家后", 
				"莫名其妙", 
				"也没有任何准备的", 
				"来到了这家公司"]);
			$athena.start(stage);
			$athena.addTimeSlice(mono);
		}
	}
}