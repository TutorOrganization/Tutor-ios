//
//  SYRequest.m
//  Knoala
//
//  Created by syzhou on 13-7-6.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "SYRequest.h"
#import "TutorDataProvider.h"
#import <MobileCoreServices/MobileCoreServices.h>

NSString * const NetworkRequestErrorDomain = @"KnoalaRequestErrorDomain";

#define TimeOut 10

@interface SYRequest ()

@property (nonatomic, strong)   NSMutableArray *marrayFile;

- (NSURLRequest *)createRequest;
- (void)appendPostString:(NSString *)string;
- (void)appendPostData:(NSData *)data;
- (void)buildRequestHeaders:(NSMutableURLRequest *)request;
- (void)buildPostBody;
- (void)buildURLEncodedPostBody;
- (void)buildMultipartFormDataPostBody;

@end

@implementation SYRequest

@synthesize url = _url;
@synthesize marrayPostData = _marrayPostData;
@synthesize mdictRequestHeaders = _mdictRequestHeaders;
@synthesize marrayFile = _marrayFile;
@synthesize strRequestMethod = _strRequestMethod;
@synthesize dictUserInfo = _dictUserInfo;
@synthesize tag = _tag;
@synthesize postFormat = _postFormat;
@synthesize stringEncoding = _stringEncoding;
@synthesize error = _error;
@synthesize response = _response;
@synthesize delegate = _delegate;
@synthesize timeout = _timeout;
@synthesize isLoading = _isLoading;

@synthesize didFailSelector = _didFailSelector;
@synthesize didFinishSelector = _didFinishSelector;
@synthesize didReceiveDataSelector = _didReceiveDataSelector;
@synthesize didStartSelector = _didStartSelector;
@synthesize didReceiveResponseHeadersSelector = _didReceiveResponseHeadersSelector;

- (id)initWithURL:(NSURL *)newURL {
    self = [super init];
    if (self) {
        self.url = newURL;
        self.strRequestMethod = @"GET";
        self.marrayPostData = [[NSMutableArray alloc] init];
        self.postFormat = URLEncodedPostFormat;
        self.stringEncoding = NSUTF8StringEncoding;
        self.error = nil;
        self.response = nil;
        self.timeout = TimeOut;
        
        [self setDidStartSelector:@selector(requestStarted:)];
        [self setDidReceiveResponseHeadersSelector:@selector(request:didReceiveResponseHeaders:)];
        [self setDidFinishSelector:@selector(requestFinished:)];
        [self setDidFailSelector:@selector(requestFailed:)];
        [self setDidReceiveDataSelector:@selector(request:didReceiveData:)];
    }
    
    return self;
}

+ (id)requestWithURL:(NSURL *)newURL {

    return [[self alloc] initWithURL:newURL];
}

- (id)startSynchronous {
    if (_connection) {
        [_connection cancel];
    }
    __weak NSURLResponse *responseTemp;
    __weak NSError *errorTemp;
    _isLoading = YES;
    
    _mdataReviceContent = (id)[NSURLConnection sendSynchronousRequest:[self createRequest] returningResponse:&responseTemp  error:&errorTemp];
    self.error = errorTemp;
    self.response = responseTemp;
    _isLoading = NO;
    
    if (self.error) {
        if ([_delegate respondsToSelector:@selector(didFailSelector)]) {
            [_delegate performSelector:@selector(didFailSelector) withObject:self];
        }
        
    } else {
        if ([_delegate respondsToSelector:@selector(didFinishSelector)]) {
            [_delegate performSelector:@selector(didFinishSelector) withObject:self];
        }        
    }

    DLog(@"url:%@ \n result:%@",self.url,self.responseString);
    
    return [self responseString];
}

- (void)startAsynchronous {
    if (_connection) {
        [_connection cancel];
    }
    
    _mdataReviceContent = nil;
    _connection = [[NSURLConnection alloc] initWithRequest:[self createRequest] delegate:self];
    [_connection start];
    _isLoading = YES;
    DLog(@"url:%@",self.url);
}

