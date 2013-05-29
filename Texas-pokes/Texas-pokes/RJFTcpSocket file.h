//
//  RJFTcpSocket.h
//  Texas-pokes
//
//  Created by ran on 12-8-14.
//
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
//#import "GCDAsyncSocket.h"
//#import "AsyncSocket.h"
#define TCPSOCKETMESSAGE            @"MESSAGE"
#define TCPSOCKETSIZE               @"SIZE"
#define SOCKET_CONNECTFAIL          -1
@protocol BNRSOCKRECMESGFROMSERVER <NSObject>
-(void)RecMsgFromServer:(char *)charMsg;

@optional
-(void)RecStringFromServer:(NSString *)strMsg;
@end



@interface RJFTcpSocket : NSObject
{
    //AsyncSocket         *m_socket;
    id<BNRSOCKRECMESGFROMSERVER>                  delegate;
    NSInteger           m_itag;
    BOOL                m_bconnectSuc;
    NSString            *m_host;
    int16_t             m_port;
    NSFileHandle        *m_handleForWR;
    struct sockaddr_in      remote_addr;
    int                 m_iSocket;
    int                 m_iHealth;
    NSLock              *m_lock;
    
    NSMutableData       *m_receivaData;
    NSMutableArray      *m_arrstrorData;
}
@property(nonatomic,assign)id<BNRSOCKRECMESGFROMSERVER>  delegate;
@property(readwrite) NSInteger tag;
@property(readwrite) BOOL      connectSuc;
@property(copy)NSString        *host;
@property(nonatomic,readwrite)int16_t port;
//@property(retain)   AsyncSocket *socket;

//-(id)initWithHost:(NSString *)Host Port:(u_int)iPort  Delagate:(id)Mydelegate;
//-(void)SendMessage:(NSString *)strMessage;
-(void)disConnect;
-(void)SendCharMessage:(int8_t *)data size:(size_t)size;
-(id)TcpSocketOftag:(NSInteger)tag;
-(id)initWithHost:(NSString *)Host
             Port:(u_int)iPort
         Delagate:(id)Mydelegate
              tag:(NSInteger)itag;
+(id)shareWithTag:(NSInteger)iTag;
+(id)shareInitWithHost:(NSString *)Host
                  Port:(u_int)iPort
              Delagate:(id)Mydelegate
                   tag:(NSInteger)itag;
-(id)ReConnectToHost:(NSString *)Host port:(u_int16_t)port delegate:(id)Delegate tag:(int32_t)iTag;
+(NSString *) macaddress;
@end
