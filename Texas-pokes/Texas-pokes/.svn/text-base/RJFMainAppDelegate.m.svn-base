//
//  RJFMainAppDelegate.m
//  Texas-pokes
//
//  Created by popo on 12-6-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFMainAppDelegate.h"

#import "RJFMainViewController.h"
#import "PushManager.h"
//#import "AlixPay.h"
//#import "AlixPayResult.h"
//#import "DataVerifier.h"
#import <sys/utsname.h>
#import "MyStoreObserver.h"
#import "RJFMainViewController.h"
#import "Reachability.h"







#ifndef LOGIN_INFO_USER_91
#define LOGIN_INFO_USER_91
#pragma mark  - 91Login
#define Login91AppKey       105378
#define Login91KeySecret    @"e7cbac24d2fcfde82a4ebaa645eb0d7cd77cdb88bd5a02b4"
#define Login91KeyURL       @"http://www.o-popo.com"
#endif


#ifndef DOWN_JOY_LOGIN_INFO
#define DOWN_JOY_LOGIN_INFO
#pragma mark  - DownJoyLogin
#define DownJoyAppKey       @"310"
#define DownJoyKeySecret    @"GiZWueFb"
#define DownJoyKeyURL       @"http://www.o-popo.com"
#endif


void UncaughtExceptionHandler(NSException *exception);

NSString* const  BNRDISCONNECTSERVER = @"BNRDISCONNECTSERVER";
NSString *const   BNRRESULTFROMALIPAY =  @"BNRRESULTFROMALIPAY";
NSString *const   BNRUPDATUSERINFO =  @"BNRUPDATUSERINFO";

extern NSString    *BNRSTARTRESOURCEHEARTPACK;



void UncaughtExceptionHandler(NSException *exception)
{
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    //NSString *  locationString=[dateformatter stringFromDate:senddate];
    [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    NSString *  morelocationString=[dateformatter stringFromDate:senddate];
    
    
    NSDate  * oldDate=[dateformatter dateFromString:morelocationString];
    NSTimeInterval  timeZoneOffset=[[NSTimeZone systemTimeZone] secondsFromGMT];
    NSDate  * newDate=[oldDate dateByAddingTimeInterval:timeZoneOffset];
    [dateformatter release];
    
    
    
    NSString  *strFileName = @"log0.txt";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    strFileName = [documentsDirectory stringByAppendingPathComponent:strFileName];
    
    NSString    *strTemp = nil;
    NSFileManager  *fileManger = [NSFileManager defaultManager];
    BOOL  bNotHasLogFile = NO;
   
    int i = 0;
    do {
        
        
        if (![fileManger fileExistsAtPath:strFileName])
        {
            bNotHasLogFile = YES;
          
        }else
        {
            
            strFileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"log%d.txt",i]];
            i++;
            bNotHasLogFile = NO;
            
            
        }
    } while (!bNotHasLogFile);
    
    strTemp = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"log%d.txt",i-2]];
    
    NSError  *error = nil;
    NSString  *strContent = [NSString stringWithContentsOfFile:strTemp encoding:NSUTF8StringEncoding error:&error];
    
    //NSLog(@"strTemp:%@ strContent:%@ error:%@",strTemp,strContent,error);
    if ([strContent length] > 100000)
    {
        strContent = [strContent substringFromIndex:[strContent length]-100000];
    }
    
	NSArray *arr = [exception callStackSymbols];
	NSString *reason = [exception reason];
	NSString *name = [exception name];
	
	NSString *urlStr = [NSString stringWithFormat:@"mailto://a20251313@163.com?subject=bug报告&body=感谢您的配合!<br><br><br>"
						"错误发生时间<br>:%@ 错误详情:<br>%@<br>--------------------------<br>%@<br>---------------------<br>%@<br>-----------------<br><br>错误日志<br>%@",
						newDate,name,reason,[arr componentsJoinedByString:@"<br>"],strContent];
	
	NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[[UIApplication sharedApplication] openURL:url];
}




@implementation RJFMainAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}


- (void)scheduleAlarmForDate:(NSDate*)theDate

