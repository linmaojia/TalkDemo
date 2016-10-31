//
//  UIView+Empty.h
//
//  Created by jiangkun on 16/4/29.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVHTTPClient.h"

typedef void(^RefreshBlock)();

@interface UIView (Empty)

@property (nonatomic, strong, readonly) UIView *bottomView;

@property (nonatomic, copy) RefreshBlock block;

@property(nonatomic, assign)EmptyViewTypes type;


//用此方法即可
- (void)showEmptyViewWithtype:(EmptyViewTypes)type IsOrder:(BOOL)isOrder refresh:(RefreshBlock)block;

//- (void)showNetWorkErrorWithRefresh:(RefreshBlock)block;
//
//- (void)showEmptyViewWithRefresh:(RefreshBlock)block;

- (void)showWithImageName:(NSString *)imageName
                    title:(NSString *)title
              detailTitle:(NSString *)detailTitle
              buttonTitle:(NSString *)buttonTitle
                  refresh:(RefreshBlock)block;

- (void)removeEmptyView;

@end
