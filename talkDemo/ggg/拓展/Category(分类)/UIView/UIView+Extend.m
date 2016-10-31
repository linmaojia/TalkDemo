//
//  UIView+Extend.m
//  wucai
//
//  Created by muxi on 14/10/26.
//  Copyright (c) 2014年 muxi. All rights reserved.
//

#import "UIView+Extend.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIView (Extend)



/**
 *  添加边框：注给scrollView添加会出错
 *
 *  @param direct 方向
 *  @param color  颜色
 *  @param width  线宽
 */
-(void)addSingleBorder:(UIViewBorderDirect)direct color:(UIColor *)color width:(CGFloat)width{
    
    UIView *line=[[UIView alloc] init];
    
    //设置颜色
    line.backgroundColor=color;
    
    //添加
    [self addSubview:line];
    
    //禁用ar
    line.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSDictionary *views=NSDictionaryOfVariableBindings(line);
    NSDictionary *metrics=@{@"w":@(width),@"y":@(self.jk_height - width),@"x":@(self.jk_width - width)};
    
    
    NSString *vfl_H=@"";
    NSString *vfl_W=@"";
    
    //上
    if(UIViewBorderDirectTop==direct){
        vfl_H=@"H:|-0-[line]-0-|";
        vfl_W=@"V:|-0-[line(==w)]";
    }
    
    //左
    if(UIViewBorderDirectLeft==direct){
        vfl_H=@"H:|-0-[line(==w)]";
        vfl_W=@"V:|-0-[line]-0-|";
    }
    
    //下
    if(UIViewBorderDirectBottom==direct){
        vfl_H=@"H:|-0-[line]-0-|";
        vfl_W=@"V:[line(==w)]-0-|";
    }
    
    //右
    if(UIViewBorderDirectRight==direct){
        vfl_H=@"H:|-x-[line(==w)]";
        vfl_W=@"V:|-0-[line]-0-|";
    }

    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl_H options:0 metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl_W options:0 metrics:metrics views:views]];
}



/**
 *  自动从xib创建视图
 */
+(instancetype)viewFromXIB{
    
    NSString *name=NSStringFromClass(self);
    
    UIView *xibView=[[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] firstObject];
    
    if(xibView==nil){
        NSLog(@"CoreXibView：从xib创建视图失败，当前类是：%@",name);
    }
    
    return xibView;
}




- (void)setJk_x:(CGFloat)jk_x
{
    CGRect frame = self.frame;
    frame.origin.x = jk_x;
    self.frame = frame;
}

- (void)setJk_y:(CGFloat)jk_y
{
    CGRect frame = self.frame;
    frame.origin.y = jk_y;
    self.frame = frame;
}

- (CGFloat)jk_x
{
    return self.frame.origin.x;
}

- (CGFloat)jk_y
{
    return self.frame.origin.y;
}

- (void)setJk_width:(CGFloat)jk_width
{
    CGRect frame = self.frame;
    frame.size.width = jk_width;
    self.frame = frame;
}

- (void)setJk_height:(CGFloat)jk_height
{
    CGRect frame = self.frame;
    frame.size.height = jk_height;
    self.frame = frame;
}

- (CGFloat)jk_height
{
    return self.frame.size.height;
}

- (CGFloat)jk_width
{
    return self.frame.size.width;
}

- (void)setJk_size:(CGSize)jk_size
{
    CGRect frame = self.frame;
    frame.size = jk_size;
    self.frame = frame;
}

- (CGSize)jk_size
{
    return self.frame.size;
}

- (void)setJk_origin:(CGPoint)jk_origin
{
    CGRect frame = self.frame;
    frame.origin = jk_origin;
    self.frame = frame;
}

- (CGPoint)jk_origin
{
    return self.frame.origin;
}



#pragma mark  添加一组子view：
-(void)addSubviewsWithArray:(NSArray *)subViews{
    
    for (UIView *view in subViews) {
        
        [self addSubview:view];
        
    }
}



#pragma mark  圆角处理
-(void)setJk_radius:(CGFloat)jk_radius
{
    
    if(jk_radius<=0) jk_radius = self.frame.size.width * .5f;
    
    //圆角半径
    self.layer.cornerRadius = jk_radius;
    
    //强制
    self.layer.masksToBounds=YES;
}

-(CGFloat)radius{
    return 0;
}

/**
 *  添加底部的边线
 */
-(void)setBottomBorderColor:(UIColor *)bottomBorderColor{
    
}




-(UIColor *)bottomBorderColor{
    return nil;
}

/**
 *  添加边框
 */
-(void)setBorder:(UIColor *)color width:(CGFloat)width{
    CALayer *layer=self.layer;
    layer.borderColor=color.CGColor;
    layer.borderWidth=width;
}




/**
 *  调试
 */
-(void)debug:(UIColor *)color width:(CGFloat)width{
    
    [self setBorder:color width:width];
}

/**
 *  批量移除视图
 *
 *  @param views 需要移除的视图数组
 */
+(void)removeViews:(NSArray *)views{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (UIView *view in views) {
            [view removeFromSuperview];
        }
    });
}


/**
 *  添加圆角
 *
 *  @param side 圆角类型
 */
- (void)roundSide:(JKSide)side
{

    UIBezierPath *maskPath;
    if(side == JKSideTop)
    {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    }
    else
    {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    }
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}

@end
