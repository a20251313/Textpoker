//
//  RJFMainViewController.m
//  Texas-pokes
//
//  Created by popo on 12-6-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFMainViewController.h"
#import "RJFWarnView.h"
#import "RJFUpAndDown.h"
#import "RJFMainHelpViewController.h"
#import "QFObject.h"
#import "PushManager.h"


#ifndef USERID
#define USERID  @"USERID"
#endif

#ifndef CURRENTTHIRDUSERID
#define CURRENTTHIRDUSERID          @"CURRENTTHIRDUSERID"
#endif

#ifndef PUSH_SERVER_IP
#define PUSH_SERVER_IP              @"iospush.lelechat.com"
#define PUSH_SERVER_PORT            58800
#endif


#ifndef CURRENTPROPTAGS
#define CURRENTPROPTAGS             @"CURRENTPROPTAGS"
#define CURRENTPROPPRICES           @"CURRENTPROPPRICES"
#endif


#pragma mark -QQLogin info
#define     BTNQQTAG                2034
#define     BTNIGusetTAG            2035
#define     BTNSettingTAG           2036
#define     BTNHelpTAG              2037
#define     BTNSINATAG              2038

#define    LOGINUSERUUID                    @"LOGINUSERUUID"
#define    LOGINUSERTYPE                    @"LOGINUSERTYPE"
#define    LOGINUSERSESSION                 @"LOGINUSERSESSION"
#define    LOGINUSERNICKNAME                @"LOGINUSERNICKNAME"
#define    LOGINUSERPORTRAIT                @"LOGINUSERPORTRAIT"
#define    LOGINUSERSEX                     @"LOGINUSERSEX"


#warning change network when distribution
#if    0
#define ACCESSHOST                 @"221.181.73.61"
#define ACCESSPORT                  20000

#else

//#define ACCESSHOST          @"117.135.139.81"
#define ACCESSHOST              @"ipoker.bbitoo.cn"
#define ACCESSPORT              20000
#endif



@implementation RJFMainViewController


-(void)ClickInsure:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:m_strURL]];
}