- (void)cancel {
    [_connection cancel];
}

#pragma mark setup request

- (void)addRequestHeader:(NSString *)header value:(NSString *)value {
    if (!_mdictRequestHeaders) {
		[self setMdictRequestHeaders:[NSMutableDictionary dictionaryWithCapacity:1]];
	}
	[_mdictRequestHeaders setObject:value forKey:header];
}

- (void)addPostValue:(id <NSObject>)value forKey:(NSString *)key {
	if (!key) {
		return;
	}
	if (![self marrayPostData]) {
		[self setMarrayPostData:[NSMutableArray array]];
	}
	NSMutableDictionary *keyValuePair = [NSMutableDictionary dictionaryWithCapacity:2];
	[keyValuePair setValue:key forKey:@"key"];
	[keyValuePair setValue:[value description] forKey:@"value"];
	[[self marrayPostData] addObject:keyValuePair];
}

- (void)setPostValue:(id <NSObject>)value forKey:(NSString *)key {
	// Remove any existing value
	NSUInteger i;
	for (i=0; i<[[self marrayPostData] count]; i++) {
		NSDictionary *val = [[self marrayPostData] objectAtIndex:i];
		if ([[val objectForKey:@"key"] isEqualToString:key]) {
			[[self marrayPostData] removeObjectAtIndex:i];
			i--;
		}
	}
	[self addPostValue:value forKey:key];
}

- (void)addFile:(NSString *)filePath forKey:(NSString *)key
{
	[self addFile:filePath withFileName:nil andContentType:nil forKey:key];
}

- (void)addFile:(NSString *)filePath withFileName:(NSString *)fileName andContentType:(NSString *)contentType forKey:(NSString *)key
{
	BOOL isDirectory = NO;
	BOOL fileExists = [[NSFileManager defaultManager]  fileExistsAtPath:filePath isDirectory:&isDirectory];
	if (!fileExists || isDirectory) {
		self.error = [NSError errorWithDomain:NetworkRequestErrorDomain code:0100 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"No file exists at %@",filePath],NSLocalizedDescriptionKey,nil]];
	}
    
	// If the caller didn't specify a custom file name, we'll use the file name of the file we were passed
	if (!fileName) {
		fileName = [filePath lastPathComponent];
	}
    
	// If we were given the path to a file, and the user didn't specify a mime type, we can detect it from the file extension
	if (!contentType) {
		contentType = [SYRequest mimeTypeForFileAtPath:filePath];
	}
	[self addData:[NSData dataWithContentsOfFile:filePath] withFileName:fileName andContentType:contentType forKey:key];
}

- (void)setFile:(NSString *)filePath forKey:(NSString *)key
{
	[self setFile:[NSData dataWithContentsOfFile:filePath] withFileName:nil andContentType:nil forKey:key];
}

- (void)setFile:(id)data withFileName:(NSString *)fileName andContentType:(NSString *)contentType forKey:(NSString *)key
{
	// Remove any existing value
	NSUInteger i;
	for (i=0; i<[[self marrayFile] count]; i++) {
		NSDictionary *val = [[self marrayFile] objectAtIndex:i];
		if ([[val objectForKey:@"key"] isEqualToString:key]) {
			[[self marrayFile] removeObjectAtIndex:i];
			i--;
		}
	}
	[self addFile:data withFileName:fileName andContentType:contentType forKey:key];
}

- (void)addData:(NSData *)data forKey:(NSString *)key
{
	[self addData:data withFileName:@"file" andContentType:nil forKey:key];
}

- (void)addData:(id)data withFileName:(NSString *)fileName andContentType:(NSString *)contentType forKey:(NSString *)key
{
	if (![self marrayFile]) {
		[self setMarrayFile:[NSMutableArray array]];
	}
	if (!contentType) {
		contentType = @"application/octet-stream";
	}
    
	NSMutableDictionary *fileInfo = [NSMutableDictionary dictionaryWithCapacity:4];
	[fileInfo setValue:key forKey:@"key"];
	[fileInfo setValue:fileName forKey:@"fileName"];
	[fileInfo setValue:contentType forKey:@"contentType"];
	[fileInfo setValue:data forKey:@"data"];
    
	[[self marrayFile] addObject:fileInfo];
}

