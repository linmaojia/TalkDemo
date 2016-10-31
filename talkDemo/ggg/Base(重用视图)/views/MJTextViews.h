//
//  MJTextView.h
//  Masonry
//
//  Created by LXY on 16/7/31.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJTextViews : UIView
@property(nonatomic, strong) UITextView *textView;   /** 文本框 左边文本 */
@property(nonatomic, strong)NSString *placehoderText;   /**< 占位符文字 */
@property(nonatomic, assign)int limitTextLength; /**< 限制文本长度数 会自动显示出个数 */
@property(nonatomic, copy)void(^limitTextLengthBlock)();   /**< 文本超出限制的回调 */
@end
