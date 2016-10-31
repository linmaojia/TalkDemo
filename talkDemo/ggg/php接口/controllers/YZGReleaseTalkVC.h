//
//  YZGUserSettingViewController.h
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRootViewController.h"
/**< 发布说说 */
@interface YZGReleaseTalkVC : YZGRootViewController

@property (nonatomic,copy) void(^reloadDataBlock)();  //刷新数据

@end
