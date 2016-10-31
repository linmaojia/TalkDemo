//
//  UIView+Empty.m
//
//  Created by jiangkun on 16/4/29.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "UIView+Empty.h"
#import <objc/runtime.h>
#import <ImageIO/ImageIO.h>

static char TypeKey;
static char RefreshKey;
static char BottomKey;
#define TitleFontSize 15
#define TitleColor [UIColor grayColor]

#define DetailTitleFontSize 15
#define DetailTitleColor [UIColor lightGrayColor]

#define ButtonTitleColor [UIColor whiteColor]
#define ButtonFontSize 13
#define ButtoBacColor mainColor

#define ErrorWidth [UIScreen mainScreen].bounds.size.width
#define Offset ErrorWidth / 3.5
#define Top 100


//配置网络出错图片和空视图图片
#define NoSignalImageName @"nonetwork-img"
#define EmptyDataImageName @"icon_null"
#define EmptyOrderImageName @"icon_no_order"
#define NotAuthenticationImageName @"NotAuthentication"
#define DataErrorImageName @"failed_load_img"
#define UnknownErrorImageName @"UnknownError"

@implementation UIView (Empty)

@dynamic type;

@dynamic bottomView;

@dynamic block;

- (UIView *)buttomView {
    UIView *view = objc_getAssociatedObject(self, &BottomKey);
    if (!view) {
        view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.frame = [UIScreen mainScreen].bounds;
        [self setButtomView:view];
    }
    return view;
}


- (void)setType:(EmptyViewTypes)type
{
    objc_setAssociatedObject(self, &TypeKey,[NSNumber numberWithInteger:type], OBJC_ASSOCIATION_ASSIGN);
}

- (EmptyViewTypes)type
{
    
    return [objc_getAssociatedObject(self, &TypeKey) integerValue];
}

