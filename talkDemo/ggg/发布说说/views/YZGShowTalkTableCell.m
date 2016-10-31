//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGShowTalkTableCell.h"

@interface YZGShowTalkTableCell()
/* 顶部*/
@property (nonatomic, strong) UIView *topView;
/**<  用户图片 */
@property (nonatomic, strong) UIImageView *userImg;
/**<  用户名称 */
@property (nonatomic, strong) UILabel *userName;
/**<  说说内容 */
@property (nonatomic, strong) UILabel *titleLab;
/**<  图片容器 */
@property (nonatomic, strong) UIView *centerView;

/**<  底部线 */
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSArray *imgUrlArray;  /**<  图片数组 */
@end
@implementation YZGShowTalkTableCell

#pragma mark ************** 懒加载控件
- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIImageView alloc] init];
        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.userInteractionEnabled = YES;
        
    }
    return _centerView;
}

- (UILabel *)userName {
    if (!_userName) {
        _userName = [[UILabel alloc] init];
        _userName.textAlignment = NSTextAlignmentLeft;
        _userName.font = systemFont(16);
        _userName.text = @"龙马";
        _userName.backgroundColor = [UIColor whiteColor];
    }
    return _userName;
}
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIImageView alloc] init];
        _topView.backgroundColor =  [UIColor whiteColor];
    }
    return _topView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor grayColor];
    }
    return _lineView;
}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = systemFont(16);
        _titleLab.text = @"查看详情";
        _titleLab.backgroundColor = [UIColor whiteColor];
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}
- (UIImageView *)userImg {
    if (!_userImg) {
        _userImg = [[UIImageView alloc] init];
        _userImg.image = [UIImage imageNamed:@"userImg"];
        _userImg.layer.cornerRadius = 20;
        _userImg.layer.masksToBounds = YES;
        
    }
    return _userImg;
}

#pragma mark ************** 设置cell 内容
- (void)setModel:(YZGTalkModel *)model{
    _model = model;
    
    _titleLab.text = model.talkString;
    
    self.imgUrlArray = model.picUrl;
    NSInteger ImgCount = self.imgUrlArray.count;
    
    for(int i = 0 ;i<9;i++)
    {
        UIImageView *titleImg = (UIImageView *)[_centerView viewWithTag:100+i];
        if(i <  ImgCount)
        {
            titleImg.hidden = NO;
            NSURL *imgUrl = [NSURL URLWithString:self.imgUrlArray[i]];
            [titleImg sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
        }
        else
        {
            titleImg.hidden = YES;
        }
        
    }
    
    //计算text高度
    NSString *text = model.talkString;
    
    CGFloat textHeight = [text HeightWithText:text constrainedToWidth:SCREEN_WIDTH -20 LabFont:[UIFont systemFontOfSize:16]];//计算文字高度
    
    _titleLab.text = text;
    
    [_titleLab updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(textHeight + 5));
    }];
    

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
        [self addSubviewsForCell];
        
        [self addConstraintsForCell];
        
        [self creatImgs];
        
    }
    return self;
}
#pragma mark **************** 创建图片数组
- (void)creatImgs
{
    CGFloat space = 10;
    CGFloat img_W = (self.frame.size.width - space *4)/3;
    int index = 0;
    for(int j = 0;j<3;j++)
    {
        for(int i = 0;i<3;i++)
        {
            CGRect frame = CGRectMake(space +i*(img_W +space), space + j*(img_W +space), img_W, img_W);
            UIImageView *titleImg = [[UIImageView alloc] initWithFrame:frame];
            [titleImg setContentMode:UIViewContentModeScaleAspectFill];
            titleImg.clipsToBounds=YES;
            titleImg.image = [UIImage imageNamed:@"logo_del_pro"];
            titleImg.backgroundColor = [UIColor grayColor];
            titleImg.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleImgClick:)];
            [titleImg addGestureRecognizer:tap];
            titleImg.tag = 100+index;
            [_centerView addSubview:titleImg];
            index++;
            
            
        }
    }
}
-(void)titleImgClick:(UITapGestureRecognizer *)sender
{
}
#pragma mark **************** 添加子控件
- (void)addSubviewsForCell
{
    //顶部
    [self.contentView addSubview:self.topView];
    [self.topView addSubview:self.userImg];
    [self.topView addSubview:self.userName];
    
    //说说内容
    [self.contentView addSubview:self.titleLab];

    //图片内容
    [self.contentView addSubview:self.centerView];

    [self.contentView addSubview:self.lineView];

    
    
}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    //顶部
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.contentView);
        make.height.equalTo(@50);
    }];
    
    [_userImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView).offset(10);
        make.height.width.equalTo(@(40));
        make.centerY.equalTo(_topView);
    }];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userImg.right).offset(10);
        make.top.equalTo(_userImg);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@30);
    }];
   
    //内容
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(_topView.bottom);
        make.height.equalTo(@50);
    }];
    
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self.contentView);
        make.height.equalTo(@(0.5));
    }];
    
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.bottom);
        make.bottom.equalTo(_lineView.top);
        make.right.left.equalTo(self.contentView);
    }];
    
    
    
}
@end
