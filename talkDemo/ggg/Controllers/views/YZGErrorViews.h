//
//  ErrorViews.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZGErrorViews : UIView

@property (nonatomic,copy) void(^ErrorBtnClick)();

@property (nonatomic,assign) EmptyViewTypes errorType;
@property (nonatomic,assign) BOOL isOrder;

@end
