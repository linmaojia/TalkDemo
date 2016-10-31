//
//  YZGAlertView.m
//  Masonry
//
//  Created by LXY on 16/6/14.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRemarksView.h"
#import "JKPlaceholderTextView.h"



@interface YZGRemarksView()

@property (nonatomic,copy) void(^confirmBlock)(NSString *text);     /**< 确定按钮点击 */
@property (nonatomic,copy) void(^cancelBlock)();     /**< 取消按钮点击 */

@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) JKPlaceholderTextView *credentialText;  /**< 个人简介输入框 */
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *centerView;


@end

@implementation YZGRemarksView
- (JKPlaceholderTextView *)credentialText {
    if (!_credentialText) {
        _credentialText = [[JKPlaceholderTextView alloc] init];
        _credentialText.textColor = [UIColor blackColor];
        _credentialText.font = [UIFont systemFontOfSize:15];
        _credentialText.returnKeyType = UIReturnKeyDone;
        _credentialText.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _credentialText.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _credentialText.layer.borderWidth = 1;
        _credentialText.placehoderText = @"请输入商品的备注";
        _credentialText.limitTextLength = 200;
        _credentialText.limitTextLengthBlock = ^(){
        };
        
    }
    return _credentialText;
}
- (UIButton *)cancelBtn
{
    if (!_cancelBtn)
    {
        _cancelBtn=[[UIButton alloc]init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = [UIColor clearColor];
        _cancelBtn.titleLabel.font = systemFont(14);//标题文字大小
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _cancelBtn;
}
- (UIButton *)confirmBtn
{
    if (!_confirmBtn)
    {
        _confirmBtn=[[UIButton alloc]init];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = systemFont(14);//标题文字大小
        _confirmBtn.backgroundColor = mainColor;
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _confirmBtn;
}
- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor =  RGB(206, 206, 206);
    }
    return _lineView;
}
- (UIView *)centerView
{
    if (!_centerView)
    {
        _centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 220)];
        _centerView.backgroundColor = RGB(235, 235, 235);
        _centerView.alpha = 0;
        
    }
    return _centerView;
}


+ (void)showRemarksViewWithTitle:(NSString *)title PlacehoderText:(NSString *)placehoderText ConfirmBlock:(void(^)(NSString *text))confirmBlock CancelBlock:(void(^)())cancelBlock
{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    YZGRemarksView *blackView = [[YZGRemarksView alloc] initWithFrame:keyWindow.frame];//黑色阴影
    [keyWindow addSubview:blackView];
    
    blackView.credentialText.placehoderText = placehoderText;
    blackView.credentialText.text = title;
    
    blackView.confirmBlock = confirmBlock;
    blackView.cancelBlock = cancelBlock;
    
    
}
#pragma mark **************** init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = RGBA(0, 0, 0, 0);
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tap];//添加手势
        
        [self addSubviewsForAlertView];//添加子控件
        [self layoutSubviewsForAlertView];//布局子控件
        [self show];
    }
    return self;
}
#pragma mark ************** 显示
- (void)show {
    
    [self.credentialText becomeFirstResponder];
    
    [UIView animateWithDuration:0.2f animations:^{
        [self setBackgroundColor:RGBA(0, 0, 0, 0.5)];
        self.centerView.alpha = 1;
    } completion:nil];
}
#pragma mark ************** 消失
- (void)dismiss
{
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0);
        self.centerView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark ************** 取消
- (void)cancelBtnClick:(UIButton *)sender{
    [self dismiss];
    self.cancelBlock();
    
}
#pragma mark ************** 确定
- (void)confirmBtnClick:(UIButton *)sender{
    [self dismiss];
    self.confirmBlock(self.credentialText.text);
}

#pragma mark **************** 添加子控件
- (void)addSubviewsForAlertView
{
    [self addSubview:self.centerView];
    
    [self.centerView addSubview:self.credentialText];
    [self.centerView addSubview:self.lineView];
    [self.centerView addSubview:self.confirmBtn];
    [self.centerView addSubview:self.cancelBtn];
    
}
#pragma mark **************** 添加约束
- (void)layoutSubviewsForAlertView {
    
    [self.credentialText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerView).offset(20);
        make.left.equalTo(self.centerView).offset(10);
        make.right.equalTo(self.centerView).offset(-10);
        make.bottom.equalTo(@(-60));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.centerView).offset(-40);
        make.right.left.equalTo(self.centerView);
        make.height.equalTo(@(0.5));
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.bottom);
        make.bottom.left.equalTo(self.centerView);
        make.width.equalTo(@(SCREEN_WIDTH/2));
    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.bottom);
        make.right.bottom.equalTo(self.centerView);
        make.width.equalTo(@(SCREEN_WIDTH/2));
    }];
    
    
}

@end