{
    
    UIApplication* app = [UIApplication sharedApplication];
    
    NSArray*    oldNotifications = [app scheduledLocalNotifications];
    
    
    
    // Clear out the old notification before scheduling a new one.
    
    if ([oldNotifications count] > 0)
        
        [app cancelAllLocalNotifications];
    
    
    
    // Create a new notification.
    
    UILocalNotification* alarm = [[UILocalNotification alloc] init];
    
    if (alarm)
        
    {
        
        alarm.fireDate = theDate;
        
        alarm.timeZone = [NSTimeZone defaultTimeZone];
        
        alarm.repeatInterval = 0;
        
        alarm.soundName = @"alarm_active.mp3";
        
        alarm.alertBody = @"Time to wake up!";
        
        
        
        [app scheduleLocalNotification:alarm];
        [alarm release];
        
    }
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //NSLog(@"HostName:%@",getHostname());
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[RJFMainViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
   // [self scheduleAlarmForDate:[NSDate dateWithTimeInterval:5 sinceDate:[NSDate date]]];

    UINavigationController  *nav = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)
    {
        self.window.rootViewController = nav;
    }
    else
    {
        [self.window addSubview:nav.view];
    }

    


    nav.navigationBar.hidden = YES;
    [self.window makeKeyAndVisible];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(disconnectManually:)
                                                 name:BNRDISCONNECTSERVER
                                               object:nil];
    
#if MODEFORDOWNJOY
    UIView   *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    backView.backgroundColor = [UIColor whiteColor];
    UIImageView  *DownjoyLogoView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH-316)/2, (SCREENHEIGHT-80)/2, 316, 80)];
    DownjoyLogoView.image = [UIImage imageNamed:@"downjoy_logo.png"];
    DownjoyLogoView.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2-20);
    [backView addSubview:DownjoyLogoView];
    [DownjoyLogoView release];
        
    [self.viewController.view addSubview:backView];
    [self.viewController.view bringSubviewToFront:backView];
    [backView performSelector:@selector(removeFromSuperview)
                   withObject:nil
                   afterDelay:2];
    [backView release];
#endif
   
    
#if DEBUG
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
#endif
    
    //alipay
    if ([self isSingleTask])
    {
		NSURL *url = [launchOptions objectForKey:@"UIApplicationLaunchOptionsURLKey"];
		if (nil != url)
        {
#if 0
			[self parseURL:url application:application];
#endif
		}
	}
    
#if MODEFOR91
    //hyman021 z123456
    //..开发者这应该在程序启动的时候优先设置向开发者后台申请的 AppId 和 AppKey
#if DEBUG
    [[NdComPlatform defaultPlatform] NdSetDebugMode:0];
#endif
    [[NdComPlatform defaultPlatform] setAppId:Login91AppKey];
    [[NdComPlatform defaultPlatform] setAppKey:Login91KeySecret];
    [[NdComPlatform defaultPlatform] NdSetAutoRotation:YES];
    [[NdComPlatform defaultPlatform] NdAppVersionUpdate:0 delegate:self];
#elif MODEFORDOWNJOY
    Downjoy  *shareObj = [Downjoy shareInstance];
    shareObj.appId = DownJoyAppKey;
    shareObj.appKey = DownJoyKeySecret;
    
#endif
    
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    application.applicationIconBadgeNumber = 0;
    //判断程序是不是由推送服务完成的
    if (launchOptions)
    {
        NSDictionary* pushNotificationKey = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (pushNotificationKey)
        {
            application.applicationIconBadgeNumber = 0;
        }
        
        logMyLogInfo(@"pushNotificationKey:%@",pushNotificationKey);
    }
    [self performSelector:@selector(checkNetObBackground:)];
    
    
   //NSString *strUUID =  [[NSProcessInfo processInfo] globallyUniqueString];
  //  [self scheduleAlarmForDate:[NSDate dateWithTimeInterval:10 sinceDate:[NSDate date]]];
    return YES;
}

-(void)checkNetObBackground:(id)Thread
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    [self checkNetWorkStatus:nil];
    objUser = [UserInfo shareInstance];
    NSNotificationCenter   *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(ReceiveStartResouceTimerNoti:)
               name:BNRSTARTRESOURCEHEARTPACK
             object:nil];
    [nc addObserver:self
           selector:@selector(ReceiveSyncInfo:)
               name:BNRRECEIVEMESSAGEFROMSERVER
             object:nil];
    
    
    MyStoreObserver  *mystore = [[MyStoreObserver alloc] init];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:mystore];
    
}
-(void)ReceiveStartResouceTimerNoti:(NSNotification*)note
{
    if (m_timerResource)
    {
        return;
        [m_timerResource invalidate];
        [m_timerResource release];
        m_timerResource = nil;
    }
    
    
    
    m_timerResource = [[NSTimer alloc] initWithFireDate:[NSDate date]
                                               interval:120
                                                 target:self
                                               selector:@selector(StartResourceHeart:)
                                               userInfo:nil
                                                repeats:YES];    
    [[NSRunLoop currentRunLoop] addTimer:m_timerResource forMode:NSDefaultRunLoopMode];
    
}