-(void)ClickCancel:(id)sender
{
    
    if ([[sender titleForState:UIControlStateNormal] isEqualToString:NSLocalizedString(@"退出程序", nil)])
    {
        exit(0);
    }
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:m_strURL]];
}
-(void)ReceiveLoginInfo:(NSNotification*)note
{
    
  
    RJFTcpSocket  *m_socket = [note object];
    NSDictionary  *dicInfo = [note userInfo];
    if (dicInfo &&(m_socket.tag == RESOURCESOCKEtTAG  || m_socket.tag == LOGINSOCKETTAG) )
    {
        
    }else
    {
        
        return;
    }
    
    size_t  size = [[dicInfo valueForKey:TCPSOCKETSIZE] intValue];
    BasisZipAndUnzip   *objShare = [[BasisZipAndUnzip alloc] initWithSize:size+10];
    int  requestCode = -1;
   
    NSData  *data = [[note userInfo] valueForKey:TCPSOCKETMESSAGE];
    
    void *handle = NULL;
    int8_t  *byte =(int8_t*) [data bytes];
    int  pos = 4;
    if (byte[0] != 'D')
    {
        pos = 5;
    }
    
    logMyLogInfo(@"data:%s  time:[%@]",[data bytes],[NSDate date]);
    requestCode = [BasisZipAndUnzip unbyte_to_int16:byte pos:pos];
    
    if (requestCode == REQ_LOGIN)
    {
        handle =[objShare PhaseInfoFromData:(int8_t *)[data bytes]
                             outRequestCode:&requestCode];
        
        
        if (handle == NULL)
        {
            HideHUD(self, YES);
            [objShare release];
            objShare = nil;
            return;
        }
        
        DZPK_SERVER_REQ_LOGIN  *info = (DZPK_SERVER_REQ_LOGIN*)handle;
        UserInfo  *objUser = [UserInfo shareInstance];
        objUser.userIDForDzpk = info->user_id;
        objUser.userKey = info->key;
        objUser.userType = info->user_type;
        
        if (info->status)
        {
            
            HideHUD(self, YES);
            NSString   *strWarning = nil;
            if (info->status == 1)
            {
                strWarning = NSLocalizedString(@"提示\n\n\n用户名错误！", nil);
            }else if(info->status == 2)
            {
                strWarning = NSLocalizedString(@"提示\n\n\n密码错误!", nil);
            }else if(info->status == 3)
            {
                strWarning = NSLocalizedString(@"提示\n\n\n数据库出错!", nil);
            }
            else if(info->status == 4)
            {
                [self checkVersion:nil];
                //strWarning = NSLocalizedString(@"提示\n\n\n程序版本过低！", nil);
            }
            
            if (strWarning != nil)
            {
                [RJFWarnView addinSelfview:self.view
                                  delegate:nil
                                   message:strWarning
                                buttontype:INSUREBUTTON
                              InsureButton:INSURE
                              CancelButton:nil];
                
            }
 
            
            free(handle);
            handle = NULL;
            [objShare release];
            objShare = nil;

            return;
        }
        
        
        logMyLogInfo(@"-------------------receive REQ_LOGIN -------------------");
        logMyLogInfo(@"info->IP:%@ key:%@ port:%d server_number:%d status:%d userID:%d userType:%d isfirstLogin:%d",info->IP,info->key,info->port,info->server_number,info->status,info->user_id,info->user_type,info->isfirstLogin);
        logMyLogInfo(@"-------------------end receive REQ_LOGIN-----------------");
        
         [m_UserdicInfo setObject:info->key forKey:@"LOGINKEYFORSERVER"];
        [m_UserdicInfo setObject:info->IP forKey:@"SERVERIP"];
        [m_UserdicInfo setObject:@(info->port) forKey:@"SERVERPORT"];
        if (info->user_id > 0 && info->user_type == 0)
        {
            [[NSUserDefaults standardUserDefaults] setInteger:info->user_id forKey:USERID];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        

        if (info->isfirstLogin == 0 && info->user_type != 0)
        {
            UserInfo  *objUser = [UserInfo shareInstance];
            objUser.needSyncInfo = YES;
            m_bIsFirstLogin = YES;
            
            if (info->user_type == 1)
            {
                TencentOAuth  *tenecnt = [TencentOAuth ShareInstance:self];
                [tenecnt getUserInfo];
            }else if(info->user_type == 2)
            {
                SinaWeibo  *sina = [SinaWeibo shareInstance:self];
                [sina GetUserInfo];
            }else if (info->user_type == 3)
            {
#if MODEFOR91
                NdComPlatform  *com =  [NdComPlatform defaultPlatform];
                // ND_PHOTO_SIZE_TYPE
                [[NdComPlatform defaultPlatform] NdGetPortraitEx:com.loginUin imageType:ND_PHOTO_SIZE_MIDDLE checkSum:[m_UserdicInfo valueForKey:@"checksum"] delegate:self];
#endif
            }else if (info->user_type == 6)
            {
#if MODEFORDOWNJOY
                [self downJoyGetFirstInfo:nil];
#endif
            }
            
    
        }else
        {
            RJFTcpSocket  *socket2 = [RJFTcpSocket shareInitWithHost:info->IP
                                                                Port:info->port
                                                            Delagate:nil
                                                                 tag:RESOURCESOCKEtTAG];
            
            
            
            DZPK_CLIENT_REQ_LOGIN_RESOURCES  resource = {info->key};
           
            // NSLog(@"key:%@ IP:%@",info->key,info->IP);
            
            BasisZipAndUnzip  *objZip = [[BasisZipAndUnzip alloc] initWithSize:300];
            [socket2 SendCharMessage:[objZip syncWithRequest:REQ_LOGIN_RESOURCES
                                                      userID:info->user_id
                                                 structArray:&resource]
                                size:[objZip dataSize]];
            [objZip release];
            objZip = nil;
            
        }
    
        
        logMyLogInfo(@"has login into login,waiting resource");
        
        
    }else if(requestCode == REQ_LOGIN_RESOURCES)
    {
        handle =[objShare PhaseInfoFromData:(int8_t *)[data bytes]       
                             outRequestCode:&requestCode];
        logMyLogInfo(@"get resource info");
        HideHUD(self, YES);
        DZPK_SERVER_REQ_LOGIN_RESOURCES  *info  =(DZPK_SERVER_REQ_LOGIN_RESOURCES*)handle;
        
        if (info->status == 0)
        {

            
            
            
            logMyLogInfo(@"-------------------receive REQ_LOGIN_RESOURCE -------------------");
            logMyLogInfo(@"status:%d fileserverIP:%@ fileserverPort:%d chips:%d head_picName:%@ idou:%d level:%d lose_number:%d match_score:%d max_own:%d msg_count:%d maxwin:%d nick:%@ score:%d sex:%d",info->status,info->fileServerIP,info->fileServerPort,info->gold,info->head_picName,info->idou,info->level,info->lose_number,info->match_score,info->max_own,info->msg_count,info->maxwin,info->nick,info->score,info->sex);
            for (int i = 0; i < info->boundsNumber; i++)
            {
                logMyLogInfo(@"bounds[%i]:%d",i,info->bounds[i]);
            }
            for (int i = 0; i < info->maxcardNumber; i++)
            {
                logMyLogInfo(@"maxcards[%i]:%d",i,info->maxcards[i]);
            }
            logMyLogInfo(@"-------------------end receive REQ_LOGIN_RESOURCE-----------------");
            
            [RJFUpAndDown shareInitWithHost:info->fileServerIP
                                       Port:info->fileServerPort
                                   Delagate:nil
                                        tag:0];
            logMyLogInfo(@"fileIP:%@ port:%d",info->fileServerIP,info->fileServerPort);
            [self setUserInfo:[UserInfo shareInstance] structUserinfo:info];
            
      
        
            
            [self sendGetBasicInfo:nil];
            
            
          /*  RJFMainWindow *Iwannanib = [[RJFMainWindow alloc]
                                         initWithNibName:@"RJFMainWindow"
                                         bundle:nil];
            Iwannanib.dayBounds = 199;
            Iwannanib.dayIndex = -1;
            [self.navigationController pushViewController:Iwannanib animated:YES];
            [Iwannanib release];*/
            
            
        }else
        {
                [RJFWarnView addinSelfview:self.view
                                  delegate:nil
                                   message:NSLocalizedString(@"提示\n\n\n登录失败，请重新登录！", nil)
                                buttontype:INSUREBUTTON
                              InsureButton:INSURE
                              CancelButton:nil];
        }
        
    }else if (requestCode == REQ_VERSION)
    {
        handle =[objShare PhaseInfoFromData:(int8_t *)[data bytes]       
                             outRequestCode:&requestCode];
        UserInfo  *objUser = [UserInfo shareInstance];
        objUser.hasCheckVersion = YES;
        DZPK_SERVER_REQ_VERSION  *info = handle;
         HideHUD(self, YES);
        NSString   *strWarning = nil;
     
        if (info->updateContent)
        {
              NSArray  *array = [info->updateContent componentsSeparatedByString:@"|"];
             strWarning = [NSString stringWithFormat:@"发现新版本\n\n%@",[array componentsJoinedByString:@"\n"]];
        }
        logMyLogInfo(@"get version status");
        
        switch (info->status)
        {
            case 0:
                break;
            case 1:
                
               
              //strWarning = [NSString stringWithFormat:NSLocalizedString(@"发现新版本\n\n", nil),info->versionName,info->updateContent];
               // strWarning = [NSString stringWithFormat:@"提示\n发现新版本\n新版本新增加了如下功能\n%@\n是否更新！",info->updateContent];
                [m_strURL setString:info->url];
                break;
            case 2:
                 [m_strURL setString:info->url];
               //  strWarning = [NSString stringWithFormat:@"提示\n当前版本过低，现在有新版本\"%@\"\n新版本新增加了如下功能\n%@\n请更新到新版本！",info->versionName,info->updateContent];
                break; 
            default:
                break;
        }
        
        if (info->status == 1)
        {
            [RJFWarnView addinSelfview:self.view
                              delegate:self
                               message:strWarning
                            buttontype:BOTHBUTTON
                          InsureButton:NSLocalizedString(@"更新", nil)
                          CancelButton:CANCEL];
        }else if(info->status == 2)
        {
            [RJFWarnView addinSelfview:self.view
                              delegate:self
                               message:strWarning
                            buttontype:BOTHBUTTON
                          InsureButton:NSLocalizedString(@"更新", nil)
                          CancelButton:NSLocalizedString(@"退出程序", nil)];
            
        }
        
    }else if (requestCode == REQ_BASIC_INFOR)
    {
        
        handle =[objShare PhaseInfoFromData:(int8_t *)[data bytes]
                             outRequestCode:&requestCode];
        DZPK_SERVER_REQ_BASIC_INFOR   *info = handle;
        if (info->status)
        {
            
            logMyLogInfo(@"-------------------receive REQ_BASIC_INFOR -------------------");
             logMyLogInfo(@"status:%d",info->status);
            logMyLogInfo(@"-------------------end receive REQ_BASIC_INFOR-----------------");
           
            [self sendGetBasicInfo:nil];
        }else
        {
            
            PushManager     *sharePush = [PushManager sharedManager];
            [sharePush setSendMsgFlag:1];
            [sharePush setAddFlag:1];
            
            [sharePush connectToHost:PUSH_SERVER_IP andPort:PUSH_SERVER_PORT];
            logMyLogInfo(@"-------------------receive REQ_BASIC_INFOR -------------------");
            logMyLogInfo(@"status:%d dayindex:%d ",info->status,info->dayindex);
            
            
            for (int i = 0; i < info->loginbounds_number; i++)
            {
                logMyLogInfo(@"loginBoundsArray[%i]:%d\n",i,info->loginBoundsArray[i]);
            }
            for (int i = 0; i < info->propArraynumber; i++)
            {
                logMyLogInfo(@"propArray[%i]:%d\n",i,info->propArray[i]);
            }
            for (int i = 0; i < info->propPriceNumber; i++)
            {
                logMyLogInfo(@"propprice_array[%i]:%d\n",i,info->propprice_array[i]);
            }
             logMyLogInfo(@"-------------------end receive REQ_BASIC_INFOR-----------------");
            
            RJFMainWindow *Iwannanib = [[RJFMainWindow alloc]
                                        initWithNibName:@"RJFMainWindow"
                                        bundle:nil];
            
            
            NSMutableArray   *arrayTags = [NSMutableArray arrayWithCapacity:info->propArraynumber];
            NSMutableArray   *arrayPrices = [NSMutableArray arrayWithCapacity:info->propPriceNumber];
            for (int i = 0; i < info->propArraynumber  && i < info->propPriceNumber; i++)
            {
                [arrayPrices addObject:@(info->propprice_array[i])];
                [arrayTags addObject:@(info->propArray[i])];
            }
            [[NSUserDefaults standardUserDefaults] setObject:arrayPrices forKey:CURRENTPROPPRICES];
            [[NSUserDefaults standardUserDefaults] setObject:arrayTags forKey:CURRENTPROPTAGS];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            Iwannanib.dayIndex = info->dayindex;
            Iwannanib.dayBounds = info->loginBoundsArray[info->dayindex];
            [self.navigationController pushViewController:Iwannanib animated:YES];
            [Iwannanib release];
            
            free(info->loginBoundsArray);
            free(info->propprice_array);
            free(info->propArray);
            
           
        }
    }
  
    
    
    free(handle);
    handle = NULL;
    [objShare release];
    objShare = nil;

    
    
    
}

-(void)sendGetBasicInfo:(id)Thread
{
    UserInfo  *objUser = [UserInfo shareInstance];
    BasisZipAndUnzip  *obj_basic = [[BasisZipAndUnzip alloc] initWithSize:40];
    RJFTcpSocket  *sockresource = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    [sockresource SendCharMessage:[obj_basic syncWithRequest:REQ_BASIC_INFOR
                                                      userID:objUser.userIDForDzpk
                                                 structArray:NULL]
                             size:[obj_basic dataSize]];
    [obj_basic release];
    obj_basic = nil;
    
}


-(UIButton *)buttonWithBackImage:(NSString *)bgimageName
                       withTitle:(NSString *)strTitle
                       leftImage:(NSString *)logoImgaeName
                        frame:(CGRect)frame
                         isSmall:(BOOL)isSmall
{
    UIButton   *button = [[[UIButton alloc] initWithFrame:frame] autorelease];
    [button setBackgroundImage:[UIImage imageNamed:bgimageName] forState:UIControlStateNormal];
    [button setTitle:strTitle forState:UIControlStateNormal];
    
 
    UIImage *logoimage = [UIImage imageNamed:logoImgaeName];
    
    if (logoimage)
    {
         [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)]; 
    }
  
  
    
    UIImageView  *imageView = nil;
    if(isSmall)
    {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,( button.frame.size.height-logoimage.size.height/2)/2, logoimage.size.width/2, logoimage.size.height/2)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    }else
    {
       imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,( button.frame.size.height-logoimage.size.height/2)/2, logoimage.size.width/2, logoimage.size.height/2)];
        
    }
    
    imageView.image = logoimage;
    [button addSubview:imageView];
    [imageView release];
    return button;
}

