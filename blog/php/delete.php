<?php 
header('Content-type:text/json');
include("conn.php");

function jsonRemoveUnicodeSequences($struct) {
   return preg_replace("/\\\\u([a-f0-9]{4})/e", "iconv('UCS-4LE','UTF-8',pack('V', hexdec('U$1')))", json_encode($struct));
}

parse_str($_SERVER['QUERY_STRING'], $gets);
//print_r($gets);

$delid = str_replace('\'', ' ', $gets['delid']);
if (!$delid) {
  die('Nothing to Delete.');
}

$session = str_replace('\'', ' ', $gets['session']);
$session = str_replace('"', ' ', $session);

$query = 'SELECT * FROM my_user WHERE f_key = \''.$session.'\'';

$result = mysql_query($query);
if (!$result) {
  die('Query User Error.');
}

$row = mysql_fetch_array($result);
if (!$row) {
  die('Query No Result.');
}

$myuser = $row['f_name'];
if (!$myuser) {
  die('Auth Failed.');
}

//echo $myuser;

// Now user and page got, do the query and output
$del = 'DELETE FROM my_content WHERE f_name = \''.$myuser.'\' AND f_id = \'' . $delid . '\'';

$result = mysql_query($del);
if (!$result) {
  die('Delete Content Error.');
}
echo "Success";
?>