-(void)disconnectManually:(id)Thread
{
    
    logMyLogInfo(@"Thread:%@",Thread);
  [RJFWarnView addinSelfview:self.viewController.navigationController.view
                      delegate:self
                       message:@"\n提示\n您与服务器的连接断开，请重新登录！"
                    buttontype:INSUREBUTTON
                  InsureButton:NSLocalizedString(@"返回登录", nil)
                  CancelButton:nil];
    [self disConnectAndBack:nil];
    HideHUD(self.viewController.navigationController, YES);
    [objUser setGamedate:nil];
    
}


-(void)StartResourceHeart:(id)Timer
{
    BasisZipAndUnzip  *objBasic = [[BasisZipAndUnzip alloc] initWithSize:40];
    
    RJFTcpSocket  *sockResource = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    [sockResource SendCharMessage:[objBasic syncWithRequest:REQ_SYNC_SIGNAL_RESOURCE
                                                     userID:objUser.userIDForDzpk
                                                structArray:NULL]
                             size:[objBasic dataSize]];
    [objBasic release];
    logMyLogInfo(@"________________send resource heart____________________");
    //  NSLog(@"resourceHeart beat");
    
}




-(void)ReceiveSyncInfo:(NSNotification*)note
{
    RJFTcpSocket  *m_socket = [note object];
    NSDictionary  *dicInfo = [note userInfo];
    if (dicInfo &&(m_socket.tag == RESOURCESOCKEtTAG  || m_socket.tag == GAMESOCKETTAG) )
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
    requestCode = [BasisZipAndUnzip unbyte_to_int16:byte pos:pos];
    logMyLogInfo(@"Appdelegate,requestCode:%d",requestCode);
    
    
    
    if (requestCode == REQ_SYNC_SIGNAL_RESOURCE)
    {  //logMyLogInfo(@"ResourceHeart beat");
        handle =[objShare PhaseInfoFromData:(int8_t *)[data bytes]
                                     
                             outRequestCode:&requestCode];
        DZPK_SERVER_REQ_SYNC_SIGNAL_RESOURCE  *info = (DZPK_SERVER_REQ_SYNC_SIGNAL_RESOURCE*)handle;
        if (info->status)
        {
            //fail
            NSLog(@"resource heartFail! time:%@",[NSDate date]);
            //[self StartResourceHeart:nil];
        }else
        {
            //success
            objUser.onlineCount = info->onlineCount;
            logMyLogInfo(@"-------------------resourceHeart suc,onlineCount:%ld---------------------\n\n",objUser.onlineCount);
        }
    }else if (requestCode == REQ_READ_CHARGE_RESULT)
    {
        handle =[objShare PhaseInfoFromData:(int8_t *)[data bytes]
                                     
                             outRequestCode:&requestCode];
        DZPK_SERVER_REQ_CHARGE_RESULT  *info = (DZPK_SERVER_REQ_CHARGE_RESULT*)handle;
        if (info->status)
        {
            logMyLogInfo(@"chare fail");
        }else
        {
            UserInfo  *objShareUser = [UserInfo shareInstance];
            objShareUser.idou = info->moneySum*1.0f/100.0f;
        }
    }else if (requestCode == REQ_OFFLINE)
    {
        handle =[objShare PhaseInfoFromData:(int8_t *)[data bytes]
                                     
                             outRequestCode:&requestCode];
        DZPK_SERVER_REQ_OFFLINE  *info = (DZPK_SERVER_REQ_OFFLINE*)handle;
        if (info->status == 1)
        {
            logMyLogInfo(@"\n此账号已在另外一个地方登录!\n请重新登录！  timer:%@",[NSDate date]);
            [RJFWarnView addinSelfview:self.viewController.navigationController.view
                              delegate:self
                               message:@"\n此账号已在另外一个地方登录!\n请重新登录！"
                            buttontype:INSUREBUTTON
                          InsureButton:NSLocalizedString(@"返回登录", nil)
                          CancelButton:nil];
            
            HideHUD(self.viewController.navigationController, YES);
            [self disConnectAndBack:nil];
            [objUser setGamedate:nil];
            
        }
    }else if(requestCode == REQ_RECV_NEW_MSG)
    {
        handle =[objShare PhaseInfoFromData:(int8_t *)[data bytes]
                                     
                             outRequestCode:&requestCode];
        DZPK_SERVER_REQ_RECV_NEW_MSG  *info = (DZPK_SERVER_REQ_RECV_NEW_MSG*)handle;
        if (info->new_msg_number > 0)
        {
            UserInfo  *shareUser = [UserInfo shareInstance];
            shareUser.msgCount += info->new_msg_number;
        }
    }else if (requestCode == REQ_PERSON_DATA)
    {
        handle =[objShare PhaseInfoFromData:(int8_t *)[data bytes]       
                             outRequestCode:&requestCode];
        [self dealNotiForproREQ_PERSON_DATA:requestCode handle:handle];
    }else if (requestCode == REQ_REALTIME_INFOR)
    {
        handle = [objShare PhaseInfoFromData:(int8_t*)[data bytes]       
                              outRequestCode:&requestCode];
        [self dealNotiForproREQ_REALTIME_INFOR:requestCode handle:handle];
    }
    free(handle);
    handle = NULL;
    [objShare release];
    objShare = nil;
    
}


