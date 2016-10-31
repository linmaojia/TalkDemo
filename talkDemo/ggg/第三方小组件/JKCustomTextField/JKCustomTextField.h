//
//  JKCustomTextField.h
//  ETao
//
//  Created by AVGD—JK on 16/3/25.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKCustomTextField : UIView
{
    NSString *_title;
}
@property(nonatomic, copy)NSString *placeholder;   /**< 默认文字 */

@property(nonatomic, strong)UIColor *placeholderColor;   /**< 默认文字颜色 */

@property(nonatomic, copy, readwrite)NSString *title;   /**< 文本框文字 */

@property(nonatomic, assign)BOOL resignFirst;   /**< 第一响应者 */

@property(nonatomic, strong)UIView *textFieldRightView;   /**< 文本框右视图 */

@property(nonatomic, strong)UIView *textFieldLeftView;   /**< 文本框左视图 */

@property(nonatomic, assign)id<UITextFieldDelegate>delegate;

@property(nonatomic, strong)UIFont *font;   /**< font */

@property(nonatomic, assign)UIKeyboardType kbType;  /**< 键盘类型 */

@property(nonatomic, assign)UITextFieldViewMode clearButtonMode;

@property (nonatomic, assign) UIReturnKeyType rkType;    /**< <#name#> */

@property (nonatomic, strong) UIFont *placeholderFont;    /**< <#name#> */

- (void)becomeFirstResponder;

@end
