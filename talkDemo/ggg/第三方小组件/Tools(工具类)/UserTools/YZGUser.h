//
//  ETUser.h
//  ETao
//
//  Created by AVGD—JK on 15/11/19.
//  Copyright © 2015年 jacky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZGUser : NSObject <NSCoding>

@property (nonatomic, strong) NSString *seqid;     /* id*/
@property (nonatomic, strong) NSString *userlogno;     /* 登陆名*/


@property (nonatomic, strong) NSString *headImage;  /* 头像地址*/
@property (nonatomic, strong) NSString *trueName;    /* 用户真名*/
@property (nonatomic, strong) NSString *telephone;    /* 电话号码*/
@property (nonatomic, strong) NSString *company;      /* 公司地址*/
@property (nonatomic, assign) int sex;      /* 性别*/
@property (nonatomic, strong) NSString *userpassword;       /* 密码*/
@property (nonatomic, strong) NSString *remark;       /* 个人简介*/



@end