-(void)setUserInfo:(UserInfo *)objShare structUserinfo:(DZPK_SERVER_REQ_LOGIN_RESOURCES *)info
{
    
    if (info->sex == 0)
    {
        [objShare.Sex setString:NSLocalizedString(@"男", nil)];
    }else if(info->sex == 1)
    {
        [objShare.Sex setString:NSLocalizedString(@"女", nil)];
    }
    objShare.msgCount = info->msg_count;
    [objShare.userName setString:info->nick];
    [objShare.userImagePath setString:info->head_picName];
    //  NSLog(@"mainview control userimagepath:%@",objShare.userImagePath);
    
    if (info->maxcards  && info->maxcardNumber >= 5)
    {
        objShare.MaxCard1 = info->maxcards[0];
        objShare.MaxCard2 = info->maxcards[1];
        objShare.MaxCard3 = info->maxcards[2];
        objShare.MaxCard4 = info->maxcards[3];
        objShare.MaxCard5 = info->maxcards[4];
    }

    objShare.MaxWinchips = info->maxwin;
    objShare.userChips = info->gold;
    objShare.idou = info->idou*1.0f/100.0f;
    objShare.loseTime = info->lose_number;
    objShare.winTimes = info->win_number;
    objShare.maxOwn = info->max_own;
    objShare.fileHost = info->fileServerIP;
    objShare.filePort = info->fileServerPort;
    objShare.onlineCount = info->online_count;
    objShare.level = info->level;
    objShare.score = info->score;
    objShare.matchscore = info->match_score;
    objShare.task = info->task;
    objShare.getChipTimes = info->bounds[2];
    if (info->bounds)
    {
        if (info->bounds[1] == 0)
        {
            objShare.hasFreshBounds = YES;
        }else
        {
            objShare.hasFreshBounds = NO;
        }
    }

    
  
    if (m_bIsFirstLogin)
    {
        
        if ([m_UserdicInfo valueForKey:LOGINUSERNICKNAME])
        {
            [objShare.userName setString:[m_UserdicInfo valueForKey:LOGINUSERNICKNAME]];
        }
        if ([m_UserdicInfo valueForKey:LOGINUSERSEX])
        {
            [objShare.Sex setString:[m_UserdicInfo valueForKey:LOGINUSERSEX]];
        }
        if ([m_UserdicInfo valueForKey:LOGINUSERPORTRAIT])
        {
            [objShare.userImagePath setString:[m_UserdicInfo valueForKey:LOGINUSERPORTRAIT]];
        }
    }
        
}
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    m_strURL = [[NSMutableString alloc] init];
    m_UserdicInfo = [[NSMutableDictionary alloc] init];
    m_bIsFirstLogin = NO;
    
    return self;
}
-(IBAction)PopTheCorrecctXib:(UIButton *)sender
{
    id  Iwannanib = nil;
#if MODEFORDOWNJOY
       /* Downjoy  *downObj = [[Downjoy alloc] initWithBaseInfo:DownJoyAppKey
                                                       appKey:DownJoyKeySecret
                                                     delegate:(id)self];*/
        Downjoy   *downObj = [Downjoy shareInstance];
        [downObj setDelegate:(id)self];
#endif
    switch (sender.tag)
    {
        case BTNQQTAG:
//            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USERSHOULDNEEDLOGINAUTO];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            Iwannanib = [[RJFLoginViewController alloc] initWithNibName:@"RJFLoginViewController" bundle:nil];
            [self InitQQAndLogin:nil];
            break;
        case BTNSINATAG:
            
#if MODEFOR91
            [[NdComPlatform defaultPlatform] NdLogin:0];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(user91HasLogin:)
                                                         name:(NSString *)kNdCPLoginNotification
                                                       object:nil];
#elif MODEFORDOWNJOY
           
            [self presentModalViewController:downObj animated:YES];
            [downObj downjoyLogin:nil state:@"a20251313"];
#elif MODEFORAPPSTORE
            [self InitSinaAndLogin:nil];
#endif

            break;
        case BTNIGusetTAG:
            [self loginToDZPKServer:nil];
            break;
        case BTNHelpTAG:
            Iwannanib = [[RJFMainHelpViewController alloc] initWithNibName:@"RJFMainHelpViewController" bundle:nil];
            [Iwannanib setCanSendAdvice:NO];
            break;
        case BTNSettingTAG:
            Iwannanib = [[RJFSettingViewController alloc] initWithNibName:@"RJFSettingViewController" bundle:nil];
            break;
        default:
            break;
    }
    
    if (Iwannanib)
    {
        [self.navigationController pushViewController:Iwannanib animated:YES];
        [Iwannanib release];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
//    CFUUIDRef     myUUID;
//    CFStringRef   myUUIDString;
//    char          strBuffer[100];
//    
//    myUUID = CFUUIDCreate(kCFAllocatorDefault);
//    myUUIDString = CFUUIDCreateString(kCFAllocatorDefault, myUUID);
//    
//    // This is the safest way to obtain a C string from a CFString.
//    CFStringGetCString(myUUIDString, strBuffer, 100, kCFStringEncodingASCII);
//    
//    CFStringRef outputString =
//    CFStringCreateWithFormat(kCFAllocatorDefault,
//                             NULL,
//                             CFSTR("My UUID is: %s!\n"),
//                             strBuffer);
//    CFShow(outputString);
    
    logMyLogInfo(@"mac address:%@",[RJFTcpSocket macaddress]);
    [UIApplication sharedApplication].statusBarHidden = YES;
    

    
    /*[buttonGuest setBackgroundImage:[UIImage imageNamed:@"big_green.png"] forState:UIControlStateNormal];
 
    [buttonQQlogin setBackgroundImage:[UIImage imageNamed:@"big_yellow.png"] forState:UIControlStateNormal];
    [buttonSinalogin setBackgroundImage:[UIImage imageNamed:@"big_yellow.png"] forState:UIControlStateNormal];
    [buttonSetting setBackgroundImage:[UIImage imageNamed:@"small_blue.png"] forState:UIControlStateNormal];
    [buttonHelp setBackgroundImage:[UIImage imageNamed:@"small_blue.png"] forState:UIControlStateNormal];
    
    
    m_permits =  [[NSMutableArray arrayWithObjects:
                   @"get_user_info",@"add_share", @"add_topic",@"add_one_blog", @"list_album",
                   @"upload_pic",@"list_photo", @"add_album", @"check_page_fans",@"get_simple_userinfo",@"get_info",nil] retain];*/


   // self.view.backgroundColor = [UIColor colorWithRed:0x07*1.0f/255.0f green:0x33*1.0f/255.0f blue:0x6a*1.0f/255.0f alpha:1];
    
  //  [UserInfo shareInstance];
    
   //NSArray  *array =  [[UIApplication sharedApplication] windows];
    //logMyLogInfo(@"array:%@",array);

   // [self logAllSubViews:[[[UIApplication sharedApplication] windows] objectAtIndex:0]];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithRed:0x07*1.0f/255.0f green:0x33*1.0f/255.0f blue:0x6a*1.0f/255.0f alpha:1];
    UIImageView  *welLogoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 275, 280)];
    welLogoView.image = [UIImage imageNamed:@"welcomeLOGO.png"];
    [self.view addSubview:welLogoView];
    welLogoView.userInteractionEnabled = YES;
    [welLogoView release];
    
    
    UIImageView  *welbackimageView = [[UIImageView alloc] initWithFrame:CGRectMake(253, 0, 203, 320)];
    welbackimageView.image = [UIImage imageNamed:@"welcome_back.png"];
    welbackimageView.userInteractionEnabled = YES;
    [self.view addSubview:welbackimageView];
    [welbackimageView release];
    
   

    
    
    
    
    buttonQQlogin    = [self buttonWithBackImage:@"big_yellow.png" withTitle:NSLocalizedString(@"QQ账号登录", nil)
                                         leftImage:@"dzpk_qq.png" frame:CGRectMake(270, 40, 165, 43) isSmall:NO];
    [buttonQQlogin addTarget:self
                        action:@selector(PopTheCorrecctXib:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonQQlogin];

    
    
    buttonGuest    = [self buttonWithBackImage:@"big_green.png" withTitle:NSLocalizedString(@"游客账号登录", nil)
                                       leftImage:@"dzpk_guest.png" frame:CGRectMake(270, 156, 165, 43) isSmall:NO];
    
    [buttonGuest addTarget:self
                      action:@selector(PopTheCorrecctXib:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonGuest];
    
    buttonHelp    = [self buttonWithBackImage:@"small_blue.png" withTitle:NSLocalizedString(@"帮助", nil)
                                     leftImage:@"littlehelp.png" frame:CGRectMake(284, 258, 75, 25) isSmall:YES];
    [buttonHelp addTarget:self
                    action:@selector(PopTheCorrecctXib:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonHelp];
    
    
    buttonSetting    = [self buttonWithBackImage:@"small_blue.png" withTitle:NSLocalizedString(@"设置", nil)
                                    leftImage:@"Small_button_setting_logo.png" frame:CGRectMake(359, 258, 75, 25) isSmall:YES];
    [buttonSetting addTarget:self
                   action:@selector(PopTheCorrecctXib:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonSetting];
    
    
    m_permits =  [[NSMutableArray arrayWithObjects:
                   @"get_simple_userinfo",@"addt",@"addpic_t",nil] retain];
    
   

    
#if MODEFOR91
    buttonQQlogin.hidden = YES;
    buttonGuest.hidden = YES;
    buttonSinalogin = [self buttonWithBackImage:@"big_yellow.png"
                                      withTitle:@"91账号登录"
                                      leftImage:@""
                                          frame:CGRectMake(270, 98, 165, 43) isSmall:NO];
#elif MODEFORDOWNJOY
    buttonQQlogin.hidden = YES;
    buttonGuest.hidden = YES;
    buttonSinalogin = [self buttonWithBackImage:@"big_yellow.png"
                                      withTitle:@"当乐账号登录"
                                      leftImage:@""
                                          frame:CGRectMake(270, 98, 165, 43) isSmall:NO];
#else
    
    buttonSinalogin    = [self buttonWithBackImage:@"big_yellow.png" withTitle:NSLocalizedString(@"新浪微博登录", nil)
                                         leftImage:@"dzpk_sina.png" frame:CGRectMake(270, 98, 165, 43) isSmall:NO];
#endif
    
    
    [buttonSinalogin addTarget:self
                        action:@selector(PopTheCorrecctXib:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonSinalogin];
    [buttonSinalogin release];
    buttonGuest.tag = BTNIGusetTAG;
    buttonHelp.tag = BTNHelpTAG;
    buttonSetting.tag = BTNSettingTAG;
    buttonQQlogin.tag = BTNQQTAG;
    buttonSinalogin.tag = BTNSINATAG;
    [UserInfo shareInstance];
    
    
    
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    setAllViewautoResize(self.view);
    HideHUD(self, YES);
    for (UIView  *view in [self.view subviews])
    {
        view.userInteractionEnabled = YES;
    }
    [m_UserdicInfo removeAllObjects];
    
   // logMyLogInfo(@"info:%@",[[NSBundle mainBundle] infoDictionary]);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ReceiveLoginInfo:)
                                                 name:BNRRECEIVEMESSAGEFROMSERVER
                                               object:nil];
    [self performSelector:@selector(didAppearInfoOnBackground:)];
   // [RJFTcpSocket shareInitWithHost:ACCESSHOST Port:ACCESSPORT Delagate:nil tag:LOGINSOCKETTAG];
    
    [super viewWillAppear:animated];
}

-(void)didAppearInfoOnBackground:(id)Thread
{
    HideHUD(self, YES);
   
   
    
    UserInfo  *objUser = [UserInfo shareInstance];
    if (objUser.checkVersion && !objUser.hasCheckVersion)
    {
       
        [self checkVersion:nil];   
    }
    

    [m_UserdicInfo removeAllObjects];
}



-(void)checkVersion:(id)Thread
{
    
#if MODEFOR91
    [[NdComPlatform defaultPlatform] NdAppVersionUpdate:0 delegate:self];
#else
    RJFTcpSocket  *mysock = [RJFTcpSocket shareInitWithHost:ACCESSHOST
                                                       Port:ACCESSPORT
                                                   Delagate:nil tag:LOGINSOCKETTAG];
    ShowHUD(@"检测新版本中，请稍候", self,25);
    BasisZipAndUnzip  *objBasic = [[BasisZipAndUnzip alloc] initWithSize:35];
    
    UserInfo  *shareUser = [UserInfo shareInstance];
    [mysock SendCharMessage:[objBasic syncWithRequest:REQ_VERSION
                                               userID:shareUser.userIDForDzpk
                                          structArray:NULL]
                       size:[objBasic dataSize]];
    [objBasic release];
    objBasic = nil;
#endif
    
}
- (void)viewDidAppear:(BOOL)animated
{
    
  //  [NSThread detachNewThreadSelector:@selector(didAppearInfoOnBackground:) toTarget:self withObject:nil];
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]
     removeObserver:self];
    
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    
	[super viewDidDisappear:animated];
}


-(void)InitSinaAndLogin:(id)Thread
{
    SinaWeibo  *sinaweibo = [SinaWeibo shareInstance:self];
    [sinaweibo logIn];
    
}

-(void)InitQQAndLogin:(id)Thread
{
  
    TencentOAuth  *tenect = [TencentOAuth ShareInstance:self];
   /* if (m_Tencent == nil)
    {
        m_Tencent = [[TencentOAuth alloc] initWithAppId:QQLoginAPPKEY andDelegate:self];
    }*/
     [tenect authorize:[NSArray arrayWithObjects:@"add_topic",@"add_t",@"add_pic_t",@"get_simple_userinfo", nil] inSafari:NO];
    
}

-(void)dealloc
{
    if (m_UserdicInfo)
    {
        [m_UserdicInfo removeAllObjects];
        [m_UserdicInfo release];
        m_UserdicInfo = nil;
    }
    if (buttonSinalogin)
    {
        [buttonSinalogin release];
        buttonSinalogin = nil;
    }
    if (m_permits)
    {
        [m_permits removeAllObjects];
        [m_permits release];
        m_permits = nil;
    }
    if (m_Tencent)
    {
        [m_Tencent release];
        m_Tencent = nil;
    }
    if (buttonQQlogin)
    {
        [buttonQQlogin release];
        buttonQQlogin = nil;
    }
    if (buttonGuest)
    {
        [buttonGuest release];
        buttonGuest = nil;
    }
    if (buttonSetting)
    {
        [buttonSetting release];
        buttonSetting = nil;
    }
    if (buttonHelp)
    {
        [buttonHelp release];
        buttonHelp = nil;
    }
    if (m_strURL)
    {
        [m_strURL release];
        m_strURL = nil;
    }
    [super dealloc];
}




-(void)loginToDZPKServer:(id)Thread
{

    ShowHUD(NSLocalizedString(@"正在登录游戏服务器，请稍候!", nil), self,30);
    logMyLogInfo(@"......................login User Info:%@...............",Thread);
    BOOL  bGuest = NO;
    if ([[Thread valueForKey:LOGINUSERTYPE] intValue] == 0 || Thread == nil)
    {
        bGuest = YES;
    }
    
    NSUserDefaults   *defaulat  = [NSUserDefaults standardUserDefaults];
    NSNumber   *struserID = [defaulat valueForKey:USERID];
    DZPK_CLIENT_REQ_LOGIN   *loginuser = malloc(sizeof(DZPK_CLIENT_REQ_LOGIN)+1);
    
     UserInfo *objUser = [UserInfo shareInstance];
    if (struserID && bGuest)
    {
        objUser.userIDForDzpk = [struserID intValue];
    }else
    {
        objUser.userIDForDzpk = 0;
    }
    
    if (bGuest)
    {
        loginuser->user_type = 0;
        loginuser->imsi = @"";
        loginuser->userUUID = @"";
        loginuser->sessionKey = @"";
    }else
    {
    
        loginuser->user_type = [[Thread valueForKey:LOGINUSERTYPE] intValue];
        loginuser->imsi = @"";
        loginuser->userUUID = [Thread valueForKey:LOGINUSERUUID];
        [m_UserdicInfo setObject:[Thread valueForKey:LOGINUSERUUID] forKey:LOGINUSERUUID];
        [m_UserdicInfo setObject:[Thread valueForKey:LOGINUSERSESSION] forKey:LOGINUSERSESSION];
        [m_UserdicInfo setObject:[Thread valueForKey:LOGINUSERTYPE] forKey:LOGINUSERTYPE];
        [[NSUserDefaults standardUserDefaults] setObject:[Thread valueForKey:LOGINUSERUUID] forKey:CURRENTTHIRDUSERID];
    }
    
    loginuser->macAddress = [RJFTcpSocket macaddress];
    CGRect  rect = [[UIScreen mainScreen] applicationFrame];
    NSString *strHW = [NSString stringWithFormat:@"%0.0f*%0.0f",rect.size.height,rect.size.width];
    NSString *strModel = [[UIDevice currentDevice] model];
    NSString *strVersion = [[UIDevice currentDevice] systemVersion];
    loginuser->HeighthAndWidth = strHW;
    loginuser->model = strModel;
    loginuser->system_version = strVersion;
    
    if ([Thread valueForKey:LOGINUSERSESSION])
    {
        loginuser->sessionKey = [Thread valueForKey:LOGINUSERSESSION];
    }else
    {
        loginuser->sessionKey = @"";
    }
    RJFTcpSocket  *socket =[RJFTcpSocket shareInitWithHost:ACCESSHOST
                                                      Port:ACCESSPORT
                                                  Delagate:nil
                                                       tag:LOGINSOCKETTAG];
    
    BasisZipAndUnzip  *objShare = [[BasisZipAndUnzip alloc] initWithSize:500];
    [socket SendCharMessage:[objShare syncWithRequest:REQ_LOGIN
                                               userID:objUser.userIDForDzpk
                                          structArray:loginuser]
                       size:[objShare dataSize]];
   
    
    
    logMyLogInfo(@"usertype:%d imsi:%@ token:%@ sesssion:%@ mac:%@ heightandwidth:%@ model:%@ systemversion:%@",loginuser->user_type,loginuser->imsi,loginuser->userUUID,loginuser->sessionKey,loginuser->macAddress,loginuser->HeighthAndWidth,loginuser->model,loginuser->system_version);
    free(loginuser);
    loginuser = NULL;
    [objShare release];
    objShare = nil;

 
}


-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
#if MODEFOR91
    UIInterfaceOrientation   ori = [[UIDevice currentDevice] orientation];
    if(ori == UIInterfaceOrientationLandscapeLeft)
    {
        [[NdComPlatform defaultPlatform] NdSetScreenOrientation:UIInterfaceOrientationLandscapeLeft];
    }else if (ori == UIInterfaceOrientationLandscapeRight)
    {
        [[NdComPlatform defaultPlatform] NdSetScreenOrientation:UIInterfaceOrientationLandscapeRight];
    }else
    {
        [[NdComPlatform defaultPlatform] NdSetScreenOrientation:UIInterfaceOrientationLandscapeLeft];
    }
#endif
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationLandscapeRight;
}
#pragma mark QQLogin delegate
/**
 * Called when the user successfully logged in.
 */
