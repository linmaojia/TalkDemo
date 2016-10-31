//
//  YZGOrderButtonView.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGOrderButtonView.h"

@interface YZGOrderButtonView ()
{
    CGFloat button_width,button_height;
    CGFloat self_width,self_height;
}
@property (nonatomic, strong) UIButton *tempBtn;
@property (nonatomic, strong) UIView *lineView;      /**< 顶部横线 */
@end
@implementation YZGOrderButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self_width = self.frame.size.width;
        self_height = self.frame.size.height;
        
    }
    return self;
}
//- (void)setFrame:(CGRect)frame
//{
//    self_width = self.frame.size.width;
//    self_height = self.frame.size.height;
//}
- (void)setIndex:(NSInteger)index
{
    UIButton *selectBtn = (UIButton *)[self viewWithTag:100 + index];
    self.tempBtn.selected = !self.tempBtn.selected;
    selectBtn.selected = YES;
    self.tempBtn = selectBtn;
    
    
    [UIView animateWithDuration:0.15 animations:^{
        
        self.lineView.center = CGPointMake(selectBtn.center.x, self.lineView.center.y);
        
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark ************** 布局
- (void)setButtonArray:(NSArray *)buttonArray
{
    button_width  =  self_width/buttonArray.count;
    button_height =  self_height;
    
    for (int i = 0; i < buttonArray.count; i++)
    {
        
        UIButton *button = [[UIButton alloc]init];
        button.titleLabel.font = systemFont(15);
        button.frame = CGRectMake(i*button_width, 0, button_width, button_height);
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:buttonArray[i] forState:0];
        [button setTitleColor:[UIColor blackColor] forState:0];
        [button setTitleColor:mainColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(optionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        [self addSubview:button];
        
    }
    
    
    UIButton *selectBtn = (UIButton *)[self viewWithTag:100];
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 45, 2)];
    self.lineView.center = CGPointMake(selectBtn.center.x, button_height - 1);
    self.lineView.backgroundColor = mainColor;
    [self addSubview:self.lineView];
}
#pragma mark ************** 隐藏线条
- (void)setIsHideLineView:(BOOL)isHideLineView
{
    self.lineView.hidden = isHideLineView;
}
#pragma mark ************** downView上的button点击事件
- (void)optionButtonClick:(UIButton *)sender
{
    
    self.tempBtn.selected = !self.tempBtn.selected;
    sender.selected = YES;
    self.tempBtn = sender;
    
    
    [UIView animateWithDuration:0.15 animations:^{
        
        self.lineView.center = CGPointMake(sender.center.x, self.lineView.center.y);
        
    } completion:^(BOOL finished) {
        
    }];
    
    if(self.orderButtonClick)
    {
        self.orderButtonClick(sender.tag - 100);
    }
}

@end
