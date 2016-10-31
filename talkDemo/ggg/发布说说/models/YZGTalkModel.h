//
//  YZGProductDetailModel.h
//  yzg
//
//  Created by EDS on 16/6/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
/**< 说说model */
@interface YZGTalkModel : NSObject
@property (nonatomic, copy)  NSString *talkId;
@property (nonatomic, strong) NSArray *picUrl;
@property (nonatomic, copy)  NSString *talkString;


@end
