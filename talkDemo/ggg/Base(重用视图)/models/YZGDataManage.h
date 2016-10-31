//
//  GeneralViewModel.h
//  ggg
//
//  Created by LXY on 16/9/23.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZGDataManage : NSObject

/* 根据时间戳返回 时间字符串*/
- (NSString *)changeTime:(NSInteger)time;
/* 时间戳，剩余天数*/
- (NSInteger)getCurrentDaySurplusSecond:(NSInteger)timestamp CountData:(NSInteger)countData;
/* 返回时间 */
- (NSString *)getDetailTimeWithTimestamp:(NSInteger)timestamp;


/*判断错误类型*/
+ (EmptyViewTypes)dealEmptyViewTypeWithData:(id)response error:(NSError *)error;

/*计算文本高度*/
+ (CGFloat)getLabelHeightWithText:(NSString *)text LabWidth:(CGFloat)labWidth LabFontSize:(CGFloat)labFontSize;

/*计算文本宽度*/
+ (CGFloat)getLabelwidthWithText:(NSString *)text LabHeight:(CGFloat)labHeight LabFontSize:(CGFloat)labFontSize;
@end
