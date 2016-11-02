<?php

$talkId = $_GET["talkId"];

$con = mysql_connect("localhost","root","");  
if (!$con) 
{
die('Could not connect: ' . mysql_error());
}

mysql_select_db("longma", $con);
//先查询数据库,获得图片路径
 $resultUrl = mysql_query("SELECT * FROM talk_1 WHERE talkId = '$talkId'");//倒序查询
 $row=mysql_fetch_array($resultUrl);

 if(!empty($row['picUrl']))
 {
     deleteImage($row['picUrl']);//删除本地图片
 }
 
 deleteImagePath();//删除数据库信息
	
	



//删除数据库数据
function deleteImagePath() 
{
	global $con,$talkId; //用于访问外部变量
   $sql="DELETE FROM talk_1 WHERE talkId = '$talkId'";
	if (mysql_query($sql,$con))//删除数据库数据
	{
		$json= array('message' => "删除成功");
		echo json_encode($json); 
		mysql_close($con);

	}
	else
	{

	   die('Error: ' . mysql_error());
	}
}

//删除本地图片数组
function deleteImage($urls) 
{

  $foo = explode(',',$urls);//字符串根据逗号切割获取图片数组

  foreach($foo as $value) // 遍历数组 
  {  


   $imagePath = "../image/uploadPic/".$value;
   unlinkFile($imagePath);
   
  }
   
}
 function unlinkFile($aimUrl) {  
            if (file_exists($aimUrl)) {  
                unlink($aimUrl);  
                return true;  
            } else {  
                return false;  
            }  
        }  
?>

