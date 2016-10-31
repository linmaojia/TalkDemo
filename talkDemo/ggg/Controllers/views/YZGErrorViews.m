//
//  ErrorViews.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGErrorViews.h"

@interface YZGErrorViews ()

@property (nonatomic, strong) UIImageView *titleImg;      /**<  图标 */
@property (nonatomic, strong) UILabel *titleLab;        /**<  说明 */
@property (nonatomic, strong) UIButton *titleBtn;       /**<  按钮 */
@end
@implementation YZGErrorViews
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGB(247, 247, 247);
        
        [self addSubviewsForView];
        [self addConstraintsView];
    }
    return self;
}
#pragma mark ************** 懒加载
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = systemFont(15);
        _titleLab.text = @"数据出错了\n请重试";
        _titleLab.numberOfLines = 0;
        _titleLab.textColor = [UIColor blackColor];
    }
    return _titleLab;
}
- (UIImageView *)titleImg {
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] init];
        _titleImg.image = [UIImage imageNamed:@"nonetwork-img"];
         [_titleImg setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _titleImg;
}
- (UIButton *)titleBtn {
    if (!_titleBtn) {
        _titleBtn=[[UIButton alloc]init];
        [_titleBtn setTitle:@"点击重试" forState:UIControlStateNormal];
        _titleBtn.backgroundColor = mainColor;
        [_titleBtn setTitleColor:[UIColor whiteColor] forState:0];
        _titleBtn.titleLabel.font = systemFont(14);//标题文字大小
        _titleBtn.layer.cornerRadius = 3;
        _titleBtn.layer.masksToBounds = YES;
        [_titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _titleBtn;
}

#pragma mark ************** 按钮被点击
- (void)titleBtnClick:(UIButton *)sender
{
    if(self.ErrorBtnClick)
    {
        self.ErrorBtnClick();
    }
}
- (void)showWithImageName:(NSString *)imageName Title:(NSString *)title ButtonTitle:(NSString *)buttonTitle
{

    self.titleImg.image = [UIImage imageNamed:imageName];
    self.titleLab.text = title;
    [self.titleBtn setTitle:buttonTitle forState:0];
    
}
- (void)setErrorType:(EmptyViewTypes)errorType
{
    //网络无连接
    if(errorType == EmptyViewTypeNoSignal)
    {
        [self showWithImageName:@"nonetwork-img" Title:@"网络连接失败\n请检查网络设置" ButtonTitle:@"点击重试"];
    }
    //数据为空
    else if (errorType == EmptyViewTypeEmptyData)
    {
         [self showWithImageName:@"icon_null" Title:@"暂无数据\n赶紧添加吧" ButtonTitle:@"点击添加"];
         //[self showWithImageName:@"" Title:@"暂无订单" ButtonTitle:@"点击添加"];//icon_no_order
    
    }
    //未审核
    else if (errorType == EmptyViewTypeNotAuthentication)
    {
         [self showWithImageName:@"NotAuthentication" Title:@"账号在其它地方登陆\n请重新登陆" ButtonTitle:@"重新登陆"];
     
    }
    //数据出错
    else if (errorType == EmptyViewTypesDataError)
    {
         [self showWithImageName:@"failed_load_img" Title:@"数据出错了\n请重试" ButtonTitle:@"点击重试"];
    }
    //未知错误
    else if (errorType == EmptyViewTypesUnknownError)
    {
         [self showWithImageName:@"UnknownError" Title:@"发生未知错误\n请重试或者联系小E" ButtonTitle:@"点击重试"];
    
    }

}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{

    [self addSubview:self.titleImg];
    [self addSubview:self.titleLab];
    [self addSubview:self.titleBtn];

}
#pragma mark ************** 添加约束
- (void)addConstraintsView
{
    CGFloat img_width = SCREEN_WIDTH/3;

    [_titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(AUTO_MATE_HEIGHT(100));
        make.height.width.equalTo(@(img_width));
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.right.equalTo(self);
        make.height.equalTo(@(40));
        make.top.equalTo(_titleImg.bottom);
    }];
    [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.bottom).offset(10);
        make.centerX.equalTo(self);
        make.width.equalTo(@(120));
        make.height.equalTo(@(40));
    }];
  
}
@end
