<?php
// php 7.2 with php7.2-mysql
$conn = @mysqli_connect("localhost", "root", "") or die('DB Error. '.@mysqli_connect_error());
mysqli_select_db($conn, "mydata");
mysqli_query($conn, "set names 'utf8'");
?>
