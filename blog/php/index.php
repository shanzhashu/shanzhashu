<?php
header('Content-type:text/json');
include("conn.php");

parse_str($_SERVER['QUERY_STRING'], $gets);
//print_r($gets);

$session = str_replace('\'', ' ', $gets['session']);
$session = str_replace('"', ' ', $session);

$query = 'SELECT * FROM my_user WHERE f_key = \''.$session.'\'';

$result = mysqli_query($conn, $query);
if (!$result) {
  die('Query User Error.'.$query);
}

$row = mysqli_fetch_array($result);
if (!$row) {
  die('Query No Result.');
}

$myuser = $row['f_name'];
if (!$myuser) {
  die('Auth Failed.');
}

//echo $myuser;
$page = 0;
if ($gets['page'])
  $page = $gets['page'];

$page *= 25;

$query_word = str_replace('\'', ' ', $gets['query']);
$query_word = str_replace('"', ' ', $query_word);

// Now user and page got, do the query and output
$query = 'SELECT f_id, f_time, f_content FROM my_content WHERE f_name = \''.$myuser.'\'';
if ($query_word) {
	$query = $query.' AND f_content LIKE \'%'.$query_word.'%\'';
}
$query = $query.' ORDER BY f_time DESC LIMIT '.$page.', 25';
//echo $query;

$result = mysqli_query($conn,$query);
if (!$result) {
  die('Query Content Error.');
}

$item = array();

while($row = mysqli_fetch_object($result))
{
  array_push($item, $row);
  //echo $row['f_content'];
}

// not good for chinese
echo json_encode($item,JSON_UNESCAPED_UNICODE);
//phpinfo();
?>

