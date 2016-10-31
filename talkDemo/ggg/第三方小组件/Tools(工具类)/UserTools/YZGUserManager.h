//
//  UserManager.h
//  Masonry
//
//  Created by LXY on 16/5/28.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZGAccessToken.h"
#import "YZGUser.h"
@interface YZGUserManager : NSObject


+ (BOOL)firstLaunch;
+ (BOOL)isLogin;   //用户是否登录过, YES:已经登录, NO:没有登录


+ (YZGAccessToken *)accessToken;//反归档，用户数据

+ (void)saveAccessToken:(YZGAccessToken *)accessToken;//对象归档，保存数据


+ (void)saveUser:(YZGUser *)user;//保存用户模型


+ (YZGUser *)user;//取出用户模型

@end
