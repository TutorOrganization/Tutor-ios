//
//  KnoalaDataProvider.h
//  Knoala
//
//  Created by syzhou on 13-7-10.
//  Copyright (c) 2013年 Gong Xuehan. All rights reserved.
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
