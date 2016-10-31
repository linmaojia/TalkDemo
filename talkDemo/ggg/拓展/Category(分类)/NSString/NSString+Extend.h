//
//  NSString+Extend.h
//  CoreCategory
//
//  Created by 成林 on 15/4/6.
//  Copyright (c) 2015年 沐汐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)


/*
 *  时间戳对应的NSDate
 */
@property (nonatomic,strong,readonly) NSDate *date;


/**
 *  计算文本的宽高
 *
 *  @param font    文本显示的字体
 *  @param size 文本显示的范围(一般使用:CGSizeMake(MAXFLOAT, MAXFLOAT))
 *  @param lineBreakMode 文本对齐方式
 
 *  @return 文本占用的真实宽高
 */
- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;



@end
