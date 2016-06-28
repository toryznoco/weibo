//
//  TRAccount.m
//  微博
//
//  Created by Tory on 15/9/24.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import "TRAccount.h"
#import "MJExtension.h"

#define TRAccountTokenKey @"token"
#define TRUidKey @"uid"
#define TRExpires_inKey @"expires"
#define TRExpires_dateKey @"date"
#define TRNameKey @"name"

#import "MJExtension.h"

@implementation TRAccount
//  底层遍历当前的类的所有属性，一个一个归档和解档
MJCodingImplementation
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    TRAccount *account = [[self alloc] init];
    
    [account setValuesForKeysWithDictionary:dict];
    
    
    return account;
}

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    
    //  计算过期的时间 = 当期时间 + 有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

//  归档的时候调用：告诉系统哪个属性需要归档，如何归档
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:_access_token forKey:TRAccountTokenKey];
//    [aCoder encodeObject:_expires_in forKey:TRExpires_inKey];
//    [aCoder encodeObject:_uid forKey:TRUidKey];
//    [aCoder encodeObject:_expires_date forKey:TRExpires_dateKey];
//    [aCoder encodeObject:_name forKey:TRNameKey];
//}

//  解档的时候调用：告诉系统哪个属性需要解档，如何解档
//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super init]) {
//        //  一定要记得赋值
//        _access_token = [aDecoder decodeObjectForKey:TRAccountTokenKey];
//        _expires_in = [aDecoder decodeObjectForKey:TRExpires_inKey];
//        _uid = [aDecoder decodeObjectForKey:TRUidKey];
//        _expires_date = [aDecoder decodeObjectForKey:TRExpires_dateKey];
//        _name = [aDecoder decodeObjectForKey:TRNameKey];
//    }
//    return self;
//}

/**
 *  KVC底层实现，遍历字典里的所有key
    一个一个获取key,会去模型里查找setKey:setUid:,直接调用这个方法，赋值 setUid:obj
    寻找有没有带下划线_key,_uid,直接拿到属性赋值
    寻找有没有key的属性，如果有，直接赋值
    在模型里面找不到对应的key，就会报错
 */

@end