- (void)tencentDidLogin:(NSDictionary *)dicInfo;
{

    TencentOAuth  *tencent = [TencentOAuth ShareInstance:self];
  
  //  NSData   *data = UIImagePNGRepresentation([UIImage imageNamed:@"logo.png"]);
  //  NSData  *data = UIImagePNGRepresentation([UIImage imageNamed:@"title_btn.png"]);
    [self loginToDZPKServer:[NSDictionary dictionaryWithObjectsAndKeys:@(1),LOGINUSERTYPE,tencent.openId,LOGINUSERUUID,tencent.accessToken,LOGINUSERSESSION,nil]];
    //[tencent addMessageWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"yiyiti",@"content", nil]];
   // [tencent addMessageAndPicWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"火啊",@"content",data,@"pic",nil]];
    logMyLogInfo(@"-----------------------login suc ro0tInfo:%@---------------------------",dicInfo);
	// 登录成功
}
/**
 * Called when the user dismissed the dialog without logging in.
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
	if (cancelled)
    {
        logMyLogInfo(@"用户取消登录");
	}
	else {
		logMyLogInfo(@"登录失败");
	}
	
}
/**
 * Called when the notNewWork.
 */
-(void)tencentDidNotNetWork
{
    [self netWorkError:nil];
    logMyLogInfo(@"无网络连接，请设置网络");
}
/**
 * Called when the get_user_info has response.
 */
