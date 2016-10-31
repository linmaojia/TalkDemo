//
//  JKPlaceholderTextView.m
//  Test
//
//  Created by AVGD—JK on 15/12/28.
//  Copyright © 2015年 AVGD. All rights reserved.
//

#import "JKPlaceholderTextView.h"

@interface JKPlaceholderTextView()

@property(nonatomic, strong)UILabel *placeholderLabel;   /**< 用来显示占位符的label */

@property(nonatomic, strong)UILabel *limitTextLengthLabel;   /**< 限制文本长度label */

@end

@implementation JKPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //创建用来显示占位符的label
        self.placeholderLabel = [[UILabel alloc] init];
        
        self.placeholderLabel.backgroundColor = [UIColor clearColor];
        self.placeholderLabel.textColor = [UIColor grayColor];
        self.placeholderLabel.numberOfLines = 0;
        
        [self addSubview:self.placeholderLabel];
        
        self.limitTextLengthLabel = [[UILabel alloc] init];
        
        self.limitTextLengthLabel.backgroundColor = [UIColor clearColor];
        self.limitTextLengthLabel.textColor = [UIColor blackColor];
        self.limitTextLengthLabel.textAlignment = NSTextAlignmentCenter;
        self.limitTextLengthLabel.hidden = YES;
        self.limitTextLengthLabel.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:self.limitTextLengthLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}

- (void)textDidChange
{
    //如果有文字则隐藏  无文字则显示
    self.placeholderLabel.hidden = self.hasText;
    
    if(_limitTextLength > 0)
    {
        NSInteger textLength = self.text.length;
        
        if (textLength > self.limitTextLength) {
            
            self.limitTextLengthBlock(); 
#warning 修改简介textView限制字体输入xxxxxxxxxxxxxx
            self.text = [self.text substringToIndex:self.limitTextLength];

        }
        
        self.limitTextLengthLabel.text = [NSString stringWithFormat:@"%d",self.limitTextLength - (int)self.text.length];
    }
    


}

- (void)setLimitTextLength:(int)limitTextLength
{
    _limitTextLength = limitTextLength;
    
    if(_limitTextLength > 0)
    {
        self.limitTextLengthLabel.hidden = NO;
        self.limitTextLengthLabel.text = [NSString stringWithFormat:@"%d",limitTextLength - (int)self.text.length];
    }
    else
    {
        self.limitTextLengthLabel.hidden = YES;
    }
}

- (void)setPlacehoderTextLabelTextColor:(UIColor *)placehoderTextLabelTextColor
{
    _placehoderTextLabelTextColor = placehoderTextLabelTextColor;
    
    self.placeholderLabel.textColor = placehoderTextLabelTextColor;
}

- (void)setLimitTextLengthLabelTextColor:(UIColor *)limitTextLengthLabelTextColor
{
    _limitTextLengthLabelTextColor = limitTextLengthLabelTextColor;
    
    self.limitTextLengthLabel.textColor = limitTextLengthLabelTextColor;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setPlacehoderText:(NSString *)placehoderText
{
    _placehoderText = placehoderText;
    
    self.placeholderLabel.text = placehoderText;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat placehoderLabel_x = self.bounds.origin.x + 5;
    CGFloat placehoderLabel_y = self.bounds.origin.y + 7;
    CGFloat placehoderLabel_w = self.bounds.size.width - 10;
    CGFloat placehoderLabel_h = [_placehoderText boundingRectWithSize:CGSizeMake(placehoderLabel_w, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.placeholderLabel.font} context:nil].size.height;
    
    self.placeholderLabel.frame = CGRectMake(placehoderLabel_x, placehoderLabel_y, placehoderLabel_w, placehoderLabel_h);
    
    
    CGFloat limitTextLengthLabel_w = [[NSString stringWithFormat:@"%d",self.limitTextLength] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.width + 5;
    CGFloat limitTextLengthLabel_h = 20;
    CGFloat limitTextLengthLabel_x = self.bounds.size.width - limitTextLengthLabel_w - 5;
    CGFloat limitTextLengthLabel_y = self.bounds.size.height - limitTextLengthLabel_h - 5 ;
    
    self.limitTextLengthLabel.frame = CGRectMake(limitTextLengthLabel_x, limitTextLengthLabel_y, limitTextLengthLabel_w, limitTextLengthLabel_h);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

@end
