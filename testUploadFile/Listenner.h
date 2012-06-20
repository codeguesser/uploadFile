//
//  SendMessageButton.h
//  NetServer
//
//  Created by  on 2012/5/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
@protocol ListennerDelegate <NSObject>
-(void)getMessage:(NSString *)msg;
@end



#import <UIKit/UIKit.h>
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
#define BACKLOG 10
#define MAXDATASIZE 200


@interface Listenner : NSObject{
    int sock_fd, client_fd;
    char buf[MAXDATASIZE];
    int recvbytes;
    struct sockaddr_in my_addr,remote_addr;
}
@property(nonatomic,assign)id<ListennerDelegate>delegate;
-(void)connectThread;
-(void)returnMessage:(NSString*)getString;
@end
