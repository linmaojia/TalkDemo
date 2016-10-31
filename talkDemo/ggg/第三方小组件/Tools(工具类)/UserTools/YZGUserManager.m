//
//  UserManager.m
//  Masonry
//
//  Created by LXY on 16/5/28.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGUserManager.h"
#define ETAccessTokenFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"YZGaccessToken.data"]
#define ETUserFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"YZGuser.data"]
@implementation YZGUserManager

+ (BOOL)firstLaunch
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return YES;
    }
    
    return NO;
}
+ (BOOL)isLogin
{
    YZGAccessToken *accessToken = [YZGUserManager accessToken];//获取数据
    
    if(accessToken == nil)  //第一次登陆
        return NO;
    
    if(accessToken.isLogin == NO) //之前退出登陆
    {
        
        return NO;
    }
    else
    {
        //判断
        //如果过期
        if([self isTimeOut])
        {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [SVProgressHUD showInfoWithStatus:@"由于您长时间未操作, 需要您重新登录"];
            });
            return NO;
        }
        else
        {
            //重新生成过期时间，每次登陆都要生成过期时间
            NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:accessToken.outTime];
            
            accessToken.outDate = date;
            
            [self saveAccessToken:accessToken];//归档
            
            return YES;
        }
    }
    return YES;
}
+ (BOOL)isTimeOut
{
    YZGAccessToken *accessToken = [YZGUserManager accessToken];
    
    //获取剩余时间 获取2个时间的时间差
    float outTime = [accessToken.outDate timeIntervalSinceNow];
    
    //过期
    if(outTime <= 0.f)
    {
        return YES;
    }
    else
    {
        
        return NO;
    }
}

//解档令牌模型
+ (YZGAccessToken *)accessToken
{
    //解档
    YZGAccessToken *accessToken = [NSKeyedUnarchiver unarchiveObjectWithFile:ETAccessTokenFilepath];
    return accessToken;
    
}

//归档令牌模型
+ (void)saveAccessToken:(YZGAccessToken *)accessToken
{
    [NSKeyedArchiver archiveRootObject:accessToken toFile:ETAccessTokenFilepath];
}



//归档用户模型
+ (void)saveUser:(YZGUser *)user
{
    [NSKeyedArchiver archiveRootObject:user toFile:ETUserFilepath];
}

//解档用户模型
+ (YZGUser *)user
{
    YZGUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:ETUserFilepath];
    
    return user;
}

@end
