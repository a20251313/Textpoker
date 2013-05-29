
//
//  RJFTcpSocket.m
//  Texas-pokes
//
//  Created by ran on 12-8-14.
//
//

#import "PublicDefine.h"
#if MODEFORAPPSTORE

#import "RJFAppDownload.h"
#import "UserInfo.h"
#include "appcenter.h"

@implementation RJFAppDownload
@synthesize delegate;
@synthesize tag = m_itag;
@synthesize connectSuc = m_bconnectSuc;
@synthesize socket = m_socket;
@synthesize host = m_Host;
@synthesize port = m_port;

#define TIMESEP            @"TIMESEP"
#define APPINFO            @"APPINFO"
//@synthesize receiveData;


#ifndef SOFTINFO_ABOUT_APPRECOMMAND
#define SOFTINFO_ABOUT_APPRECOMMAND
#define SOFTARETITLE        @"SOFTARETITLE"
#define SOFTAREVERSION      @"SOFTAREVERSION"
#define SOFTARESIZE         @"SOFTARESIZE"
#define SOFTAREURL          @"SOFTAREURL"
#define SOFTARELOGO         @"SOFTARELOGO"
#define SOFTAREDOWNNUMBER   @"SOFTAREDOWNNUMBER"
#define SOFTAREIDNUMBER     @"SOFTAREIDNUMBER"
#define SOFTAREAPPID        @"APPID"
#define SOFTAREUPDATETIME   @"SOFTAREUPDATETIME"
#define SOFTAREDISPLAYSEQUE  @"DISPLAYSEQUE"
#define SOFTARELANGUAGE     @"SOFTARELANGUAGE"
#define SOFTAREDESPRICTION  @"SOFTAREDESPRICTION"
#endif



#define TIMEOUT          -1

static AppCenter  *app_info = NULL;



-(id)initWithHost:(NSString *)Host
             Port:(uint16_t)iPort
         Delagate:(id)Mydelegate
              tag:(NSInteger)itag
{
    self = [super init];
    if (self)
    {
        
        
        //[receiveData ]
        m_receivelength = -100;
        m_storeData = [[NSMutableArray alloc] init];
        receiveData = [[NSMutableData alloc] init];
        m_lock = [[NSLock alloc] init];
        self.host = Host;
        self.port = iPort;
        m_socket = [[AsyncSocket alloc] initWithDelegate:self];
        NSError *error = nil;
        if (![m_socket connectToHost:Host
                              onPort:iPort error:&error])
        {
            NSLog(@"connect fail\n error info:%@",[error localizedDescription]);
            
            
            /*   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
             message:@"创建套接字失败"
             delegate:nil
             cancelButtonTitle:@"关闭"
             otherButtonTitles:nil];
             [alert show];
             [alert release];*/
            return self;
            
        }
        if ([[NSUserDefaults standardUserDefaults] valueForKey:TIMESEP])
        {
            m_timeSince1970 = [[[NSUserDefaults standardUserDefaults] valueForKey:TIMESEP] floatValue];
        }else
        {
            m_timeSince1970 = 0;
        }
        delegate = Mydelegate;
        m_itag = itag;
        #if TARGET_OS_IPHONE
        if (app_info == NULL)
        {
            app_info = new AppCenter();
            UserInfo  *shareUser = [UserInfo shareInstance];
            if (!app_info->init(shareUser.userIDForDzpk, 1001, 1,DZPKCLIENTBUILDNUMBER))
            {
                NSLog(@"init fail");
            }
            NSLog(@"INIT suc");
        }
        #endif
        
        
    }
    return self;
    
}
-(id)ReConnectToHost:(NSString *)Host port:(uint16_t)port delegate:(id)Delegate tag:(int32_t)iTag
{
 
    
    self.host = Host;
    self.port = port;
    NSError *error = nil;
    if (![m_socket connectToHost:Host
                          onPort:port error:&error])
    {
        NSLog(@"connect fail\n error info:%@",[error localizedDescription]);
        
        
        /* UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"创建套接字失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
         [alert show];
         [alert release];*/
        return self;
        
    }
    // [m_socket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    
    m_bconnectSuc = YES;
    delegate = Delegate;
    m_itag = iTag;
    return self;
}

-(void)SendCharMessage:(unsigned char *)data size:(size_t)size
{
    
    NSLog(@"+++++++size %ld",size);
    @autoreleasepool
    {
        NSData  *senddata = [NSData dataWithBytes:data length:size];
        if (self.connectSuc)
        {
            
            [m_socket writeData:senddata withTimeout:TIMEOUT tag:0];
#if DEBUG
              NSLog(@"send suc size:%ld",size);
#endif
        }else
        {
            [m_storeData addObject:senddata];
            NSLog(@"send fail");
        }
        
    }
 
    
    //  [m_socket readDataWithTimeout:-1 tag:0];
    
}
-(id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}


