
//
//  RJFTcpSocket.m
//  Texas-pokes
//
//  Created by ran on 12-8-14.
//
//

#import "RJFTcpSocket.h"


NSString   *BNRRECEIVEMESSAGEFROMSERVER = @"BNRRECEIVEMESSAGEFROMSERVER";
@implementation RJFTcpSocket
@synthesize delegate;
@synthesize tag = m_itag;
@synthesize connectSuc = m_bconnectSuc;
@synthesize host = m_host;
@synthesize port = m_port;
//@synthesize socket = m_socket;

#ifndef MAXRECEIVE
#define MAXRECEIVE      1024*8
#endif


static  RJFTcpSocket *Mysocket[6] = {nil,nil,nil,nil,nil,nil};
+(id)shareInitWithHost:(NSString *)Host
                  Port:(u_int)iPort
              Delagate:(id)Mydelegate
                   tag:(NSInteger)itag
{
    
    
    if (Mysocket[itag] == nil || !Mysocket[itag].connectSuc)
    {
        Mysocket[itag] = [[RJFTcpSocket alloc] initWithHost:Host
                                                       Port:iPort
                                                   Delagate:Mydelegate
                                                        tag:itag];
        
    }
    return Mysocket[itag];
}

+(id)shareWithTag:(NSInteger)iTag
{
    if (Mysocket[iTag] != nil)
    {
        if (!Mysocket[iTag].connectSuc)
        {
            NSString  *host = [Mysocket[iTag] host];
            UInt16 port = [Mysocket[iTag] port];
            
            NSLog(@"reconnectHost:%@ pot:%d",host,port);
            Mysocket[iTag] = [Mysocket[iTag] ReConnectToHost:host
                                                        port:port
                                                    delegate:nil
                                                         tag:iTag];
        }
        
    }
    return Mysocket[iTag];
}

-(id)initWithHost:(NSString *)Host
             Port:(u_int)iPort
         Delagate:(id)Mydelegate
              tag:(NSInteger)itag
{
    self = [super init];
    if (self)
    {
        m_receivaData = [[NSMutableData alloc] init];
        [m_receivaData setData:nil];
        m_arrstrorData = [[NSMutableArray alloc] init];
        m_lock = [[NSLock alloc] init];
        NSUInteger nlen = 16;
        nlen = [Host length]+1;
        char  *hostIP = malloc(nlen);
        self.host = Host;
        self.port = iPort;
        delegate = Mydelegate;
        m_itag = itag;
        
        
        if (-1 == (m_iSocket = socket(PF_INET, SOCK_STREAM, 0)))
        {
            free(hostIP);
            NSLog(@"errsocket :%d",m_iSocket);
            m_bconnectSuc = NO;
            return self;
        }
        bzero(hostIP,nlen);
		strcpy(hostIP, [Host UTF8String]);
		bzero(&remote_addr,sizeof(remote_addr));
		remote_addr.sin_family = PF_INET;
		remote_addr.sin_port = htons(iPort);
		remote_addr.sin_addr.s_addr = inet_addr(hostIP);
        
        m_iHealth = connect(m_iSocket, (struct sockaddr *) &remote_addr, sizeof(struct sockaddr));
        if (-1 == m_iHealth)
        {
            free(hostIP);
            m_bconnectSuc = NO;
            if (itag == 0)
            {
                UIAlertView  *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil)
                                                              message:NSLocalizedString(@"服务器不可达，请稍候再连！", nil)
                                                             delegate:nil
                                                    cancelButtonTitle:@"确定"
                                                    otherButtonTitles:nil, nil];
                [av show];
                [av release];
            }
            NSLog(@"connect to server fail tag:%d  iP:%@ port:%d",self.tag,Host,iPort);
            return self;
        }else
        {
            m_handleForWR = [[NSFileHandle alloc] initWithFileDescriptor:m_iSocket closeOnDealloc:YES];
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
			[nc addObserver:self
				   selector:@selector(ReceiveMessage:)
					   name:NSFileHandleReadCompletionNotification
					 object:m_handleForWR];
            [m_handleForWR readInBackgroundAndNotify];
        }
        
        free(hostIP);
        
        m_bconnectSuc = YES;
        NSLog(@"connect to server suc tag:%d  iP:%@ port:%d",self.tag,Host,iPort);
        
        for (int i = 0; i < [m_arrstrorData count]; i++)
        {
            [m_handleForWR writeData:[m_arrstrorData objectAtIndex:i]];
            NSLog(@"send after connect");
        }
        [m_arrstrorData removeAllObjects];
        
        
    }
    return self;
    
}