- (void)setButtomView:(UIView *)buttomView {
    objc_setAssociatedObject(self, &BottomKey, buttomView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RefreshBlock)block {
    return objc_getAssociatedObject(self, &RefreshKey);
}

- (void)setBlock:(RefreshBlock)block {
    objc_setAssociatedObject(self, &RefreshKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)showWithImageName:(NSString *)imageName
                    title:(NSString *)title
              detailTitle:(NSString *)detailTitle
              buttonTitle:(NSString *)buttonTitle {
    //如果页面不为空返回
    if (self.buttomView.subviews.count != 0) {
        return;
    }
    UIImageView *errorImage = [[UIImageView alloc] init];
    
    errorImage.image = [UIImage imageNamed:imageName];
    
    UIImage *image = [self animatedGIFNamed:imageName];
    errorImage.image = image;
    errorImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.buttomView addSubview:errorImage];
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.font = [UIFont systemFontOfSize:TitleFontSize];
    titleLable.textColor = TitleColor;
    titleLable.numberOfLines = 2;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = title;
    [self.buttomView addSubview:titleLable];
    
//            self.detailLable = [[UILabel alloc] init];
//            self.detailLable.font = [UIFont systemFontOfSize:TitleFontSize];
//            self.detailLable.textColor = TitleColor;
//            self.detailLable.text = detailTitle;
//            [self addSubview:_detailLable];
    
    UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeSystem];
     reloadButton.layer.cornerRadius = 3;
    [reloadButton setTitle:buttonTitle forState:UIControlStateNormal];
    [reloadButton setTitleColor:ButtonTitleColor forState:UIControlStateNormal];
    reloadButton.titleLabel.font = [UIFont systemFontOfSize:ButtonFontSize];
    [reloadButton addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    reloadButton.backgroundColor = ButtoBacColor;
    [self.buttomView addSubview:reloadButton];
    
    [self addSubview:self.buttomView];
    
    errorImage.frame = CGRectMake(Offset, Top, ErrorWidth - 2 * Offset, ErrorWidth - 2 * Offset);
    
    CGFloat titleLableTop = Top + ErrorWidth - 2 * Offset;
    titleLable.frame = CGRectMake(Offset, titleLableTop + 20, ErrorWidth - 2 * Offset, 40);
    
    CGFloat reloadButtonTop = titleLableTop + 20 + 30;
    reloadButton.frame = CGRectMake((ErrorWidth - 150) / 2.0, reloadButtonTop + 20, 150, 30);
}

#pragma mark - 展示空和错误页面


- (void)showEmptyViewWithtype:(EmptyViewTypes)type IsOrder:(BOOL)isOrder refresh:(RefreshBlock)block
{
    //网络无连接
    if(type == EmptyViewTypeNoSignal)
    {
        [self showWithImageName:NoSignalImageName title:@"网络连接失败\n请检查网络设置" detailTitle:nil buttonTitle:@"点击重试"];
    }
    //数据为空
    else if (type == EmptyViewTypeEmptyData)
    {
        
        if(isOrder)
        {
            [self showWithImageName:EmptyOrderImageName title:@"暂无订单" detailTitle:nil buttonTitle:@"去逛逛"];

        }
        else
        {
            [self showWithImageName:EmptyDataImageName title:@"暂无数据\n赶紧添加吧" detailTitle:nil buttonTitle:@"点击添加"];

        }
    }
    //未审核
    else if (type == EmptyViewTypeNotAuthentication)
    {
        [self showWithImageName:NotAuthenticationImageName title:@"账号在其它地方登陆\n请重新登陆" detailTitle:nil buttonTitle:@"重新登陆"];
    }
    //数据出错
    else if (type == EmptyViewTypesDataError)
    {
        [self showWithImageName:DataErrorImageName title:@"数据出错了\n请重试" detailTitle:nil buttonTitle:@"点击重试"];
    }
    //未知错误
    else if (type == EmptyViewTypesUnknownError)
    {
        [self showWithImageName:UnknownErrorImageName title:@"发生未知错误\n请重试或者联系小E" detailTitle:nil buttonTitle:@"点击重试"];
    }
    self.type = type;
    self.block = block;
}

//- (void)showNetWorkErrorWithRefresh:(RefreshBlock)block {
//    [self showWithImageName:ErrorImageName title:@"网络错误!" detailTitle:nil buttonTitle:@"点击重试"];
//    self.block = block;
//}
//
//- (void)showEmptyViewWithRefresh:(RefreshBlock)block {
//    [self showWithImageName:EmptyImageName title:@"暂无数据!" detailTitle:nil buttonTitle:@"点击重试"];
//    self.block = block;
//}

- (void)showWithImageName:(NSString *)imageName
                    title:(NSString *)title
              detailTitle:(NSString *)detailTitle
              buttonTitle:(NSString *)buttonTitle
                  refresh:(RefreshBlock)block {
    [self showWithImageName:imageName title:title detailTitle:detailTitle buttonTitle:buttonTitle];
    self.block = block;
}

#pragma mark - 移除页面
- (void)removeEmptyView {
    UIView *view = objc_getAssociatedObject(self, &BottomKey);
    if (view) {
        [view removeFromSuperview];
        objc_setAssociatedObject(self, &RefreshKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, &BottomKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)refresh
{
    
    //如果是未审核 则直接跳转到登录界面
    if(self.type == EmptyViewTypeNotAuthentication)
    {
        
//        YZGAccessToken *token = nil;
//        
//        YZGUser *user = nil;
//        
//        [YZGUserManager saveAccessToken:token];
//        
//        [YZGUserManager saveUser:user];
//        
//        YZGLoginViewController *loginVC = [[YZGLoginViewController alloc] init];
//        YZGRootNavigationController *loginNav = [[YZGRootNavigationController alloc] initWithRootViewController:loginVC];
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        window.rootViewController = loginNav;

    }
    else
    {
     self.block();
    }
   
}

- (NSString *)typeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}

#pragma mark - 加载GIF
- (UIImage *)animatedGIFNamed:(NSString *)name {
    CGFloat scale = [UIScreen mainScreen].scale;
    if (scale > 1.0f) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        if (data) {
            return [self animatedGIFWithData:data];
        }
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        data = [NSData dataWithContentsOfFile:path];
        if (data) {
            return [self animatedGIFWithData:data];
        }
        return [UIImage imageNamed:name];
    } else {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        if (data) {
            return [self animatedGIFWithData:data];
        }
        return [UIImage imageNamed:name];
    }
}
- (UIImage *)animatedGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    UIImage *animatedImage;
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    } else {
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval duration = 0.0f;
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            duration += [self frameDurationAtIndex:i source:source];
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            CGImageRelease(image);
        }
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    CFRelease(source);
    return animatedImage;
}
- (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    } else {
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    CFRelease(cfFrameProperties);
    return frameDuration;
}

@end
