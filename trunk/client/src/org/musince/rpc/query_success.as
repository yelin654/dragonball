package org.musince.rpc
{
	import org.musince.global.$client;

	public function query_success(...args):void
	{
		$client.querySuccess.apply($client, args);  
	}
}