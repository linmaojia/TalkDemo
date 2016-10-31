//
//  YZGOrderButtonView.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZGOrderButtonView : UIView
@property (nonatomic, strong) NSArray *buttonArray;/*按钮数组*/
@property (nonatomic, assign) NSInteger index;/*选中*/
@property (nonatomic,copy) void(^orderButtonClick)(NSInteger index);  //block回调
@property (nonatomic, assign) BOOL isHideLineView;/*隐藏线条*/

@end
