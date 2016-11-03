<?php

$talkString = $_POST["talkString"];

error_reporting(E_ALL ^ E_DEPRECATED);
$con = mysql_connect(SAE_MYSQL_HOST_M.':'.SAE_MYSQL_PORT,SAE_MYSQL_USER,SAE_MYSQL_PASS);

//$con = mysql_connect("localhost","root","");  //连接到一个 MySQL 数据库
if ($con) {
    mysql_select_db(SAE_MYSQL_DB, $con);

    // ...
}


$sql="INSERT INTO talk_1 (talkString) VALUES  ('$talkString') ";//插入数据

if (!mysql_query($sql,$con))
  {
  die('Error: ' . mysql_error());
  }


 $json=$arrayName = array('message' => "发布成功");
echo json_encode($json);


mysql_close($con)






/*
$array = array();
$array[]= "我是测试的龙马";
$array[]= "中国新导弹亮相：可对抗隐形战机 同时拦8个目标";
$array[]= "东北人口危机逼近：生育率极低 人口外流严重";
$array[]= "溥仪大婚礼节单首次亮相：楷书书写内容繁杂(图)";
$array[]= "南昌一检察院副科长坐拥上百套房 已被停职调查";
$array[]= "湖人宣布裁易建联 广东队声明:阿联愿回归";
$array[]= "阿联:不是去坐板凳 第2轮或登场 湖人主帅:易不比别人强";
$array[]= "NBA仍可签阿联 美媒评价严苛:还是老样子 合同输起跑线";
$array[]= "薪水排行榜:你猜库里第几? 十大MVP候选哈登力压詹皇";
$array[]= "西安环保官";
$array[]= "NBA仍可签阿联 美媒";
$array[]= "薪水排行榜:你猜库里第几? 十大MVP候选哈登力压詹皇";

$con = mysql_connect("localhost","root","");  
if (!$con) 
{
die('Could not connect: ' . mysql_error());
}

mysql_select_db("longma", $con);


///////////////////////////////////////循环插入
for($i = 0;$i<=10;$i++)
{
$url = "ball_".$i.".jpg";
$text = $array[$i];
$sql="INSERT INTO img_1 (talkString, picUrl) VALUES  ('$text','$url')";//插入数据

if (!mysql_query($sql,$con))
  {
  die('Error: ' . mysql_error());
  }

echo "1 record added";


}
mysql_close($con)
*/


?>

