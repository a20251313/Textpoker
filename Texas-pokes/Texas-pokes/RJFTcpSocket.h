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
#import "AsyncSocket.h"
#define TCPSOCKETMESSAGE            @"MESSAGE"
#define TCPSOCKETSIZE               @"SIZE"
@protocol BNRSOCKRECMESGFROMSERVER <NSObject>
-(void)RecMsgFromServer:(char *)charMsg;

@optional
-(void)RecStringFromServer:(NSString *)strMsg;
@end



@interface RJFTcpSocket : NSObject
{
    AsyncSocket         *m_socket;
    id<BNRSOCKRECMESGFROMSERVER>                  delegate;
    NSInteger           m_itag;
    BOOL                m_bconnectSuc;
    NSString            *m_Host;
    UInt16              m_port;
    NSMutableData       *receiveData;
    NSMutableArray      *m_storeData;
    NSLock              *m_lock;
    NSInteger           m_iReceiveLength;
}
@property(nonatomic,assign)id<BNRSOCKRECMESGFROMSERVER>  delegate;
@property(readwrite) NSInteger tag;
@property(readwrite) BOOL      connectSuc;
@property(retain)   AsyncSocket *socket;
@property(copy)     NSString *host;
@property(readwrite) UInt16 port;
//@property(copy)NSMutableData  *receiveData;

//-(id)initWithHost:(NSString *)Host Port:(u_int)iPort  Delagate:(id)Mydelegate;
//-(void)SendMessage:(NSString *)strMessage;
-(void)disConnect;
-(void)SendCharMessage:(int8_t *)data size:(size_t)size;
-(id)TcpSocketOftag:(NSInteger)tag;
-(id)initWithHost:(NSString *)Host
             Port:(uint16_t)iPort
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
