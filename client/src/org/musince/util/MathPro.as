package org.musince.util
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	public class MathPro
	{
		public static const SQUARE_2:Number = 1.414;
		
		public function MathPro()
		{
		}
		
		public static function dictionarySize(dict:Dictionary):int {
			var i:int = 0 ;
			for each (var o:Object in dict) 
				i++;
			return i;
		}
		
		public static function cross(x11:int, y11:int, x12:int, y12:int, x21:int, y21:int, x22:int, y22:int):Boolean{
			if(pointAndline(x11,y11,x21,y21,x22,y22) * pointAndline(x12,y12,x21,y21,x22,y22)<0 
				&& pointAndline(x21,y21,x11,y11,x12,y12) * pointAndline(x22,y22,x11,y11,x12,y12)<0){
				return true;
			}
			return false;
		}
		
		//when x2>x1 r>0=>point above line 
		public static function pointAndline(x:int, y:int, x1:int, y1:int, x2:int, y2:int):int{
			return (x2-x1)*(y-y1) - (y2-y1)*(x-x1);
		}
		
		public static function distance(o1:DisplayObject, o2:DisplayObject):Number{
			return Math.sqrt(Math.pow(o1.x-o2.x,2)+Math.pow(o1.y-o2.y,2));
		}
		
		public static function distance2(o1:DisplayObject, x:int, y:int):Number{
			return Math.sqrt(Math.pow(o1.x-x,2)+Math.pow(o1.y-y,2));
		}
		
		public static function distance3(x1:int, y1:int, x2:int, y2:int):Number{
			return Math.sqrt(Math.pow(x1-x2,2)+Math.pow(y1-y2,2));
		}
		
		public static function getDirection(x:int, y:int, xTarget:int, yTarget:int):int{
			var direction:int = Math.atan2(yTarget-y, xTarget-x)/Math.PI*180;
			if(direction<0){
				direction += 360;
			}
			return direction;
		}
		
		public static const COS8_TABLE:Array = [1, 0.717, 0, -0.717, -1, -0.717, 0, 0.717];
		public static const SIN8_TABLE:Array = [0, 0.717, 1, 0.717, 0, -0.717, -1, -0.717];
		public static function cos8(direction:int):Number{
			return COS8_TABLE[Math.round(direction/45)%8];
		}
		public static function sin8(direction:int):Number{
			return SIN8_TABLE[Math.round(direction/45)%8]; 
		}

		public static const DIRECTION8_TABLE:Array = [[225, 180, 135], [270, 360, 90], [315, 0, 45]]; 
		public static function getDirection8(startX:int, startY:int, endX:int, endY:int):int{
			var ix:int = endX - startX; 
			var iy:int = endY - startY;
			if(ix != 0){
				ix = ix > 0 ? 1:-1;
			}
			if(iy != 0){
				iy = iy > 0 ? 1:-1;
			}
			return DIRECTION8_TABLE[ix+1][iy+1];		
		}
		
		//result: >0 when left shelte right
//		public static function shelte1to1p(x0:int, y0:int, x1:int, y1:int):int{
//			return y0-y1;
//		}
//		
//		public static function shelte1to2p(x00:int,y00:int,x10:int,y10:int,x11:int,y11:int):int{
//			return MathPro.pointAndline(x00,y00,x10,y10,x11,y11);
//		}
//		
//		public static function shelte1to3p(x00:int,y00:int,x10:int,y10:int,x11:int,y11:int,x12:int,y12:int):int{
//		 	var r1:int = MathPro.pointAndline(x00,y00,x10,y10,x11,y11);
//			var r2:int = MathPro.pointAndline(x00,y00,x11,y11,x12,y12);
//			if(r1>0 && r2>0){
//				return 1;
//			}
//			return -1;
//		}
		
		public static function shelte1to1P(rpoints1:Vector.<Point>, rpoints2:Vector.<Point>):int{
			return rpoints1[0].y - rpoints2[0].y;
		}
		
		public static function shelte1to2P(rpoints1:Vector.<Point>, rpoints2:Vector.<Point>):int{
			return MathPro.pointAndline(rpoints1[0].x, rpoints1[0].y, rpoints2[0].x, rpoints2[0].y, rpoints2[1].x ,rpoints2[1].y);
		}
		
		public static function shelte2to1P(rpoints1:Vector.<Point>, rpoints2:Vector.<Point>):int{
			return -(shelte1to2P(rpoints2, rpoints1));
		}
		
		public static function shelte1to3P(rpoints1:Vector.<Point>, rpoints2:Vector.<Point>):int{
			var r1:int = MathPro.pointAndline(rpoints1[0].x,rpoints1[0].y,rpoints2[0].x,rpoints2[0].y,rpoints2[1].x,rpoints2[1].y);
			var r2:int = MathPro.pointAndline(rpoints1[0].x,rpoints1[0].y,rpoints2[1].x,rpoints2[1].y,rpoints2[2].x,rpoints2[2].y);
			if(r1>0 && r2>0){
				return 1;
			}
			//			if(rpoints2[0][0]<rpoints1[0][0] && rpoints1[0][0]<rpoints2[1][0]){
			if(rpoints1[0].x<rpoints2[1].x){
				return r1;
			}
			//			if(rpoints2[1][0]<rpoints1[0][0] && rpoints1[0][0]<rpoints2[2][0]){
			if(rpoints2[1].x<rpoints1[0].x){				
				return r2
			}
			return -1;
		}
		
		public static function shelte3to1P(rpoints1:Vector.<Point>, rpoints2:Vector.<Point>):int{
			return -(shelte1to3P(rpoints2, rpoints1));
		}
		
		public static function shelte2to2P(rpoints1:Vector.<Point>, rpoints2:Vector.<Point>):int{
			var r1:int = MathPro.pointAndline(rpoints1[0].x,rpoints1[0].y,rpoints2[0].x,rpoints2[0].y,rpoints2[1].x,rpoints2[1].y);
			var r2:int = MathPro.pointAndline(rpoints1[1].x,rpoints1[1].y,rpoints2[0].x,rpoints2[0].y,rpoints2[1].x,rpoints2[1].y);
			if((r1*r2) > 0){
				return r1;
			}
			
			r1 = MathPro.pointAndline(rpoints2[1].x,rpoints2[0].y,rpoints1[0].x,rpoints1[0].y,rpoints1[1].x,rpoints1[1].y);
			r2 = MathPro.pointAndline(rpoints2[1].x,rpoints2[1].y,rpoints1[0].x,rpoints1[0].y,rpoints1[1].x,rpoints1[1].y);
			if((r1*r2) > 0){
				return -r1;
			}
			return 0;
		}
		
		public static function shelte2to3P(rpoints1:Vector.<Point>, rpoints2:Vector.<Point>):int{
			var m1:int = Math.max(rpoints1[0].y, rpoints1[1].y);
			var m2:int = Math.max(Math.max(rpoints2[0].y, rpoints2[1].y), rpoints2[2].y);
			if(m1 > m2) return 1;
			return -1;
		}
		
		public static function shelte3to2P(rpoints1:Vector.<Point>, rpoints2:Vector.<Point>):int{
			return -(shelte2to3P(rpoints2, rpoints1));
		}
		
		public static function shelte3to3P(rpoints1:Vector.<Point>, rpoints2:Vector.<Point>):int{
			var m1:int = Math.max(Math.max(rpoints1[0].y, rpoints1[1].y), rpoints2[2].y);
			var m2:int = Math.max(Math.max(rpoints2[0].y, rpoints2[1].y), rpoints2[2].y);
			if(m1 > m2) return 1;
			return -1;
		}
		
		
		public static function shelte1to1(rpoints1:Array, rpoints2:Array):int{
			return rpoints1[0][1] - rpoints2[0][1];
		}
		
		public static function shelte1to2(rpoints1:Array, rpoints2:Array):int{
			return MathPro.pointAndline(rpoints1[0][0],rpoints1[0][1],rpoints2[0][0],rpoints2[0][1],rpoints2[1][0],rpoints2[1][1]);
		}
		
		public static function shelte2to1(rpoints1:Array, rpoints2:Array):int{
			return -(shelte1to2(rpoints2, rpoints1));
		}
		
		public static function shelte1to3(rpoints1:Array, rpoints2:Array):int{
			var r1:int = MathPro.pointAndline(rpoints1[0][0],rpoints1[0][1],rpoints2[0][0],rpoints2[0][1],rpoints2[1][0],rpoints2[1][1]);
			var r2:int = MathPro.pointAndline(rpoints1[0][0],rpoints1[0][1],rpoints2[1][0],rpoints2[1][1],rpoints2[2][0],rpoints2[2][1]);
			if(r1>0 && r2>0){
				return 1;
			}
//			if(rpoints2[0][0]<rpoints1[0][0] && rpoints1[0][0]<rpoints2[1][0]){
			if(rpoints1[0][0]<rpoints2[1][0]){
				return r1;
			}
//			if(rpoints2[1][0]<rpoints1[0][0] && rpoints1[0][0]<rpoints2[2][0]){
			if(rpoints2[1][0]<rpoints1[0][0]){				
				return r2
			}
			return -1;
		}
		
		public static function shelte3to1(rpoints1:Array, rpoints2:Array):int{
			return -(shelte1to3(rpoints2, rpoints1));
		}
		
		public static function shelte2to2(rpoints1:Array, rpoints2:Array):int{
			var r1:int = MathPro.pointAndline(rpoints1[0][0],rpoints1[0][1],rpoints2[0][0],rpoints2[0][1],rpoints2[1][0],rpoints2[1][1]);
			var r2:int = MathPro.pointAndline(rpoints1[1][0],rpoints1[1][1],rpoints2[0][0],rpoints2[0][1],rpoints2[1][0],rpoints2[1][1]);
			if((r1*r2) > 0){
				return r1;
			}
			
			r1 = MathPro.pointAndline(rpoints2[1][0],rpoints2[0][1],rpoints1[0][0],rpoints1[0][1],rpoints1[1][0],rpoints1[1][1]);
			r2 = MathPro.pointAndline(rpoints2[1][0],rpoints2[1][1],rpoints1[0][0],rpoints1[0][1],rpoints1[1][0],rpoints1[1][1]);
			if((r1*r2) > 0){
				return -r1;
			}
			return 0;
		}
		
		public static function shelte2to3(rpoints1:Array, rpoints2:Array):int{
			var m1:int = Math.max(rpoints1[0][1], rpoints1[1][1]);
			var m2:int = Math.max(Math.max(rpoints2[0][1], rpoints2[1][1]), rpoints2[2][1]);
			if(m1 > m2) return 1;
			return -1;
		}
		
		public static function shelte3to2(rpoints1:Array, rpoints2:Array):int{
			return -(shelte2to3(rpoints2, rpoints1));
		}
		
		public static function shelte3to3(rpoints1:Array, rpoints2:Array):int{
			var m1:int = Math.max(Math.max(rpoints1[0][1], rpoints1[1][1]), rpoints2[2][1]);
			var m2:int = Math.max(Math.max(rpoints2[0][1], rpoints2[1][1]), rpoints2[2][1]);
			if(m1 > m2) return 1;
			return -1;
		}

	}
}