//
//  SimpleHtmlServer.m
//  testUploadFile
//
//  Created by  on 2012/6/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SimpleHtmlServer.h"

@implementation SimpleHtmlServer
@synthesize delegate=_delegate;
- (id)init
{
    self = [super init];
    if (self) {
        [NSThread detachNewThreadSelector:@selector(connectThread) toTarget:self withObject:nil];
    }
    return self;
}

-(void)connectThread{
    NSThread *subThreed = [NSThread currentThread];
    
    NSAutoreleasePool *uploadPool = [[NSAutoreleasePool alloc] init];
    
    NSLog(@"thread start");
    
    
    if ((sock_fd=socket(AF_INET, SOCK_STREAM, 0))== -1) {
        NSLog(@"socket create error");
    }else{
        NSLog(@"socket create success");
    }
    
    my_addr.sin_family = AF_INET;
    my_addr.sin_port = htons(SERVERPORT);
    my_addr.sin_addr.s_addr = INADDR_ANY;
    
    bzero(&(my_addr.sin_zero), 8);
    
    
    if (bind(sock_fd, (struct sockaddr *)&my_addr, sizeof(struct sockaddr))== -1) {
        NSLog(@"bind error");
    }else{
        NSLog(@"bind success");
    }
    
    if (listen(sock_fd, CONNECTNUMBER)==-1) {
        NSLog(@"listen error");
    }else{
        NSLog(@"listen success");
    }
    
    
    
    while (YES) {
        
        socklen_t sin_size  = sizeof(struct sockaddr_in);
        
        if ((client_fd = accept(sock_fd, (struct sockaddr *)&remote_addr, &sin_size))==-1) {
            NSLog(@"accept error");
            continue;
            
        }
        
        NSLog(@"remote ip is %s,and it want the msg",inet_ntoa(remote_addr.sin_addr));
        
        /*
         
         char buf[500];
         
         ssize_t recvbytes;
         
         if ((recvbytes=recv(client_fd, buf, 500, 0))==-1) {
         
         NSLog(@”recv error”);
         
         }
         
         buf[recvbytes]=’\0′;
         
         NSString *getString = [NSString stringWithFormat:@"%s",buf];
         
         NSLog(@”%@”,getString);
         
         */
        
        char buf[10240];
        
        ssize_t recvbytes;
        
        if ((recvbytes=recv(client_fd, buf, 10240, 0))==-1) {
            
            NSLog(@"recv error");
            
        }
        
        buf[recvbytes]='\0';
        
        NSMutableString *getString = [[NSMutableString alloc]initWithFormat:@"%s",buf];
        
        //NSLog(@"%@",getString);
        
        //[self performSelectorOnMainThread:@selector(returnMessage:) withObject:getString waitUntilDone:YES];
        
        if ([getString hasPrefix:@"POST"]) {
            NSString *boundary = [[NSString alloc]initWithFormat:@"--%@",[self getStringFromWholeString:getString from:@"boundary=" to:@"\r\n"]];
            
            BOOL end=YES;
            do {
                NSString *nowContent = [[NSString alloc]initWithString:[self getStringFromWholeString:getString from:boundary to:boundary]];
                if ([nowContent isEqualToString:@""]) {
                    //NSLog(@"nowContent:%@",nowContent);
                    end = NO;
                }else{
                    NSRange rangeForResetGetString = [getString rangeOfString:boundary];
                    [getString setString: [getString substringFromIndex:(rangeForResetGetString.location+rangeForResetGetString.length)]];
                    //NSLog(@"nowContent:%@",nowContent);
                    
                    
                    NSRange rangeForGetKeyName = [nowContent rangeOfString:@"name=\"name\""];
                    NSRange rangeForGetKeyFile = [nowContent rangeOfString:@"name=\"file\""];
                    NSRange rangeForGetKeySubmit = [nowContent rangeOfString:@"name=\"submit\""];
                    if (!NSEqualRanges(rangeForGetKeyName, NSMakeRange(NSNotFound,0))) {
                        NSLog(@"name:%d,%d",rangeForGetKeyName.location,rangeForGetKeyName.length);
                        NSRange rangeForValue = [nowContent rangeOfString:@"\r\n\r\n"];
                        if (!NSEqualRanges(rangeForValue, NSMakeRange(NSNotFound,0))) {
                            NSLog(@"name-value:%@",[nowContent substringFromIndex:rangeForValue.location+rangeForValue.length]);
                        }
                    }else if(!NSEqualRanges(rangeForGetKeyFile, NSMakeRange(NSNotFound,0))){
                        NSLog(@"file:%d,%d",rangeForGetKeyFile.location,rangeForGetKeyFile.length);
                        
                        NSMutableString *fileName = [[NSMutableString alloc]init];
                        NSMutableData *fileData = [[NSMutableData alloc]init];
                        
                        NSRange rangeForValue = [nowContent rangeOfString:@"\r\n\r\n"];
                        if (!NSEqualRanges(rangeForValue, NSMakeRange(NSNotFound,0))) {
                            const void * tempString = [nowContent substringFromIndex:rangeForValue.location+rangeForValue.length].UTF8String;
                            NSLog(@"file-value:%s",tempString);
                            [fileData appendBytes:tempString length:strlen(tempString)];
                        }
                        NSRange rangeForFilename = [nowContent rangeOfString:@"; filename=\""];
                        if (!NSEqualRanges(rangeForFilename, NSMakeRange(NSNotFound,0))) {
                            NSString *tempString = [self getStringFromWholeString:nowContent from:@"; filename=\"" to:@"\""];
                            NSLog(@"file-name:%@",tempString);
                            [fileName setString:tempString];
                        }
                        if ((![fileName isEqualToString:@""])&&(![fileData isEqualToData:[NSData dataWithBytes:@"" length:0]])) {
                            NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                            BOOL isDir;
                            if ([[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory isDirectory:&isDir]) {
                                [fileData writeToFile:[documentsDirectory stringByAppendingPathComponent:fileName] atomically:YES];
                            }
                        }
                        [fileName release];
                        [fileData release];
                    }else if(!NSEqualRanges(rangeForGetKeySubmit, NSMakeRange(NSNotFound,0))){
                        NSLog(@"submit:%d,%d",rangeForGetKeySubmit.location,rangeForGetKeySubmit.length);
                        NSRange rangeForValue = [nowContent rangeOfString:@"\r\n\r\n"];
                        if (!NSEqualRanges(rangeForValue, NSMakeRange(NSNotFound,0))) {
                            NSLog(@"submit-value:%@",[nowContent substringFromIndex:rangeForValue.location+rangeForValue.length]);
                        }
                    }else{
                        NSLog(@"Nothing");
                    }
                    
                }
                
            } while (end);
            
            
            
            if (send(client_fd, "Success", strlen("Success"), 0)==-1) {
                perror("error");
            }
        }else{
            NSString *sendHtml = @"HTTP/1.1 200 OK\nContent-Type: text/html\r\n\r\n<html><body><form enctype='multipart/form-data' method='post' ><input type='text' name='name'><input name='file' type='file' /><input type='submit' name='submit' value='submit'/></form></body></html>";
            
            if (send(client_fd, sendHtml.UTF8String, strlen(sendHtml.UTF8String), 0)==-1) {
                
                perror("error");
                
            };
        }
        //NSLog(@"%@",getString);
        [getString release];
        
        close(client_fd);
        
    }
    
    
    
    
    
    
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    
    
    [uploadPool release];
    uploadPool = nil;
    subThreed = nil;
    NSLog(@"thread over");
}

-(void)returnMessage:(NSString*)getString{
    [self.delegate getMessage:getString];
}
-(NSString *)getStringFromWholeString:(NSString *)string1 from:(NSString*)string2 to:(NSString *)string3{
    NSString *str1 = [[NSString alloc]initWithString:string1];
    NSString *str2 = [[NSString alloc]initWithString:string2];
    NSString *str3 = [[NSString alloc]initWithString:string3];
    
    NSRange range = [str1 rangeOfString:str2];
    NSString *tempString = [str1 substringFromIndex:range.location+range.length];
    
    NSRange range2 = [tempString rangeOfString:str3];
    if (NSEqualRanges(range2, NSMakeRange(NSNotFound,0)) ){
        return @"";
    }
    
    NSString *finalString = [tempString substringWithRange:NSMakeRange(0, range2.location)];
    [str1 release];
    [str2 release];
    [str3 release];
    
    return finalString;
    
}
@end
