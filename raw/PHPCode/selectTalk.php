<?php

  $pagesize = $_GET['pageSize'] > 0 ? $_GET['pageSize'] : 10; //默认情况下每页显示10条数据
  $pagenum = $_GET['pageNum'] > 0 ? $_GET['pageNum'] : 0;

$deleCount = $_GET['deleCount'] > 0 ? $_GET['deleCount'] : 0;

  $query_start = $pagesize * ($pagenum - 1) - $deleCount;


$con = mysql_connect("localhost","root","");  //连接到一个 MySQL 数据库,root 用户名 密码为 空
if (!$con) //如果连接失败，将执行 "die" 部分：
{
die('Could not connect: ' . mysql_error());
}

mysql_select_db("longma", $con); //longma 数据库名称

$result = mysql_query("SELECT * FROM talk_1 ORDER BY talkID DESC limit $query_start,$pagesize");
//$result = mysql_query("SELECT * FROM talk_1 ORDER BY talkID DESC");//倒序查询

$imgArray=array();

while($row = mysql_fetch_array($result))
{

  $imgArray[]=array(
    'picUrl' => imageUrl($row['picUrl']),
    'talkId' => $row['talkId'],
    'talkString' => $row['talkString']
    );


}
   $Dic=array('urls' => $imgArray);//生成字典
   echo json_encode($Dic);

   mysql_close($con); //脚本一结束，就会关闭连接。


//处理图片路径
function imageUrl($urls) 
{
   $IP =  "http://".$_SERVER["SERVER_ADDR"];

   $imaUrls = array();//图片数组
   
   if(!empty($urls))//不等于空
   {
      
     $foo = explode(',',$urls);//字符串根据逗号切割获取图片数组

      foreach($foo as $value) // 遍历数组 
      {      
        $imaUrl = $IP."/longma/image/uploadPic/".$value;
        $imaUrls[]=$imaUrl;//添加数据
      }
   }

    return $imaUrls;
}

/*
 echo $row['picUrl'];
  echo "<br />";

  $imgArray[]=$row['picUrl'];  //返回只有 string


   $imgDic=array();
  $imgDic['picUrl']=$row['picUrl'];


  $imgArray[]=$imgDic;
*/
?>