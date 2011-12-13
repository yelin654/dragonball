package org.musince.actions
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.musince.core.TimeSlice;
	import org.musince.global.$root;
	
	public class UpdateProgress extends TimeSlice
	{
		private var _progress:Progress;
		private var _tf:TextField;
		private var _container:Sprite;
		
		public function UpdateProgress(progress:Progress, container:Sprite)
		{
			super();
			_progress = progress;
			_tf = new TextField();
			var tft:TextFormat = new TextFormat();
			tft.size = 20;
			tft.color = 0xFFFFFF;
			tft.align = TextFormatAlign.CENTER;
			_tf.defaultTextFormat = tft;
			_tf.y = $root.stage.stageHeight / 2 + 10;
			_tf.x = $root.stage.stageWidth / 2;
			_container = container;
			container.addChild(_tf);
		}
		
		override public function onUpdate():void
		{
			var scale:Number = _progress.current;
			var g:Graphics = _container.graphics;
			g.clear();
			g.lineStyle(1, 0xFFFFFF);
			g.moveTo(0, $root.stage.stageHeight/2);
			g.lineTo($root.stage.stageWidth * scale, $root.stage.stageHeight/2);
			_tf.text = int(scale * 100) + "%";
		}
	}
}