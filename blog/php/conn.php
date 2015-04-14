<?php
$conn = @mysql_connect("localhost", "root", "mypassword") or die("DB Error.");
mysql_select_db("mydata", $conn);
mysql_query("set names 'utf8'");
?>
