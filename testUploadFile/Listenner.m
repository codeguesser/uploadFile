//
//  SendMessageButton.m
//  NetServer
//
//  Created by  on 2012/5/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Listenner.h"
@implementation Listenner
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
    }
    
    my_addr.sin_family = AF_INET;
    my_addr.sin_port = htons(SERVERPORT);
    my_addr.sin_addr.s_addr = INADDR_ANY;
    
    bzero(&(my_addr.sin_zero), 8);
    
    
    if (bind(sock_fd, (struct sockaddr *)&my_addr, sizeof(struct sockaddr))== -1) {
        NSLog(@"bind error");
    }
    
    if (listen(sock_fd, BACKLOG)==-1) {
        NSLog(@"listen error");
    }
    
    while (YES) {
        socklen_t sin_size  = sizeof(struct sockaddr_in);
        if ((client_fd = accept(sock_fd, (struct sockaddr *)&remote_addr, &sin_size))==-1) {
            NSLog(@"accept error");
            continue;
        }
        //NSLog(@"remote ip is %s,and it want the msg",inet_ntoa(remote_addr.sin_addr));
        
        
        if ((recvbytes=recv(client_fd, buf, 200, 0))==-1) {
            NSLog(@"recv error");
        }
        buf[recvbytes]='\0';
        
        NSString *getString = [NSString stringWithFormat:@"%s",buf];
        [self performSelectorOnMainThread:@selector(returnMessage:) withObject:getString waitUntilDone:YES];
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

@end