- (void)getUserInfoResponse:(APIResponse*) response
{
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		
		NSMutableString *str=[NSMutableString stringWithFormat:@""];
		for (id key in response.jsonResponse)
        {
			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
		}
        
        [m_UserdicInfo setObject:@(1) forKey:LOGINUSERTYPE];
        if ([response.jsonResponse valueForKey:@"nickname"])
        {
            [m_UserdicInfo setObject:[response.jsonResponse valueForKey:@"nickname"] forKey:LOGINUSERNICKNAME];
        }
        NSString   *strSex = NSLocalizedString(@"男", nil);
        if ([response.jsonResponse valueForKey:@"gender"])
        {
            if ([response.jsonResponse valueForKey:@"gender"])
            {
                
            }
        }
        [m_UserdicInfo setObject:strSex forKey:LOGINUSERSEX];
        
        NSString *strFileName = [NSString stringWithFormat:@"%@123456789012345678901234567890",[m_UserdicInfo valueForKey:LOGINUSERUUID]];
        NSData  *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[response.jsonResponse valueForKey:@"figureurl_2"]]];
        [m_UserdicInfo setObject:strFileName forKey:LOGINUSERPORTRAIT];
        [m_UserdicInfo setObject:strSex forKey:LOGINUSERSEX];
        [RJFUpAndDown WriteToLocal:[NSDictionary dictionaryWithObjectsAndKeys:data,@"DATA",strFileName,@"FILENAME",nil]];
        [data release];
      //  [m_UserdicInfo addEntriesFromDictionary:response.jsonResponse];
        NSLog(@"str:%@",str);
        [self LoginToResourceServer:nil];

	}else
    {
        
	}
	
}