- (void)setData:(NSData *)data forKey:(NSString *)key
{
	[self setData:data withFileName:@"file" andContentType:nil forKey:key];
}

- (void)setData:(id)data withFileName:(NSString *)fileName andContentType:(NSString *)contentType forKey:(NSString *)key
{
	// Remove any existing value
	NSUInteger i;
	for (i=0; i<[[self marrayFile] count]; i++) {
		NSDictionary *val = [[self marrayFile] objectAtIndex:i];
		if ([[val objectForKey:@"key"] isEqualToString:key]) {
			[[self marrayFile] removeObjectAtIndex:i];
			i--;
		}
	}
	[self addData:data withFileName:fileName andContentType:contentType forKey:key];
}

#pragma mark get information about this request
- (NSString *)responseString {
    if (!_mdataReviceContent) {
        return nil;
    }
    
    return [[NSString alloc] initWithBytes:[_mdataReviceContent bytes] length:[_mdataReviceContent length] encoding:[self stringEncoding]];
}
- (NSData *)responseData {
    return _mdataReviceContent;
}


#pragma mark - Private method
- (NSMutableURLRequest *)createRequest {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:self.url];
    [self buildPostBody];
    [self buildRequestHeaders:request];
    request.timeoutInterval = self.timeout;
    [request setHTTPMethod:_strRequestMethod];
    
    if ([[_strRequestMethod uppercaseString] isEqualToString:@"POST"]) {
        [request setHTTPBody:_mdataPost];
    }
    return request;
}

- (void)appendPostString:(NSString *)string
{
    [self appendPostData:[string dataUsingEncoding:[self stringEncoding]]];
}

- (void)appendPostData:(NSData *)data {
    if (!_mdataPost) {
        _mdataPost = [[NSMutableData alloc] init];
    }
    
    [_mdataPost appendData:data];
}

- (void)buildRequestHeaders:(NSMutableURLRequest *)request {
    for (NSString *strKey in [_mdictRequestHeaders allKeys]) {
        [request setValue:[_mdictRequestHeaders objectForKey:strKey] forHTTPHeaderField:strKey];
    }
}

