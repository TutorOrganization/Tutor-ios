//
//  SYRequest.h
//  Knoala
//
//  Created by syzhou on 13-7-6.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYRequestDelegate.h"
#import "JSON.h"

typedef enum {
    URLEncodedPostFormat = 0,
    MultipartFormDataPostFormat = 1,
}HttpPostFormat;

@interface SYRequest : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>{
    NSURL *_url;
    NSURLConnection *_connection;

    // Parameters that will be posted to the url
    NSMutableArray *_marrayPostData;
    NSMutableArray *_marrayFile;
    
    NSMutableData *_mdataPost;
    NSMutableData *_mdataReviceContent;
    
    // Dictionary for custom HTTP request headers
    NSMutableDictionary *_mdictRequestHeaders;
    
    // HTTP method to use (eg: GET / POST / PUT / DELETE / HEAD etc). Defaults to GET
	NSString *_strRequestMethod;
    
    // Custom user information associated with the request (not sent to the server)
	NSDictionary *_dictUserInfo;
    NSInteger _tag;
    
    HttpPostFormat _postFormat;//defalut is URLEncodedPostFormat
	NSStringEncoding _stringEncoding;//default is NSUTF8StringEncoding

    // If an error occurs, error will contain an NSError
    NSError *_error;
    NSURLResponse *_response;
    
    __weak id <KnoalaRequestDelegate> _delegate;
    BOOL _isLoading;
    NSInteger _timeout;
    
    // Called on the delegate (if implemented) when the request starts. Default is requestStarted:
	SEL _didStartSelector;
	
	// Called on the delegate (if implemented) when the request receives response headers. Default is request:didReceiveResponseHeaders:
	SEL _didReceiveResponseHeadersSelector;
    // Called on the delegate (if implemented) when the request completes successfully. Default is requestFinished:
	SEL _didFinishSelector;
	
	// Called on the delegate (if implemented) when the request fails. Default is requestFailed:
	SEL _didFailSelector;
    // Called on the delegate (if implemented) when the request receives data. Default is request:didReceiveData:
	// If you set this and implement the method in your delegate, you must handle the data yourself - KnoalaRequest will not populate responseData or write the data to downloadDestinationPath
	SEL _didReceiveDataSelector;
}

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSMutableArray *marrayPostData;
@property (nonatomic, strong) NSMutableDictionary *mdictRequestHeaders;
@property (nonatomic, strong) NSString *strRequestMethod;
@property (nonatomic, strong) NSDictionary *dictUserInfo;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) HttpPostFormat postFormat;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, assign) NSStringEncoding stringEncoding;

@property (nonatomic, weak) id <KnoalaRequestDelegate> delegate;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) NSInteger timeout;

@property (nonatomic, assign) SEL didStartSelector;
@property (nonatomic, assign) SEL didReceiveResponseHeadersSelector;
@property (nonatomic, assign) SEL didFinishSelector;
@property (nonatomic, assign) SEL didFailSelector;
@property (nonatomic, assign) SEL didReceiveDataSelector;

#pragma mark init
- (id)initWithURL:(NSURL *)newURL;
+ (id)requestWithURL:(NSURL *)newURL;

#pragma mark running a request
- (id)startSynchronous;
- (void)startAsynchronous;
- (void)cancel;

#pragma mark setup request
// Add a custom header to the request
- (void)addRequestHeader:(NSString *)header value:(NSString *)value;

// Add a POST variable to the request
- (void)addPostValue:(id <NSObject>)value forKey:(NSString *)key;

// Set a POST variable for this request, clearing any others with the same key
- (void)setPostValue:(id <NSObject>)value forKey:(NSString *)key;

// Add the contents of a local file to the request
- (void)addFile:(NSString *)filePath forKey:(NSString *)key;

// Same as above, but you can specify the content-type and file name
- (void)addFile:(NSString *)filePath withFileName:(NSString *)fileName andContentType:(NSString *)contentType forKey:(NSString *)key;

// Add the contents of a local file to the request, clearing any others with the same key
- (void)setFile:(NSString *)filePath forKey:(NSString *)key;

// Same as above, but you can specify the content-type and file name
- (void)setFile:(NSString *)filePath withFileName:(NSString *)fileName andContentType:(NSString *)contentType forKey:(NSString *)key;

// Add the contents of an NSData object to the request
- (void)addData:(NSData *)data forKey:(NSString *)key;

// Same as above, but you can specify the content-type and file name
- (void)addData:(id)data withFileName:(NSString *)fileName andContentType:(NSString *)contentType forKey:(NSString *)key;

// Add the contents of an NSData object to the request, clearing any others with the same key
- (void)setData:(NSData *)data forKey:(NSString *)key;

// Same as above, but you can specify the content-type and file name
- (void)setData:(id)data withFileName:(NSString *)fileName andContentType:(NSString *)contentType forKey:(NSString *)key;


#pragma mark get information about this request

// Returns the contents of the result as an NSString (not appropriate for binary data - used responseData instead)
- (NSString *)responseString;

// Response data,
- (NSData *)responseData;


#pragma mark utilities
- (NSString*)encodeURL:(NSString *)string;
#pragma mark mime-type detection
+ (NSString *)mimeTypeForFileAtPath:(NSString *)path;

@end