//
//  TutorDataProvider.h
//  Tutor
//
//  Created by syzhou on 13-10-29.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "SYRequest.h"

typedef enum {
    GetOldType= 0,
    GetNewType,
}GetDataType;

@interface TutorDataProvider : NSObject

+ (void)handleCookies;

+ (void)clearCookies;


@end
