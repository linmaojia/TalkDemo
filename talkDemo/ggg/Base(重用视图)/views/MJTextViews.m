//
//  MJTextView.m
//  Masonry
//
//  Created by LXY on 16/7/31.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "MJTextViews.h"

@interface MJTextViews ()

@property(nonatomic, strong)UILabel *placeholderLab;   /**< 占位符的label */
@property(nonatomic, strong)UILabel *limitTextLengthLabel;   /**< 限制文本长度label */

@end

@implementation MJTextViews



#pragma mark ************** 懒加载
- (UILabel *)placeholderLab
{
    if(!_placeholderLab)
    {
        _placeholderLab = [[UILabel alloc] init];
        _placeholderLab.backgroundColor = [UIColor clearColor];
        _placeholderLab.textColor = [UIColor grayColor];
        _placeholderLab.font = [UIFont systemFontOfSize:15];
        _placeholderLab.text = @"请描述问题xxx";
        
    }
    return _placeholderLab;
}
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.textColor = [UIColor blackColor];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.text = @"";
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
      
    }
    return _textView;
}
- (UILabel *)limitTextLengthLabel
{
    if(!_limitTextLengthLabel)
    {
        _limitTextLengthLabel = [[UILabel alloc] init];
        
        _limitTextLengthLabel.backgroundColor = [UIColor clearColor];
        _limitTextLengthLabel.textColor = [UIColor blackColor];
        _limitTextLengthLabel.textAlignment = NSTextAlignmentRight;
        _limitTextLengthLabel.font = [UIFont systemFontOfSize:13];
        _limitTextLengthLabel.text = @"200";
        
    }
    return _limitTextLengthLabel;
}
- (void)textDidChange
{
    //如果有文字则隐藏  无文字则显示
    self.placeholderLab.hidden = self.textView.hasText;
    
    if(_limitTextLength > 0)
    {
        NSInteger textLength = self.textView.text.length;
        
        if (textLength > self.limitTextLength) {
            
            self.limitTextLengthBlock();
            self.textView.text = [self.textView.text substringToIndex:self.limitTextLength];
            
        }
        
        self.limitTextLengthLabel.text = [NSString stringWithFormat:@"%d",self.limitTextLength - (int)self.textView.text.length];
    }
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        [self addSubview:self.textView];
        [self addSubview:self.placeholderLab];
        [self addSubview:self.limitTextLengthLabel];
        
    }
    return self;
}
- (void)setPlacehoderText:(NSString *)placehoderText{
    _placehoderText = placehoderText;
    _placeholderLab.text = placehoderText;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
 
    
    //计算提示文本高度
    CGFloat placeholderLab_x = 8;
    CGFloat placeholderLab_y = 8;
    CGRect placehoderRect=[_placeholderLab.text boundingRectWithSize:CGSizeMake(self.frame.size.width-16, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_placeholderLab.font} context:nil];
    self.placeholderLab.frame = CGRectMake(placeholderLab_x,placeholderLab_y,placehoderRect.size.width, placehoderRect.size.height);
    
    
    //计算UITextView
    
    self.textView.frame = CGRectMake(5,0,self.frame.size.width - 10, self.frame.size.height - 20);
    
    //计算数字Lab
  
    self.limitTextLengthLabel.frame = CGRectMake(0, self.frame.size.height - 20, self.frame.size.width - 5, 20);
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

@end
