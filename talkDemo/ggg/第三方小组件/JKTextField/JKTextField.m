//
//  JKTextField.m
//  test
//
//  Created by AVGD—JK on 15/12/17.
//  Copyright © 2015年 AVGD. All rights reserved.
//

#import "JKTextField.h"

#define TEXT_PADDING 10;

@implementation JKTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.layer.borderWidth = 0.5;
//        self.layer.borderColor = RGB(227, 229, 230).CGColor;
        
        self.leftViewPadding = 10.f;
        self.rightViewPadding = 10.f;
        
        self.centerViewPadding = 0.0f;//中间View
    }
    return self;
}

//重写leftView的origin.x值
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect leftViewRect = [super leftViewRectForBounds:bounds];
    
    leftViewRect.origin.x += _leftViewPadding;
    
    return leftViewRect;
}

//重写rightView的origin.x值
- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    CGRect rightViewRect = [super rightViewRectForBounds:bounds];
    
    rightViewRect.origin.x -= _rightViewPadding;
    
    return rightViewRect;
}

- (void)setLeftViewPadding:(CGFloat)leftViewPadding
{
    _leftViewPadding = leftViewPadding;
    
    [self leftViewRectForBounds:self.bounds];
}

- (void)setRightViewPadding:(CGFloat)rightViewPadding
{
    _rightViewPadding = rightViewPadding;
    
    [self rightViewRectForBounds:self.bounds];
}

//重写文本框的origin.x
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect textRect = [super textRectForBounds:bounds];
    
    textRect.origin.x += _centerViewPadding;
    textRect.size.width -= _centerViewPadding;
    
    return textRect;
}

//重写编辑状态下文本框的origin.x
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect editingRect = [super editingRectForBounds:bounds];
    
    editingRect.origin.x += _centerViewPadding;
    editingRect.size.width -= _centerViewPadding;
    
    return editingRect;
}


@end
