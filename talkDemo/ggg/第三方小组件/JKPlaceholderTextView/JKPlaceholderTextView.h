//
//  JKPlaceholderTextView.h
//  Test
//
//  Created by AVGD—JK on 15/12/28.
//  Copyright © 2015年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKPlaceholderTextView : UITextView

@property(nonatomic, copy)NSString *placehoderText;   /**< 占位符文字 */

@property(nonatomic, assign)int limitTextLength; /**< 限制文本长度数 会自动显示出个数 */

@property(nonatomic, strong)UIColor *placehoderTextLabelTextColor;   /**< 占位符label文字颜色 */

@property(nonatomic, strong)UIColor *limitTextLengthLabelTextColor;   /**< 限制文本长度label文字颜色 */

@property(nonatomic, copy)void(^limitTextLengthBlock)();   /**< 文本超出限制的回调 */

@end