-(void)connect:(id)Timer
{
    
    
    m_iHealth = connect(m_iSocket, (struct sockaddr *) &remote_addr, sizeof(struct sockaddr));
    if (-1 == m_iHealth)
    {
        m_bconnectSuc = NO;
        NSLog(@"connect to server fail");
        [self ReConnectToHost:m_host
                         port:m_port
                     delegate:nil
                          tag:m_itag];
    }else
    {
        m_bconnectSuc = YES;
        NSLog(@"connect suc!");
    }
    
    
}


-(void)ReceiveMessage:(NSNotification *)note
{
    [m_lock lock];
    NSData *dataSocket = [[note userInfo] objectForKey:NSFileHandleNotificationDataItem];
#if DEBUG
    NSLog(@"receive size:%d",[dataSocket length]);
#endif
    if ([dataSocket length] > 0)
    {
        
        
        if ([dataSocket length] == 1440 || [dataSocket length] == 1428 || [dataSocket length] == 1460)
        {
            [m_receivaData appendData:dataSocket];
            NSLog(@"append data..........");
        }else
        {
            [m_receivaData appendData:dataSocket];
            NSData  *postdata = [NSData dataWithData:m_receivaData];
            [self PostData:postdata];
            [m_receivaData setData:nil];
            
        }
        
        [m_handleForWR readInBackgroundAndNotify];
        
        
    }else if([dataSocket length] <= 0)
    {
        NSLog(@"receive %d bytes tag:%d reconnect。。。。",[dataSocket length],self.tag);
        [self disConnect];
        [self connect:nil];
       
        //[m_handleForWR readInBackgroundAndNotify];
    }
    
    [m_lock unlock];
    
    
}
-(id)ReConnectToHost:(NSString *)Host
                port:(u_int16_t)port
            delegate:(id)Delegate
                 tag:(int32_t)iTag
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (m_handleForWR)
    {
        [m_handleForWR closeFile];
        [m_handleForWR release];
        m_handleForWR = nil;
    }
    NSUInteger nlen = 32;
    nlen = [Host length];
    char  *hostIP = malloc(nlen);
    m_host = Host;
    m_port = port;
    
    delegate = delegate;
    m_itag = iTag;
    
    
    if (-1 == (m_iSocket = socket(PF_INET, SOCK_STREAM, 0)))
    {
        free(hostIP);
        NSLog(@"errsocket :%d",m_iSocket);
        m_bconnectSuc = NO;
        return self;
    }
    bzero(hostIP,nlen);
    strcpy(hostIP, [Host UTF8String]);
    bzero(&remote_addr,sizeof(remote_addr));
    remote_addr.sin_family = PF_INET;
    remote_addr.sin_port = htons(port);
    remote_addr.sin_addr.s_addr = inet_addr(hostIP);
    
    m_iHealth = connect(m_iSocket, (struct sockaddr *) &remote_addr, sizeof(struct sockaddr));
    
    if (-1 == m_iHealth)
    {
        m_bconnectSuc = NO;
        NSLog(@"connect to server fail");
        return self;
    }else
    {
        m_handleForWR = [[NSFileHandle alloc] initWithFileDescriptor:m_iSocket closeOnDealloc:YES];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(ReceiveMessage:)
                   name:NSFileHandleReadCompletionNotification
                 object:m_handleForWR];
        [m_handleForWR readInBackgroundAndNotify];
    }
    
    free(hostIP);
    
    m_bconnectSuc = YES;
    for (int i = 0; i < [m_arrstrorData count]; i++)
    {
        [m_handleForWR writeData:[m_arrstrorData objectAtIndex:i]];
        NSLog(@"send after connect");
    }
    NSLog(@"connect to server suc!");
    
    return self;
}

