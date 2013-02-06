package org.musince.rpc
{
	import globals.$client;

	public function query_success(...args):void
	{
		$client.querySuccess.apply($client, args);  
	}
}