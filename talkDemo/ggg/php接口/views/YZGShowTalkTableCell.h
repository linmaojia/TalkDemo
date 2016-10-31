//
//  YZGMineTableOrderCell.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGTalkModel.h"
@interface YZGShowTalkTableCell : UITableViewCell


@property (nonatomic, strong) YZGTalkModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic,copy) void(^BtnClickBlack)(NSString *text);    

@end
