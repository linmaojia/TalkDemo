//
//  MJAFNetWorking.m
//  ggg
//
//  Created by LXY on 16/10/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "MJAFNetWorking.h"

@implementation MJAFNetWorking
//GET请求
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(HttpSuccess)success
                 failure:(HttpFailure)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//可以接受的类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];//内容类型
    
    /*
     manager.operationQueue.maxConcurrentOperationCount = 5;//请求队列的最大并发数
     manager.requestSerializer.timeoutInterval = 5;//请求超时的时间
     */
    
    
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject)
        {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            success(dic);
        }
      
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        if(error)
        {
            failure(error);
        }
    }];
}

+ (void)postWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(HttpSuccess)success
                 failure:(HttpFailure)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//可以接受的类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];//内容类型
    
    /*
     manager.operationQueue.maxConcurrentOperationCount = 5;//请求队列的最大并发数
     manager.requestSerializer.timeoutInterval = 5;//请求超时的时间
     */
    
    
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject)
        {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            success(dic);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(error)
        {
            failure(error);
        }
        
    }];
}
+ (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                    dataImg:(NSData *)data
                    success:(HttpSuccess)success
                    failure:(HttpFailure)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    
    
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:data
                                    name:@"file" //名称要与服务端一致
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        //上传成功
        if(responseObject)
        {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            success(dic);
        }
        
        
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
      
        if(error)
        {
            failure(error);
        }
    }];
    

}

+ (void)uploadMoreImgWithURLString:(NSString *)URLString
                        parameters:(id)parameters
                           dataImg:(NSArray *)imgArray
                           success:(HttpSuccess)success
                           failure:(HttpFailure)failure
{
    // －－－－－－－－－－－－－－－－－－－－－－－－－－－－上传图片－－－－
    /*
     此段代码如果需要修改，可以调整的位置
     1. 把upload.php改成网站开发人员告知的地址
     2. 把name改成网站开发人员告知的字段名
     */
    // 查询条件
    [SVProgressHUD show];
    // 基于AFN3.0+ 封装的HTPPSession句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    // 在parameters里存放照片以外的对象
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组
        
        
        
        for (int i = 0; i < imgArray.count; i++) {
            
            UIImage *image = imgArray[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
            // 多张图片不能用此方法，应为会造成重复命名只保存最后一张图片
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:imageData
                                        name:@"file[]" //名称要与服务端一致,多张图片要加[]
                                    fileName:fileName
                                    mimeType:@"image/jpeg/png/jpg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---上传进度--- %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(responseObject)
        {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            success(dic);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(error)
        {
            failure(error);
        }
        
    }];
}


@end
