//
//  UIBarButtonItem+ButtonItem.h
//  ETao
//
//  Created by AVGD—JK on 15/11/18.
//  Copyright © 2015年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ButtonItem)

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
