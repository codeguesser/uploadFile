//
//  AppDelegate.m
//  testUploadFile
//
//  Created by  on 2012/6/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "SimpleHtmlServer.h"
@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    
    SimpleHtmlServer *server = [[SimpleHtmlServer alloc]init];
    
    
    
    
    
    
    /*
     //cfstream
    CFURLRef fileURL = CFURLCreateWithString(NULL, CFSTR("http://www.baidu.com"), NULL);
    CFReadStreamRef myReadStream = CFReadStreamCreateWithFile(kCFAllocatorDefault, fileURL);
    if (!CFReadStreamOpen(myReadStream)) {
        CFStreamError myErr = CFReadStreamGetError(myReadStream);
        // An error has occurred.
        if (myErr.domain == kCFStreamErrorDomainPOSIX) {
            // Interpret myErr.error as a UNIX errno.
        } else if (myErr.domain == kCFStreamErrorDomainMacOSStatus) {
            // Interpret myErr.error as a MacOS error code.
            OSStatus macError = (OSStatus)myErr.error;
            // Check other error domains.
        }
    }
    
    
    int  myReadBufferSize = 200;
    
    CFIndex numBytesRead;
    do {
        UInt8 buf[myReadBufferSize]; // define myReadBufferSize as desired
        numBytesRead = CFReadStreamRead(myReadStream, buf, sizeof(buf));
        if( numBytesRead > 0 ) {
            handleBytes(buf, numBytesRead);
        } else if( numBytesRead < 0 ) {
            CFStreamError error = CFReadStreamGetError(myReadStream);
            reportError(error);
        }
        
    } while( numBytesRead > 0 );
    
    
    CFReadStreamClose(myReadStream);
    CFRelease(myReadStream);
    myReadStream = NULL;
    
    */
    
    
    /*
    //正常读取
     
    //CFStream
    CFStringRef bodyString = CFSTR("cc"); // Usually used for POST data
    CFDataRef bodyData = CFStringCreateExternalRepresentation(kCFAllocatorDefault,
                                                              bodyString, kCFStringEncodingUTF8, 0);
    NSString * str1 = [[NSString alloc]initWithData:(NSData *)bodyData encoding:NSUTF8StringEncoding];

    CFStringRef headerFieldName = CFSTR("X-My-Favorite-Field");
    CFStringRef headerFieldValue = CFSTR("Dreams");
    
    CFStringRef url = CFSTR("http://www.codeguesser.tk");
    CFURLRef myURL = CFURLCreateWithString(kCFAllocatorDefault, url, NULL);
    
    CFStringRef requestMethod = CFSTR("GET");
    CFHTTPMessageRef myRequest =CFHTTPMessageCreateRequest(kCFAllocatorDefault, requestMethod, myURL,kCFHTTPVersion1_1);
    
    
    
    
    
    //序列化and 发送
    
    CFReadStreamRef myReadStream = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, myRequest);
    CFReadStreamOpen(myReadStream);
    CFHTTPMessageRef myResponse = (CFHTTPMessageRef)CFReadStreamCopyProperty(myReadStream, kCFStreamPropertyHTTPResponseHeader);
    CFStringRef myStatusLine = CFHTTPMessageCopyResponseStatusLine(myResponse);
    NSLog(@"::%@",myStatusLine);
    UInt32 myErrCode = CFHTTPMessageGetResponseStatusCode(myResponse);
    
    
    
    NSMutableString *responseBody = [NSMutableString string];
	
	static unsigned int kReadBufSize = 102400;
	CFIndex numBytesRead;
	do {
        NSLog(@"%lu",numBytesRead);
		UInt8 buf[kReadBufSize];
		numBytesRead = CFReadStreamRead(myReadStream, buf, sizeof(buf));
		if( numBytesRead > 0 ) {
            NSString *tempStr=[[NSString alloc] initWithBytes:buf length:numBytesRead encoding:NSUTF8StringEncoding];
			[responseBody appendString: tempStr];
            [tempStr release];
		} else if( numBytesRead < 0 ) {
			CFErrorRef error = CFReadStreamCopyError(myReadStream);
            NSLog(@"%@",CFErrorCopyFailureReason);
			//[[NSApplication sharedApplication] presentError:(NSError*)error];
		}
	} while( numBytesRead > 0 );
    
    
    
    
    
    CFReadStreamClose(myReadStream);
    NSLog(@"%@,%lu,%@",myStatusLine,myErrCode,responseBody);
    */
    
    
    
    
	
    
    
    /*
     //重定向
    CFReadStreamRef myReadStream = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, myRequest);
    if (CFReadStreamSetProperty(myReadStream, kCFStreamPropertyHTTPShouldAutoredirect, kCFBooleanTrue) == false) {
        // something went wrong, exit
    }
    CFReadStreamOpen(myReadStream);
    */
    
    
    /*
    //反序列化
    CFDataRef bodyDataExt = CFStringCreateExternalRepresentation(kCFAllocatorDefault, (CFStringRef)str1, kCFStringEncodingUTF8, 0);
    CFHTTPMessageSetBody(myRequest, bodyDataExt);
    CFHTTPMessageSetHeaderFieldValue(myRequest, headerFieldName, headerFieldValue);
    CFDataRef mySerializedRequest = CFHTTPMessageCopySerializedMessage(myRequest);
    NSString *str = [[NSString alloc]initWithData:(NSData *)mySerializedRequest encoding:NSUTF8StringEncoding];

    CFRelease(myRequest);
    CFRelease(myURL);
    CFRelease(url);
    CFRelease(mySerializedRequest);
    myRequest = NULL;
    mySerializedRequest = NULL;
    
    
    
    const UInt8 *data = [str1 UTF8String];
    CFIndex numBytes = [str1 length];
    
    CFHTTPMessageRef myMessage = CFHTTPMessageCreateEmpty(kCFAllocatorDefault, TRUE);
    if (!CFHTTPMessageAppendBytes(myMessage, data, numBytes)) {
        //Handle parsing error
    }
    NSLog(@"%@",CFHTTPMessageCopyAllHeaderFields(myMessage));
    if (CFHTTPMessageIsHeaderComplete(myMessage)) {
        // Perform processing.
        
    }
    
    */
    
    
    
    
    
    
    /*
    //加载读取内容
    UIWebView *testWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];

    [testWeb loadHTMLString:responseBody baseURL:nil];
    [self.window addSubview:testWeb];
     */
    
    

    
    
    
    /*
    CFSocketRef serverSocket = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM, IPPROTO_TCP, 0, NULL, NULL);
    
    struct sockaddr_in addr;
    int yes = 1;
    setsockopt(CFSocketGetNative(serverSocket), SOL_SOCKET, SO_REUSEADDR, (void*)&yes, sizeof(int));
    
    
    memset(&addr, 0, sizeof(addr));
    addr.sin_len = sizeof(struct sockaddr_in);
    addr.sin_family = AF_INET;
    addr.sin_port = htons(5656);
    addr.sin_addr.s_addr = htonl(INADDR_ANY);
    
    NSData *address = [NSData dataWithBytes:&addr length:sizeof(addr)];
    CFSocketSetAddress(serverSocket, (CFDataRef)address);
    
    CFDictionaryRef imcommingRequest = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    NSFileHandle *listenHandle = [[NSFileHandle alloc]initWithFileDescriptor:CFSocketGetNative(serverSocket) closeOnDealloc:yes];
    [listenHandle acceptConnectionInBackgroundAndNotify];
    NSLog(@"%s:%d",addr2ascii(AF_INET, &(addr.sin_addr.s_addr),sizeof(addr.sin_addr.s_addr), NULL), 5656);
    */
    
    
    [self.window makeKeyAndVisible];
    return YES;
}
/*
- (void)_startServer
{
    BOOL        success;
    int         err;
    int         fd;
    int         junk;
    struct sockaddr_in addr;
    int         port;
    
    // Create a listening socket and use CFSocket to integrate it into our 
    // runloop.  We bind to port 0, which causes the kernel to give us 
    // any free port, then use getsockname to find out what port number we 
    // actually got.
    
    port = 0;
    
    fd = socket(AF_INET, SOCK_STREAM, 0);
    success = (fd != -1);
    if (success) {
        memset(&addr, 0, sizeof(addr));
        addr.sin_len    = sizeof(addr);
        addr.sin_family = AF_INET;
        addr.sin_port   = 0;
        addr.sin_addr.s_addr = INADDR_ANY;
        err = bind(fd, (const struct sockaddr *) &addr, sizeof(addr));
        success = (err == 0);
    }
    if (success) {
        err = listen(fd, 5);
        success = (err == 0);
    }
    if (success) {
        socklen_t addrLen;
        
        addrLen = sizeof(addr);
        err = getsockname(fd, (struct sockaddr *) &addr, &addrLen);
        success = (err == 0);
        
        if (success) {
            assert(addrLen == sizeof(addr));
            port = ntohs(addr.sin_port);
        }
    }
    if (success) {
        CFSocketContext context = { 0, self, NULL, NULL, NULL };
        
        self.listeningSocket = CFSocketCreateWithNative(
                                                        NULL, 
                                                        fd, 
                                                        kCFSocketAcceptCallBack, 
                                                        AcceptCallback, 
                                                        &context
                                                        );
        success = (self.listeningSocket != NULL);
        
        if (success) {
            CFRunLoopSourceRef  rls;
            
            CFRelease(self.listeningSocket);        // to balance the create
            
            fd = -1;        // listeningSocket is now responsible for closing fd
            
            rls = CFSocketCreateRunLoopSource(NULL, self.listeningSocket, 0);
            assert(rls != NULL);
            
            CFRunLoopAddSource(CFRunLoopGetCurrent(), rls, kCFRunLoopDefaultMode);
            
            CFRelease(rls);
        }
    }
    
    // Now register our service with Bonjour.  See the comments in -netService:didNotPublish: 
    // for more info about this simplifying assumption.
    
    if (success) {
        self.netService = [[[NSNetService alloc] initWithDomain:@"local." type:@"_x-SNSDownload._tcp." name:@"Test" port:port] autorelease];
        success = (self.netService != nil);
    }
    if (success) {
        self.netService.delegate = self;
        
        [self.netService publishWithOptions:NSNetServiceNoAutoRename];
        
        // continues in -netServiceDidPublish: or -netService:didNotPublish: ...
    }
    
    // Clean up after failure.
    
    if ( success ) {
        assert(port != 0);
        [self _serverDidStartOnPort:port];
    } else {
        [self _stopServer:@"Start failed"];
        if (fd != -1) {
            junk = close(fd);
            assert(junk == 0);
        }
    }
}
 */
@end
