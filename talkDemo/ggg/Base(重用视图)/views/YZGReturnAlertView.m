//
//  YZGAlertView.m
//  Masonry
//
//  Created by LXY on 16/6/14.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGReturnAlertView.h"

@interface YZGReturnAlertView()
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIButton *yesButton;
@property (nonatomic, strong) UIButton *noButton;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIView *lineView;


@end

@implementation YZGReturnAlertView
- (UIButton *)noButton {
    if (!_noButton) {
        _noButton=[[UIButton alloc]init];
        [_noButton setTitle:@"我再想想" forState:UIControlStateNormal];
        [_noButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _noButton.titleLabel.font = systemFont(14);//标题文字大小
        [_noButton addTarget:self action:@selector(noButtonClick:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _noButton;
}
- (UIButton *)yesButton {
    if (!_yesButton) {
        _yesButton=[[UIButton alloc]init];
        [_yesButton setTitle:@"去意已决" forState:UIControlStateNormal];
        [_yesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _yesButton.titleLabel.font = systemFont(14);//标题文字大小
        _yesButton.backgroundColor = mainColor;
        [_yesButton addTarget:self action:@selector(yesButtonClick:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _yesButton;
}
- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(227, 229, 230);
    }
    return _lineView;
}
- (UIView *)alertView
{
    if (!_alertView)
    {
        _alertView = [[UIView alloc] init];
        _alertView.bounds = CGRectMake(0, 0, 250, 130);
        _alertView.layer.cornerRadius = 10;
        _alertView.clipsToBounds = YES;
        _alertView.backgroundColor = [UIColor whiteColor];
    }
    return _alertView;
}
- (UILabel *)titleLable
{
    if (_titleLable == nil)
    {
        _titleLable = [[UILabel alloc] init];
        _titleLable.text = @"是否清除全部选项";
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.font = [UIFont systemFontOfSize:14];
    }
    return _titleLable;
}
- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        self.alertView.center = keyWindow.center;
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
        self.frame = keyWindow.frame;
        [self setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickCancelBtn)];
        [self addGestureRecognizer:tap];//添加手势
        [keyWindow addSubview:self];
        [keyWindow addSubview:self.alertView];
       
        [self addSubviewsForAlertView];
        [self addContstraintsForAlertView];
         self.titleLable.text = title;
    }
     return self;
}
#pragma mark **************** 添加子控件
- (void)addSubviewsForAlertView
{
    [self.alertView addSubview:self.titleLable];
    [self.alertView addSubview:self.lineView];
    [self.alertView addSubview:self.yesButton];
    [self.alertView addSubview:self.noButton];
   
}
#pragma mark ************** 取消
- (void)noButtonClick:(UIButton *)sender{
   [self dismiss];
    self.alertNoBlock();
}
#pragma mark ************** 确定
- (void)yesButtonClick:(UIButton *)sender{
     [self dismiss];
    self.alertYesBlock();
}

#pragma mark **************** 添加约束
- (void)addContstraintsForAlertView
{
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alertView);
        make.right.left.equalTo(self.alertView);
        make.height.equalTo(@(80));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLable.bottom);
        make.right.left.equalTo(self.alertView);
        make.height.equalTo(@(0.5));
    }];
    [self.noButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.bottom);
        make.left.equalTo(self.alertView);
        make.bottom.equalTo(self.alertView);
        make.width.equalTo(@(250/2));
    }];
    [self.yesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.bottom);
        make.left.equalTo(_noButton.right);
        make.bottom.equalTo(self.alertView);
        make.right.equalTo(self.alertView);
    }];
}
- (void)dismiss
{
    [self removeFromSuperview];
    [self.alertView removeFromSuperview];
}
//消失
- (void)didClickCancelBtn {
    [self dismiss];
}
@end
