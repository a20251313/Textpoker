//
//  RJFUpAndDown.m
//  Texas-pokes
//
//  Created by ran on 12-10-8.
//
//

#import "RJFUpAndDown.h"
#import "PublicDefine.h"
#define TIMEOUT             -1
#define DOWNAPPPICID        47
#define UPLOADREQUESTID     42
#define DOWNLOADREQUESDID   43

@implementation RJFUpAndDown
@synthesize delegate;
@synthesize connectSuc = m_bconnectSuc;

static  RJFUpAndDown *Mysocket[1] = {nil};


static uchar_t * pv_int_to_byte_array(int32_t intData, uchar_t bytearray[])
{
	bytearray[0] = (uchar_t)((intData & 0xFF000000) >> 24 );
	bytearray[1] = (uchar_t)((intData & 0x00FF0000) >> 16 );
	bytearray[2] = (uchar_t)((intData & 0x0000FF00) >> 8  );
	bytearray[3] = (uchar_t) (intData & 0x000000FF);
    
	return bytearray;
}
//﹏ `R  09:23:38
static uchar_t * pv_uint16_to_byte_array(uint16_t intData, uchar_t bytearray[])
{
	bytearray[0] = (uchar_t)((intData & 0xFF00) >> 8);
	bytearray[1] = (uchar_t) (intData & 0x00FF);
    
	return bytearray;
}