-(void)dealNotiForproREQ_REALTIME_INFOR:(int32_t)requestCode  handle:(void*)handle
{
    DZPK_SERVER_REQ_REALTIME_INFOR   *info = handle;
    
    logMyLogInfo(@"status:%d  desc:%@",info->status,info->descprition);
    ShowMsgInTopView(info->descprition, 5, self.viewController);
    
  //  [self.];
    
}


#pragma mark alipay

- (BOOL)isSingleTask{
	struct utsname name;
	uname(&name);
	float version = [[UIDevice currentDevice].systemVersion floatValue];//判定系统版本。
	if (version < 4.0 || strstr(name.machine, "iPod1,1") != 0 || strstr(name.machine, "iPod2,1") != 0)
    {
		return YES;
	}
	else {
		return NO;
	}
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    logMyLogInfo(@"url:%@ sourceApplication:%@ annotation:%@",url,sourceApplication,annotation);
    if ([[url description] rangeOfString:@"sinaweibosso"].location
        != NSNotFound)
    {
        return [[SinaWeibo shareInstance:nil] handleOpenURL:url];
    }else
    {
        return YES;
    }
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    logMyLogInfo(@"url:%@",url);
    if ([[url description] rangeOfString:@"sinaweibosso"].location
        != NSNotFound)
    {
        return [[SinaWeibo shareInstance:nil] handleOpenURL:url];
    }else if([[url description] rangeOfString:@"tencent"].location != NSNotFound)
    {
        return [[SinaWeibo shareInstance:nil] handleOpenURL:url];
    }
    
#if 0
	[self parseURL:url application:application];
#endif
	return YES;
}

#if 0
- (void)parseURL:(NSURL *)url application:(UIApplication *)application
{
	AlixPay *alixpay = [AlixPay shared];
	AlixPayResult *result = [alixpay handleOpenURL:url];
	if (result)
    {
        
        NSNotificationCenter  *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:BNRRESULTFROMALIPAY object:self userInfo:[NSDictionary dictionaryWithObject:result forKey:@"RESULT"]];
        
        
	}
}
#endif

- (void)applicationWillResignActive:(UIApplication *)application
{
    /**[[NSUserDefaults standardUserDefaults] setObject:[UserInfo shareInstance] forKey:@"1234"];
     [[NSUserDefaults standardUserDefaults] synchronize];*/
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:VIEWENTERBGTIME];
    logMyLogInfo(@"bg time remain:%f",[[UIApplication sharedApplication] backgroundTimeRemaining]);
    
    [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^
    {
        HideHUD(self.viewController.navigationController, YES);
       // [self disConnectAndBack:nil];
        [objUser setGamedate:nil];
       // [self.viewController.navigationController popToRootViewControllerAnimated:YES];
        logMyLogInfo(@"\n\n\n\n\n\n\n\nsetKeepAliveTimeout:\n\n\n\\n\n\n\n\n\n\n\n\n");
        
    }];

    
    
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    [[UIApplication sharedApplication] clearKeepAliveTimeout];
    logMyLogInfo(@"bg time remain:%f",[[UIApplication sharedApplication] backgroundTimeRemaining]);
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    UIAlertView  *av = [[UIAlertView alloc] initWithTitle:@"hello" message:@"sads" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"fou", nil];
    [av show];
    [av release];
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}



