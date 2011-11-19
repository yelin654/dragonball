package org.musince.editor
{
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	import org.musince.core.TimeSlice;
	
	public class InputTalk extends TimeSlice
	{
		public var inputText:TextField;
		
		public var outputText:TextField;
		
		public function InputTalk(input:TextField, output:TextField)
		{
			super();
			inputText = input;
			outputText = output;
		}
		
		override public function onStart():void
		{
			enableKeyDown(Keyboard.ENTER, inputText, onClickEnter);
		}
		
		public function onClickEnter():void
		{
			outputText.appendText(inputText.text);
			inputText.text = "";
		}
		
	}
}