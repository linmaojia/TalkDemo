//
//  NSString+Extend.h
//  CoreCategory
//
//  Created by 成林 on 15/4/6.
//  Copyright (c) 2015年 沐汐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)

/* 计算文本高度*/
- (CGFloat)HeightWithText:(NSString *)text constrainedToWidth:(CGFloat)width LabFont:(UIFont *)font;

/* 计算文本宽度*/
- (CGFloat)widthWithText:(NSString *)text constrainedToHeight:(CGFloat)height LabFont:(UIFont *)font;

/* 计算富文本宽度*/
- (CGFloat)HeightWithAttributedString:(NSMutableAttributedString *)text andFont:(UIFont *)font ParagraphStyle:(NSMutableParagraphStyle *)style constrainedToWidth:(CGFloat)width;

/* 判断如果包含中文*/
- (BOOL)containChinese:(NSString *)str;

/* 中文转码*/
- (NSURL *)urlWithString:(NSString *)imgUrl;
@end
