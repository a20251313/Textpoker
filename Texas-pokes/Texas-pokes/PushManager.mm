//
//  PushManager.m
//  i366
//
//  Created by admin on 12-11-16.
//
//

#import "PushManager.h"
#include "appcenter.h"
#import "UserInfo.h"

static  AppCenter   *myappCenter = NULL;
#define BUFFERSIZE 1024*20

#ifndef PUSH_SERVER_IP
#define PUSH_SERVER_IP  @"iospush.lelechat.com"
#define PUSH_SERVER_PORT   58800 
#endif

@implementation PushManager
@synthesize tokenData = _tokenData;
@synthesize addFlag;
@synthesize sendMsgFlag;
@synthesize iMyID;

static PushManager *manager = nil;

- (id)init
{
    self = [super init];
    if (self)
    {
        UserInfo  *objUser = [UserInfo shareInstance];
        myappCenter = new AppCenter();
        if (!myappCenter->init(objUser.userIDForDzpk, 1001, 1,DZPKCLIENTBUILDNUMBER))
        {
            NSLog(@"init fail");
        }
        NSLog(@"INIT suc");
        receiveData = [[NSMutableData alloc] init];
    }
    
    return self;
}

- (void)dealloc
{
    self.tokenData = nil;
    [super dealloc];
}

+ (id)sharedManager
{
    if (!manager)
    {
        manager = [[PushManager alloc] init];
    }
    
    return manager;
}

- (void)connectToHost:(NSString *)host andPort:(int)port
{
    NSError *error;
    
    if ([_socket isConnected]) {
        [self disconnect];
    }
    
    _socket = [[AsyncSocket alloc] initWithDelegate:self];
    _socket.delegate = self;
    
    if (![_socket connectToHost:host onPort:port error:&error])
    {
        NSLog(@"connect error:%@", error);
    }
}

- (void)disconnect
{
    if ([_socket isConnected])
    {
        [_socket disconnect];
        _socket.delegate = nil;
        [_socket release];
        _socket = nil;
    }
}

- (void)deleteAppCenter
{
    delete myappCenter;
    myappCenter = NULL;
}

#pragma mark - AsyncSocket Delegate -

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
//    [_socket readDataToLength:32 withTimeout:-1 tag:1];
    
    [_socket readDataWithTimeout:-1 tag:1];
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    if (tag == 1) {     //连接成功，服务器下发的数据包
        [receiveData setData:nil];
        
        [receiveData appendData:data];
        
        int length = [self parseData:receiveData];
        
        int dataLen = [data length];
        
        int subLength = length + 32;
        
        if (length+32 > dataLen) {
            subLength = dataLen;
        }
        
//        if ([data length] == length) {
            if ([self checkServerSendData:[receiveData subdataWithRange:NSMakeRange(0, subLength)]]) {
                
                [receiveData setData:nil];
                
                if (sendMsgFlag == 0) {
                    [self sendDeviceToken:addFlag];
                }else if (sendMsgFlag == 1) {
                    [self sendResetBadgeNumber];
                }
                
            }
//        }

    }else if (tag == 2) {   //服务器再次下发数据包
        
        [receiveData appendData:data];
            
        if ([self checkServerSendData:receiveData]) {
            
            [receiveData setData:nil];
            
            if (sendMsgFlag == 0) {
                [self sendDeviceToken:addFlag];
            }else if (sendMsgFlag == 1) {
                [self sendResetBadgeNumber];
            }
            
        }
    }else if (tag == 3) {   //发送deviceToken后，服务器返回的数据验证包
        
        [receiveData appendData:data];
        
        [self checkFeedbackData:receiveData];
    }
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
//    NSLog(@"onSocketDidDisconnect");
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
//    NSLog(@"willDisconnectWithError : %@", [err description]);
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
//    [sock readDataWithTimeout:-1 tag:3];
    
    [sock readDataToData:[AsyncSocket LFData] withTimeout:-1 tag:tag];
}

#pragma mark - parse data -

- (int)parseData:(NSData *)data
{
    char *buffer = (char *)malloc(sizeof(char) * 32);
    memset(buffer, 0, 32);
    [data getBytes:buffer length:32];
    
    int length = [self getPackageLength:buffer];
    
    free(buffer);
    
    [_socket readDataWithTimeout:-1 tag:2];
    
    [_socket readDataToLength:length withTimeout:-1 tag:2];
    
    return length;
}

- (int)getPackageLength:(char *)buffer
{
    int length = 0;
    
    int *temp = (int *)(buffer+8);
    
    length = ntohl(*temp);
    
    length = (length + 8) * 8 / 8;
    
    return length;
}

- (BOOL)checkServerSendData:(NSData *)data
{
    
    
    bool result = myappCenter->analyzeTokenServerHandshakePkt((unsigned char *)[data bytes], [data length]);
    
    if (result) {
        return YES;
    }
    
    return NO;
}

- (BOOL)checkFeedbackData:(NSData *)data
{
   
    
    bool result = myappCenter->analyzeTokenUpdateAck((unsigned char *)[data bytes], [data length]);
    
    if (result)
    {
        return YES;
    }
    
    return NO;
}

#pragma mark - send data -

- (void)sendDeviceToken:(int)flag
{
   
    
    unsigned char token[32] = {0};
    [_tokenData getBytes:token length:32];
    
    unsigned char *buff = (unsigned char *)malloc(sizeof(unsigned char) * BUFFERSIZE);
    memset(buff, 0, sizeof(unsigned char) * BUFFERSIZE);
    
    unsigned int buffLen;
    
    bool result = myappCenter->createTokenUpdatePkt(flag, token, buff, BUFFERSIZE, &buffLen);
    
    if (result)
    {
        
        NSData *sendData = [[NSData alloc] initWithBytes:buff length:buffLen];
        [_socket readDataToLength:1024 withTimeout:-1 tag:3];
        [_socket writeData:sendData withTimeout:-1 tag:3];
        [sendData release];
    }
    
    free(buff);
}

- (void)sendResetBadgeNumber
{
   
    
    unsigned char *buff = (unsigned char *)malloc(sizeof(unsigned char) * BUFFERSIZE);
    memset(buff, 0, sizeof(unsigned char) * BUFFERSIZE);
    
    unsigned int buffLen;
    
    bool result = myappCenter->createBadgeResetPkt(buff, BUFFERSIZE, &buffLen);
    
    if (result) {
        
        NSData *sendData = [[NSData alloc] initWithBytes:buff length:buffLen];
        [_socket readDataToLength:1024 withTimeout:-1 tag:3];
        [_socket writeData:sendData withTimeout:-1 tag:3];
        [sendData release];
    }
    
    free(buff);
}

#pragma mark - ligin success -

- (void)loginSuccess:(NSNotification *)notification
{
    [self deleteAppCenter];
    
    [self connectToHost:PUSH_SERVER_IP andPort:PUSH_SERVER_PORT];
}

@end
