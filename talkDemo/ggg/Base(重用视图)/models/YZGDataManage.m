//
//  GeneralViewModel.m
//  ggg
//
//  Created by LXY on 16/9/23.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGDataManage.h"
#import "CoreStatus.h"
@interface YZGDataManage ()
{
    NSInteger _hour,_minute,_day;
}
@end
@implementation YZGDataManage

#pragma mark ************** 计算文本高度
+ (CGFloat)getLabelHeightWithText:(NSString *)text LabWidth:(CGFloat)labWidth LabFontSize:(CGFloat)labFontSize
{
    CGRect placehoderRect=[text boundingRectWithSize:CGSizeMake(labWidth, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:labFontSize]} context:nil];
    CGFloat height = placehoderRect.size.height;
    
    return height;
    
}
+ (CGFloat)getLabelwidthWithText:(NSString *)text LabHeight:(CGFloat)labHeight LabFontSize:(CGFloat)labFontSize
{
    CGRect placehoderRect=[text boundingRectWithSize:CGSizeMake(MAXFLOAT,labHeight)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:labFontSize]} context:nil];
    CGFloat width = placehoderRect.size.width;
    
    return width;
    
}
#pragma mark ************** 时间戳转换
- (NSString *)changeTime:(NSInteger)time{
    NSString *strTime;
    NSDate *newdate=[NSDate dateWithTimeIntervalSince1970:time/1000];//NSDate
    //定义时间格式
    NSDateFormatter *dateformatter=[NSDateFormatter new];
    [dateformatter setDateFormat:@"MM-dd HH:mm:ss"];
    //转为字符串
    strTime =[dateformatter stringFromDate:newdate];
    return strTime;
}
- (NSInteger)getCurrentDaySurplusSecond:(NSInteger)timestamp CountData:(NSInteger)countData
{
    //时间戳
    
    //计算申请退款当天经过的时间 然后 用总时间 减掉
    NSTimeInterval courseTime = [self calculatorWithOrderTime:timestamp];
    
    NSTimeInterval beginTime = timestamp + 8 * 60 * 60;
    NSTimeInterval endTime = beginTime + countData * 24 * 60 * 60 - courseTime;
    
    //申请退款的时间
    NSDate *beginDate = [NSDate dateWithTimeIntervalSince1970:beginTime];
    //当前时间
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:8 * 60 * 60];
    //过期时间
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:endTime];
    
    //当前时间 跟 申请退款 时间差
    NSInteger currentTime = (NSInteger)[currentDate timeIntervalSinceDate:beginDate];
    
    //过期时间 跟 申请退款 时间差
    NSInteger totalTime = (NSInteger)[endDate timeIntervalSinceDate:beginDate];
    
    //过期时间 - 经过的时间 = 剩余时间
    NSInteger finalTime = totalTime - currentTime;
    
    return finalTime;
}
/*计算订单当天经过时间*/
- (NSTimeInterval )calculatorWithOrderTime:(NSTimeInterval)timestamp
{
    
    NSDate *beginDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekday fromDate:beginDate];
    
    //设置时间dataFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];  // 设置时间格式
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    
    [dateFormatter setTimeZone:timeZone]; //设置时区 ＋8:00
    
    //加入当天的日期
    NSString  *someDayStr= [NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",comps.year,comps.month,comps.day];   // 设置过去的某个时间点比如:2000-01-01 00:00:00
    
    //需要对比的某个时间(订单申请的 当天 0点 时间)
    NSDate *someDayDate = [dateFormatter dateFromString:someDayStr];
    
    //订单申请的时间
    NSTimeInterval beginTime = timestamp + 8 * 60 * 60;
    NSDate *orderBeginDate = [NSDate dateWithTimeIntervalSince1970:beginTime];
    
    //申请订单当天经过时间
    NSTimeInterval courseTime = [orderBeginDate timeIntervalSinceDate:someDayDate];
    
    return courseTime;
}
/* 返回时间 */
- (NSString *)getDetailTimeWithTimestamp:(NSInteger)timestamp
{
    NSInteger ms = timestamp;
    NSInteger ss = 1;
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    NSInteger dd = hh * 24;
    
    // 剩余的
    NSInteger day = ms / dd;// 天
    NSInteger hour = (ms - day * dd) / hh;// 时
    NSInteger minute = (ms - day * dd - hour * hh) / mi;// 分
    NSInteger second = (ms - day * dd - hour * hh - minute * mi) / ss;// 秒
    
    NSString *dateStr = [NSString stringWithFormat:@" %ld 天 %ld 时 %ld 分", day,hour,minute];
    
    _day = day;
    _hour = hour;
    _minute = minute;
    
    return dateStr ;
    
}





/*判断错误类型*/
+ (EmptyViewTypes)dealEmptyViewTypeWithData:(id)response error:(NSError *)error
{
    
    if(!error)
    {
        //2.数据为空
        if([response isKindOfClass:[NSArray class]] || [response isKindOfClass:[NSDictionary class]])
        {
            if([response isKindOfClass:[NSArray class]])
            {
                NSArray *dataArray = (NSArray *)response;
                
                if(dataArray.count == 0)
                {
                    return EmptyViewTypeEmptyData;
                }
            }
            if([response isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *dataDict = (NSDictionary *)response;
                
                if(dataDict.count == 0)
                {
                    return EmptyViewTypeEmptyData;
                }
            }
        }
        
        //6.成功
        return EmptyViewTypesucceed;
    }
    else
    {
        //1.无网络连接
        if([CoreStatus currentNetWorkStatus] == 0)
        {
            return EmptyViewTypeNoSignal;
        }
        //3.未审核
        else if (error.code == 401)
        {
            return EmptyViewTypeNotAuthentication;
        }
        //4.数据出错
        else if (![response isKindOfClass:[NSArray class]] || [response isKindOfClass:[NSDictionary class]])
        {
            return EmptyViewTypesDataError;
        }
        //5.未知错误
        else
        {
            return EmptyViewTypesUnknownError;
        }
    }
    
}

@end