-(void)disConnectAndBack:(id)Thread
{
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:GAMESOCKETTAG];
    [socket disConnect];
    socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    BasisZipAndUnzip  *basic = [[BasisZipAndUnzip alloc] initWithSize:100];
    
    [socket SendCharMessage:[basic syncWithRequest:REQ_OFFLINE
                                            userID:objUser.userIDForDzpk
                                       structArray:NULL]
                       size:[basic dataSize]];
    [basic release];
    basic = nil;
    [socket disConnect];
    objUser.userHasSitDown = NO;
    if (m_timerResource)
    {
        [m_timerResource invalidate];
        [m_timerResource release];
        m_timerResource = nil;
    }
    
    
    
}


- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window  NS_AVAILABLE_IOS(6_0)
{
    // UserInfo  *objUser = [UserInfo shareInstance];
    
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
    
    return objUser.userInterface;
    
}




//-(BOOL)shouldAutorotate
//{
//    return YES;
//}


-(void)dealNotiForproREQ_PERSON_DATA:(int32_t)requestCode  handle:(void*)handle
{
    
    
    
    DZPK_SERVER_REQ_PERSON_DATA  *info = (DZPK_SERVER_REQ_PERSON_DATA*)handle;
    if (info->status)
    {
        NSLog(@"getInfo fail");
    }else
    {
        logMyLogInfo(@"get userinfo+++++++++++++++++++ ");
        if (info->sex == 0)
        {
            [objUser.Sex setString:@"男"];
        }else
        {
            [objUser.Sex setString:@"女"];
        }
        objUser.msgCount = info->msg_count;
        if (info->nick != nil)
        {
            // [objUser.userName setString:info->nick];
        }
        if (info->head_pic_name != nil)
        {
            // [objUser.userImagePath setString:info->head_pic_name];
            
        }
        if (info->maxCards != NULL && info->maxcardNumber > 0 && info->maxcardNumber < 6)
        {
            objUser.MaxCard1 = info->maxCards[0];
            objUser.MaxCard2 = info->maxCards[1];
            objUser.MaxCard3 = info->maxCards[2];
            objUser.MaxCard4 = info->maxCards[3];
            objUser.MaxCard5 = info->maxCards[4];
            
            objUser.onlineCount = info->online_count;
            objUser.winTimes = info->win_number;
            objUser.loseTime = info->lose_number;
            objUser.idou = info->idou*1.0f/100.0f;
            objUser.maxOwn = info->max_own;
            objUser.MaxWinchips = info->max_win;
            objUser.userChips = info->chips;
            objUser.score = info->score;
            objUser.matchscore = info->match_score;
            objUser.task = info->task;
            NSLog(@"userchip:%d",info->chips);
        }
        free(info->maxCards);
        info->maxCards = NULL;
        [[NSNotificationCenter defaultCenter] postNotificationName:BNRUPDATUSERINFO
                                                            object:nil];
        
    }
    
}


-(void)checkNetWorkStatus:(id)Thread
{
    
    Reachability *r = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    BOOL     bNetWork = YES;
    switch ([r currentReachabilityStatus])
    {
        case ReachableViaWiFi:
            break;
        case ReachableViaWWAN:
            break;
            
        default:
            bNetWork = NO;
            break;
    }
    
    
    r.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^
        {
            
            ShowMsgInTopView(NSLocalizedString(@"当前网络状况差，请切换更好的网络接口", nil), 4, self.viewController);
        });
    };
    [r startNotifier];
    
    if (!bNetWork)
    {
        UIAlertView   *av = [[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"本游戏需要WIFI或者3G网络环境，当前没有可用网络可以选择，请更改您的网络设置！"
                                                      delegate:self
                                             cancelButtonTitle:nil
                                             otherButtonTitles:INSURE, nil];
        [av show];
        [av  release];
        
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
        // NSURL * url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
        //  [[UIApplication sharedApplication] openURL:url];
        exit(0);
    }
}
-(void)SetAllSubViewsButtonEnable:(UIView *)view bEnable:(BOOL)bIsenale
{
    for (UIView  *viewTemp in [view subviews])
    {
        
        logMyLogInfo(@"1............viewtemp:%@",viewTemp);
        if ([viewTemp isKindOfClass:[UIButton class]] || [viewTemp isKindOfClass:[UIImageView class]])
        {
            viewTemp.userInteractionEnabled = bIsenale;
        }
        if ([[viewTemp subviews] count])
        {
            [self SetAllSubViewsButtonEnable:viewTemp bEnable:bIsenale];
        }
        
    }
}

