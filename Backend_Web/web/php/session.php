<?php

include_once 'includes.php';

if (isset($_POST['userid'])){
	$userid = $_POST['userid'];

	$url = $domain."/system/call.php?comp=auth&subcomp=sesstart&usrid=".$userid;
	$return1 = request($url);

	$url2 = $domain."/system/call.php?comp=auth&subcomp=sesreq";
	$return2 = request($url2);

	echo $return1 == $return2;
}
