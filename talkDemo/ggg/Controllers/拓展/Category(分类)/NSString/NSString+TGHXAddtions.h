//
//  NSString+TGHXAddtions.h
//  ETao
//
//  Created by AVGD on 15/9/22.
//  Copyright © 2015年 jacky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TGHXAddtions)

//字典转json
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;

//数组转json
+(NSString *) jsonStringWithArray:(NSArray *)array;

//NSString转json
+(NSString *) jsonStringWithString:(NSString *) string;

//对象转json
+(NSString *) jsonStringWithObject:(id) object;

@end
