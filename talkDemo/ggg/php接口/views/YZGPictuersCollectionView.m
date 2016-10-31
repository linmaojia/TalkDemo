//
//  YZGCategoryCollectionView.m
//  Masonry
//
//  Created by LXY on 16/7/22.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGPictuersCollectionView.h"

static NSString * const reuseIdentifier = @"Cell";
@interface YZGPictuersCollectionView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>


@end

@implementation YZGPictuersCollectionView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{

    if (self = [super initWithFrame:frame collectionViewLayout:layout])
    {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
   
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    [self reloadData];
}

#pragma mark **************** <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //只允许输入9张图片
    if(_dataArray.count == 9)
    {
        return 9;
    }
    else
    {
        return _dataArray.count + 1;
    }
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    
    UIImageView *Img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (self.frame.size.width-40)/3, (self.frame.size.width-40)/3)];
    Img.backgroundColor = [UIColor whiteColor];
    
    if(indexPath.item < _dataArray.count)
    {
        Img.image = _dataArray[indexPath.item];
    }
    else
    {
        Img.image = [UIImage imageNamed:@"xiangji"];
    }
    
    
    [cell addSubview:Img];
    NSLog(@"---%ld",indexPath.item);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
      self.didClick(indexPath);

       NSLog(@"--xxxxxxxx-%ld",indexPath.item);
    
}

@end