-(void)disConnect
{
    if (m_bconnectSuc)
    {
        [m_socket disconnect];
        m_bconnectSuc = NO;
    } 
}

-(void)dealloc
{
    if (m_storeData)
    {
        [m_storeData removeAllObjects];
        [m_storeData release];
        m_storeData = nil;
    }
    
    if (app_info)
    {
        delete app_info;
        app_info = NULL;
    }
    [receiveData release];
    receiveData = nil;
    
    [m_socket release];
    m_socket = nil;
    
    [super dealloc];
}

-(id)TcpSocketOftag:(NSInteger)tag
{
    if (self)
    {
        return self;
    }else
    {
        return nil;
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"tag:%d socketIsValud:%d  socketAdd:%p connectSuc:%d",m_itag,m_socket.isConnected,m_socket,m_bconnectSuc];
}




- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    //NSLog(@"data:%@",data);
   // const  char *fir = (const char*)[data bytes];
 //   NSLog(@"size:%d first char:%c number:%d",[data length],fir[0],fir[0]);
    //  NSAutoreleasePool   *pool = [[NSAutoreleasePool alloc] init];
    [m_lock lock];
    //[m_socket readDataToLength:32 withTimeout:0 tag:0];
    NSLog(@"recvive size:%d",[data length]);
    if ([data length] == 1440 || [data length] == 1428 || [data length] == 1460)
    {
        [receiveData appendData:data];
    }else
    {
        [receiveData appendData:data];
        NSData  *postData = [NSData dataWithData:receiveData];
        [self PostData:postData];
        [receiveData setData:nil];
    }
     [m_socket readDataWithTimeout:TIMEOUT tag:0];
    
    [m_lock unlock];
    

}
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"sock has connected,the host is:%@   port:%d",host,port);
    m_bconnectSuc = YES;
    [m_socket readDataWithTimeout:TIMEOUT tag:0];
    for (int i = 0; i < [m_storeData count]; i++)
    {
        [m_socket writeData:[m_storeData objectAtIndex:i]
                withTimeout:TIMEOUT
                        tag:0];
        NSLog(@"send after connect");
    }
    [m_storeData removeAllObjects];
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    
    m_bconnectSuc = NO;
    [m_socket setDelegate:nil];
	[m_socket release];
	m_socket = nil;
    NSLog(@"disconnect:%@",self);
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    
    m_bconnectSuc = NO;
    // NSString  *host = self.host;
    // UInt16 port = self.port;
    /* self = [self ReConnectToHost:host
     port:port
     delegate:nil
     tag:m_itag];*/
    NSLog(@"disconnect Error:%@  errlocal:%@ self:%@",err,[err localizedDescription],self);
    
}

- (NSTimeInterval)onSocket:(AsyncSocket *)sock
  shouldTimeoutReadWithTag:(long)tag
                   elapsed:(NSTimeInterval)elapsed
                 bytesDone:(NSUInteger)length

{
    NSLog(@"time out socket");
    return 30;
}

- (BOOL)onSocketWillConnect:(AsyncSocket *)sock
{
	NSLog(@"onSocketWillConnect:");
	return YES;
}

- (void)readWithTag:(long)tag
{
	// reads response line-by-line
	[m_socket readDataToData:[AsyncSocket CRLFData] withTimeout:-1 tag:tag];
}

- (void)onSocket:(AsyncSocket *)sock didReadPartialDataOfLength:(CFIndex)partialLength tag:(long)tag
{
    NSLog(@"+++info:%ld",partialLength);
	//NSLog(@"onSocket:didReadPartialDataOfLength:%li tag:%li", partialLength, tag);
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
	//NSLog(@"onSocket:didWriteDataWithTag:%li", tag);
}
-(uint32_t) unbyte_to_int32:(unsigned char * )data  pos:(size_t)pos
{
    
    return      (data[pos++]&0xff)<<24 |
    (data[pos++]&0xff)<<16 |
    (data[pos++]&0xff)<<8 |
    (data[pos++]&0xff);
    
    
}

-(int16_t) unbyte_to_int16:(unsigned char * )data pos:(size_t)pos
{
    
    return
    (data[pos++]&0xff)<<8 |
    (data[pos++]&0xff);
}

