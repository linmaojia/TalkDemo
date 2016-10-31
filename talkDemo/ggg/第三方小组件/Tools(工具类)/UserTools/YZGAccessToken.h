//
//  ETAccessToken.h
//  ETao
//
//  Created by AVGD—JK on 16/3/4.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZGAccessToken : NSObject<NSCoding>

@property (nonatomic, copy) NSString *userId;    /**< 用户账号 */

@property(nonatomic, copy)NSString *accessToken;    /**< 令牌 */

@property(nonatomic, assign)BOOL isLogin;           /**< 是否登录 */

@property(nonatomic, strong)NSDate *outDate;          /**< 过期日期 */

@property(nonatomic, assign)float outTime;          /**< 过期具体时间(秒) */

@end
