//
//  YZGAlertView.h
//  Masonry
//
//  Created by LXY on 16/6/14.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 备注View*/
@interface YZGRemarksView : UIView

+ (void)showRemarksViewWithTitle:(NSString *)title PlacehoderText:(NSString *)placehoderText ConfirmBlock:(void(^)(NSString *text))confirmBlock CancelBlock:(void(^)())cancelBlock;

@end
