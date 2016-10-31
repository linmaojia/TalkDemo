//
//  ETMineViewCostomAlertView.h
//  ETao
//
//  Created by 麥展毅 on 15/11/24.
//  Copyright © 2015年 麥展毅 All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomAlertView : UIView


+ (void)showAlertViewWithTitleArray:(NSArray *)titleArray TitleBtnBlock:(void(^)(NSString *title))titleBtnBlock;
@end
