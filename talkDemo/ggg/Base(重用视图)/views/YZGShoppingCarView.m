//
//  YZGOrderButtonView.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGShoppingCarView.h"

@interface YZGShoppingCarView ()
{
    CGFloat button_width,button_height;
    CGFloat self_width,self_height;
}
@property (nonatomic, strong) UIButton *tempBtn;
@property (nonatomic, strong) UIView *lineView;      /**< 顶部横线 */

@property (nonatomic, strong) UIButton *carBtn;
@property (nonatomic, strong) UILabel *carLabel;
@end
@implementation YZGShoppingCarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self_width = self.frame.size.width;
        self_height = self.frame.size.height;
        
        [self addSubview:self.carBtn];
        [self addSubview:self.carLabel];
        
    }
    return self;
}
- (UIButton *)carBtn {
    if (!_carBtn) {
        _carBtn = [[UIButton alloc]init];
        _carBtn.frame = CGRectMake(0,0, 40, 40);
        [_carBtn setImage:[UIImage imageNamed:@"icon_goshopping"] forState:UIControlStateNormal];
        _carBtn.backgroundColor = [UIColor whiteColor];
        _carBtn.layer.cornerRadius = _carBtn.frame.size.width/2;
        _carBtn.layer.masksToBounds = YES;
        [_carBtn addTarget:self action:@selector(puchCarAction:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _carBtn;
}
- (UILabel *)carLabel {
    if (!_carLabel) {
        _carLabel = [[UILabel alloc] initWithFrame:CGRectMake(self_width - 13, 0, 13, 13)];
        _carLabel.backgroundColor = [UIColor redColor];
        _carLabel.text = @"0";
        _carLabel.textAlignment = NSTextAlignmentCenter;
        _carLabel.font = [UIFont systemFontOfSize:10];
        _carLabel.textColor = [UIColor whiteColor];
        _carLabel.layer.cornerRadius = _carLabel.frame.size.width/2;
        _carLabel.layer.masksToBounds = YES;
        _carLabel.hidden = YES;
    }
    return _carLabel;
}
- (void)setCount:(NSInteger)count
{
    _count = count;
    
    CGRect newFram = CGRectZero;
    NSString *countStr;
    if(count >= 10 && count <= 99 )
    {
        newFram = CGRectMake(self_width - 13, 0, 16, 13);
        countStr = [NSString stringWithFormat:@"%ld",count];
    }
    if(count < 10)
    {
        newFram = CGRectMake(self_width - 13, 0, 13, 13);
        countStr = [NSString stringWithFormat:@"%ld",count];
    }
    if(count > 99)
    {
        newFram = CGRectMake(self_width - 13, 0, 20, 13);
        countStr = @"99+";
    }
    self.carLabel.hidden = NO;
    self.carLabel.frame = newFram;
    self.carLabel.text = countStr;
}
#pragma mark ************** 布局

#pragma mark ************** 点击事件
- (void)puchCarAction:(UIButton *)sender
{
    if(self.carButtonClick)
    {
        self.carButtonClick();
    }
}

@end