-(void)PostData:(NSData*)data
{
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    unsigned char   *bytes = (unsigned char *)[data bytes];
 //   int pos = 8;
   // int32_t  size = 0;
    int lenth = [data length];
  //  int totalLenth = 0;
    
 //   NSLog(@"\ntotal size:%d",lenth);
    //do
    //{
      //  size = [self unbyte_to_int32:bytes pos:lenth];
        [self phaseDataInfo:bytes size:lenth];
       // NSData  *postdata = [NSData dataWithBytes:bytes+totalLenth length:size];
        
       
      //  totalLenth += size;
      //  pos += size;
        
   // } while (totalLenth+8 < lenth);
    
    [pool drain];
}


-(void)phaseDataInfo:(unsigned char *)bytes size:(size_t)size
{
    #if TARGET_OS_IPHONE
    m_iRecDataCount++;
    usleep(10000);
    size_t  datasize = [self unbyte_to_int32:bytes pos:8];
    NSLog(@"dataSize:%ld recCount:%d",datasize,m_iRecDataCount);
    unsigned int   outSize = 0;
    memset(m_data, '\0', MAXAPPINFO);
    unsigned int updatetime = 0;
    //unsigned char   *senddata = malloc(MAXAPPINFO);
    switch (m_iRecDataCount)
    {
        case 1:
            if (!app_info->analyzeHandshakePkt(bytes, (datasize+8-1)/8*8+32))
            {
                [self failAnderror:m_iRecDataCount];
            }
            if (!app_info->createHandshakePkt(m_data, MAXAPPINFO, &outSize))
            {
               [self failAnderror:m_iRecDataCount];
                
            }
            
            [self SendCharMessage:m_data size:outSize];
            break;
        case 2:
            if (!app_info->analyzeQuestionPkt(bytes, (datasize+8-1)/8*8+32))
            {
                [self failAnderror:m_iRecDataCount];
            }
            
            if (!app_info->createQuestionAnswerPkt(m_data, MAXAPPINFO, &outSize))
            {
                [self failAnderror:m_iRecDataCount];
            }else
            {
             [self SendCharMessage:m_data size:outSize];
            }
            break;
        case 3:
            if (!app_info->analyzeAuthorizedPkt(bytes, (datasize+8-1)/8*8+32))
            {
                [self failAnderror:m_iRecDataCount];
            }else
            {
                if (!app_info->createReqAppCenterUpdateTime(m_data, MAXAPPINFO, &outSize))
                {
                    [self failAnderror:m_iRecDataCount];
                }else
                {
                    [self SendCharMessage:m_data size:outSize];
                }
            }
            break;
        case 4:
            if (app_info->analyzeAppCenterUpdateTime(bytes, (datasize+8-1)/8*8+32))
            {
                if(app_info->getAppCenterUpdateTime(&updatetime))
                {
                    if (m_timeSince1970 < updatetime)
                    {
                        NSLog(@"TIME since 1970 seconds:%d",updatetime);
                        [[NSUserDefaults standardUserDefaults] setFloat:updatetime forKey:TIMESEP];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        if (app_info->createReqAppInfo(m_data, MAXAPPINFO, &outSize))
                        {
                            [self SendCharMessage:m_data size:outSize];
                        }else
                        {
                            [self failAnderror:m_iRecDataCount];
                        }
                        
                    }else
                    {
                        NSDictionary  *dicInfo = [[NSUserDefaults standardUserDefaults] valueForKey:APPINFO];
                        
                        if (dicInfo != nil)
                        {
                            if (delegate && [delegate respondsToSelector:@selector(receiveAppInfo:)])
                            {
                                [delegate receiveAppInfo:dicInfo];
                            }
                            [[NSUserDefaults standardUserDefaults] setFloat:updatetime forKey:TIMESEP];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            [self disConnect];
                            
                        }else
                        {
                            NSLog(@"TIME since 1970 seconds:%d",updatetime);
                            [[NSUserDefaults standardUserDefaults] setFloat:updatetime forKey:TIMESEP];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            if (app_info->createReqAppInfo(m_data, MAXAPPINFO, &outSize))
                            {
                                [self SendCharMessage:m_data size:outSize];
                            }else
                            {
                                [self failAnderror:m_iRecDataCount];
                            }
                            
                        }
                        
                    }
                    
                    
                    
                    
                }else
                {
                    [self failAnderror:m_iRecDataCount];
                }
                
            }
            break;
        default:
            break;
    }
    
    
    if (m_iRecDataCount >= 5)
    {
        if (app_info->analyzeAppInfo(bytes, (datasize+8-1)/8*8+32))
        {
            
            [self getAppinfo];
           /* if(app_info->analyzeAppInfo(bytes,(datasize+8-1)/8*8+32))
            {
                [self getAppinfo];
            }else
            {
                [self failAnderror:m_iRecDataCount];
            }*/
            
            
        }else
        {
            [self failAnderror:m_iRecDataCount];
            NSLog(@"anayale fail");
        }
        
    }
    #endif
    
}

