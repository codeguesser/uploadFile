//
//  GetMessage.h
//  NetClient
//
//  Created by  on 2012/5/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

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
#import <netdb.h>
#define SERVERPORT 3333


@interface Sender : NSObject{
    int sock_fd;
    
    struct hostent *host;
    struct sockaddr_in server_addr;
    NSString *content;
}
-(void)setContent:(NSString *)_content;
-(void)SendMessage;
@end
