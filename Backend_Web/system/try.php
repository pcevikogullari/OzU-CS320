<?php

//$url = DOMAIN.'/system/call.php?comp=sender&subcomp=sendmsg&msg=naber';
$url = DOMAIN.'/system/call.php?comp=auth&subcomp=usrform&email='.urlencode("turushan.aktay@ozu.edu.tr").'&pass='.urlencode("123456");
var_dump(request($url));

/*
unset($_SESSION['userid']);

$url1 = DOMAIN.'/system/call.php?comp=auth&subcomp=sesreq';
echo "before request ->".request($url1)."<br>";

$url2 = DOMAIN.'/system/call.php?comp=auth&subcomp=sesstart&usrid=1';
echo "request ->".request($url2)."<br>";

$url3 = DOMAIN.'/system/call.php?comp=auth&subcomp=sesreq';
echo "after request ->".request($url3)."<br>";

echo "current ->".$_SESSION['userid'];

$urld = DOMAIN.'/system/call.php?comp=auth&subcomp=sesdestroy';
request($urld);
echo "<br><br>destroy<br><br>";

$url3 = DOMAIN.'/system/call.php?comp=auth&subcomp=sesreq';
echo "after request ->".request($url3)."<br>";

echo "current ->".$_SESSION['userid'];

*/