- (void)buildPostBody {
    
    if (_postFormat == URLEncodedPostFormat) {
        [self buildURLEncodedPostBody];
    } else if (_postFormat == MultipartFormDataPostFormat) {
        [self buildMultipartFormDataPostBody];
    }
    
    unsigned long long postLenth = [_mdataPost length];
    if (postLenth > 0) {
		if ([_strRequestMethod isEqualToString:@"GET"] || [_strRequestMethod isEqualToString:@"DELETE"] || [_strRequestMethod isEqualToString:@"HEAD"]) {
			[self setStrRequestMethod:@"POST"];
		}
        
		[self addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%llu",postLenth]];
	}
}


- (void)buildURLEncodedPostBody {
    NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding([self stringEncoding]));
    
	[self addRequestHeader:@"Content-Type" value:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@",charset]];
    
	DLog(@"post para:%@",self.marrayPostData);
	NSUInteger i=0;
	NSUInteger count = [[self marrayPostData] count]-1;
	for (NSDictionary *val in [self marrayPostData]) {
        NSString *data = [NSString stringWithFormat:@"%@=%@%@", [self encodeURL:[val objectForKey:@"key"]], [self encodeURL:[val objectForKey:@"value"]],(i<count ?  @"&" : @"")];
		[self appendPostString:data];
		i++;
	}
}

- (void)buildMultipartFormDataPostBody {
    NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding([self stringEncoding]));
	
	// We don't bother to check if post data contains the boundary, since it's pretty unlikely that it does.
	CFUUIDRef uuid = CFUUIDCreate(nil);
	NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuid));
	CFRelease(uuid);
	NSString *stringBoundary = [NSString stringWithFormat:@"0xKhTmLbOuNdArY-%@",uuidString];
	
	[self addRequestHeader:@"Content-Type" value:[NSString stringWithFormat:@"multipart/form-data; charset=%@; boundary=%@", charset, stringBoundary]];
	
	[self appendPostString:[NSString stringWithFormat:@"--%@\r\n",stringBoundary]];
	
	// Adds post data
	NSString *endItemBoundary = [NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary];
	NSUInteger i=0;
	for (NSDictionary *val in [self marrayPostData]) {
		[self appendPostString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",[val objectForKey:@"key"]]];
		[self appendPostString:[val objectForKey:@"value"]];
		i++;
		if (i != [[self marrayPostData] count] || [[self marrayFile] count] > 0) { //Only add the boundary if this is not the last item in the post body
			[self appendPostString:endItemBoundary];
		}
	}
	
	// Adds files to upload
	i=0;
	for (NSDictionary *val in [self marrayFile]) {
        
		[self appendPostString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", [val objectForKey:@"key"], [val objectForKey:@"fileName"]]];
		[self appendPostString:[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", [val objectForKey:@"contentType"]]];
		
		id data = [val objectForKey:@"data"];
        [self appendPostData:data];

		i++;
		// Only add the boundary if this is not the last item in the post body
		if (i != [[self marrayFile] count]) {
			[self appendPostString:endItemBoundary];
		}
	}
	
	[self appendPostString:[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary]];
}

#pragma mark utilities
- (NSString*)encodeURL:(NSString *)string
{
    NSString *newString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding([self stringEncoding])));
    //    NSMakeCollectable is no longer required in ARC
    //	NSString *newString = NSMakeCollectable(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding([self stringEncoding])));
	if (newString) {
		return newString;
	}
	return @"";
}

#pragma mark mime-type detection
+ (NSString *)mimeTypeForFileAtPath:(NSString *)path
{
	if (![[[NSFileManager alloc] init] fileExistsAtPath:path]) {
		return nil;
	}
	// Borrowed from http://stackoverflow.com/questions/2439020/wheres-the-iphone-mime-type-database
	CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
	if (!MIMEType) {
		return @"application/octet-stream";
	}
    return CFBridgingRelease(MIMEType);
}

#pragma mark - NSURLConnection delegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    _isLoading = NO;
    self.error = error;
//    if ([_delegate respondsToSelector:_didFailSelector]) {
//        [_delegate performSelector:_didFailSelector withObject:self];
//    }
    if ([_delegate respondsToSelector:@selector(requestFailed:)]) {
        [_delegate performSelector:@selector(requestFailed:) withObject:self];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.response = response;
    if ([_delegate respondsToSelector:@selector(request:didReceiveResponseHeaders:)]) {
        [_delegate performSelector:@selector(request:didReceiveResponseHeaders:) withObject:self withObject:response];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (!_mdataReviceContent) {
        _mdataReviceContent = [[NSMutableData alloc ] init];
    }
    
    [_mdataReviceContent appendData:data];
    
//    if ([_delegate respondsToSelector:@selector(didReceiveDataSelector)]) {
//        [_delegate performSelector:@selector(didReceiveDataSelector) withObject:self withObject:[self responseString]];
//    }
    if ([_delegate respondsToSelector:@selector(request:didReceiveData:)]) {
        [_delegate performSelector:@selector(request:didReceiveData:) withObject:self withObject:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    _isLoading = NO;
    
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        NSLog(@"%@", cookie);
    }
    
    DLog(@"result:%@",self.responseString);
    if ([_delegate respondsToSelector:@selector(didFinishSelector:)]) {
        [_delegate performSelector:@selector(didFinishSelector:) withObject:self];
    }
    
    [TutorDataProvider handleCookies];
    if ([_delegate respondsToSelector:@selector(requestFinished:)]) {
        [_delegate requestFinished:self];
    }
}

@end
