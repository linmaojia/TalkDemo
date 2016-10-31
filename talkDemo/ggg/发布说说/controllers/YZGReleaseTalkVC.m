//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGReleaseTalkVC.h"
#import "YZGTalkManager.h"
#import "MJTextViews.h"
#import "CustomAlertView.h"
#import "TZImagePickerController.h"
#import "YZGPictuersCollectionView.h"

@interface YZGReleaseTalkVC ()<TZImagePickerControllerDelegate>
@property (nonatomic, strong) MJTextViews *mjTextView; /**<  输入框 */
@property (nonatomic, strong) YZGPictuersCollectionView  *pictuersView; /* 下边collectionView*/
@property (nonatomic, strong) NSArray *imaArray;
@end

@implementation YZGReleaseTalkVC

#pragma mark ************** 懒加载控件
- (YZGPictuersCollectionView *)pictuersView
{
    if (_pictuersView == nil)
    {
        ESWeakSelf;
        CGFloat cellWidth = (self.view.frame.size.width - 40)/3;
        CGFloat cellHeight = cellWidth;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 0.0f, 10.0f);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        layout.itemSize = CGSizeMake(cellWidth, cellHeight);//cell的大小
        _pictuersView = [[YZGPictuersCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _pictuersView.didClick = ^(NSIndexPath *indexPath){
            
            [__weakSelf openPhotoAlbum];//打开相册
        };
        
    }
    return _pictuersView;
}
- (MJTextViews *)mjTextView {
    if (!_mjTextView) {
        _mjTextView = [[MJTextViews alloc]init];
        _mjTextView.limitTextLength = 200;
        _mjTextView.layer.borderWidth = 0.5;
        _mjTextView.layer.borderColor = RGB(227, 229, 230).CGColor;
        _mjTextView.placehoderText = @"输入内容";
        _mjTextView.limitTextLengthBlock = ^(){
            [SVProgressHUD showErrorWithStatus:@"超出字数限制"];
        };
    }
    return _mjTextView;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    

}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"写说说";
    UIBarButtonItem *talkItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(upLoadImgAction)];
    self.navigationItem.rightBarButtonItem = talkItem;
}

#pragma mark ************** 点击相机
-(void)titleImgClick:(UITapGestureRecognizer *)sender
{
    [CustomAlertView showAlertViewWithTitleArray:@[@"拍照",@"从手机相册选择"] TitleBtnBlock:^(NSString *title) {
        if([title isEqualToString:@"拍照"])
        {
            NSLog(@"拍照");
        }
        else if([title isEqualToString:@"从手机相册选择"])
        {
            NSLog(@"从手机相册选择");
            [self openPhotoAlbum];
        }
    }];
}
#pragma mark ************** 打开手机相册
- (void)openPhotoAlbum
{
    
    ESWeakSelf;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVc.barItemTextColor = [UIColor blackColor];//设置导航栏的按钮文字颜色
    imagePickerVc.navigationBar.tintColor =  [UIColor blackColor];//设置导航栏的按钮图片颜色
    imagePickerVc.allowPickingOriginalPhoto=NO;
    imagePickerVc.allowPickingVideo=NO;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
        
         __weakSelf.imaArray = photos;
        
    }];
    
}
- (void)setImaArray:(NSArray *)imaArray
{
    _imaArray = imaArray;
    
    _pictuersView.dataArray = imaArray;
}
#pragma mark ************** 上传多张图片和文字
- (void)upLoadImgAction
{
    ESWeakSelf;
    NSString *API;
    if(self.imaArray)
    {
        API = APIUploadMorePicture;
    }
    else
    {
        //不存在图片
        API = APIInsertTalk;
        self.imaArray = @[];
    }
    
    
    [SVProgressHUD show];
    NSDictionary *dic = @{@"talkString":_mjTextView.textView.text};
    [MJAFNetWorking uploadMoreImgWithURLString:API parameters:dic dataImg:self.imaArray success:^(NSDictionary *dictionary) {
         [SVProgressHUD showSuccessWithStatus:dictionary[@"message"]];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(self.reloadDataBlock)
            {
                self.reloadDataBlock();
            }
            [__weakSelf.navigationController popViewControllerAnimated:YES];
            
        });
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"---%@",error);
    }];

}

#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
   
    [self.view addSubview:self.mjTextView];
    [self.view addSubview:self.pictuersView];
  
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_mjTextView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(@150);
    }];
    [_pictuersView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_mjTextView.bottom).offset(20);
        make.left.right.bottom.equalTo(self.view);
        
    }];
   
}
@end
