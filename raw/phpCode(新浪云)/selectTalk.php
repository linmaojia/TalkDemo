<?php
header("content-type:text/html;charset=utf-8");
 //$userID =  $_GET["userID"];
// 连主库
error_reporting(E_ALL ^ E_DEPRECATED);
$con = mysql_connect(SAE_MYSQL_HOST_M.':'.SAE_MYSQL_PORT,SAE_MYSQL_USER,SAE_MYSQL_PASS);

//$con = mysql_connect("localhost","root","");  //连接到一个 MySQL 数据库
if ($con) {
    mysql_select_db(SAE_MYSQL_DB, $con);

    // ...
}




$result = mysql_query("SELECT * FROM talk_1 ORDER BY talkID DESC");//倒序查询

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

   $imaUrls = array();//图片数组
   
   if(!empty($urls))//不等于空
   {
      
     $foo = explode(',',$urls);//字符串根据逗号切割获取图片数组

      foreach($foo as $value) // 遍历数组 
      {      
        $imaUrl = "http://linmaojia-image.stor.sinaapp.com/uploadPic/".$value;    
       
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