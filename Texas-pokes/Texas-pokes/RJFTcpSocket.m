
//
//  RJFTcpSocket.m
//  Texas-pokes
//
//  Created by ran on 12-8-14.
//
//

/*
#import "RJFTcpSocket.h"

#import "BasisZipAndUnzip+PhaseAndLoad.h"
NSString   *BNRRECEIVEMESSAGEFROMSERVER = @"BNRRECEIVEMESSAGEFROMSERVER";
@implementation RJFTcpSocket
@synthesize delegate;
@synthesize tag = m_itag;
@synthesize connectSuc = m_bconnectSuc;
@synthesize socket = m_socket;
@synthesize host = m_Host;
@synthesize port = m_port;
//@synthesize receiveData;

#ifndef MAXRECEIVE
#define MAXRECEIVE      1024*8
#endif

#define FIRSTRECEIVELENGTH  20
#define TIMEOUT          -1

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
            
            NSLog(@"reconnectHost:%@ port:%d",host,port);
            Mysocket[iTag] = [Mysocket[iTag] ReConnectToHost:host
                                                        port:port
                                                    delegate:nil
                                                         tag:iTag];
        }
        
    }
    return Mysocket[iTag];
}


-(id)initWithHost:(NSString *)Host
             Port:(uint16_t)iPort
         Delagate:(id)Mydelegate
              tag:(NSInteger)itag
{
    self = [super init];
    if (self)
    {
        
        m_iReceiveLength = -100;
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
            
            
            return self;
            
        }
        delegate = Mydelegate;
        m_itag = itag;
    //    [m_socket readDataToLength:FIRSTRECEIVELENGTH withTimeout:-1 tag:0];
        
        
    }
    return self;
    
}
-(id)ReConnectToHost:(NSString *)Host port:(uint16_t)port delegate:(id)Delegate tag:(int32_t)iTag
{
    if (m_socket)
    {
        m_socket.delegate = nil;
        [m_socket release];
        m_socket = nil;
    }
    m_iReceiveLength = -100;
    self.host = Host;
    self.port = port;
    m_socket = [[AsyncSocket alloc] initWithDelegate:self];
    NSError *error = nil;
    if (![m_socket connectToHost:Host
                          onPort:port error:&error])
    {
        NSLog(@"connect fail\n error info:%@",[error localizedDescription]);
        
        

        return self;
        
    }
    // [m_socket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
   // [m_socket readDataToLength:FIRSTRECEIVELENGTH withTimeout:-1 tag:0];
    m_bconnectSuc = YES;
    self.connectSuc = YES;
    delegate = delegate;
    m_itag = iTag;
    return self;
}

-(void)SendCharMessage:(int8_t *)data size:(size_t)size
{
    
    NSLog(@"+++++++send size %ld tag:%d",size,self.tag);
  
        NSData  *senddata = [NSData dataWithBytes:data length:size];
        if (self.connectSuc && size == [senddata length])
        {
            
            [m_socket writeData:senddata withTimeout:TIMEOUT tag:0];
            //  NSLog(@"send suc");
        }else
        {
            [m_storeData addObject:senddata];
            NSLog(@"send fail");
        }
        
    
    
      //[m_socket readDataWithTimeout:-1 tag:0];
    
}
-(id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)readStream
{
    
	
}

-(void)disConnect
{
    if (self.connectSuc)
    {
        [m_socket disconnect];
        if (m_socket)
        {
            [m_socket release];
            m_socket = nil;
        }
        m_bconnectSuc = NO;
        self.connectSuc = NO;
        
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
    

    
    if ([data length] == 1440 || [data length] == 1428 || [data length] == 1460)
    {
        [receiveData appendData:data];
       // [m_socket readDataWithTimeout:TIMEOUT tag:0];
        NSLog(@"\n______________appdata");
    }else
    {
        [receiveData appendData:data];
        NSData  *postData = [NSData dataWithData:receiveData];
        [self PostData:postData];
        [receiveData setData:nil];
    }
    // [m_socket readDataWithTimeout:TIMEOUT tag:0];
    [m_lock unlock];
    

}
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"connect host:%@   port:%d",host,port);
    m_bconnectSuc = YES;
    [m_socket readDataToLength:FIRSTRECEIVELENGTH withTimeout:-1 tag:0];
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
	//[m_socket readDataToData:[AsyncSocket CRLFData] withTimeout:-1 tag:tag];
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
            NSLog(@"aaaaunlegal size:%d",size);
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

@end*/




