package test
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	public class DrawRect extends Sprite
	{
		public function DrawRect()
		{
			super();
			var g:Graphics = graphics;
			g.beginFill(0x000000);
			g.drawRoundRect(100, 100, 300, 200, 10, 10);
			g.endFill();
		}
	}
}