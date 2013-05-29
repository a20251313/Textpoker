//
//  PublicVarible.h
//  Texas-pokes
//
//  Created by ran on 12-12-24.
//
//

#ifndef Texas_pokes_PublicVarible_h
#define Texas_pokes_PublicVarible_h

#import "BasisZipAndUnzip+PhaseAndLoad.h"
#import "RJFTcpSocket.h"
#import "CoreTelephony/CTTelephonyNetworkInfo.h"
#import "RJFWarnView.h"
#import "MBProgressHUD.h"
#import "UIImage+sizeOfimage.h"
#import "UserInfo.h"
#import "RJFaudioPlay.h"
#import "PublicMethod.h"
#import "RJFShareViewController.h"
#import "SinaWeibo.h"
#import "TencentOAuth.h"
#import "UIImage+sizeOfimage.h"
#import "JFSharePanel.h"
#import "CABasicAnimation+someAniForProp.h"

@class BasisZipAndUnzip;
@class UserInfo;

extern  NSString  *BNRRECEIVEMESSAGEFROMSERVER;

#if DEBUG == 1
#define logMyLogInfo(format,...)    NSLog(format,##__VA_ARGS__)
#else
#define logMyLogInfo(format,...)    {};
#define NSLog(...) {};
#endif


#define LOGINSOCKETTAG                    0
#define RESOURCESOCKEtTAG                 1
#define GAMESOCKETTAG                     2
#define CHARGESOCKETTAG                   4



#define SCREENHEIGHT            320
#define SCREENWIDTH             480





#define USERIMAGEPATH               [NSHomeDirectory() stringByAppendingFormat:@"/MyUser.png"]
#define VIEWENTERBGTIME             @"VIEWENTERBG"



#define LittleChip                     NSLocalizedString(@"小盲注", nil)
#define BigChip                        NSLocalizedString(@"大盲注", nil)
#define FollowChip                     NSLocalizedString(@"跟注", nil)
#define AddChip                        NSLocalizedString(@"加注", nil)
#define GiveUpCard                     NSLocalizedString(@"弃牌" , nil)
#define KeepCard                       NSLocalizedString(@"看牌", nil)
#define ALLChipBet                     NSLocalizedString(@"全下", nil)
#define AutoBet                        NSLocalizedString(@"托管", nil)
#define WaitnextBet                    NSLocalizedString(@"等待下一局", nil)
#define Recv_out                       NSLocalizedString(@"淘汰" , nil)
#define FollowAnyChip                  NSLocalizedString(@"跟任何注", nil)
#define GiveOrKeepCard                 NSLocalizedString(@"弃或看" , nil)
#define INSURE                         NSLocalizedString(@"确定" , nil)
#define CANCEL                         NSLocalizedString(@"取消", nil)

#define DORLLARSYMBOL                   @""

#define LINEWIDTH                   4

//@"192.168.1.222"

#define COMPONETSTRING              @"@%"


#pragma mark - message info define
#define MESSAGETYPE                     @"MESSAGETYPE"
#define MESSAGEDATE                     @"MESSAGEDATE"
#define MESSAGECONTENT                  @"MESSAGECONTENT"

#define USERBEFORCHIPNUMBER             @"USERBEFORCHIPNUMBER"
#define USERNOWCHIPNUMBER               @"USERNOWCHIPNUMBER"
#define USERPROPCHIPNUMBER               @"USERPROPCHIPNUMBER"
#define USERCHIPHASCHANGE               @"USERCHIPHASCHANGE"

#define USERINFOID         [[UserInfo shareInstance] userIDForDzpk] 

#define MESSAGEUSERINFOINLOCAL          [NSString stringWithFormat:@"MESSAGEUSERINFOINLOCAL%d",USERINFOID]
#define MESSAGESYSLOCAL                 [NSString stringWithFormat:@"MESSAGESYSLOCAL%d",USERINFOID]
#define USERCHIPCOUNTDIC                [NSString stringWithFormat:@"USERCHIPCOUNTDIC%d",USERINFOID]


#endif
