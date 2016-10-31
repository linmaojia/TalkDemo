//
//  ETUser.m
//  ETao
//
//  Created by AVGD—JK on 15/11/19.
//  Copyright © 2015年 jacky. All rights reserved.
//

#import "YZGUser.h"


@implementation YZGUser

/**
 *  当把一个对象 归档 到文件中 会调用一次
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{


    [encoder encodeObject:self.seqid forKey:@"seqid"];
    [encoder encodeObject:self.userlogno forKey:@"userlogno"];
    [encoder encodeObject:self.headImage forKey:@"headImage"];
    [encoder encodeObject:self.trueName forKey:@"trueName"];
    [encoder encodeObject:self.telephone forKey:@"telephone"];
    [encoder encodeObject:self.company forKey:@"company"];
    [encoder encodeObject:@(self.sex) forKey:@"sex"];
    [encoder encodeObject:self.userpassword forKey:@"userpassword"];
    [encoder encodeObject:self.remark forKey:@"remark"];
 
}

/**
 *  从文件中 解析 一个对象 时会调用1次
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        
        self.seqid = [decoder decodeObjectForKey:@"seqid"];
        self.userlogno = [decoder decodeObjectForKey:@"userlogno"];
        self.headImage = [decoder decodeObjectForKey:@"headImage"];
        self.trueName = [decoder decodeObjectForKey:@"trueName"];
        self.telephone = [decoder decodeObjectForKey:@"telephone"];
        self.company = [decoder decodeObjectForKey:@"company"];
        self.sex = [[decoder decodeObjectForKey:@"sex"] intValue];
        self.userpassword = [decoder decodeObjectForKey:@"userpassword"];
        self.remark = [decoder decodeObjectForKey:@"remark"];
      
    }
    return self;
}

@end
