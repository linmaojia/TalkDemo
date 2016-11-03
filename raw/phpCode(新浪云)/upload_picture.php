<?php

header('Content-type: text/json; charset=UTF-8' );
//接收文本
$talkString = $_POST["talkString"];

 
error_reporting(E_ALL ^ E_DEPRECATED);

/**
 * $_FILES 文件上传变量，是一个二维数组，第一维保存上传的文件的数组，第二维保存文件的属性，包括类型、大小等
 * 要实现上传文件，必须修改权限为加入可写 chmod -R 777 目标目录
 */

// 文件类型限制
// "file"名字必须和iOS客户端上传的name一致
if (($_FILES["file"]["type"] == "image/gif")
|| ($_FILES["file"]["type"] == "image/jpeg")
|| ($_FILES["file"]["type"] == "image/png")
|| ($_FILES["file"]["type"] == "image/pjpeg"))
// && ($_FILES["file"]["size"] < 20000)) // 小于20k
{
    if ($_FILES["file"]["error"] > 0) 
    {

        echo $_FILES["file"]["error"]; // 错误代码
    } 
    else 
    {           
        $fillname = $_FILES['file']['name']; // 得到文件全名
        $dotArray = explode('.', $fillname); // 以.分割字符串，得到数组
        $type = end($dotArray); // 得到最后一个元素：文件后缀


        $picName = $_FILES['file']['name'];
        $path = "upload/uploadPic/".$picName; // 产生随机唯一的名字
         
        $s =new SaeStorage();
        $i='uploadPic/'.$picName; //文件名
        $domain='image'; //storage名
        $s->upload( $domain , $i ,$_FILES['file']['tmp_name'] ); //上传
        
        /*
           move_uploaded_file( // 从临时目录复制到目标目录
          $_FILES["file"]["tmp_name"], // 存储在服务器的文件的临时副本的名称
          $path);
        */
     

        //插入数据库
        insertData($talkString,$picName);

        
    } 
}

 else 
{
    
    echo json_encode(array('message' => "文件类型不正确"));
}


//插入数据库
function insertData($text,$picName) {
  
   $con = mysql_connect(SAE_MYSQL_HOST_M.':'.SAE_MYSQL_PORT,SAE_MYSQL_USER,SAE_MYSQL_PASS);

//$con = mysql_connect("localhost","root","");  //连接到一个 MySQL 数据库
if ($con) {
    mysql_select_db(SAE_MYSQL_DB, $con);

    // ...
}


    $sql="INSERT INTO talk_1 (talkString,picUrl) VALUES  ('$text','$picName') ";//插入数据

    if (!mysql_query($sql,$con))
      {
      die('Error: ' . mysql_error());
      }

      mysql_close($con);

      echo json_encode(array('message' => "上传成功"));
} 

/*
./  当前路径，可省略
../ 上一层目录，可重复使用，如../../，表示上上层目录

*/

          /*
move_uploaded_file() 函数将上传的文件移动到新位置。
move_uploaded_file(file,newloc)
file  必需。规定要移动的文件。
newloc  必需。规定文件的新位置。
        */



?>