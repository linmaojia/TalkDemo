//
//  YZGOrderButtonView.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
/*收藏界面购物车*/
@interface YZGShoppingCarView : UIView
@property (nonatomic, assign) NSInteger count;/*数量*/
@property (nonatomic,copy) void(^carButtonClick)();  //block回调
@end