/**
 * Called when the add_share has response.
 */
- (void)addShareResponse:(APIResponse*) response
{
#if 0
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		
		
		NSMutableString *str=[NSMutableString stringWithFormat:@""];
		for (id key in response.jsonResponse) {
			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
		}
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"%@",str]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles:nil];
		[alert show];
		
		
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%@", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
	
	_labelAddShare.text=@"分享完成";
#endif
	
}
/**
 * Called when the uploadPic has response.
 */
- (void)uploadPicResponse:(APIResponse*) response
{
#if 0
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		
		
		NSMutableString *str=[NSMutableString stringWithFormat:@""];
		for (id key in response.jsonResponse) {
			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
		}
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"%@",str]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
		
		
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%@", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
	_uploadPicButton.enabled = YES;
	_labelUploadPic.text=@"操作完成";
#endif
	
}
/**
 * Called when the getListAlbum has response.
 */
-(void)getListAlbumResponse:(APIResponse*) response
{
#if 0
	NSMutableString *str=[NSMutableString stringWithFormat:@""];
	for (id key in response.jsonResponse) {
		[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
	}
	
	
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[[NSString stringWithFormat:@"%@",str] decodeUnicode]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
	
	_labellistalbum.text=@"获取相册列表完成";
#endif
}
/**
 * Called when the getListPhoto has response.
 */
-(void)getListPhotoResponse:(APIResponse*) response {
	NSMutableString *str=[NSMutableString stringWithFormat:@""];
	for (id key in response.jsonResponse) {
		[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
	}
	
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[[NSString stringWithFormat:@"%@",str] decodeUnicode]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
        [alert release];
		
		
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%@", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
        [alert release];
	}
	
	//_labellistphoto.text=@"获取照片列表完成";
	
}
/**
 * Called when the addTopic has response.
 */
-(void)addTopicResponse:(APIResponse*) response
{
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		
		
		NSMutableString *str=[NSMutableString stringWithFormat:@""];
		for (id key in response.jsonResponse) {
			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
		}
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"%@",str]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
        [alert release];
		
		
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%@", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
        [alert release];
	}
    	
	//_labeltopic.text=@"发表说说完成";
	
}

/**
 * Called when the checkPageFans has response.
 */
-(void)checkPageFansResponse:(APIResponse*) response
{
#if 0
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		
		
		NSMutableString *str=[NSMutableString stringWithFormat:@""];
		for (id key in response.jsonResponse) {
			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
		}
		if ([[NSString stringWithFormat:@"%@",[response.jsonResponse objectForKey:@"isfans"]] isEqualToString:@"1"]) {
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您是冷兔的粉丝" message:[NSString stringWithFormat:@"%@",str]
								  
														   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
			[alert show];
			
			_labelcheckfans.text=@"您是冷兔的粉丝";
			
		}
		else {
			
			
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您不是冷兔的粉丝" message:[NSString stringWithFormat:@"%@",str]
								  
														   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
			[alert show];
			_labelcheckfans.text=@"您不是冷兔的粉丝";
		}
		
		
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%@", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
#endif
	
}
/**
 * Called when the addAlbum has response.
 */


