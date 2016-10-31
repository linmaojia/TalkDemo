//
//  GetOrderList.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZGTalkModel.h"

@interface YZGTalkManager : MJAFNetWorking
+ (CGFloat )getImgArrayHeightWith:(NSInteger )imgCount;//计算图片高度
+ (CGFloat )getCellHeightWithModel:(YZGTalkModel *)model;//计算图片高度

@end
