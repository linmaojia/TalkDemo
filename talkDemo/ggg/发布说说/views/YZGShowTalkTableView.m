//
//  YZGShopProduductTableView.m
//  YZGShopInformation
//
//  Created by 李超 on 16/6/9.
//  Copyright © 2016年 lichao. All rights reserved.
//

#import "YZGShowTalkTableView.h"
#import "YZGShowTalkTableCell.h"
#import "YZGTalkModel.h"
#import "YZGRemarksView.h"
 #import "YZGTalkManager.h"
@interface YZGShowTalkTableView ()<UITableViewDelegate,UITableViewDataSource>


@end
@implementation YZGShowTalkTableView

#pragma ******************* init
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[YZGShowTalkTableCell class] forCellReuseIdentifier:@"YZGShowTalkTableCell"];

        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
        longPressGr.minimumPressDuration = 1.0;
        [self addGestureRecognizer:longPressGr];
        
    }
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
}

#pragma mark ************** UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YZGTalkModel *model = self.dataArray[indexPath.row];
    
    CGFloat cell_H = [YZGTalkManager getCellHeightWithModel:model];//图片内容高度

    return cell_H;
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YZGShowTalkTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZGShowTalkTableCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
#pragma ******************* UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

}
/* 添加删除效果*/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //删除按钮
    ESWeakSelf;
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath){
        
        [SVProgressHUD show];
        YZGTalkModel *model = __weakSelf.dataArray[indexPath.row];
        
         NSDictionary *dic = @{@"talkId": model.talkId};
        [MJAFNetWorking getWithURLString:APIDeleteTalk parameters:dic success:^(NSDictionary *dictionary) {
            
             [SVProgressHUD showSuccessWithStatus:dictionary[@"message"]];
            
            [__weakSelf.dataArray removeObjectAtIndex:indexPath.row];
            
            [__weakSelf reloadData];
            
            if(__weakSelf.cellDeleteBlack)
            {
                __weakSelf.cellDeleteBlack();
            }
            
            
        } failure:^(NSError *error) {
            
            
            NSLog(@"--error-%@",error);
        }];
        
    }];
 
    //返回按钮数组
    return @[deleteRowAction];
}

/* 响应长按事件*/
-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:self];
        NSIndexPath * indexPath = [self indexPathForRowAtPoint:point];
        if(indexPath == nil)
        {
            return ;
        }
        else
        {
            
            YZGTalkModel *model = self.dataArray[indexPath.row];
            ESWeakSelf;
            [YZGRemarksView showRemarksViewWithTitle:model.talkString PlacehoderText:nil ConfirmBlock:^(NSString *text) {
                
                [__weakSelf updatalkWithString:text Model:model];
                
            } CancelBlock:^{
                
            }];
            
             NSLog(@"----%@",model.talkId);
        }
 
        
    }
}
#pragma ******************* 更新数据
- (void)updatalkWithString:(NSString *)text Model:(YZGTalkModel *)model
{
    ESWeakSelf;
    NSDictionary *dic = @{@"talkString":text,@"talkId":model.talkId};
    
    [MJAFNetWorking getWithURLString:APIUpdateTalk parameters:dic success:^(NSDictionary *dictionary) {
        
        [SVProgressHUD showSuccessWithStatus:dictionary[@"message"]];
        
         model.talkString = text;
        
        [__weakSelf reloadData];
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"--error-%@",error);
    }];
}
@end