- (void)addAlbumResponse:(APIResponse*) response
{
#if 0
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		
		
		NSMutableString *str=[NSMutableString stringWithFormat:@""];
		for (id key in response.jsonResponse) {
			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
		}
		_labeladdalbum.text=[NSString stringWithFormat:@"%@",[response.jsonResponse objectForKey:@"albumid"]];
		
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"%@",str]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
		
		_listphotoButton.enabled=YES;
		_uploadPicButton.enabled = YES;
		
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%@", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
#endif
	
}

/**
 * Called when the addOneBlog has response.
 */
- (void)addOneBlogResponse:(APIResponse*) response
{
#if 0
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		
		
		NSMutableString *str=[NSMutableString stringWithFormat:@""];
		for (id key in response.jsonResponse) {
			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
		}
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"%@",str]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
		
		
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%@", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
	
	_labeladdblog.text=@"发表日志完成";
#endif
}






#pragma mark sinawinbo delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    
   
   
    [self loginToDZPKServer:[NSDictionary dictionaryWithObjectsAndKeys:@(2),LOGINUSERTYPE,sinaweibo.userID,LOGINUSERUUID,sinaweibo.accessToken,LOGINUSERSESSION,nil]];
   // [sinaweibo PublicWeiBoMessage:@"哈哈，我登陆了德州扑克"];
  //  NSData   *data = UIImagePNGRepresentation([UIImage imageNamed:@"logo.png"]);
 //   [sinaweibo PublicWeiBoMessage:@"xiaodi！" withImage:data];
    NSLog(@"sinaweibo login in:%@",sinaweibo);
}
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
     NSLog(@"sinaweibo login out:%@",sinaweibo);
}
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
     NSLog(@"sinaweibo loginCancel:%@",sinaweibo);
}
- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
     [self netWorkError:nil];
     NSLog(@"sinaweibo loginfail:%@",sinaweibo);  
}
- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
      NSLog(@"sinaweibo accessToken invalid or expired:%@",sinaweibo);
    
}



// 1  is login 
- (void)sinaweiboDataResponse:(id)result withErrorInfo:(NSError *)error withRequesttype:(NSInteger)type
{
    if (type != 1)
    {
        return;
    }
    if (error != nil)
    {
        logMyLogInfo(@"getUserInfo error:%@",error);
        
    }else
    {
        
        
        [m_UserdicInfo setObject:@(2) forKey:LOGINUSERTYPE];
        [m_UserdicInfo setObject:[result valueForKey:@"screen_name"] forKey:LOGINUSERNICKNAME];
         NSString   *strSex = [result valueForKey:@"gender"];
        if (strSex)
        {
            if ([strSex isEqualToString:@"m"])
            {
                strSex = NSLocalizedString(@"男", nil);
                
            }else
                strSex = NSLocalizedString(@"女", nil);
            
        }
        
        NSString *strFileName = [NSString stringWithFormat:@"%@123456789012345678901234567890",[m_UserdicInfo valueForKey:LOGINUSERUUID]];
        NSData  *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[result valueForKey:@"avatar_large"]]];
        [m_UserdicInfo setObject:strFileName forKey:LOGINUSERPORTRAIT];
        [m_UserdicInfo setObject:strSex forKey:LOGINUSERSEX];
        [RJFUpAndDown WriteToLocal:[NSDictionary dictionaryWithObjectsAndKeys:data,@"DATA",strFileName,@"FILENAME",nil]];
        [data release];
     
        
       // [m_UserdicInfo addEntriesFromDictionary:result];
        [self LoginToResourceServer:nil];
    }
   
    
    logMyLogInfo(@"sina userInfo:\n---------------%@",result);
}


-(void)LoginToResourceServer:(id)Thtread
{
    RJFTcpSocket  *socket2 = [RJFTcpSocket shareInitWithHost:[m_UserdicInfo valueForKey:@"SERVERIP"]
                                                        Port:[[m_UserdicInfo valueForKey:@"SERVERPORT"] intValue]
                                                    Delagate:nil
                                                         tag:RESOURCESOCKEtTAG];
    
    
    
    DZPK_CLIENT_REQ_LOGIN_RESOURCES  resource = {[m_UserdicInfo valueForKey:@"LOGINKEYFORSERVER"]};
    
    // NSLog(@"key:%@ IP:%@",info->key,info->IP);
    UserInfo  *objUser = [UserInfo shareInstance];
    
    BasisZipAndUnzip  *objShare = [[BasisZipAndUnzip alloc] initWithSize:200];
    [socket2 SendCharMessage:[objShare syncWithRequest:REQ_LOGIN_RESOURCES
                                                userID:objUser.userIDForDzpk
                                           structArray:&resource]
                        size:[objShare dataSize]];
    [objShare release];
    objShare = nil;
    
    
}

-(void)netWorkError:(id)Thread
{
    [RJFWarnView addinSelfview:self.view
                      delegate:nil
                       message:NSLocalizedString(@"提示\n\n\n网络连接出现错误，请检查您的网络设置!", nil)
                    buttontype:INSUREBUTTON
                  InsureButton:INSURE
                  CancelButton:nil];
}



#pragma mark  91APPUpdate
#if MODEFOR91
- (void)appVersionUpdateDidFinish:(ND_APP_UPDATE_RESULT)updateResult
{
    NSString *title = nil;
    NSLog(@"update result:%d", updateResult);
    switch (updateResult)
    {
        case ND_APP_UPDATE_NO_NEW_VERSION:
            //title = NSLocalizedString(@"提示\n\n\n无可用更新", nil);
            break;
        case ND_APP_UPDATE_FORCE_UPDATE_CANCEL_BY_USER:
            title = NSLocalizedString(@"提示\n\n\n下载强制更新被取消,不能登录游戏服务器", nil);
            break;
        case ND_APP_UPDATE_NORMAL_UPDATE_CANCEL_BY_USER:
            // title = NSLocalizedString(@"提示\n\n\n下载普通更新被取消", nil);
            break;
        case ND_APP_UPDATE_NEW_VERSION_DOWNLOAD_FAIL:
            //title = NSLocalizedString(@"提示\n\n\n下载新版本失败", nil);
            break;
        case ND_APP_UPDATE_CHECK_NEW_VERSION_FAIL:
            //title = NSLocalizedString(@"提示\n\n\n检测新版本信息失败", nil);
            break;
        default:
            
            break;
    }
    [m_UserdicInfo setObject:@(updateResult) forKey:@"UPDATESTATUS"];
    //无可用更新程序继续,其他情况demo暂不做特殊处理
    if (updateResult == ND_APP_UPDATE_NO_NEW_VERSION)
    {
        //开始登录以及应用相关的操作 }
        
    }else
    {
        if (title != nil)
        {
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:title
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
            
        }
        //相应的错误提示和程序处理。 建议:如果下载或者检测新版本失败,当作无可用更新处理。
    }
    UserInfo  *objUser = [UserInfo shareInstance];
    objUser.hasCheckVersion = YES;
}

