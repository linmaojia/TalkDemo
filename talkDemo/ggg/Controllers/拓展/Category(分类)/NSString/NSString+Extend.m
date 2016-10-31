//
//  NSString+Extend.m
//  CoreCategory
//
//  Created by 成林 on 15/4/6.
//  Copyright (c) 2015年 沐汐. All rights reserved.
//

#import "NSString+Extend.h"

@implementation NSString (Extend)
/**
 *  @method 获取指定宽度width的字符串的高度
 *
 *  @param text 文本
 *  @param Width 限制字符串显示区域的宽度
 *  @param font  Lab的Font
 *  @result CGFloat 返回的高度
 */
- (CGFloat)HeightWithText:(NSString *)text constrainedToWidth:(CGFloat)width LabFont:(UIFont *)font
{
    CGSize textSize=[text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    CGFloat height = textSize.height;
    
    return height;
    
}

/**
 *  @method 获取指定宽度width的字符串的宽度
 *
 *  @param text 文本
 *  @param Width 限制字符串显示区域的宽度
 *  @param font  Lab的Font
 *  @result CGFloat 返回的宽度
 */
- (CGFloat)widthWithText:(NSString *)text constrainedToHeight:(CGFloat)height LabFont:(UIFont *)font
{
    CGSize textSize =[text boundingRectWithSize:CGSizeMake(MAXFLOAT,height)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    CGFloat width = textSize.width;
    
    return width;
    
}


/**
 *  @method 获取指定宽度width的带间距富文本的高度
 *
 *  @param text 富文本
 *  @param Width 限制字符串显示区域的宽度
 *  @param font  富文本的Font
 *  @param style  富文本的style
 *  @result CGFloat 返回的高度
 */
- (CGFloat)HeightWithAttributedString:(NSMutableAttributedString *)text andFont:(UIFont *)font ParagraphStyle:(NSMutableParagraphStyle *)style constrainedToWidth:(CGFloat)width
{
    
    CGRect rect;
    CGFloat height;
    
    CGRect textRect=[text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil];
    
    //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
    if ((textRect.size.height - font.lineHeight) <= style.lineSpacing)
    {
        
        if ([self containChinese:text.string])//如果包含中文
        {
            rect = CGRectMake(textRect.origin.x, textRect.origin.y, textRect.size.width, textRect.size.height-style.lineSpacing);
            height = rect.size.height;
        }
        else
        {
            height = textRect.size.height;
        }
        
        
    }
    else
    {
        height = textRect.size.height;
    }
    
    return height;
    
}
/*
 判断如果包含中文
 */
- (BOOL)containChinese:(NSString *)str
{
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}
/*
 转码成UTf_8
 */
- (NSURL *)urlWithString:(NSString *)string
{
    //去编码
    string = [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *imgUrl = [NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return imgUrl;
}


@end
