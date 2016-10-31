

#import "CustomAlertView.h"

static float const BUTTON_H = 50.0f;  /**< 按钮高度 */

@interface CustomAlertView ()

@property (nonatomic, strong) UIView *bottomView;      /**< 背景 */
@property (nonatomic,strong) NSArray *titleArray;     /**< 标题数组 */
@property (nonatomic,copy) void(^titleBtnBlock)(NSString *text);     /**< 按钮回调 */
@end

@implementation CustomAlertView

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [_bottomView setBackgroundColor:RGB(233, 233, 238)];
        CGFloat bottom_h = (BUTTON_H+0.5)*self.titleArray.count + BUTTON_H + 5;
        _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, bottom_h);
    }
    return _bottomView;
}

+ (void)showAlertViewWithTitleArray:(NSArray *)titleArray TitleBtnBlock:(void(^)(NSString *title))titleBtnBlock{

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    CustomAlertView *blackView = [[CustomAlertView alloc] initWithFrame:keyWindow.frame];//黑色阴影
    [keyWindow addSubview:blackView];
    
    blackView.titleArray = titleArray;
    
    blackView.titleBtnBlock = titleBtnBlock;
    
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

    }
    return self;
}
- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    
    [self addSubview:self.bottomView];
    [self creatButton];  //创建按钮
    [self show];
  
}
- (void)creatButton {
    for (int i = 0; i < self.titleArray.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];// 所有按钮
        [btn setTag:i];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [[btn titleLabel] setFont:[UIFont systemFontOfSize:16.0f]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat btnY = (BUTTON_H+0.5) * i;
        [btn setFrame:CGRectMake(0, btnY, SCREEN_WIDTH, BUTTON_H)];
        [_bottomView addSubview:btn];
        
        if(i != self.titleArray.count-1){
            //线条
            UIView *linLab = [[UIView alloc]initWithFrame:CGRectMake(0, BUTTON_H *(i+1), SCREEN_WIDTH, 0.5)];
            linLab.backgroundColor = RGB(227, 229, 230);
            [_bottomView addSubview:linLab];
        }
        
    }
    UIButton *cancelBtn = [[UIButton alloc] init]; //取消按钮
    [cancelBtn setTag:self.titleArray.count];
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [[cancelBtn titleLabel] setFont:[UIFont systemFontOfSize:16.0f]];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat btnY = (BUTTON_H+0.5) * self.titleArray.count + 5.0f;
    [cancelBtn setFrame:CGRectMake(0, btnY, SCREEN_WIDTH, BUTTON_H)];
    [_bottomView addSubview:cancelBtn];

}
#pragma mark ************** 显示
- (void)show {
    
    [UIView animateWithDuration:0.3f animations:^{
       [self setBackgroundColor:RGBA(0, 0, 0, 0.5)];
        
        CGRect frame = _bottomView.frame;
        frame.origin.y -= frame.size.height;
         _bottomView.frame = frame;
    } completion:nil];
}
#pragma mark ************** 按钮被点击
- (void)didClickBtn:(UIButton *)btn {
   
    self.titleBtnBlock(btn.titleLabel.text);
    
    [self dismiss];
}

#pragma mark ************** 消失
- (void)dismiss {
    [UIView animateWithDuration:0.4f  animations:^{
        [self setBackgroundColor:RGBA(0, 0, 0, 0)];
    
        CGRect frame = _bottomView.frame;
        frame.origin.y += frame.size.height;
        _bottomView.frame = frame;
    } completion:^(BOOL finished) {

        [self removeFromSuperview];
    }];
}


@end
