//
//  KViewController.m
//  ggg
//
//  Created by longma on 16/9/20.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "KViewController.h"

@interface KViewController ()


@property (nonatomic, strong) UIImageView *titleImg;         /**<  图片 */

@end

@implementation KViewController


#pragma mark ************** 系统方法

- (UIImageView *)titleImg {
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] init];
        _titleImg.image = [UIImage imageNamed:@"logo_del_pro"];
        _titleImg.backgroundColor = [UIColor grayColor];
        _titleImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleImgClick:)];
        [_titleImg addGestureRecognizer:tap];
        
    }
    return _titleImg;
}

#pragma mark ************** 个人背景被点击
-(void)titleImgClick:(UITapGestureRecognizer *)sender{
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.titleImg];
    [_titleImg makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@100);
        make.left.top.equalTo(self.view).offset(20);
    }];
    
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.37/longma/img/1.png"];
    [_titleImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
    
//

    
}

@end
