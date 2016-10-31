//
//  MJAFNetWorking.h
//  ggg
//
//  Created by LXY on 16/10/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>

//宏定义成功block 回调成功后得到的信息
typedef void (^HttpSuccess)(NSDictionary *dictionary);
//宏定义失败block 回调失败信息
typedef void (^HttpFailure)(NSError *error);

@interface MJAFNetWorking : NSObject


/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(HttpSuccess)success
                 failure:(HttpFailure)failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)postWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(HttpSuccess)success
                 failure:(HttpFailure)failure;
/**
 *  上传图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param uploadParam 上传图片的信息
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
+ (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                 dataImg:(NSData *)data
                    success:(HttpSuccess)success
                    failure:(HttpFailure)failure;

/**
 *  上传多张图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param imgArray    上传图片数组
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
+ (void)uploadMoreImgWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                    dataImg:(NSArray *)imgArray
                    success:(HttpSuccess)success
                    failure:(HttpFailure)failure;
@end
