//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGShowTalkVC.h"
#import "YZGTalkManager.h"
#import "YZGTalkModel.h"
#import "YZGShowTalkTableView.h"
#import "YZGReleaseTalkVC.h"
@interface YZGShowTalkVC ()
{
}
@property (nonatomic, strong) YZGShowTalkTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger tablelPageNum;
@property (nonatomic, assign) NSInteger deleCount;

@end

@implementation YZGShowTalkVC

#pragma mark ************** 懒加载控件
- (YZGShowTalkTableView *)tableView
{
    if (!_tableView)
    {
        ESWeakSelf;
        _tableView = [[YZGShowTalkTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
           __weakSelf.tablelPageNum ++;
           [__weakSelf getDataWithPageNum:__weakSelf.tablelPageNum];
        }];
        _tableView.mj_footer.hidden = YES;
        _tableView.cellDeleteBlack = ^(){
            __weakSelf.deleCount++;//根据删除数据来加载，服务端会相应减少
        };
     }
    return _tableView;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
    
    self.tablelPageNum = 1;
    
    [self getDataWithPageNum:self.tablelPageNum];
}

#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"动态";
    
    UIBarButtonItem *talkItem = [[UIBarButtonItem alloc] initWithTitle:@"说说" style:UIBarButtonItemStylePlain target:self action:@selector(puchAction)];
    self.navigationItem.rightBarButtonItem = talkItem;

}
#pragma mark ************** 推到发布界面
- (void)puchAction
{
    ESWeakSelf;
    YZGReleaseTalkVC *VC = [[YZGReleaseTalkVC alloc]init];
    VC.reloadDataBlock = ^()
    {
        __weakSelf.tablelPageNum = 1;
        [__weakSelf getDataWithPageNum:__weakSelf.tablelPageNum];//刷新回调
    };
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark ************** 获取数据
- (void)getDataWithPageNum:(NSInteger)pageNum
{
    ESWeakSelf;
    [SVProgressHUD show];
    /*
     增加 deleCount 每删除一个增加1，后台做相应处理，把请求位置相应定位减少
     */
    NSDictionary *params = @{@"pageSize":@"5",@"pageNum":@(pageNum),@"deleCount":@(self.deleCount)};
    [MJAFNetWorking getWithURLString:APISelectTalk parameters:params success:^(NSDictionary *dictionary) {
         NSLog(@"---%@",dictionary);
        
        [SVProgressHUD dismiss];
      
        NSArray *listArray = [YZGTalkModel mj_objectArrayWithKeyValuesArray:dictionary[@"urls"]];
        
        [__weakSelf.tableView.mj_footer endRefreshing];
        
         __weakSelf.tableView.mj_footer.hidden = NO;
        
        if(listArray.count == 0)
        {
            [__weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];//设置没有更多数据
        }
        
        [__weakSelf addDataArray:listArray];
        
        
    } failure:^(NSError *error) {
         NSLog(@"--error-%@",error);
    }];

}
#pragma mark ************** 数据处理
- (void)addDataArray:(NSArray *)listArray
{
    
    if(!self.dataArray)
    {
        self.dataArray = [NSMutableArray array];
    }
    if(self.tablelPageNum == 1)
    {
        [self.dataArray removeAllObjects];
    }
    
    [self.dataArray addObjectsFromArray:listArray];
    
    self.tableView.dataArray = self.dataArray;//赋值
    
    
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self.view addSubview:self.tableView];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
@end
