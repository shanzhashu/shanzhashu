<?php 
header('Content-type:text/json');
include("conn.php");

parse_str($_SERVER['QUERY_STRING'], $gets);
//print_r($gets);

$session = str_replace('\'', ' ', $gets['session']);
$session = str_replace('"', ' ', $session);

if (!$session) {
  $session = str_replace('\'', ' ', $_POST['session']);
  $session = str_replace('"', ' ', $session);
  if (!session) {
    die('Query No Session.');
  }
}

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
$post = str_replace('\'', ' ', $_POST['content']);
if (!$post) {
  die('No Content.');
}

// Now user and page got, do the query and output
$ins = 'INSERT INTO my_content (f_id, f_time, f_name, f_content) VALUES (NULL , NOW( ) , \'' . $myuser . '\', \'' . ($post) . '\');';

$result = mysql_query($ins);
if (!$result) {
  die('Query Content Error.');
}

echo "Success"
//phpinfo(); 
?>