-(void)ClickCancel:(id)sender
{
    
}
-(void)ClickInsure:(id)sender
{
    
    if (![[self.viewController.navigationController topViewController] isEqual:self.viewController])
    {
        NSLog(@"topViewcontrol:%@",[self.viewController.navigationController topViewController]);
#if  MODEFORDOWNJOY
        [Downjoy shareRelease];
#endif
        [self.viewController.navigationController popToRootViewControllerAnimated:YES];
    }
    
    
}

#if MODEFOR91
- (void)appVersionUpdateDidFinish:(ND_APP_UPDATE_RESULT)updateResult
{
    NSString *title = nil;
    NSLog(@"update result:%d", updateResult);
    switch (updateResult)
    {
        case ND_APP_UPDATE_NO_NEW_VERSION:
         //   title = NSLocalizedString(@"提示\n\n\n无可用更新", nil);
            break;
        case ND_APP_UPDATE_FORCE_UPDATE_CANCEL_BY_USER:
            title = NSLocalizedString(@"提示\n\n\n您已经取消强制更新,不能登录游戏服务器", nil);
            break;
        case ND_APP_UPDATE_NORMAL_UPDATE_CANCEL_BY_USER:
            // title = NSLocalizedString(@"提示\n\n\n下载普通更新被取消", nil);
            break;
        case ND_APP_UPDATE_NEW_VERSION_DOWNLOAD_FAIL:
            title = NSLocalizedString(@"提示\n\n\n下载新版本失败", nil);
            break;
        case ND_APP_UPDATE_CHECK_NEW_VERSION_FAIL:
           // title = NSLocalizedString(@"提示\n\n\n检测新版本信息失败", nil);
            break;
        default:
            
            break;
    }
    //[m_UserdicInfo setObject:@(updateResult) forKey:@"UPDATESTATUS"];
    //无可用更新程序继续,其他情况demo暂不做特殊处理
    if (updateResult == ND_APP_UPDATE_NO_NEW_VERSION)
    {
        //开始登录以及应用相关的操作 }
        
    }else
    {
        if (title != nil)
        {
            [RJFWarnView addinSelfview:self.viewController.view
                              delegate:nil
                               message:title
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
            
        }
        //相应的错误提示和程序处理。 建议:如果下载或者检测新版本失败,当作无可用更新处理。
    }
   // UserInfo  *objUser = [UserInfo shareInstance];
    objUser.hasCheckVersion = YES;
}
#endif


/* 接收从苹果服务器返回的唯一的设备token，然后发送给自己的服务端*/
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
   // NSString* devices_token = [NSString stringWithFormat:@"%@",deviceToken];
  //  NSString   *strDevices = [NSString stringWithUTF8String:[deviceToken bytes]];
    
    
    PushManager             *shareObj = [PushManager sharedManager];
    [shareObj setTokenData:deviceToken];
    
   /* NSString  *strDeveiceToken = [deviceToken description];
    strDeveiceToken = [strDeveiceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    strDeveiceToken = [strDeveiceToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    strDeveiceToken = [strDeveiceToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    NSLog(@"strDeveiceToken:%@",strDeveiceToken);*/
}

//程序处于启动状态，或者在后台运行时，会接收到推送消息，解析处理
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"\napns -> didReceiveRemoteNotification,Receive Data:\n%@", userInfo);
    //把icon上的标记数字设置为0,
    application.applicationIconBadgeNumber = 0;
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=NULL)
    {
        if(application.applicationState == UIApplicationStateActive)
        {
           // [self alertNotice:@"推送通知" withMSG:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
        }

    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification
{

    // 图标上的数字减1
    [application cancelAllLocalNotifications];
    application.applicationIconBadgeNumber = 0;
}
@end
