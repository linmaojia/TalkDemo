<?php

$talkId = $_GET["talkId"];
$talkString = $_GET["talkString"];
error_reporting(E_ALL ^ E_DEPRECATED);
$con = mysql_connect(SAE_MYSQL_HOST_M.':'.SAE_MYSQL_PORT,SAE_MYSQL_USER,SAE_MYSQL_PASS);

//$con = mysql_connect("localhost","root","");  //连接到一个 MySQL 数据库
if ($con) {
    mysql_select_db(SAE_MYSQL_DB, $con);

    // ...
}


$sql="UPDATE talk_1 SET talkString = '$talkString' WHERE talkId = '$talkId'";//插入数据

if (!mysql_query($sql,$con))
  {
  die('Error: ' . mysql_error());
  }


 $json=$arrayName = array('message' => "更新成功");
echo json_encode($json);


mysql_close($con)



?>

