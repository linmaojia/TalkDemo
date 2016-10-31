//
//  UIView+Extend.h
//  wucai
//
//  Created by muxi on 14/10/26.
//  Copyright (c) 2014年 muxi. All rights reserved.
//

#import <UIKit/UIKit.h>


#define CustomViewTranslate(ViewClass,view) (ViewClass *)view;

typedef enum{
    
    //上
    UIViewBorderDirectTop=0,
    
    //左
    UIViewBorderDirectLeft,
    
    //下
    UIViewBorderDirectBottom,
    
    //右
    UIViewBorderDirectRight,
    
    
}UIViewBorderDirect;

typedef enum
{
    JKSideTop = 0, /**< 上 */
    JKSideBottom   /**< 下 */
    
}JKSide; /**< 倒角方向 */

@interface UIView (Extend)

@property (nonatomic, assign) CGFloat jk_x;
@property (nonatomic, assign) CGFloat jk_y;

@property (nonatomic, assign) CGFloat jk_width;
@property (nonatomic, assign) CGFloat jk_height;

@property (nonatomic, assign) CGSize jk_size;
@property (nonatomic, assign) CGPoint jk_origin;
@property (nonatomic,assign) CGFloat jk_radius;




/**
 *  添加边框：注给scrollView添加会出错
 *
 *  @param direct 方向
 *  @param color  颜色
 *  @param width  线宽
 */
-(void)addSingleBorder:(UIViewBorderDirect)direct color:(UIColor *)color width:(CGFloat)width;


/**
 *  自动从xib创建视图
 */
+(instancetype)viewFromXIB;


/**
 *  添加一组子view：
 */
-(void)addSubviewsWithArray:(NSArray *)subViews;


/**
 *  添加边框:四边
 */
-(void)setBorder:(UIColor *)color width:(CGFloat)width;



/**
 *  调试
 */
-(void)debug:(UIColor *)color width:(CGFloat)width;



/**
 *  批量移除视图
 *
 *  @param views 需要移除的视图数组
 */
+(void)removeViews:(NSArray *)views;

/**
 *  添加任意圆角
 *
 *  @param side 圆角类型
 */
- (void)roundSide:(JKSide)side;

@end
