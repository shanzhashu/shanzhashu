<?php 
header('Content-type:text/json');
include("conn.php");

parse_str($_SERVER['QUERY_STRING'], $gets);
//print_r($gets);

$delid = str_replace('\'', ' ', $gets['delid']);
if (!$delid) {
  die('Nothing to Delete.');
}

$session = str_replace('\'', ' ', $gets['session']);
$session = str_replace('"', ' ', $session);

$query = 'SELECT * FROM my_user WHERE f_key = \''.$session.'\'';

$result = mysqli_query($conn,$query);
if (!$result) {
  die('Query User Error.');
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

// Now user and page got, do the query and output
$del = 'DELETE FROM my_content WHERE f_name = \''.$myuser.'\' AND f_id = \'' . $delid . '\'';

$result = mysqli_query($conn,$del);
if (!$result) {
  die('Delete Content Error.');
}
echo "Success";
?>

