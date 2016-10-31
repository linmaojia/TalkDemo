//
//  GetOrderList.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGTalkManager.h"

@interface YZGTalkManager ()

@end
@implementation YZGTalkManager
+ (CGFloat )getImgArrayHeightWith:(NSInteger )imgCount
{
    CGFloat height = 0;
    
    CGFloat space = 10;
    
    CGFloat img_W = (SCREEN_WIDTH - space *4)/3;
    
    NSInteger imgLine = 0;
   
    if(imgCount > 0 && imgCount <= 3 )
    {
        imgLine = 1;
    }
    else if(imgCount >3  && imgCount <= 6 )
    {
        imgLine = 2;
    }
    else if(imgCount >6  && imgCount <= 9 )
    {
        imgLine = 3;
    }
    else
    {
        imgLine = 0;
    }
    
    //计算图片高度
    height = imgLine*(img_W+space) + space ;//50 为cell 顶部

    return height;
    
}

+ (CGFloat )getCellHeightWithModel:(YZGTalkModel *)model
{
    CGFloat cell_H;
    
    CGFloat cellHead_H = 50;//cell 头部高度
    
    CGFloat image_H = [YZGTalkManager getImgArrayHeightWith:model.picUrl.count];//图片内容高度
    
    CGFloat text_H = [model.talkString HeightWithText:model.talkString constrainedToWidth:SCREEN_WIDTH -20 LabFont:[UIFont systemFontOfSize:16]];//计算文字高度
    
    text_H = text_H + 5;
    
    cell_H = cellHead_H + text_H + image_H;
    
    return cell_H;
}

@end
