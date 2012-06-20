//
//  GetMessage.m
//  NetClient
//
//  Created by  on 2012/5/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Sender.h"

@implementation Sender
-(void)SendMessage{
    const char * ipstr = "192.168.1.105";
    if ((host = gethostbyname(ipstr))==NULL) {
        NSLog(@"host error");
    };
    //NSLog(@"%s",host->h_name);
    
    if ((sock_fd=socket(AF_INET, SOCK_STREAM, 0))==-1) {
        NSLog(@"create socket error");
    }
    
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(SERVERPORT);
    
    server_addr.sin_addr = *((struct in_addr*)host->h_addr);
    
    bzero(&(server_addr.sin_zero), 8);
    
    
    if (connect(sock_fd, (struct sockaddr *)&server_addr, sizeof(struct sockaddr))==-1) {
        perror("connect error");
    }
    
    if (send(sock_fd, content.UTF8String, 100, 0)==-1) {
        NSLog(@"send error");
    }
}

-(void)setContent:(NSString *)_content{
    [content release];
    content = [_content retain];
    
}
@end
