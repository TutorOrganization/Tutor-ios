//
//  TutorDataProvider.h
//  Tutor
//
//  Created by syzhou on 13-10-29.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "SYRequest.h"

#define ServerUrl @"http://121.199.29.230/api"

typedef enum {
    GetOldType= 0,
    GetNewType,
}GetDataType;

@interface TutorDataProvider : NSObject

+ (void)handleCookies;

+ (void)clearCookies;

//+(SYRequest *)login

@end