//
//  RJFTcpSocket.m
//  Texas-pokes
//
//  Created by ran on 12-8-14.
//
//

#import "RJFTcpSocket.h"

#import "BasisZipAndUnzip+PhaseAndLoad.h"
NSString   *BNRRECEIVEMESSAGEFROMSERVER = @"BNRRECEIVEMESSAGEFROMSERVER";
@implementation RJFTcpSocket
@synthesize delegate;
@synthesize tag = m_itag;
@synthesize connectSuc = m_bconnectSuc;
@synthesize socket = m_socket;
@synthesize host = m_Host;
@synthesize port = m_port;
//@synthesize receiveData;

#ifndef MAXRECEIVE
#define MAXRECEIVE      1024*8
#endif

#define TIMEOUT          -1

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
            
            NSLog(@"reconnectHost:%@ port:%d",host,port);
            Mysocket[iTag] = [Mysocket[iTag] ReConnectToHost:host
                                                        port:port
                                                    delegate:nil
                                                         tag:iTag];
        }
        
    }
    return Mysocket[iTag];
}


-(id)initWithHost:(NSString *)Host
             Port:(uint16_t)iPort
         Delagate:(id)Mydelegate
              tag:(NSInteger)itag
{
    self = [super init];
    if (self)
    {
        
        
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
            
            
            return self;
            
        }
        delegate = Mydelegate;
        m_itag = itag;
        
        
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
        
        
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                         message:@"网络连接出错，请检查你的网络连接！"
                                                        delegate:nil
                                               cancelButtonTitle:@"关闭"
                                               otherButtonTitles:nil];
         [alert show];
         [alert release];
        return self;
        
    }
    // [m_socket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    
    m_bconnectSuc = YES;
    self.connectSuc = YES;
    delegate = Delegate;
    m_itag = iTag;
    return self;
}

-(void)SendCharMessage:(int8_t *)data size:(size_t)size
{
    
    NSLog(@"+++++++send size %ld tag:%d   request:%d",size,self.tag,[BasisZipAndUnzip unbyte_to_int16:data pos:16]);
    
    NSData  *senddata = [NSData dataWithBytes:data length:size];
    if (self.connectSuc && size == [senddata length])
    {
        
        [m_socket writeData:senddata withTimeout:TIMEOUT tag:0];
        //  NSLog(@"send suc");
    }else
    {
        [m_storeData addObject:senddata];
        NSLog(@"send fail");
    }
    
    
    
    [m_socket readDataWithTimeout:-1 tag:0];
    
}
-(id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)readStream
{
    
	
}

-(void)disConnect
{
    if (self.connectSuc)
    {
        [m_socket disconnect];
        m_bconnectSuc = NO;
        self.connectSuc = NO;
        
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

    [m_lock lock];

  
    [receiveData appendData:data];
    NSData  *postData = [NSData dataWithData:receiveData];
    
    if ([postData length] > 7)
    {
        BOOL  blevel = NO;
        do {
            int8_t  *databytes = (int8_t*)[postData bytes];
            size_t  size = 0;
            if (databytes[0] == 'D')
            {
                size = [self unbyte_to_int16:databytes pos:7];
            }else if(databytes[0] == 'P')
            {
                size = [self unbyte_to_int16:databytes pos:8];
            }
            
            if (size == [postData length])
            {
                [self PostData:postData];
                [receiveData setData:nil];
                blevel = YES;
                
            }else if (size < [postData length])
            {
                NSData  *secondlevel = [NSData dataWithBytes:databytes length:size];
                [self PostData:secondlevel];
                postData = [NSData dataWithBytes:databytes+size length:[postData length]-size];
            }else if (size > [postData length])
            {
                [receiveData setData:postData];
                blevel = YES;
            }
            
        } while (!blevel);
        
    }

    [m_lock unlock];
    
    
}


- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"connected host:%@   port:%d",host,port);
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
     [m_socket readDataWithTimeout:TIMEOUT tag:0];
	//NSLog(@"onSocket:didWriteDataWithTag:%li", tag);
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
    
    usleep(10000);
    NSDictionary   *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:data,@"MESSAGE",
                               [NSNumber numberWithInt:[data length]],@"SIZE",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:BNRRECEIVEMESSAGEFROMSERVER
                                                        object:self
                                                      userInfo:dicInfo];
    
    
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
    
    
    if ((buf = malloc(len)) == NULL)
    {
        
        printf("Could not allocate memory. error!/n");
        
        return NULL;
        
    }
    
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        
        free(buf);
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













