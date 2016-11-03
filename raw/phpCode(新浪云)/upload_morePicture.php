<?php

//非常重要的，上传图片的大坑
header("Content-type:application/octet-stream");    //这句告诉以流的形式来接收数据；
//接收文本
$talkString = $_POST["talkString"];

 
error_reporting(E_ALL ^ E_DEPRECATED);

/**
 * $_FILES 文件上传变量，是一个二维数组，第一维保存上传的文件的数组，第二维保存文件的属性，包括类型、大小等
 * 要实现上传文件，必须修改权限为加入可写 chmod -R 777 目标目录
 */

// 文件类型限制
// "file"名字必须和iOS客户端上传的name一致
    $picUrls;
     $s =new SaeStorage();
    $domain='image'; //storage名
    $number = count($_FILES['file']['error']);
    for ($i=0; $i<$number; $i++)
     {
        if ($_FILES['file']['error'][$i] == 0)
        {

        //这里在同目录下需要有uploadPic文件夹
        $fillname = $_FILES['file']['name'][$i]; // 得到文件全名，多张图片要用[$i]
        $dotArray = explode('.', $fillname); // 以.分割字符串，得到数组
        $type = end($dotArray); // 得到最后一个元素：文件后缀
         $code = '';
          for($j=1;$j<=10;$j++)
         {
           $code .= chr(rand(97,122));
          }

          $picName = $code.".".$type;
          $path='uploadPic/'.$picName; //文件名 uploadPic
          $s->upload( $domain , $path ,$_FILES['file']['tmp_name'][$i]); //上传
           // // // // //拼接图片路径
            if($i == 0)
            {
              $picUrls = $picName;
            }
            else
            {
              $picUrls = $picUrls.",".$picName;
            }
          
             if($i == $number -1)
             {
              
              insertData($talkString,$picUrls);//插入数据库

             }

        }
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