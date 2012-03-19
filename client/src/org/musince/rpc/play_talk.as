package org.musince.rpc
{
	import flash.utils.Dictionary;
	
	import org.musince.actions.SendRPC;
	import org.musince.actions.WaitingForClick;
	import org.musince.global.$athena;
	import org.musince.global.$log;

	public function play_talk(text:Dictionary):void
	{
		$log.debug("[talk]", text.from+":", text.text);
		var rpc:SendRPC = new SendRPC("next_main_action", null);
		var click:WaitingForClick = new WaitingForClick();
		click.appendNext(rpc);
		$athena.addTimeSlice(click);
	}
}