//
//  KnoalaRequestDelegate.h
//  Knoala
//
//  Created by syzhou on 13-7-6.
//  Copyright (c) 2013年 Gong Xuehan. All rights reserved.
//

#ifndef Knoala_KnoalaRequestDelegate_h
#define Knoala_KnoalaRequestDelegate_h

@class KnoalaRequest;

@protocol KnoalaRequestDelegate <NSObject>

@optional

// These are the default delegate methods for request status
// You can use different ones by setting didStartSelector / didFinishSelector / didFailSelector
- (void)requestStarted:(KnoalaRequest *)request;
- (void)request:(KnoalaRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders;
- (void)request:(KnoalaRequest *)request willRedirectToURL:(NSURL *)newURL;
- (void)requestFinished:(KnoalaRequest *)request;
- (void)requestFailed:(KnoalaRequest *)request;
- (void)requestRedirected:(KnoalaRequest *)request;

// When a delegate implements this method, it is expected to process all incoming data itself
// This means that responseData / responseString / downloadDestinationPath etc are ignored
// You can have the request call a different method by setting didReceiveDataSelector
- (void)request:(KnoalaRequest *)request didReceiveData:(NSData *)data;

@end

#endif
