//
//  TutorDataProvider.m
//  Tutor
//
//  Created by syzhou on 13-10-29.
//  Copyright (c) 2013年 syzhou. All rights reserved.
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

+(void)registeWithMobile:(NSString *)mobile  password:(NSString *)password handle:(handleResult)handle {
    __weak SYRequest *request = [SYRequest requestWithURL:[NSURL URLWithString:[ServerUrl stringByAppendingPathComponent:@"user/register"]]];
    [request setStrRequestMethod:@"post"];
    [request setPostValue:mobile forKey:@"mobile_phone"];
    [request setPostValue:password forKey:@"password"];
    [request startSynchronous];
    
    handle(request);
}

+ (void)loginWithMobile:(NSString *)mobile password:(NSString *)password handle:(handleResult)handle {
    SYRequest *request = [SYRequest requestWithURL:[NSURL URLWithString:[ServerUrl stringByAppendingPathComponent:@"user/login"]]];
    [request setStrRequestMethod:@"post"];
    [request setPostValue:mobile forKey:@"mobile_phone"];
    [request setPostValue:password forKey:@"password"];
    [request startSynchronous];
    
    handle(request);
}



+ (void)authenticateTeachInfoWith:(NSString *)username idc:(NSString *)idc address:(NSString *)address longitude:(NSString *)lng latitude:(NSString *)lat payType:(NSString *)type card_no:(NSString *)cardno college:(NSString *)college degree:(NSString *)degree major:(NSString *)major handle:(handleResult)handle {
    SYRequest *request = [SYRequest requestWithURL:[NSURL URLWithString:[ServerUrl stringByAppendingPathComponent:@"user/save_tea_info"]]];
    [request setStrRequestMethod:@"post"];
    [request setPostValue:username forKey:@"user_name"];
    [request setPostValue:idc forKey:@"idc"];
    [request setPostValue:address forKey:@"address"];
    [request setPostValue:lng forKey:@"longitude"];
    [request setPostValue:lat forKey:@"latitude"];
    [request setPostValue:type forKey:@"pay_type"];
    [request setPostValue:cardno forKey:@"card_no"];
    [request setPostValue:cardno forKey:@"college"];
    [request setPostValue:cardno forKey:@"degree"];
    [request setPostValue:cardno forKey:@"major"];
    [request startSynchronous];
    
    handle(request);
}

+ (void)authenticateParentInfoWith:(NSString *)username idc:(NSString *)idc address:(NSString *)address longitude:(NSString *)lng latitude:(NSString *)lat handle:(handleResult)handle {
    SYRequest *request = [SYRequest requestWithURL:[NSURL URLWithString:[ServerUrl stringByAppendingPathComponent:@"user/save_par_info"]]];
    [request setStrRequestMethod:@"post"];
    [request setPostValue:username forKey:@"user_name"];
    [request setPostValue:idc forKey:@"idc"];
    [request setPostValue:address forKey:@"address"];
    [request setPostValue:lng forKey:@"longitude"];
    [request setPostValue:lat forKey:@"latitude"];

    [request startSynchronous];
    
    handle(request);
}

@end