-(void)user91HasLogin:(NSNotification *)notify
{
    logMyLogInfo(@"91 note:%@",notify);
    NSDictionary *dict = [notify userInfo];
    BOOL success = [[dict objectForKey:@"result"] boolValue];
    NdGuestAccountStatus* guestStatus = (NdGuestAccountStatus*)[dict
                                                                objectForKey:@"NdGuestAccountStatus"]; //登录成功后处理
    if([[NdComPlatform defaultPlatform] isLogined] && success)
    { //也可以通过[[NdComPlatform defaultPlatform] getCurrentLoginState]判断是否游客登录状态
        if (guestStatus)
        {
            if ([guestStatus isGuestLogined])
            {
                //游客账号登录成功;
            }
            else if ([guestStatus isGuestRegistered])
            {
            }
        }
        else
        {
            NdComPlatform     *info = [NdComPlatform defaultPlatform];
            NdMyUserInfo     *userInfo = [info NdGetMyInfo];
            NdMyBaseInfo      *baseinfo = userInfo.baseInfo;
            
            [m_UserdicInfo setObject:info.loginUin forKey:@"uin"];
            [m_UserdicInfo setObject:info.nickName forKey:@"nickname"];
            [m_UserdicInfo setObject:baseinfo.checkSum forKey:@"checksum"];
            [self loginToDZPKServer:[NSDictionary dictionaryWithObjectsAndKeys:@(3),LOGINUSERTYPE,info.loginUin,LOGINUSERUUID,info.sessionId,LOGINUSERSESSION,nil]];
            //普通账号登录成功!
            logMyLogInfo(@"uin:%@ sessionID:%@ nickNmae:%@ myinfo:%@ infoDetail:%d",info.loginUin,info.sessionId,info.nickName,info.NdGetMyInfo,[info NdGetMyInfoDetail:self]);
        }
    }else
    {
        //登录失败处理和相应提示
        int error = [[dict objectForKey:@"error"] intValue];
        NSString* strTip = [NSString stringWithFormat:@"登录失败, error=%d",
                            error];
        switch (error)
        {
            case ND_COM_PLATFORM_ERROR_USER_CANCEL://用户取消登录
                if (([[NdComPlatform defaultPlatform] getCurrentLoginState] ==
                     ND_LOGIN_STATE_GUEST_LOGIN))
                {
                    strTip = @"当前仍处于游客登录状态";
                } else
                {
                    strTip = @"用户未登录";
                }
                break;
            case ND_COM_PLATFORM_ERROR_APP_KEY_INVALID://appId未授权接入, 或appKey 无效
                strTip = @"登录失败, 请检查appId/appKey";
                break;
                
            case ND_COM_PLATFORM_ERROR_CLIENT_APP_ID_INVALID://无效的应用ID
                strTip = @"登录失败, 无效的应用ID";
                break;
            case ND_COM_PLATFORM_ERROR_HAS_ASSOCIATE_91: strTip = @"有关联的91账号,不能以游客方式登录";
                break;
            default:
                break;
                //其他类型的错误提示 break;
        }
        logMyLogInfo(@"strTip error:%@",strTip);
        
        
    }
    
}
- (void)getUserInfoDidFinish:(int)error userInfo:(NdUserInfo *)userInfo
{
 
    [m_UserdicInfo setObject:userInfo.nickName forKey:LOGINUSERNICKNAME];
    if (userInfo.sex == 1)
    {
        [m_UserdicInfo setObject:NSLocalizedString(@"男", nil) forKey:LOGINUSERSEX];
    }else
    {
        [m_UserdicInfo setObject:NSLocalizedString(@"女", nil) forKey:LOGINUSERSEX];
    }
    logMyLogInfo(@"error:%d userInfo:%@",error,userInfo);
}
/**
 @brief NdGetPortrait 和 NdGetPortraitEx的回调
 @param error 错误码，如果error为0，则代表API执行成功，否则失败。错误码涵义请查看NdComPlatformError文件
 @param uin 获取头像对应用户的uin
 @param portrait 获取到的头像
 @param checkSum 获取到的头像的checkSum
 */
//NdComPlatformError
- (void)getPortraitDidFinish:(int)error uin:(NSString *)uin portrait:(UIImage *)portrait checkSum:(NSString *)checkSum
{
    logMyLogInfo(@"error:%d uin:%@ portrait:%@ checkm:%@",error,uin,portrait,checkSum);
    [m_UserdicInfo setObject:@(3) forKey:LOGINUSERTYPE];    
    //+(void)WriteToLocal:(NSDictionary *)dicInfo
    
    NSString *strFileName = [NSString stringWithFormat:@"%@1234567890123456789012345678901234567890",[m_UserdicInfo valueForKey:LOGINUSERUUID]];
    [m_UserdicInfo setObject:strFileName forKey:LOGINUSERPORTRAIT];
    [RJFUpAndDown WriteToLocal:[NSDictionary dictionaryWithObjectsAndKeys:UIImagePNGRepresentation(portrait),@"DATA",strFileName,@"FILENAME",nil]];
    
    // NSLog(@"key:%@ IP:%@",info->key,info->IP);
     [self LoginToResourceServer:nil];
}
#endif


#pragma mark   downjoy delegate
#if MODEFORDOWNJOY
-(void)downJoyGetFirstInfo:(id)Thread
{
    Downjoy  *shareObj =[Downjoy shareInstance];
    shareObj.delegate = (id)self;
    DownjoyMemberInfoResult  *infoResult = [shareObj downjoyReadMemberInfo];
    NSString *strFileName = [NSString stringWithFormat:@"%@1234567890123456789012345678901234",infoResult.memberId];
    [m_UserdicInfo setObject:strFileName forKey:LOGINUSERPORTRAIT];
    NSData  *data = [[NSData  alloc] initWithContentsOfURL:[NSURL URLWithString:infoResult.avatarUrl]];
    [RJFUpAndDown WriteToLocal:[NSDictionary dictionaryWithObjectsAndKeys:data,@"DATA",strFileName,@"FILENAME",nil]];
    [data release];
    if (infoResult)
    {
        [m_UserdicInfo setObject:NSLocalizedString(infoResult.gender, nil) forKey:LOGINUSERSEX];
        [m_UserdicInfo setObject:infoResult.username forKey:LOGINUSERNICKNAME];
    }
    [self LoginToResourceServer:nil];
    
}
//登陆成功
-(void) loginSuccess : (DownjoyLoginResult *) loginResult
{
   // Downjoy  *shareObj = [Downjoy shareInstance];
    [self dismissModalViewControllerAnimated:YES];

    [self loginToDZPKServer:[NSDictionary dictionaryWithObjectsAndKeys:@(6),LOGINUSERTYPE,loginResult.memberId,LOGINUSERUUID,loginResult.token,LOGINUSERSESSION,nil]];
    NSLog(@"loginResult:%@ ",loginResult);
}
//登陆出错或取消
-(void) loginError : (DownjoyLoginResult *) loginResult
{
    [self dismissModalViewControllerAnimated:YES];
     NSLog(@"loginResult:%@ ",loginResult);
}
#endif


@end
