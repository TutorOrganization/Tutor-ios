//
//  KnoalaDataProvider.m
//  Knoala
//
//  Created by syzhou on 13-7-10.
//  Copyright (c) 2013年 Gong Xuehan. All rights reserved.
//

#import "TutorDataProvider.h"
NSString *const kLocationFollowingStartIdKey = @"cur_fid";


@implementation TutorDataProvider

+ (void)handleCookies
{
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    
//    BOOL new_following = NO;
//    BOOL new_notification = NO;
    
//    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//        if ([[cookie name] isEqualToString:@"latest_following_id"]) {
//            NSLog(@"last_following_id");
//            NSInteger latest_following_id = [[cookie value] intValue];
//            NSInteger location_following_id = [getUIObjectForKey(kLocationFollowingStartIdKey) intValue];
//            
//            if (latest_following_id > location_following_id) {
//                new_following = YES;
//            }
//        } else if ([[cookie name] isEqualToString:@"latest_notification_id"]) {
//            NSLog(@"last_notification_id");
//            NSInteger last_notification_id = [[cookie value] intValue];
//            NSInteger location_notiffication_id = [getUIObjectForKey(kLocationNotificationStartIdKey) intValue];
//            
//            if (last_notification_id > location_notiffication_id) {
//                new_notification = YES;
//            }
//        }
//    }
//    if (!new_following && !new_notification) {
//        saveUDObject([NSNumber numberWithBool:NO], kShowNavigationIndicateKey);
//        [[NSNotificationCenter defaultCenter] postNotificationName:kNavigationNormalNotificationKey object:nil];
//    } else if (new_notification || new_following) {
//        saveUDObject([NSNumber numberWithBool:YES], kShowNavigationIndicateKey);
//        [[NSNotificationCenter defaultCenter] postNotificationName:kNavigationIndicateNotificationKey object:nil];
//    }
}

+ (void)clearCookies
{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in _tmpArray) {
        [cookieJar deleteCookie:obj];
    }
}


@end
