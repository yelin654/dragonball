package 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	
	import org.musince.util.BitmapUtil;
	
	public class DaFengChe extends Sprite
	{
		private var num:int = 1
		private var m1:Sprite;
		private var rv:Number = 0.5;
		private var racc:Number = 0;
		private var pts:Array = new Array(num);
		private var R:int = 28;
		private var da:Number = 22.5 * Math.PI/180;

		
		public function DaFengChe(mc:MovieClip, domain:ApplicationDomain)
		{
			var bmp:Bitmap = BitmapUtil.convertToBitmap(mc.m1);
			bmp.smoothing = true;
			m1 = new Sprite();
			m1.addChild(bmp);
			var s:Sprite;
			for (var i:int = 0; i < num; i++)
			{
				pts[i] = getInstanceFrom("CPoint", domain) as MovieClip;
				s = new Sprite();
				s.addChild(BitmapUtil.convertToBitmap(pts[i]));
				pts[i] = s;
				
				addChild(pts[i]);
			}
			this.transform = mc.transform;
			addChild(m1);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function getInstanceFrom(name:String, domain:ApplicationDomain):Object 
		{
			if (!domain.hasDefinition(name))
			{
				return null;
			}
			var cla:Class = domain.getDefinition(name) as Class;
			return new cla;
		}
		
		public function update(e:Object):void
		{
			racc = (racc + rv) % 360;
			if (m1.rotation == int(racc))
			{
				return;
			}
			m1.rotation  = int(racc);
			var angle:Number;
			var pt:DisplayObject;
			var degree:Number = m1.rotation * Math.PI/180;
			for (var i:int = 0; i < num; i++) {
				angle = degree + i * da;
				pt = pts[i];
				pt.x = int(R * Math.cos(angle));
				pt.y = int(R * Math.sin(angle));
			}
		}
	}
}