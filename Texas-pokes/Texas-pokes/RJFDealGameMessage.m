//
//  RJFDealGameMessage.m
//  Texas-pokes
//
//  Created by Ran Jingfu on 12/15/12.
//
//


NSString *BNRSTARTPERMETHOD = @"BNRSTARTPERMETHOD";
#import "RJFDealGameMessage.h"

@implementation RJFDealGameMessage
@synthesize delegate;
@synthesize reqyestCode = m_irequest;

- (void)main
{
    BasisZipAndUnzip   *objShare = [[BasisZipAndUnzip alloc] initWithSize:[m_data length]+5];
    
    int  requestCode = -1;
   
    SEL  selector = nil;
    
    
    void *handle = NULL;
    int8_t  *bytes =(int8_t*) [m_data bytes];
    switch (m_irequest)
    {
            // case REQ_SYNC_SIGNAL_GAME:
            // [self dealNotiForproREQ_SYNC_SIGNAL_GAME:requestCode itemNuber:iItemCount handle:handle];
            //   break;
        case REQ_GAME_SEND_ACTION:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
            selector = @selector(dealNotiForproREQ_GAME_SEND_ACTIONhandle:);
          //  [delegate dealNotiForproREQ_GAME_SEND_ACTIONhandle:handle];
            break;
        case REQ_GAME_SEND_SEAT_ACTION:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
            selector = @selector(dealNotiForproREQ_GAME_SEND_SEAT_ACTIONhandle:);
           // [delegate dealNotiForproREQ_GAME_SEND_SEAT_ACTIONhandle:handle];
            break;
        case REQ_GAME_SEND_MSG:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
             selector = @selector(dealNotiForproREQ_GAME_SEND_MSGhandle:);
           // [delegate dealNotiForproREQ_GAME_SEND_MSGhandle:handle];
            break;
        case REQ_GAME_RECV_ACTION:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
             selector = @selector(dealNotiForproREQ_GAME_RECV_ACTIONhandle:);
          //  [delegate dealNotiForproREQ_GAME_RECV_ACTIONhandle:handle];
            break;
        case REQ_GAME_RECV_LEAVE://
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
             selector = @selector(dealNotiForproREQ_GAME_RECV_LEAVEhandle:);
           // [delegate dealNotiForproREQ_GAME_RECV_LEAVEhandle:handle];
            break;
        case REQ_GAME_RECV_SEAT_DOWN:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
             selector = @selector(dealNotiForproREQ_GAME_RECV_SEAT_DOWNhandle:);
           // [delegate dealNotiForproREQ_GAME_RECV_SEAT_DOWNhandle:handle];
            break;
        case REQ_GAME_RECV_CARDS:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
             selector = @selector(dealNotiForREQ_GAME_RECV_CARDShandle:);
            //[delegate dealNotiForREQ_GAME_RECV_CARDShandle:handle];
            break;
        case REQ_GAME_RECV_WINNER:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
             selector = @selector(dealNotiForproREQ_GAME_RECV_WINNERhandle:);
           // [delegate dealNotiForproREQ_GAME_RECV_WINNERhandle:handle];
            break;
      /*  case REQ_GAME_TIMEOUT_BACK:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
             //selector = @selector(dealNotiForproREQ_GAME_SEND_SEAT_ACTIONhandle:);
            //[delegate dealNotiForproREQ_GAME_TIMEOUT_BACkhandle:handle];
            break;*/
        case REQ_GAME_RECV_READYTIME:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
             selector = @selector(dealNotiForproREQ_GAME_RECV_READYTIMEhandle:);
          //  [delegate dealNotiForproREQ_GAME_RECV_READYTIMEhandle:handle];
            break;
        case REQ_GAME_RECV_START_INFOR:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
           // [delegate dealNotiForproREQ_GAME_RECV_START_INFORhandle:handle];
             selector = @selector(dealNotiForproREQ_GAME_RECV_START_INFORhandle:);
            break;
        case REQ_GAME_ADD_CHIPS:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
             selector = @selector(dealNotiForproREQ_GAME_ADD_CHIPShandle:);
           // [delegate dealNotiForproREQ_GAME_ADD_CHIPShandle:handle];
            break;
        case REQ_GAME_RECV_MSG:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
             selector = @selector(dealNotiForproREQ_GAME_RECV_MSGhandle:);
            //[delegate dealNotiForproREQ_GAME_RECV_MSGhandle:handle];
            break;
       /* case REQ_GAME_CONNECT_AGAIN:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
            // selector = @selector(dealNotiForproREQ_GAME_SEND_SEAT_ACTIONhandle:);
           // [self dealNotiForproREQ_GAME_CONNECT_AGAIN:requestCode itemNuber:iItemCount handle:handle];
            break;*/
        case REQ_GAME_RECV_OUT:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
             selector = @selector(dealNotiForproREQ_GAME_RECV_OUThandle:);
          //  [delegate dealNotiForproREQ_GAME_RECV_OUThandle:handle];
            break;
        case REQ_PERSON_DATA:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
             selector = @selector(dealNotiForproREQ_PERSON_DATAhandle:);
          //  [delegate dealNotiForproREQ_PERSON_DATAhandle:handle];
            break;
        case REQ_GET_BONUDS:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
             selector = @selector(dealNotiForproREQ_GET_BOUNDShandle:);
            //[delegate dealNotiForproREQ_GET_BOUNDShandle:handle];
            break;
        case REQ_SYNC_SIGNAL_GAME:
            if (bytes[22] == 0)
            {
                UserInfo  *objUser = [UserInfo shareInstance];
                [objUser setGamedate:[NSDate date]];
                logMyLogInfo(@"gameHeart beat");
                logMyLogInfo(@"game active");
            }else if(bytes[22] == 1)
            {
                [delegate disConnectGameSocket:nil];
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"BNRDISCONNECTSERVER"
                 object:self];
                logMyLogInfo(@"The status is unvalue disconnect self");
                
            }
            break;
        case REQ_GAME_PLAYER_DATA:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
             selector = @selector(dealNotiForproREQ_REQ_GAME_PLAYER_DATAhandle:);
           // [delegate dealNotiForproREQ_REQ_GAME_PLAYER_DATAhandle:handle];
            break;
        case REQ_GAME_ENTER_ROOM:
            handle = [objShare PhaseInfoFromData:bytes
                                          
                                  outRequestCode:&requestCode];
             selector = @selector(dealNotiForproREQ_GAME_ENTER_ROOMhandle:);
           // [delegate performSelector:@selector(dealNotiForproREQ_GAME_ENTER_ROOMhandle:) withObject:(id)handle];
           // [delegate performSelector:@selector(dealNotiForproREQ_GAME_ENTER_ROOMhandle:) onThread:[NSThread mainThread] withObject:(id)handle waitUntilDone:<#(BOOL)#>]
           // [delegate dealNotiForproREQ_GAME_ENTER_ROOMhandle:handle];
            break;
        default:
            break;
    }
    
    
    if (selector != nil)
    {
        /*[[NSNotificationCenter defaultCenter] postNotificationName:BNRSTARTPERMETHOD
                                                            object:self
                                                          userInfo:[NSDictionary dictionaryWithObjectsAndKeys:NSStringFromSelector(selector),@"METHOD",(id)handle,@"HANDLE",nil]];*/
        [delegate extuceMethod:selector handle:handle];
    }
   // free(handle);
  //  handle = NULL;
    [objShare release];
    objShare = nil;
 

    
}
-(id)initWithData:(NSData*)data andDelegate:(id<BNRDealWithGameMEssage>)delegateMessage request:(int32_t)requestcode
{
    self = [super init];
    if (self)
    {
        m_data = [[NSMutableData alloc] initWithData:data];
        self.delegate = delegateMessage;
        m_irequest = requestcode;
        
    }
    return self;
    
}

@end

