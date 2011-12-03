package
{
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	[SWF(width='800',height='600')]
	
	public class TestGadientFill extends Sprite
	{
		public function TestGadientFill()
		{
			super();
			var t:int = 80;
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(200, 200);
			graphics.beginGradientFill(GradientType.LINEAR, 
				[0x000000, 0x000000, 0x000000, 0x000000],
				[0, 0.5, 0.5, 0], 
				[0, t, 255-t, 255], matrix);
			graphics.drawRect(0, 100, 200, 200);
			graphics.endFill();
		}
	}
}