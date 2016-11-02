<?php


header("Content-type:application/octet-stream");        //这句告诉以流的形式来接收数据；
//接收文本

    // 这个是iOS端通过parameters传递过来的参数
   $talkString = $_POST["talkString"];

    // 这里的test就是parameter传递过来的参数
    $file = $_FILES['file'];


    $picUrls;
    $number = count($_FILES['file']['error']);
    for ($i=0; $i<$number; $i++)
     {
        if ($_FILES['file']['error'][$i] == 0)
        {
       

        //这里在同目录下需要有uploadPic文件夹
      
        $fillname = $_FILES['file']['name'][$i]; // 得到文件全名，多张图片要用[$i]
        $dotArray = explode('.', $fillname); // 以.分割字符串，得到数组
        $type = end($dotArray); // 得到最后一个元素：文件后缀
        $picName = md5(uniqid(rand())).'.'.$type;

        $path = "../image/uploadPic/".$picName; // 产生随机唯一的名字
          if(move_uploaded_file($_FILES['file']['tmp_name'][$i], $path))
          {
              //拼接图片路径
            if($i == 0)
            {
              $picUrls = $picName;
            }
            else
            {
              $picUrls = $picUrls.",".$picName;
            }
          
            //插入数据库
             if($i == $number -1)
             {
              
              insertData($talkString,$picUrls);
              //$foo = explode(',',$picUrls);//字符串根据逗号切割
              // echo $foo[0];  //输出结果：aaaaaa
             // echo json_encode(array("status"=>1, "message"=>"图片上传成功", "success"=>"true","urls" => $foo));

             }
              
          }
          
          else 
          {
              echo json_encode(array("status"=>0, "message"=>"图片上传失败", "success"=>"false"));
          }
        }
    }   










 


/**
 * $_FILES 文件上传变量，是一个二维数组，第一维保存上传的文件的数组，第二维保存文件的属性，包括类型、大小等
 * 要实现上传文件，必须修改权限为加入可写 chmod -R 777 目标目录
 */

// 文件类型限制
// "file"名字必须和iOS客户端上传的name一致


//插入数据库
function insertData($text,$picName) {
  
    $con = mysql_connect("localhost","root","");  
    if (!$con) 
    {
    die('Could not connect: ' . mysql_error());
    }

    mysql_select_db("longma", $con);

    $sql="INSERT INTO talk_1 (talkString,picUrl) VALUES  ('$text','$picName') ";//插入数据

    if (!mysql_query($sql,$con))
      {
      die('Error: ' . mysql_error());
      }

      mysql_close($con);
      echo json_encode(array("status"=>1, "message"=>"图片上传成功", "success"=>"true"));
     
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