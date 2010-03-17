#!/usr/bin/php -q
<?php

foreach (array('voip_api.inc') as $file) {
  require_once(dirname(__FILE__) . DIRECTORY_SEPARATOR . $file); 
}

$voip_server = 'http://localhost/d6/xmlrpc.php';

echo("\n");
echo("-------\n");
echo("Testing xmlrpc infrastructure \n");
echo("-------\n");

echo("about to call system.listMethods\n");
$result = xmlrpc($voip_server, 'system.listMethods');
echo('result: ' . print_r($result, TRUE) . "\n");

echo("about to call voip.hello\n");
$result = xmlrpc($voip_server, 'voip.hello', 'John');
echo('result: ' . print_r($result, TRUE) . "\n");


echo("\n");
echo("-------\n");
echo("Testing voip_process_request()\n");
echo("-------\n");

$request_id = 'test_invalid';
echo("about to call voip_process_request($request_id)\n");
$options = array('arg1' => '1', 'arg2' => 'blue');
$result = voip_process_request($voip_server, $request_id, $options);
echo('result: ' . print_r($result) . "\n");

$request_id = 'test_echo';
echo("about to call voip_process_request($request_id)\n");
$options = array('arg1' => '1', 'arg2' => 'blue');
$result = voip_process_request($voip_server, $request_id, $options);
echo('result: ' . print_r($result) . "\n");

$request_id = 'non existent';
echo("about to call voip_process_request($request_id)\n");
$options = array('arg1' => '1', 'arg2' => 'blue');
$result = voip_process_request($voip_server, $request_id, $options);
echo('result: ' . print_r($result) . "\n");

$request_id = 'test_failure';
echo("about to call voip_process_request($request_id)\n");
$options = array('arg1' => '1', 'arg2' => 'blue');
$result = voip_process_request($voip_server, $request_id, $options);
echo('result: ' . print_r($result) . "\n");


echo("\n");
echo("-------\n");
echo("Testing voip_send_request()\n");
echo("-------\n");

$request_id = "seat!";
$options = array('time' => 'now', 'bark' => 'loud');
echo("about to call voip.sendRequest with request_id: $request_id\n");
$result = xmlrpc($voip_server, 'voip.sendRequest', $request_id, $options);
echo('result: ' . print_r($result, TRUE) . "\n");

$request_id = "voip_echo";
$options = array('time' => 'now', 'bark' => 'loud');
echo("about to call voip.sendRequest with request_id: $request_id\n");
$result = xmlrpc($voip_server, 'voip.sendRequest', $request_id, $options);
echo('result: ' . print_r($result, TRUE) . "\n");

$request_id = "voip_failure";
$options = array('time' => 'now', 'bark' => 'loud');
echo("about to call voip.sendRequest with request_id: $request_id\n");
$result = xmlrpc($voip_server, 'voip.sendRequest', $request_id, $options);
echo('result: ' . print_r($result, TRUE) . "\n");


echo("\n");
echo("-------\n");
echo("End of tests\n");
echo("-------\n");

?>
