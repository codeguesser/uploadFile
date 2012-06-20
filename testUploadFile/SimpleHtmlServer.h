//
//  SimpleHtmlServer.h
//  testUploadFile
//
//  Created by  on 2012/6/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
@protocol ServerDelegate <NSObject>
-(void)getMessage:(NSString *)msg;
@end


#import <Foundation/Foundation.h>
#import <stdio.h>
#import <stdlib.h>
#import <errno.h>
#import <string.h>
#import <sys/types.h>
#import <netinet/in.h>
#import <sys/wait.h>
#import <sys/socket.h>
#import <arpa/inet.h>

#define SERVERPORT 3333
#define CONNECTNUMBER 10
@interface SimpleHtmlServer : NSObject{
    int sock_fd, client_fd;
    struct sockaddr_in my_addr,remote_addr;
}
@property(nonatomic,assign)id<ServerDelegate>delegate;
-(void)connectThread;
-(void)returnMessage:(NSString*)getString;
-(NSString *)getStringFromWholeString:(NSString *)string1 from:(NSString*)string2 to:(NSString *)string3;
@end
