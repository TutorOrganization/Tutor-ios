//
//  TutorDataProvider.h
//  Tutor
//
//  Created by syzhou on 13-10-29.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "SYRequest.h"

/*
 requestStatus意义说明 "0"代表请求成功并相应的返回数据,
 1：服務器內部發生了未知錯誤
 2：输入参数不对
 3：请求协议不正确
 4：检验Token失败
 5：调用接口不存在
 */

#define ServerUrl @"http://121.199.29.230/api"

typedef void (^handleResult)(SYRequest *);

typedef enum {
    GetOldType= 0,
    GetNewType,
}GetDataType;

@interface TutorDataProvider : NSObject

+ (void)handleCookies;

+ (void)clearCookies;

/*
 
 
 */

+ (void)registeWithMobile:(NSString *)mobile  password:(NSString *)password handle:(handleResult)handle;

+ (void)loginWithMobile:(NSString *)mobile password:(NSString *)password handle:(handleResult)handle;


@end