-(void)SendCharMessage:(int8_t *)data size:(size_t)size
{
    
    NSData  *senddata = [NSData dataWithBytes:data length:size];
    if (!m_bconnectSuc || !m_handleForWR)
    {
        [m_arrstrorData addObject:senddata];
        NSLog(@"send fail");
        return;
    }
    
    if ([senddata length] == size)
    {
         [m_handleForWR writeData:senddata];
    }else
    {
        NSLog(@"The data is not illeagal:Time:%@",[NSDate date]);
    }
    
   system("ls -l > temp");
#if DEBUG
    NSLog(@"send suc  size:%ld",size);
#endif
    
    
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
        m_iSocket = SOCKET_CONNECTFAIL;
        m_iHealth = SOCKET_CONNECTFAIL;
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [m_handleForWR closeFile];
        [m_handleForWR release];
        m_handleForWR = nil;
        close(m_iSocket);
        m_bconnectSuc = NO;
        
    }
    
}

-(void)dealloc
{
    m_iSocket = SOCKET_CONNECTFAIL;
    m_iHealth = SOCKET_CONNECTFAIL;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (m_handleForWR)
    {
        [m_handleForWR closeFile];
        [m_handleForWR release];
        m_handleForWR = nil;
    }
    close(m_iSocket);
    [m_lock release];
    m_lock = nil;
    
    if (m_arrstrorData)
    {
        [m_arrstrorData removeAllObjects];
        [m_arrstrorData release];
        m_arrstrorData = nil;
    }
    if (m_receivaData)
    {
        [m_receivaData release];
        m_receivaData = nil;
    }
    
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
    return [NSString stringWithFormat:@"tag:%d socketIsValud:%d  socketAdd:%@ connectSuc:%d",m_itag,m_iSocket,m_handleForWR,m_bconnectSuc];
}


-(int32_t) unbyte_to_int32:(int8_t * )data  pos:(size_t)pos
{
    
    return      (data[pos++]&0xff)<<24 |
    (data[pos++]&0xff)<<16 |
    (data[pos++]&0xff)<<8 |
    (data[pos++]&0xff);
    
    
}

-(int16_t) unbyte_to_int16:(int8_t * )data pos:(size_t)pos
{
    
    return
    (data[pos++]&0xff)<<8 |
    (data[pos++]&0xff);
}

-(void)PostData:(NSData*)data
{
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    int8_t   *bytes = (int8_t *)[data bytes];
    int pos = 7;
    if (bytes[0] == 'P')
    {
        pos = 8;
    }
    int32_t  size = 0;
    int lenth = [data length];
    int totalLenth = 0;
    
    NSLog(@"\ntotal size:%d",lenth);
    do
    {
        size = [self unbyte_to_int16:bytes pos:pos];
      // int  size1 = [self unbyte_to_int16:bytes pos:pos-1];
      //  int  size2 = [self unbyte_to_int16:bytes pos:pos+1];
        if (size < 19 || size > 20*1024 || size > lenth+1)
        {
            NSLog(@"unlegal size:%d",size);
            break;
        }
        NSData  *postdata = [NSData dataWithBytes:bytes+totalLenth length:size];
        
        NSDictionary   *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:postdata,@"MESSAGE",
                                   [NSNumber numberWithInt:[postdata length]],@"SIZE",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:BNRRECEIVEMESSAGEFROMSERVER
                                                            object:self
                                                          userInfo:dicInfo];
        totalLenth += size;
#if DEBUG
        NSLog(@"pos:%d size:%d",pos,size);
#endif
        pos += size;
        
    } while (pos < lenth);
    
    [pool drain];
}

+(NSString *) macaddress

{
    
    int                    mib[6];
    
    size_t                len;
    
    char                *buf;
    
    unsigned char        *ptr;
    
    struct if_msghdr    *ifm;
    
    struct sockaddr_dl    *sdl;
    
    
    mib[0] = CTL_NET;
    
    mib[1] = AF_ROUTE;
    
    mib[2] = 0;
    
    mib[3] = AF_LINK;
    
    mib[4] = NET_RT_IFLIST;
    
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        
        printf("Error: if_nametoindex error/n");
        
        return NULL;
        
    }
    
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        
        printf("Error: sysctl, take 1/n");
        
        return NULL;
        
    }
    
    
    if ((buf = malloc(len)) == NULL) {
        
        printf("Could not allocate memory. error!/n");
        
        return NULL;
        
    }
    
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        
        printf("Error: sysctl, take 2");
        
        return NULL;
        
    }
    
    
    ifm = (struct if_msghdr *)buf;
    
    sdl = (struct sockaddr_dl *)(ifm + 1);
    
    ptr = (unsigned char *)LLADDR(sdl);
    
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    free(buf);
    
    return [outstring uppercaseString];
    
    
}

@end

