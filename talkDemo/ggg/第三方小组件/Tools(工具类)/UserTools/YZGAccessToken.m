//
//  ETAccessToken.m
//  ETao
//
//  Created by AVGD—JK on 16/3/4.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "YZGAccessToken.h"

@implementation YZGAccessToken

/**
 *  当把一个对象 归档 到文件中 会调用一次
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    
    [encoder encodeObject:self.accessToken forKey:@"accessToken"];
    [encoder encodeObject:@(self.isLogin) forKey:@"isLogin"];
    [encoder encodeObject:self.outDate forKey:@"outDate"];
    [encoder encodeObject:@(self.outTime) forKey:@"outTime"];
    [encoder encodeObject:self.userId forKey:@"userId"];
}

/**
 *  从文件中 解析 一个对象 时会调用1次
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        
        self.accessToken = [decoder decodeObjectForKey:@"accessToken"];
        self.isLogin = [[decoder decodeObjectForKey:@"isLogin"] boolValue];
        self.outDate = [decoder decodeObjectForKey:@"outDate"];
        self.outTime = [[decoder decodeObjectForKey:@"outTime"] floatValue];
        self.userId = [decoder decodeObjectForKey:@"userId"];
    }
    return self;
}

@end
