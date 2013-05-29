
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
        
        
        //[receiveData ]
        m_storeData = [[NSMutableArray alloc] init];
        receiveData = [[NSMutableData alloc] init];
        self.host = Host;
        self.port = iPort;
        char *queue1 = malloc(sizeof(int32_t));
        queue1[0] = itag;
        dispatch_queue_t queue = dispatch_queue_create(queue1, NULL);
        m_socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:queue];
        free(queue1);
        dispatch_release(queue);
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
         [m_socket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
         m_bconnectSuc = YES;
        delegate = Mydelegate;
        m_itag = itag;
        
        
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
    
    self.host = Host;
    self.port = port;
    char *queue1 = malloc(sizeof(int32_t));
    queue1[0] = iTag;
    dispatch_queue_t queue = dispatch_queue_create(queue1, NULL);
    m_socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:queue];
    free(queue1);
    dispatch_release(queue);
    NSError *error = nil;
    if (![m_socket connectToHost:Host
                          onPort:port error:&error])
    {
        NSLog(@"connect fail\n error info:%@",[error localizedDescription]);
        
        
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                         message:@"服务器不可达"
                                                        delegate:nil
                                               cancelButtonTitle:@"关闭"
                                               otherButtonTitles:nil];
         [alert show];
         [alert release];
        return self;
        
    }
     [m_socket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    
    m_bconnectSuc = YES;
    delegate = delegate;
    m_itag = iTag;
    return self;
}

-(void)SendCharMessage:(int8_t *)data size:(size_t)size
{
    
    NSLog(@"+++++++size %ld",size);
    NSData  *senddata = [NSData dataWithBytes:data length:size];
    if (self.connectSuc)
    {
        
        [m_socket writeData:senddata withTimeout:TIMEOUT tag:0];
        //  NSLog(@"send suc");
    }else
    {
        [m_storeData addObject:senddata];
        NSLog(@"send fail");
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

- (void)readStream
{
    
	
}

-(void)disConnect
{
    [m_socket disconnect];
    m_bconnectSuc = NO;
    
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




- (void)onSocket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    //NSLog(@"data:%@",data);
    const  char *fir = (const char*)[data bytes];
    NSLog(@"size:%d first char:%c number:%d",[data length],fir[0],fir[0]);
    //  NSAutoreleasePool   *pool = [[NSAutoreleasePool alloc] init];
    if ([data length] == 1440 || [data length] == 1428)
    {
        [receiveData appendData:data];
       // [m_socket readDataWithTimeout:TIMEOUT tag:0];
        NSLog(@"\n______________appdata");
    }else
    {
        [receiveData appendData:data];
        NSData  *postData = [NSData dataWithData:receiveData];
        
        NSDictionary   *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:postData,@"MESSAGE",
                                   [NSNumber numberWithInt:[data length]],@"SIZE",nil];
        // NSString *s = [NSString stringWithUTF8String:(char*)buffer];
        
        if (delegate && [delegate respondsToSelector:@selector(RecMsgFromServer:)])
        {
            //  [delegate RecMsgFromServer:(char *)buffer];
            
        }else if (delegate && [delegate respondsToSelector:@selector(RecStringFromServer:)])
        {
            // [delegate RecStringFromServer:s];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:BNRRECEIVEMESSAGEFROMSERVER
                                                            object:self
                                                          userInfo:dicInfo];
        [receiveData setData:nil];
        
       
        
    }
     [m_socket readDataWithTimeout:TIMEOUT tag:0];
    
    /*  NSMutableData   *postData = [NSMutableData dataWithData:data];
     NSDictionary   *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:postData,@"MESSAGE",
     [NSNumber numberWithInt:[data length]],@"SIZE",nil];
     // NSString *s = [NSString stringWithUTF8String:(char*)buffer];
     
     if (delegate && [delegate respondsToSelector:@selector(RecMsgFromServer:)])
     {
     //  [delegate RecMsgFromServer:(char *)buffer];
     
     }else if (delegate && [delegate respondsToSelector:@selector(RecStringFromServer:)])
     {
     // [delegate RecStringFromServer:s];
     }
     [[NSNotificationCenter defaultCenter] postNotificationName:BNRRECEIVEMESSAGEFROMSERVER
     object:self
     userInfo:dicInfo];
     
     [m_socket readDataWithTimeout:TIMEOUT tag:0];*/
    //  [pool drain];
}
- (void)onSocket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"connect host:%@   port:%d",host,port);
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

- (void)onSocketDidDisconnect:(GCDAsyncSocket *)sock
{
    
    m_bconnectSuc = NO;
    [m_socket setDelegate:nil];
	[m_socket release];
	m_socket = nil;
    NSLog(@"disconnect:%@",self);
}

- (void)onSocket:(GCDAsyncSocket *)sock willDisconnectWithError:(NSError *)err
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





- (void)readWithTag:(long)tag
{
	// reads response line-by-line
	[m_socket readDataToData:[AsyncSocket CRLFData] withTimeout:-1 tag:tag];
}

- (void)onSocket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(CFIndex)partialLength tag:(long)tag
{
    NSLog(@"+++info:%ld",partialLength);
	//NSLog(@"onSocket:didReadPartialDataOfLength:%li tag:%li", partialLength, tag);
}



- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"connect host:%@   port:%d",host,port);
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

/**
 * Called when a socket has completed reading the requested data into memory.
 * Not called if there is an error.
 **/
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    const  char *fir = (const char*)[data bytes];
    NSLog(@"size:%d first char:%c number:%d",[data length],fir[0],fir[0]);
    //  NSAutoreleasePool   *pool = [[NSAutoreleasePool alloc] init];
    if ([data length] == 1440 || [data length] == 1428)
    {
        [receiveData appendData:data];
        // [m_socket readDataWithTimeout:TIMEOUT tag:0];
        NSLog(@"\n______________appdata");
    }else
    {
        [receiveData appendData:data];
        NSData  *postData = [NSData dataWithData:receiveData];
        
        NSDictionary   *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:postData,@"MESSAGE",
                                   [NSNumber numberWithInt:[data length]],@"SIZE",nil];
        // NSString *s = [NSString stringWithUTF8String:(char*)buffer];
        
        if (delegate && [delegate respondsToSelector:@selector(RecMsgFromServer:)])
        {
            //  [delegate RecMsgFromServer:(char *)buffer];
            
        }else if (delegate && [delegate respondsToSelector:@selector(RecStringFromServer:)])
        {
            // [delegate RecStringFromServer:s];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:BNRRECEIVEMESSAGEFROMSERVER
                                                            object:self
                                                          userInfo:dicInfo];
        [receiveData setData:nil];
        
        
        
    }
    [m_socket readDataWithTimeout:TIMEOUT tag:0];
}
- (void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
{
    
}

/**
 * Called when a socket has completed writing the requested data. Not called if there is an error.
 **/
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    
}
- (NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag
                 elapsed:(NSTimeInterval)elapsed
               bytesDone:(NSUInteger)length
{
    return 3;
}
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    m_bconnectSuc = NO;
    [m_socket setDelegate:nil];
	[m_socket release];
	m_socket = nil;
}
@end














