//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGUploadImageVC.h"
#import "YZGManager.h"
@interface YZGUploadImageVC ()

@end

@implementation YZGUploadImageVC

#pragma mark ************** 懒加载控件

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"上传图片";
 
    UIBarButtonItem *talkItem = [[UIBarButtonItem alloc] initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(upLoadMoreImgAction)];
    self.navigationItem.rightBarButtonItem = talkItem;
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ************** 上传多张图片
- (void)upLoadMoreImgAction
{
    // －－－－－－－－－－－－－－－－－－－－－－－－－－－－上传图片－－－－
    /*
     此段代码如果需要修改，可以调整的位置
     1. 把upload.php改成网站开发人员告知的地址
     2. 把name改成网站开发人员告知的字段名
     */
    // 查询条件
    [SVProgressHUD show];
    NSDictionary *dic = @{@"talkString":@"哈哈，我是龙马"};
    NSArray *_photosArr = @[[UIImage imageNamed:@"userImg"],[UIImage imageNamed:@"IMG_1464"]];//IMG_1464 userImg
    // 基于AFN3.0+ 封装的HTPPSession句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    // 在parameters里存放照片以外的对象
    [manager POST:APIUploadMorePicture parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组
        
        
        
        for (int i = 0; i < _photosArr.count; i++) {
            
            UIImage *image = _photosArr[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
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
        
        // NSLog(@"```上传成功``` %@",responseObject);
        if(responseObject)
        {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
             [SVProgressHUD showSuccessWithStatus:dic[@"message"]];
             NSLog(@"```上传成功``` %@",dic);
        }
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           [SVProgressHUD dismiss];
        NSLog(@"xxx上传失败xxx %@", error);
        
    }];
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
   

}
#pragma mark ************** 上传单张图片
- (void)upLoadImgAction
{
    [SVProgressHUD show];
    
    //图片
    UIImage *image = [UIImage imageNamed:@"userImg"];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    //文本
    NSDictionary *dic = @{@"talkString":@"哈哈，我是龙马"};
    
    [MJAFNetWorking uploadWithURLString:APIUploadMorePicture parameters:dic dataImg:imageData success:^(NSDictionary *dictionary) {
        
        [SVProgressHUD showSuccessWithStatus:dictionary[@"message"]];
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        NSLog(@"---%@",error);
    }];
    
    
}

#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    
}
@end