+(id)shareInitWithHost:(NSString *)Host
                  Port:(u_int)iPort
              Delagate:(id)Mydelegate
                   tag:(NSInteger)itag
{
    
    
    if (Mysocket[itag] == nil || !Mysocket[itag].connectSuc)
    {
        Mysocket[itag] = [[RJFUpAndDown alloc] initWithHost:Host
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
    if (m_socket)
    {
        m_socket.delegate = nil;
        [m_socket release];
        m_socket = nil;
    }
    
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
    
    m_bconnectSuc = YES;
    self.connectSuc = YES;
    delegate = Delegate;
    m_itag = iTag;
    return self;
}

-(void)SendCharMessage:(int8_t *)data size:(size_t)size
{
    
  //  NSLog(@"+++++++send size %ld tag:%d",size,self.tag);
    
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
    
  
    [receiveData appendData:data];
    NSData  *postData = [NSData dataWithData:receiveData];
    
    int8_t  *bytes = (int8_t *)[postData bytes];
    if ([postData length] > 7)
    {
        size_t  size = [self unbyte_to_int32:bytes pos:4];
        if (size > [postData length] )
        {
              NSLog(@"'''''size big than now phase data");
        }else if(size == [postData length])
        {
            [self phaseFile:postData];
            [receiveData setData:nil];
            NSLog(@"''''''size equal and now phase data");
        }else if(size < [postData length])
        {
            NSData  *firstdata = [NSData dataWithBytes:bytes length:size];
            [self phaseFile:firstdata];
            [receiveData setData:nil];
              NSLog(@"'''''size smaller than now phase data");
        }
        
    }
    
    
   /* if ([data length] == 1440 || [data length] == 1428 || [data length] == 1460)
    {
        [receiveData appendData:data];
        size_t  size = [self unbyte_to_int32:(int8_t*)[receiveData bytes] pos:4];
        NSLog(@"size  accord info：%ld receivedata length:%d",size,[receiveData length]);
        if (size == [receiveData length])
        {
            NSData  *postData = [NSData dataWithData:receiveData];
            [self phaseFile:postData];
             [receiveData setData:nil];
        }
        // [m_socket readDataWithTimeout:TIMEOUT tag:0];
        NSLog(@"\n______________appdata");
    }else
    {
        [receiveData appendData:data];
        NSData  *postData = [NSData dataWithData:receiveData];
        int8_t  *bytes = (int8_t *)[postData bytes];
        if ([postData length] > 5)
        {
            size_t  size = [self unbyte_to_int32:bytes pos:4];
            if (size < [postData length] )
            {
                
            }else if(size == [postData length])
            {
                [self phaseFile:postData];
                [receiveData setData:nil];
            }else if(size > [postData length])
            {
                NSData  *data = [NSData dataWithBytes:bytes length:size];
                [self phaseFile:data];
                [receiveData setData:nil];
                
            }
            
        }
     
        
       // NSLog(@"post size  accord info：%ld receivedata length:%d",size,[postData length]);
       
    }*/

    [m_socket readDataWithTimeout:TIMEOUT tag:0];
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


-(void)uploadfile:(NSString *)fileName filedata:(NSData *)fileData
{
    if ([fileName length] < 20 )
    {
        NSLog(@"upload file not leagal  filename:%@",fileName);
        return;
    }
    
    
    int32_t headsize = 14;
    char  *fileNameByte = (char*)[fileName UTF8String];
    BasisZipAndUnzip   *basic = [[BasisZipAndUnzip alloc] initWithSize:[fileData length]+200];
    //int8_t  *upfilename = [basic stringToInt_8:fileName];
    int32_t  fileNameLength = strlen(fileNameByte);//uni_strlen((char *)fileNameByte);
    
    uchar_t  *sendfiledata = (uchar_t *)[fileData bytes];
    int32_t  filedatsize = [fileData length];
    
    
    
    
    int32_t size = headsize+fileNameLength+sizeof(int32_t)*2+filedatsize;
    uint8_t *page = malloc(size);
    uchar_t temp[4] = {0};
    page[0] = 'F';
    page[1] = 'I';
    page[2] = 'L';
    page[3] = 'E';
    pv_int_to_byte_array(size, temp);
    page[4] = temp[0];
    page[5] = temp[1];
    page[6] = temp[2];
    page[7] = temp[3];
    pv_int_to_byte_array(headsize, temp);
    page[8] = temp[0];
    page[9] = temp[1];
    page[10] = temp[2];
    page[11] = temp[3];
    
    pv_uint16_to_byte_array(UPLOADREQUESTID, temp);
    page[12] = temp[0];
    page[13] = temp[1];
    
    pv_int_to_byte_array(fileNameLength, temp);
    page[14] = temp[0];
    page[15] = temp[1];
    page[16] = temp[2];
    page[17] = temp[3];
    memcpy(page+headsize+4, fileNameByte, fileNameLength);
    pv_int_to_byte_array(filedatsize, temp);
    
    page[headsize+4+fileNameLength] = temp[0];
    page[headsize+4+fileNameLength+1] = temp[1];
    page[headsize+4+fileNameLength+2] = temp[2];
    page[headsize+4+fileNameLength+3] = temp[3];
    memcpy(page+(headsize+4*2+fileNameLength), sendfiledata,filedatsize);
    //   [self SendCharMessage:page size:size];
    [self SendCharMessage:(int8_t*)page size:size];
    
    [basic release];
    free(page);
    page = NULL;
}

+(UIImage *)getLocalImage:(NSString *)strFileName
{
    
    //    if ([strFileName rangeOfString:@"."].location == NSNotFound)
    //    {
    //        strFileName = [strFileName stringByAppendingString:@".jpg"];
    //    }
    NSString *strCopyName = [NSString stringWithString:strFileName];
    strFileName = [strFileName stringByReplacingOccurrencesOfString:@":" withString:@""];
    strFileName = [strFileName stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    strFileName = [documentsDirectory stringByAppendingPathComponent:strFileName];
    
    // NSLog(@"112222222filename to gain:%@",strFileName);
    NSFileManager  *fileMange = [NSFileManager defaultManager];
    if ([fileMange fileExistsAtPath:strFileName])
    {
        UIImage  *image = [[[UIImage alloc] initWithContentsOfFile:strFileName] autorelease];
        
#if DEBUG
        NSLog(@"headPic %@ is exist in dir",strFileName);
#endif
        return image;
    }else
    {
        if ([strCopyName rangeOfString:@":"].location != NSNotFound || [strCopyName rangeOfString:@"/"].location != NSNotFound)
        {
            NSData   *filedata = [NSData dataWithContentsOfURL:[NSURL URLWithString:strCopyName]];
            UIImage  *image = [[UIImage alloc] initWithData:filedata];
            NSLog(@"strcopyFile:%@ image:%@",strCopyName,image);
            [RJFUpAndDown WriteToLocal:[NSDictionary dictionaryWithObjectsAndKeys:filedata,@"DATA",strFileName,@"FILENAME", nil]];
            return [image autorelease];
        }
        
        return nil;
    }
}


-(void)phaseFile:(NSData *)data
{
    BasisZipAndUnzip  *objZip = [[BasisZipAndUnzip alloc] initWithSize:[data length]+5];
    [objZip setPos:0];
    [objZip pushData:(int8_t *)[data bytes] size:[data length]];
    [objZip setPos:0];
    int8_t  checkCode = [objZip getInt8];
    if (checkCode != 'F')
    {
        [objZip release];
        return;
    }
    checkCode = [objZip getInt8];
    if (checkCode != 'I')
    {
        [objZip release];
        return;
    }
    checkCode = [objZip getInt8];
    if (checkCode != 'L')
    {
        [objZip release];
        return;
    }
    checkCode = [objZip getInt8];
    if (checkCode != 'E')
    {
        [objZip release];
        return;
    }
    
    int16_t  requestID = [objZip unbyte_to_int16:[objZip getData] pos:12];
    if (requestID == UPLOADREQUESTID)
    {
        [objZip setPos:14];
        if (delegate && [delegate respondsToSelector:@selector(UploadSucOrFail:)])
        {
            [delegate UploadSucOrFail:[objZip getInt8]];
        }
        
    }else if (requestID == DOWNLOADREQUESDID || requestID == DOWNAPPPICID)
    {
        [objZip setPos:14];
        int8_t  status = [objZip getInt8];
        //    NSLog(@"downstatus:%d",status);
        if (status)
        {
            NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
            int32_t fileLength = [objZip getInt32];
            [objZip getStringAccordSize:fileLength];
            
            char *charString = malloc(fileLength+2);
            memset(charString, '\0', fileLength);
            memcpy(charString, [data bytes]+14+5, fileLength);
            NSString  *strFileName = [NSString stringWithCString:charString encoding:NSUTF8StringEncoding];
            free(charString);
            //  fileName = [NSString stringWithCString:[fileName UTF8String] encoding:NSASCIIStringEncoding];
            int32_t  fileSize = [objZip getInt32];
            
            int8_t  *fileContent = malloc(fileSize);
            if (fileContent != NULL)
            {
                fileContent = memcpy(fileContent, [objZip getData]+[objZip dataSize], fileSize);
            }
            
            NSData  *filedata = [NSData dataWithBytes:fileContent length:fileSize];
            UIImage *image = [UIImage imageWithData:filedata];
            [RJFUpAndDown WriteToLocal:[NSDictionary dictionaryWithObjectsAndKeys:filedata,@"DATA",strFileName,@"FILENAME", nil]];
#if DEBUG
            NSLog(@"download filename:%@",strFileName);
#endif
            if (delegate && [delegate respondsToSelector:@selector(DownLoadSuOrFail:ISSuc:)])
            {
                [delegate DownLoadSuOrFail:image ISSuc:YES];
            }
            
            
            
            
            free(fileContent);
            [pool drain];
            //NSLog(@"fileName:%@,filedata:%@ file size:%d",fileName,filedata,fileSize);
            
        }else
        {
            NSLog(@"downFile fail");
            if (delegate && [delegate respondsToSelector:@selector(DownLoadSuOrFail:ISSuc:)])
            {
                [delegate DownLoadSuOrFail:nil ISSuc:NO]; 
            }
           
        }
        
        
    }
    [objZip release];
    objZip = nil;
    [self disConnect];
}

//  DATA-------NSDATA
//  FILENAME ------   FILENAME

+(void)WriteToLocal:(NSDictionary *)dicInfo
{
    //  NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    NSData  *data = [dicInfo valueForKey:@"DATA"];
    NSString  *strFileName = [dicInfo valueForKey:@"FILENAME"];
    //    if ([strFileName rangeOfString:@"."].location == NSNotFound)
    //    {
    //        strFileName = [strFileName stringByAppendingString:@".jpg"];
    //    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    strFileName = [documentsDirectory stringByAppendingPathComponent:strFileName];
    
    
    
    NSFileManager  *fileMange = [NSFileManager defaultManager];
    NSError  *error = nil;
    if ([fileMange fileExistsAtPath:strFileName])
    {
        [fileMange removeItemAtPath:strFileName error:&error];
    }
    
    if (![fileMange createFileAtPath:strFileName contents:nil attributes:nil])
    {
        NSLog(@"creat file fail");
    }
    
    if ([data writeToFile:strFileName atomically:YES])
    {
        NSLog(@"write to file suc");
    }else
    {
        NSLog(@"write to file fail!");
    }
    //  [pool drain];
    
}


-(UIImage *)SendDownRequest:(NSString *)fileName requestID:(NSInteger)request
{
    //NSLog(@"down file request file name:%@",fileName);
    if ([fileName length] < 20)
    {
        NSLog(@"filename lenth unleagal  fileName:%@",fileName);
        
        [delegate DownLoadSuOrFail:nil  ISSuc:NO];
        return nil;
    }
    UIImage  *image = [RJFUpAndDown getLocalImage:fileName];
    if (image != nil)
    {
        [delegate DownLoadSuOrFail:nil  ISSuc:NO];
        return image;
    }
    

    int32_t headsize = 14;
    BasisZipAndUnzip   *basic = [[BasisZipAndUnzip alloc] initWithSize:200];
    char  *upfilename =  (char*)[fileName UTF8String];
    int32_t  fileNameLength = strlen(upfilename);//uni_strlen((char *)upfilename);
    int32_t size = headsize+fileNameLength+sizeof(int32_t);
    uint8_t *page = malloc(size);
    uchar_t temp[4] = {0};
    page[0] = 'F';
    page[1] = 'I';
    page[2] = 'L';
    page[3] = 'E';
    pv_int_to_byte_array(size, temp);
    page[4] = temp[0];
    page[5] = temp[1];
    page[6] = temp[2];
    page[7] = temp[3];
    pv_int_to_byte_array(headsize, temp);
    page[8] = temp[0];
    page[9] = temp[1];
    page[10] = temp[2];
    page[11] = temp[3];
    
    pv_uint16_to_byte_array(request, temp);
    page[12] = temp[0];
    page[13] = temp[1];
    
    pv_int_to_byte_array(fileNameLength, temp);
    page[14] = temp[0];
    page[15] = temp[1];
    page[16] = temp[2];
    page[17] = temp[3];
    memcpy(page+headsize+4, upfilename, fileNameLength);
    
    [self SendCharMessage:(int8_t*)page size:size];

    [basic release];
    basic = nil;
    free(page);
    page = NULL;
    
    return image;
    
}


@end



