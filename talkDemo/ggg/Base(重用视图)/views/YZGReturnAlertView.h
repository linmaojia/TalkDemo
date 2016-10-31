//
//  YZGAlertView.h
//  Masonry
//
//  Created by LXY on 16/6/14.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZGReturnAlertView : UIView
- (instancetype)initWithTitle:(NSString *)title;
@property (nonatomic,copy) void(^alertYesBlock)();     /**< 确定按钮点击 */
@property (nonatomic,copy) void(^alertNoBlock)();     /**< 取消按钮点击 */



@end
