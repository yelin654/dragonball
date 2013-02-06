package test
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.musince.util.BitmapUtil;
	import utils.DisplayUtil;
	
	[SWF(width='800',height='600', backgroundColor='0x000000')]
	
	public class RolationTest extends Sprite
	{
		public var loader:Loader = new Loader();
		private var num:int = 1
		private var m1:Sprite;
		private var rv:Number = 1.5;
		private var racc:Number = 0;
		private var pts:Array = new Array(num);
		private var R:int = 28;
		private var da:Number = 22.5 * Math.PI/180;
		
		public function RolationTest()
		{
			super();
			loader.load(new URLRequest("../res/smooth.swf"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
		}
		
		private var sq:Sprite;
		private function onLoaded(e:Event):void
		{
			var mc:MovieClip = loader.content as MovieClip;
			addChild(mc);
			var bmp:Bitmap = BitmapUtil.convertToBitmap(mc.m1);
//			bmp.smoothing = true;
			var bmp2:Bitmap = BitmapUtil.convertToBitmap(mc.m1);
//			bmp2.smoothing = true;
			mc.m2.removeChildren();
//			DisplayUtil.removeChildren(mc.m1);
			mc.m2.addChild(bmp2);
			sq = new Sprite();
			sq.addChild(bmp);
			sq.x = cx;
			sq.y = cy;
			addChild(sq);
			addEventListener(Event.ENTER_FRAME, update);
			graphics.lineStyle(1, 0xFFFF00);
			graphics.drawCircle(cx, cy, R);
//			var df:DaFengChe = new DaFengChe(mc["sp1"], mc.loaderInfo.applicationDomain);
//			df.x = 400;
//			df.y = 400;
//			addChild(df);
		}
		
		private var cx:int = 160;
		private var cy:int = 245; 
		
		private function update(e:Event):void
		{
			racc = (racc + rv) % 360;
			var rotation:Number = racc;
			var angle:Number;
			var degree:Number = rotation * Math.PI/180;
			sq.x = cx + R * Math.cos(degree);
			sq.y = cy + R * Math.sin(degree);
		}
	}
}