-(void)failAnderror:(NSInteger)err
{
    NSLog(@"get fail info:%d",err);
    m_iRecDataCount = 0;
    [self disConnect];
    
    if (delegate && [delegate respondsToSelector:@selector(receiveAppInfo:)])
    {
        [delegate receiveAppInfo:nil];
    }
    return;
}


-(void)getAppinfo
{
    unsigned  int uitotalAppcount = 0;
    unsigned  int receivedCount = 0;
    if (app_info->getAppTotalApp(&uitotalAppcount))
    {
        NSLog(@"uitotal appcount info:%d",uitotalAppcount);
    }
    if (app_info->getAppReceivedApp(&receivedCount))
    {
        NSLog(@"uitotal appcount info:%d",receivedCount);
    }
    if (receivedCount >= uitotalAppcount)
    {
        [self disConnect];
        // return;
    }
    
    if (uitotalAppcount == 0)
    {
        if (delegate && [delegate respondsToSelector:@selector(receiveAppInfo:)])
        {
         
            [delegate receiveAppInfo:nil];
            [self disConnect];
            return;
        }
    }
    
    unsigned int myappinfo = 0;
    unsigned int outsize = 0;
    unsigned buflenth = 200;
    unsigned char  buf[buflenth];
    memset(buf, '\0', buflenth);
    unsigned int  port  = 0;
    
    NSString    *strFileHost = nil;
    if ((app_info->getFileServerIp(buf, buflenth, &outsize)))
    {
        strFileHost = [NSString stringWithCString:(const char*)buf encoding:NSUTF8StringEncoding];
    }
    
    if ((app_info->getFileServerPort(&myappinfo)))
    {
        port = myappinfo;
    }
    
    
    
    NSMutableArray   *array = [NSMutableArray array];
    for (int i = 0; i < receivedCount; i++)
    {
        NSMutableDictionary  *dicInfo = [NSMutableDictionary dictionary];
        
        if (app_info->getAppId(i, &myappinfo))
        {
            [dicInfo setObject:@(myappinfo) forKey:SOFTAREAPPID];
        }
        if (app_info->getAppUpdateTime(i, &myappinfo))
        {
            [dicInfo setObject:@(myappinfo) forKey:SOFTAREUPDATETIME];
        }
        if (app_info->getAppSize(i, &myappinfo))
        {
            [dicInfo setObject:@(myappinfo) forKey:SOFTARESIZE];
        }
        if (app_info->getAppDisplaySequence(i, &myappinfo))
        {
            [dicInfo setObject:@(myappinfo) forKey:SOFTAREDISPLAYSEQUE];
        }
        if (app_info->getAppLanguage(i, &myappinfo))
        {
            [dicInfo setObject:@(myappinfo) forKey:SOFTARELANGUAGE];
        }
        
        memset(buf, '\0', buflenth);
        if (app_info->getAppVersionStr(i, buf, buflenth, &outsize))
        {
            NSString   *strInfo = [NSString stringWithCString:(const char*)buf encoding:NSUTF8StringEncoding];
            [dicInfo setObject:strInfo forKey:SOFTAREVERSION];
        }
        memset(buf, '\0', buflenth);
        if (app_info->getAppURL(i, buf, buflenth, &outsize))
        {
            NSString   *strInfo = [NSString stringWithCString:(const char*)buf encoding:NSUTF8StringEncoding];
            [dicInfo setObject:strInfo forKey:SOFTAREURL];
        }
        memset(buf, '\0', buflenth);
        if (app_info->getAppPicName(i, buf, buflenth, &outsize))
        {
            NSString   *strInfo = [NSString stringWithCString:(const char*)buf encoding:NSUTF8StringEncoding];
            [dicInfo setObject:strInfo forKey:SOFTARELOGO];
        }
        memset(buf, '\0', buflenth);
        if (app_info->getAppDesc(i, buf, buflenth, &outsize))
        {
            NSString   *strInfo = [NSString stringWithCString:(const char*)buf encoding:NSUTF8StringEncoding];
            [dicInfo setObject:strInfo forKey:SOFTAREDESPRICTION];
        }
        [array addObject:dicInfo];
    }
    
    if (delegate && [delegate respondsToSelector:@selector(receiveAppInfo:)])
    {
        NSDictionary  *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:array,@"ARRAY",strFileHost,@"FILEHOST",@(port),@"FILEPORT",nil];
        [delegate receiveAppInfo:dicInfo];
        [[NSUserDefaults standardUserDefaults] setObject:dicInfo forKey:APPINFO];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

//bool getFileServerIp(unsigned char *buff, unsigned int max_buff_len, unsigned int *bufflen);
//bool getFileServerPort(unsigned int *port);
@end
#endif














