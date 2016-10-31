//
//  JKCustomTextField.m
//  ETao
//
//  Created by AVGD—JK on 16/3/25.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "JKCustomTextField.h"
#import "JVFloatLabeledTextField.h"

const static CGFloat kJVFieldFontSize = 16.0f;

const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

@interface JKCustomTextField()

@property(nonatomic, strong)UIView *topLine;   /**< 上面的线条 */

@property(nonatomic, strong)JVFloatLabeledTextField *textField;   /**< 文本框 */

@property(nonatomic, strong)UIView *bottomLine;   /**< 下面的线条 */

@end

@implementation JKCustomTextField


- (JVFloatLabeledTextField *)textField
{
    if(!_textField)
    {
        _textField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
        
        _textField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
        _textField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
        
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}


- (UIView *)topLine
{
    if(!_topLine)
    {
        _topLine = [[UIView alloc] initWithFrame:CGRectZero];
        _topLine.backgroundColor = hexColor(E4E4E4);
    }
    return _topLine;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [_textField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (UIView *)bottomLine
{
    if(!_bottomLine)
    {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = hexColor(E4E4E4);
    }
    return _bottomLine;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.topLine];
        [self addSubview:self.textField];
        [self addSubview:self.bottomLine];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    _textField.placeholder = placeholder;
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    
    [_textField setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
}

- (void)setKbType:(UIKeyboardType)kbType
{
    _kbType = kbType;
    
    _textField.keyboardType = kbType;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _textField.text = title;
}

- (NSString *)title
{
    return _textField.text;
}

- (void)setResignFirst:(BOOL)resignFirst
{
    _resignFirst = resignFirst;
    
    if(resignFirst)
    {
        [_textField becomeFirstResponder];
    }
}

- (void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode
{
    _clearButtonMode = clearButtonMode;
    
    _textField.clearButtonMode = clearButtonMode;
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    _delegate = delegate;
    
    _textField.delegate = delegate;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    
    _textField.font = font;
}

- (void)setTextFieldRightView:(UIView *)textFieldRightView
{
    _textFieldRightView = textFieldRightView;
    
    _textField.rightView = textFieldRightView;
    _textField.rightViewMode = UITextFieldViewModeAlways;
}

- (void)setTextFieldLeftView:(UIView *)textFieldLeftView
{
    _textFieldLeftView = textFieldLeftView;
    
    _textField.leftView = textFieldLeftView;
    _textField.leftViewMode = UITextFieldViewModeAlways;
}

- (void)becomeFirstResponder
{
    [_textField becomeFirstResponder];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.topLine makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self);
        make.height.equalTo(@1);
    }];
    
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.topLine.bottom);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self.bottomLine.top);
        
    }];
    
    [self.bottomLine makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(@1);
        make.left.right.bottom.equalTo(self);
        
    }];
}

@end
