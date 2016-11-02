<?php

$talkId = $_GET["talkId"];
$talkString = $_GET["talkString"];
$con = mysql_connect("localhost","root","");  
if (!$con) 
{
die('Could not connect: ' . mysql_error());
}

mysql_select_db("longma", $con);


$sql="UPDATE talk_1 SET talkString = '$talkString' WHERE talkId = '$talkId'";//更新数据

if (!mysql_query($sql,$con))
  {
  die('Error: ' . mysql_error());
  }


 $json=$arrayName = array('message' => "更新成功");
 echo json_encode($json);


mysql_close($con)



?>

