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

$msgid = intval($gets['msgid']);

if ($msgid > 0) {
  // msgid mode: return the target record plus up to 5 older and 5 newer records
  $item = array();

  // fetch the target record
  $q = 'SELECT f_id, f_time, f_content FROM my_content WHERE f_name = \''.$myuser.'\' AND f_id = '.$msgid;
  $res = mysqli_query($conn, $q);
  if (!$res) { die('Query Content Error.'); }
  $target = mysqli_fetch_object($res);
  if (!$target) { die('Record Not Found.'); }

  // up to 5 newer records (f_time >= target, excluding self), ordered DESC so we get the closest 5
  $q_newer = 'SELECT f_id, f_time, f_content FROM my_content WHERE f_name = \''.$myuser.'\' AND f_time >= \''.$target->f_time.'\' AND f_id <> '.$msgid.' ORDER BY f_time ASC, f_id ASC LIMIT 5';
  $res_newer = mysqli_query($conn, $q_newer);
  if (!$res_newer) { die('Query Content Error.'); }
  $newer = array();
  while ($r = mysqli_fetch_object($res_newer)) { array_push($newer, $r); }

  // up to 5 older records (f_time <= target, excluding self), ordered DESC to get the closest 5
  $q_older = 'SELECT f_id, f_time, f_content FROM my_content WHERE f_name = \''.$myuser.'\' AND f_time <= \''.$target->f_time.'\' AND f_id <> '.$msgid.' ORDER BY f_time DESC, f_id DESC LIMIT 5';
  $res_older = mysqli_query($conn, $q_older);
  if (!$res_older) { die('Query Content Error.'); }
  $older = array();
  while ($r = mysqli_fetch_object($res_older)) { array_push($older, $r); }

  // merge: newer(ASC) + target + older(DESC), result is time DESC
  $newer_reversed = array_reverse($newer);
  $item = array_merge($newer_reversed, array($target), $older);

  echo json_encode($item, JSON_UNESCAPED_UNICODE);

} else {
  // normal mode: paginated list with optional keyword search
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
  }

  // not good for chinese
  echo json_encode($item,JSON_UNESCAPED_UNICODE);
}
//phpinfo();
?>

