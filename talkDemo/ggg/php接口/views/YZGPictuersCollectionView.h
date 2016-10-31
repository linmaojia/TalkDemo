//
//  YZGCategoryCollectionView.h
//  Masonry
//
//  Created by LXY on 16/7/22.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YZGPictuersCollectionView : UICollectionView


@property (nonatomic, copy) void (^didClick)(NSIndexPath *indexPath);

@property (nonatomic, strong) NSArray *dataArray;    /**< 数组 */
@end
