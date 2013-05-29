//
//  RJFMainWindow.m
//  Texas-pokes
//
//  Created by popo on 12-7-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFMainWindow.h"

#import "RJFUpAndDown.h"
#import "RJFRankingVViewController.h"
#import "RJFUserdetail.h"
#import "RJFMainHelpViewController.h"
#import "RJFTaskViewController.h"
#import "RJFGameInterface.h"
#import "RJFSettingViewController.h"
#import "RJFEditUserinfoViewController.h"
#import "RJFMainViewController.h"
#import "RJFMessageViewController.h"
#import "RJFFAQViewController.h"
#import "RJFLevelViewOrWeathController.h"
#import "RJFChargeViewController.h"
#import "RJFGameFlorOrComPeteViewController.h"
#import "SinaWeiBoSDKDemoViewController.h"
#import "JFSharePanel.h"
#import "RJFEveryDayLogin.h"
#import "JFWinLoseCountView.h"

#if MODEFOR91 == 0
#import "RJFRecommandViewController.h"
#endif


#define DOWNJOYLUNTANURL        @"http://sq.d.cn/bbs/topic/list_all_9039.html?djca=1"


#define DOWNLOADREQUESDID   43

@implementation RJFMainWindow

@synthesize headpicName = m_strPicName,dayIndex,dayBounds;
NSString    *BNRSTARTRESOURCEHEARTPACK = @"BNRSTARTRESOURCEHEARTPACK";
extern NSString    *BNRSTARTGAMEHEARTPACK;
extern NSString    *BNRUPDATUSERINFO;
#pragma mark BNRWarnViewDelegate delegate method

-(void)ClickCancel:(id)sender
{
    m_clickInsureType = DEFAULTNONEMODE;
}
-(void)ClickInsure:(id)sender
{
    
    id chargeControl = nil;
    RJFTcpSocket    *socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    BasisZipAndUnzip   *obj_share = [[BasisZipAndUnzip alloc] initWithSize:40];
#if MODEFORDOWNJOY
    Downjoy  *shareJoy = [Downjoy shareInstance];
    shareJoy.delegate = (id)self;
#endif
    switch (m_clickInsureType)
    {
        case GOANDGET:
            // [self setUserInfo];
            ShowHUD(@"获取免费筹码中",self, 10);
            [socket SendCharMessage:[obj_share syncWithRequest:REQ_GET_CHIPS
                                                        userID:m_objShareInfo.userIDForDzpk
                                                   structArray:NULL] size:[obj_share dataSize]];
            
            break;
        case LOGINOUTMODE:
              ShowHUD(@"加载中，请稍候", self, 15);
#if MODEFOR91
            [[NdComPlatform defaultPlatform] NdLogout:1];
             [self LoginOutByAuto:nil];
             [self.navigationController popToRootViewControllerAnimated:YES];
#elif  MODEFORDOWNJOY
          
            [self LoginOutByAuto:nil];
            [shareJoy downjoyLogout];
           
           // [shareJoy release];
#else
            [self LoginOutByAuto:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
#endif
           
           
           
            
            
            break;
        case CHARGEIDOUMODE:
            chargeControl = [[RJFChargeViewController alloc] initWithNibName:@"RJFChargeViewController" bundle:nil];
            [self.navigationController pushViewController:chargeControl animated:YES];
            
            [chargeControl release];
            break;
        default:
            break;
    }
    m_clickInsureType = DEFAULTNONEMODE;
    [obj_share release];
    obj_share = nil;
    
}

#pragma mark self define method(button respond method)
-(IBAction)clickHelp:(UIButton *)sender
{
    RJFMainHelpViewController  *help = [[RJFMainHelpViewController alloc] initWithNibName:@"RJFMainHelpViewController" bundle:nil];
    [self.navigationController pushViewController:help animated:YES];
    [help release];
    
    logMyLogInfo(@"help");
}
-(IBAction)clickSetting:(UIButton *)sender
{
    RJFSettingViewController *setControl = [[RJFSettingViewController alloc] initWithNibName:@"RJFSettingViewController" bundle:nil];
    [[self navigationController] pushViewController:setControl animated:YES];
    [setControl release];
    
    logMyLogInfo(@"setting");
}
-(IBAction)clickQuickStart:(UIButton *)sender
{
    
    if (m_objShareInfo.userChips < 200)
    {
        m_clickInsureType = CHARGEIDOUMODE;
        [RJFWarnView addinSelfview:self.view
                          delegate:self
                           message:NSLocalizedString(@"提示\n\n\n您的筹码不足，请充值！", nil)
                        buttontype:BOTHBUTTON
                      InsureButton:NSLocalizedString(@"充值", Nil)
                      CancelButton:CANCEL];
        return;
    }
    BasisZipAndUnzip  *objBasic = [[BasisZipAndUnzip alloc] initWithSize:40];
    
    //DZPK_CLIENT_REQ_GAME_QUICK   quickInfo = {0};
    ShowHUD(NSLocalizedString(@"加载房间信息中，请稍候！", nil), self,20);
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    [socket SendCharMessage:[objBasic syncWithRequest:REQ_GAME_QUICK_SERVER
                                               userID:m_objShareInfo.userIDForDzpk
                                          structArray:NULL] size:[objBasic dataSize]];
    [objBasic release];
    
    
    
    
    logMyLogInfo(@"quick start");
}
-(IBAction)clickGameFloor:(UIButton *)sender
{
    RJFGameFlorOrComPeteViewController  *gameComeControl = [[RJFGameFlorOrComPeteViewController alloc] initWithNibName:@"RJFGameFlorOrComPeteViewController" bundle:nil controlType:GAMEFLOORTYPE];
    [self.navigationController pushViewController:gameComeControl animated:YES];
    [gameComeControl release];
    logMyLogInfo(@"GameFloor");
    
}
-(IBAction)clickMatchFloor:(UIButton *)sender
{
    RJFGameFlorOrComPeteViewController  *gameComeControl = [[RJFGameFlorOrComPeteViewController alloc] initWithNibName:@"RJFGameFlorOrComPeteViewController" bundle:nil controlType:COMPELTETYPE];
    [self.navigationController pushViewController:gameComeControl animated:YES];
    [gameComeControl release];
    
    logMyLogInfo(@"matchfloor");
    
}
-(IBAction)clickBeginTeach:(UIButton *)sender
{
    RJFGameInterface  *control = [[RJFGameInterface alloc] initWithNibName:@"RJFGameInterface" bundle:nil gameType:FRESHTEACHTYPE];
    [self.navigationController pushViewController:control animated:YES];
    [control release];
    logMyLogInfo(@"beginteach");
    
    
    
}
-(IBAction)clickChargeMoney:(UIButton *)sender
{
    if (m_objShareInfo.userType == 0)
    {
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:NSLocalizedString(@"提示\n\n您是游客用户，不能够使用充值功能\n", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
        return;
    }
    RJFChargeViewController  *chargeContrl = [[RJFChargeViewController alloc] initWithNibName:@"RJFChargeViewController" bundle:nil];
    [self.navigationController pushViewController:chargeContrl animated:YES];
    [chargeContrl release];
    logMyLogInfo(@"charge money");
    
    
}
-(IBAction)clickLohinOut:(UIButton *)sender
{
    m_clickInsureType = LOGINOUTMODE;
    
    [RJFWarnView addinSelfview:self.view
                      delegate:self
                       message:NSLocalizedString(@"提示\n\n\n是否注销该账号？", nil)
                    buttontype:BOTHBUTTON
                  InsureButton:NSLocalizedString(@"是", nil)
                  CancelButton:NSLocalizedString(@"否", nil)];
    logMyLogInfo(@"login out");
    
}
-(IBAction)clickSetuserInfo:(UIButton *)sender
{
    RJFEditUserinfoViewController  *editUser = [[RJFEditUserinfoViewController alloc] initWithNibName:@"RJFEditUserinfoViewController" bundle:nil];
    [self.navigationController pushViewController:editUser animated:YES];
    [editUser release];
    
    
    logMyLogInfo(@"set user info");
}
-(IBAction)clickMenuMessage:(UIButton *)sender
{
    RJFMessageViewController  *messageControl = [[RJFMessageViewController alloc] initWithNibName:@"RJFMessageViewController" bundle:nil];
    [self.navigationController pushViewController:messageControl animated:YES];
    [messageControl release];
    
    logMyLogInfo(@"menu message");
    
    
}

-(IBAction)clickRecomand:(UIButton *)sender
{
    
#if MODEFOR91
    [[NdComPlatform defaultPlatform] NdEnterPlatform:0];
#elif MODEFORDOWNJOY
    Downjoy  *shareObj = [Downjoy shareInstance];

    if (shareObj.downjoyIsLogin)
    {
        [self presentModalViewController:shareObj animated:YES];
       [shareObj downjoyMemberCenter]; 
    }
#else
    logMyLogInfo(@"recommand");
    RJFRecommandViewController   *command = [[RJFRecommandViewController alloc] initWithNibName:@"RJFRecommandViewController" bundle:nil];
    [self.navigationController pushViewController:command animated:YES];
    [command release];
#endif
    
}
-(IBAction)clickRank:(UIButton *)sender
{
    RJFRankingVViewController *rankControl = [[RJFRankingVViewController alloc] initWithNibName:@"RJFRankingVViewController" bundle:nil ];
    [self.navigationController pushViewController:rankControl animated:YES];
    [rankControl release];
    
    logMyLogInfo(@"rank");
    
}
-(IBAction)clickShare:(UIButton *)sender
{
    
    
   /* UIImage *image = [UIImage ScreenShotImageFromIphone:self.view];
   // [self.view addSubview:[[UIImageView alloc] initWithImage:image]];
    UIImageView  *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.bounds = CGRectMake(0,0, 240, 160);
    [self.view addSubview:imageView];*/
    
    
   // ShowMsgInTopView(@"abcdefghijklmnopqretvdsaskhdakfhdsfsjfhdsghd", 5, self);

  //  [self ShowMsgInTopView:@"恭喜你获得人类最无耻勋章，谢谢你的参与" showTime:3];
    
    [self clickShareWithType:1];
    
    

    
    logMyLogInfo(@"share");
    
}

-(void)clickShareWithType:(int8_t)type
{
    
    ShowHUD(NSLocalizedString(@"加载中，请稍候！", nil), self, 25);
    DZPK_CLIENT_REQ_SHARE_BONUS   info = {type};
    BasisZipAndUnzip  *obj_basiz = [[BasisZipAndUnzip alloc] initWithSize:50];
    RJFTcpSocket  *socketResource = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    [socketResource SendCharMessage:[obj_basiz syncWithRequest:REQ_SHARE_CONTENT
                                                        userID:m_objShareInfo.userIDForDzpk
                                                   structArray:&info]
                               size:[obj_basiz dataSize]];
    [obj_basiz release];
    obj_basiz = nil;
    
}
-(IBAction)clickTask:(UIButton *)sender
{
    RJFTaskViewController  *taskControl = [[RJFTaskViewController alloc] initWithNibName:@"RJFTaskViewController" bundle:nil];
    [self.navigationController pushViewController:taskControl animated:YES];
    [taskControl release];
    
}
-(IBAction)clickLevelDetail:(UIButton *)sender
{
    RJFLevelViewOrWeathController *levelControl = [[RJFLevelViewOrWeathController alloc] initWithNibName:@"RJFLevelViewOrWeathController" bundle:nil];
    [self.navigationController pushViewController:levelControl animated:YES];
    [levelControl release];
    logMyLogInfo(@"level detail");
}


#pragma mark override method
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        m_objShareInfo = [UserInfo shareInstance];
        self.dayBounds = -1;
        self.dayIndex = -1;
        [self setCountNochange];
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle




-(void)getChip:(id)thread
{
    
    if (m_objShareInfo.userChips >= 200 || m_objShareInfo.getChipTimes < 1)
    {
        return;
    }
    
    
    m_clickInsureType = GOANDGET;
    NSString  *strWaring = [NSString  stringWithFormat:NSLocalizedString(@"提示\n\n您当前的筹码低于200，可领取%d补偿金，今日还有%d次机会", nil),200,m_objShareInfo.getChipTimes];
    [RJFWarnView addinSelfview:self.view
                      delegate:self
                       message:strWaring
                    buttontype:BOTHBUTTON
                  InsureButton:NSLocalizedString(@"领取", nil)
                  CancelButton:NSLocalizedString(@"放弃", nil)];
    logMyLogInfo(@"-------beginTo gain free bouns------");
}

-(void)setUserInfo
{
    
    if (m_objShareInfo == nil)
    {
        m_objShareInfo = [UserInfo shareInstance];
    }
    
    
    UIImage *image = [RJFUpAndDown getLocalImage:m_objShareInfo.userImagePath];
    if (image)
    {
        imageViewlUserimage.image  = [UIImage imageByScalingAndCroppingForSize:imageViewlUserimage.frame.size sourceImages:image];;
    }else
    {
        RJFUpAndDown  *downRequest = [RJFUpAndDown shareWithTag:0];
        [downRequest setDelegate:self];
        
        [downRequest SendDownRequest:m_objShareInfo.userImagePath requestID:DOWNLOADREQUESDID];
    }
    
    labelName.text = m_objShareInfo.userName;
    labelID.text = [NSString stringWithFormat:@"ID:%d",m_objShareInfo.userIDForDzpk];
    labelCurrentPeople.text = [NSString stringWithFormat:NSLocalizedString(@"当前在线人数:%ld", nil),m_objShareInfo.onlineCount];
    labelMaxWinChips.text = [NSString stringWithFormat:@"%ld",m_objShareInfo.MaxWinchips];
    labelScore.text = [NSString stringWithFormat:NSLocalizedString(@"%ld胜%ld败", nil),m_objShareInfo.winTimes,m_objShareInfo.loseTime];
    if (m_objShareInfo.winTimes+m_objShareInfo.loseTime > 0)
    {
        [labelPer setText:[NSString stringWithFormat:@"%0.0f%%",m_objShareInfo.winTimes*1.0f/(m_objShareInfo.winTimes+m_objShareInfo.loseTime)*1.0*100]];
    }else
    {
        [labelPer setText:[NSString stringWithFormat:@"0%%"]];
    }
    labelChips.text = [NSString stringWithNeedTranfanstring:[NSNumber numberWithInt:m_objShareInfo.userChips] returnType:COMMOMTYPE];
    //  m_objShareInfo.level = 2;
    if (m_objShareInfo.level <= 1)
    {
        imageViewMedal.image = nil;
    }else if (m_objShareInfo.level < 7)
    {
        imageViewMedal.image = [UIImage imageNamed:@"medal_1.png"];
    }else if (m_objShareInfo.level < 10)
    {
        imageViewMedal.image = [UIImage imageNamed:@"medal_2.png"];
    }else if (m_objShareInfo.level < 14)
    {
        imageViewMedal.image = [UIImage imageNamed:@"medal_3.png"];
    }else if (m_objShareInfo.level < 18)
    {
        imageViewMedal.image = [UIImage imageNamed:@"medal_4.png"];
    }else
    {
        imageViewMedal.image = [UIImage imageNamed:@"medal_5.png"];
    }
    //labelScore.text = strTemp;
    
    
    if (m_objShareInfo.msgCount)
    {
        labelMessageNumber.text = [NSString stringWithFormat:@"%d",m_objShareInfo.msgCount];
        imageViewmenuNumber.hidden = NO;
    }else
    {
        labelMessageNumber.text = @"";
        imageViewmenuNumber.hidden = YES;
    }
    
    labelCardNumber1.text = SetCardNumber(m_objShareInfo.MaxCard1);
    labelCardNumber2.text = SetCardNumber(m_objShareInfo.MaxCard2);
    labelCardNumber3.text = SetCardNumber(m_objShareInfo.MaxCard3);
    labelCardNumber4.text = SetCardNumber(m_objShareInfo.MaxCard4);
    labelCardNumber5.text = SetCardNumber(m_objShareInfo.MaxCard5);
    imageViewCard1.image =  MaxImageAccordCardNumber(m_objShareInfo.MaxCard1);
    imageViewCard2.image =  MaxImageAccordCardNumber(m_objShareInfo.MaxCard2);
    imageViewCard3.image =  MaxImageAccordCardNumber(m_objShareInfo.MaxCard3);
    imageViewCard4.image =  MaxImageAccordCardNumber(m_objShareInfo.MaxCard4);
    imageViewCard5.image =  MaxImageAccordCardNumber(m_objShareInfo.MaxCard5);
    
    
    NSDictionary  *dicInfo = [[NSBundle mainBundle] infoDictionary];
    
    NSArray  *array = [dicInfo valueForKey:@"levelTable"];
    NSDictionary   *diclevelInfo = nil;
    int i = [array count]-1;
    for (; i >= 0; i--)
    {
        diclevelInfo = [array objectAtIndex:i];
        NSString  *strScore = [NSString stringWithNeedTranfanstring:[diclevelInfo valueForKey:@"score"] returnType:NORMALTYPE];
        // NSLog(@"string:%@ value:%@",[diclevelInfo valueForKey:@"score"],strScore);
        long score = [strScore longLongValue];
        if (m_objShareInfo.score >= score)
        {
            //logMyLogInfo(@"diclevelInfoL:%@",diclevelInfo);
            break;
        }
    }
    NSString *levelNeedType = @"";
    if (i < [array count])
    {
        diclevelInfo = [array objectAtIndex:i];
        levelNeedType = [NSString stringWithNeedTranfanstring:[diclevelInfo valueForKey:@"nextLevelScore"] returnType:GAMESHOWTYPE];
    }else
    {
        levelNeedType = @"200";
    }
    
    NSString *strScore = [NSString stringWithNeedTranfanNumber:m_objShareInfo.score returnType:GAMESHOWTYPE];
    
    
    [labelLevelPercentage setText:[NSString stringWithFormat:@"%@/%@",strScore,levelNeedType]];
    [labelLevelPercentage setTextAlignment:NSTextAlignmentRight];
    [labelLevelNick setText:getLevelName(m_objShareInfo.score)];
    levelNeedType = [NSString stringWithNeedTranfanstring:[diclevelInfo valueForKey:@"nextLevelScore"] returnType:NORMALTYPE];
    CGFloat  fwidth = 0;
    CGFloat   fper = (m_objShareInfo.score*1.0f)/([levelNeedType floatValue]*1.0f);
    if (m_objShareInfo.score <= 0)
    {
        fwidth = 0;
    }else
    {
        fwidth = imageViewlevelBack.frame.size.width*fper;
    }
    [imageViewlevelfill setFrame:CGRectMake(imageViewlevelBack.frame.origin.x, imageViewlevelfill.frame.origin.y,fwidth, imageViewlevelfill.frame.size.height)];
    
    
    
    if (m_objShareInfo.task == 0)
    {
        imageViewmenuTask.image = [UIImage imageNamed:@"menu_task.png"];
    }else
    {
        imageViewmenuTask.image = [UIImage imageNamed:@"menu_task_finish.png"];
    }
    logMyLogInfo(@"fwidth:%f task:%d",fwidth,m_objShareInfo.task);
    
    
    
}




- (void)viewDidLoad
{
    
    [btnGameFloor setBackgroundImage:[UIImage imageNamed:@"big_green.png"] forState:UIControlStateNormal];
    [btnQucikStart setBackgroundImage:[UIImage imageNamed:@"big_yellow.png"] forState:UIControlStateNormal];
    [btnMatchFloor setBackgroundImage:[UIImage imageNamed:@"big_green.png"] forState:UIControlStateNormal];
    [btnHelp setBackgroundImage:[UIImage imageNamed:@"small_blue.png"] forState:UIControlStateNormal];
    [btnSetting setBackgroundImage:[UIImage imageNamed:@"small_blue.png"] forState:UIControlStateNormal];
    [btnBeginTeach setBackgroundImage:[UIImage imageNamed:@"mid_blue.png"] forState:UIControlStateNormal];
    [btnLoginOut setBackgroundImage:[UIImage imageNamed:@"small_blue.png"] forState:UIControlStateNormal];
    [btnChargemoney  setBackgroundImage:[UIImage imageNamed:@"charge.png"] forState:UIControlStateNormal];
    imageViewlUserimage.layer.masksToBounds = YES;
    imageViewlUserimage.layer.cornerRadius = 5;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BNRSTARTRESOURCEHEARTPACK
                                                        object:nil];
    setAllViewautoResize(self.view);
    
    
 
  
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
}

-(void)SendUserGetdeatilInfo
{
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    BasisZipAndUnzip  *basic = [[BasisZipAndUnzip alloc] initWithSize:50];
    [socket SendCharMessage:[basic syncWithRequest:REQ_PERSON_DATA
                                            userID:m_objShareInfo.userIDForDzpk
                                       structArray:NULL] size:[basic dataSize]];
    
    
    
    
    [basic release];
    basic = nil;
    
}


-(void)dealloc
{
    if (btnHelp)
    {
        [btnHelp release];
        btnHelp = nil;
    }
    if (btnSetting)
    {
        [btnSetting release];
        btnSetting = nil;
    }
    if (btnQucikStart)
    {
        [btnQucikStart release];
        btnQucikStart = nil;
    }
    if (btnGameFloor)
    {
        [btnGameFloor release];
        btnGameFloor = nil;
    }
    if (btnMatchFloor)
    {
        [btnMatchFloor release];
        btnMatchFloor = nil;
    }
    if (btnBeginTeach)
    {
        [btnBeginTeach release];
        btnBeginTeach = nil;
    }
    if (btnChargemoney)
    {
        [btnChargemoney release];
        btnChargemoney = nil;
    }
    if (btnLoginOut)
    {
        [btnLoginOut release];
        btnLoginOut = nil;
    }
    if (btnSetUserInfo)
    {
        [btnSetUserInfo release];
        btnSetUserInfo = nil;
    }
    if (btnMenuMessage)
    {
        [btnMenuMessage release];
        btnMenuMessage = nil;
    }
    if (btnRecommand)
    {
        [btnRecommand release];
        btnRecommand = nil;
    }
    if (btnRank)
    {
        [btnRank release];
        btnRank = nil;
    }
    if (btnHelp)
    {
        [btnHelp release];
        btnHelp = nil;
    }
    if (btnShare)
    {
        [btnShare release];
        btnShare = nil;
    }
    if (btnTask)
    {
        [btnTask release];
        btnTask = nil;
        
    }
    if (btnLevelDetail)
    {
        [btnLevelDetail release];
        btnLevelDetail = nil;
    }
    if (labelName)
    {
        [labelName release];
        labelName = nil;
    }
    if (labelChips)
    {
        [labelChips release];
        labelChips = nil;
    }
    if (labelLevelNick)
    {
        [labelLevelNick release];
        labelLevelNick = nil;
    }
    if (labelLevelPercentage)
    {
        [labelLevelPercentage release];
        labelLevelPercentage = nil;
    }
    if (labelScore)
    {
        [labelScore release];
        labelScore = nil;
    }
    if (labelCardNumber1)
    {
        [labelCardNumber1 release];
        labelCardNumber1 = nil;
    }
    if (labelCardNumber2)
    {
        [labelCardNumber2 release];
        labelCardNumber2 = nil;
    }
    if (labelCardNumber3)
    {
        [labelCardNumber3 release];
        labelCardNumber3 = nil;
    }
    if (labelCardNumber4)
    {
        [labelCardNumber4 release];
        labelCardNumber4 = nil;
    }
    if (labelCardNumber5)
    {
        [labelCardNumber5 release];
        labelCardNumber5 = nil;
    }
    if (labelMaxWinChips)
    {
        [labelMaxWinChips release];
        labelMaxWinChips = nil;
    }
    if (labelMessageNumber)
    {
        [labelMessageNumber release];
        labelMessageNumber = nil;
    }
    if (labelCurrentPeople)
    {
        [labelCurrentPeople release];
        labelCurrentPeople = nil;
    }
    if (labelID)
    {
        [labelID release];
        labelID = nil;
    }
    if (imageViewlevelfill)
    {
        [imageViewlevelfill release];
        imageViewlevelfill = nil;
    }
    if (imageViewlevelBack)
    {
        [imageViewlevelBack release];
        imageViewlevelBack = nil;
    }
    if (imageViewCard1)
    {
        [imageViewCard1 release];
        imageViewCard1 = nil;
    }
    if (imageViewCard2)
    {
        [imageViewCard2 release];
        imageViewCard2 = nil;
    }
    if (imageViewCard3)
    {
        [imageViewCard3 release];
        imageViewCard3 = nil;
    }
    if (imageViewCard4)
    {
        [imageViewCard4 release];
        imageViewCard4 = nil;
    }
    if (imageViewCard5)
    {
        [imageViewCard5 release];
        imageViewCard5 = nil;
    }
    if (imageViewlUserimage)
    {
        [imageViewlUserimage release];
        imageViewlUserimage = nil;
    }
    if (imageViewmenuTask)
    {
        [imageViewmenuTask release];
        imageViewmenuTask = nil;
    }
    
    [super dealloc];
}
//REQ_GET_CHIPS

-(void)viewWillAppear:(BOOL)animated
{
    HideHUD(self, YES);
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:LOGINSOCKETTAG];
    [socket disConnect];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotiFromServer:)
                                                 name:BNRRECEIVEMESSAGEFROMSERVER
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setUserInfo)
                                                 name:BNRUPDATUSERINFO
                                               object:nil];
    [self setUserInfo];
    
    UIImage *image = [RJFUpAndDown getLocalImage:m_objShareInfo.userImagePath];
    if (image)
    {
        imageViewlUserimage.image  = [UIImage imageByScalingAndCroppingForSize:imageViewlUserimage.frame.size sourceImages:image];;
    }else
    {
        RJFUpAndDown  *downRequest = [RJFUpAndDown shareWithTag:0];
        [downRequest setDelegate:self];
        
        [downRequest SendDownRequest:m_objShareInfo.userImagePath requestID:DOWNLOADREQUESDID];
    }
    
    
    
    if (m_objShareInfo.needSyncInfo)
    {
        m_objShareInfo.needSyncInfo = NO;
        [self UpdateUserInfo:nil];
        
    }else
    {
        
        [self SendUserGetdeatilInfo];
    }
    
#if MODEFOR91
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(SNSLeaveComplatformUI:)
                                                 name:(NSString *)kNdCPLeavePlatformNotification
                                               object:nil];
#endif
    
    
    
    
    if (self.dayIndex > 0 && self.dayIndex < 8 && self.dayBounds > 0)
    {
        RJFEveryDayLogin *loginView =   [[RJFEveryDayLogin alloc] initWithChip:self.dayBounds day:1];
        [self.view addSubview:loginView];
        [loginView release];
        self.dayIndex = -1;
        self.dayBounds = 0;
        
    }

    [self ShowCountView:nil];
 
    [super viewWillAppear:animated];
    

}


-(void)ShowCountView:(id)Thread
{
    
    NSDictionary  *dicInfo = [[NSUserDefaults standardUserDefaults] valueForKey:USERCHIPCOUNTDIC];
    
    logMyLogInfo(@"USERCHIPCOUNTDIC:%@  %@",USERCHIPCOUNTDIC,dicInfo);
    if (dicInfo && [[dicInfo valueForKey:USERCHIPHASCHANGE] boolValue])
    {
        
        
        int32_t   beforeChip = [[dicInfo valueForKey:USERBEFORCHIPNUMBER] intValue];
        int32_t   nowchip = [[dicInfo valueForKey:USERNOWCHIPNUMBER] intValue];
        int32_t   propChip = [[dicInfo valueForKey:USERPROPCHIPNUMBER] intValue];
        JFWinLoseCountView   *winloseWinView = [[JFWinLoseCountView alloc] initWithBeforeChip:beforeChip nowchip:nowchip propChip:propChip];
         [self.view addSubview:winloseWinView];
         [winloseWinView performSelector:@selector(removeFromSuperview)
         withObject:nil
         afterDelay:5];
         [winloseWinView release];
         [self setCountNochange];
    }
    
}
-(void)UpdateUserInfo:(id)Thread
{
    ShowHUD(@"首次登录，正在同步用户资料中，请稍候！", self,60);
    m_iProgressCount = 0;
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    BasisZipAndUnzip  *basic = [[BasisZipAndUnzip alloc] initWithSize:50];
    [socket SendCharMessage:[basic syncWithRequest:REQ_PERSON_DATA_HEAD_NAME
                                            userID:m_objShareInfo.userIDForDzpk
                                       structArray:NULL] size:[basic dataSize]];
    [basic release];
    basic  = nil;
    
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
    [self setCountNochange];
 
}

-(void)setCountNochange
{
    NSDictionary  *dicInfo = [NSDictionary dictionaryWithObject:@(m_objShareInfo.userChips) forKey:USERBEFORCHIPNUMBER];
    [[NSUserDefaults standardUserDefaults] setObject:dicInfo forKey:USERCHIPCOUNTDIC];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}



-(void)dealQucikStart:(int16_t)requestCode handle:(void *)handle
{
    if (requestCode == REQ_GAME_QUICK_SERVER)
    {
        DZPK_SERVER_REQ_GAME_QUICK_SERVER  *info = (DZPK_SERVER_REQ_GAME_QUICK_SERVER*)handle;
        logMyLogInfo(@"quick request status:%d",info->status);
        if (info->status)
        {
            HideHUD(self, YES);
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n获取房间信息失败", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
            return;
        }
        
        logMyLogInfo(@"\n-------------------receive REQ_GAME_QUICK_SERVER -------------------");
        logMyLogInfo(@"bringGold:%d carry_big:%d carry_small:%d enter_big_Number:%d,enter_small_Number:%d,IP:%@,port:%d,roomID:%d,roomPath:%d",info->bringGold,info->carry_big_Number,info->carry_small_Number,info->enter_big_Number,info->enter_small_Number,info->IP,info->port,info->roomID,info->roomPATH);
        logMyLogInfo(@"\n-------------------end receive REQ_GAME_QUICK_SERVER----------------------");
        
        
        m_roomInfo.roomSmallChip = info->carry_small_Number;
        m_roomInfo.roomBigChip = info->carry_big_Number;
        
        
        
        
        
        
        m_roomInfo.roomID = info->roomID;
        m_roomInfo.roomPath = info->roomPATH;
        m_roomInfo.roomType = 1;
        m_roomInfo.enterFee = info->servicecharge;
        m_roomInfo.HostIP = info->IP;
        m_roomInfo.hostport = info->port;
        m_roomInfo.selfChooseSeat = 0;
        
        
        RJFGameInterface  *game = [[RJFGameInterface alloc] initWithNibName:@"RJFGameInterface"
                                                                     bundle:nil
                                                                   roomInfo:&m_roomInfo];
        [self.navigationController pushViewController:game animated:YES];
        [game release];
        
        
    }
    
    
    
}
-(void)receiveNotiFromServer:(NSNotification *)note
{
    
    RJFTcpSocket  *m_socket = [note object];
    NSDictionary  *dicInfo = [note userInfo];
    if (dicInfo &&(m_socket.tag == GAMESOCKETTAG  || m_socket.tag == RESOURCESOCKEtTAG) )
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
  //  logMyLogInfo(@"data:%s",[data bytes]);
    logMyLogInfo(@"ppppppppppmainwindow xib socket tag:%d request:%d",m_socket.tag,requestCode);
    
    if (requestCode == REQ_GAME_QUICK_SERVER )
    {
        //|| requestCode == REQ_GAME_ENTER_ROOM)
        handle =[objShare PhaseInfoFromData:(int8_t *)[data bytes]       
                             outRequestCode:&requestCode];
        
        [self dealQucikStart:requestCode handle:handle];
        free(handle);
        handle = NULL;
        [objShare release];
        objShare = nil;
        return;
    }
    
    if (requestCode == REQ_GET_CHIPS)
    {
        HideHUD(self, YES);
        handle =[objShare PhaseInfoFromData:(int8_t *)[data bytes]      
                             outRequestCode:&requestCode];
        DZPK_SERVER_REQ_GET_CHIPS   *chipInfo = (DZPK_SERVER_REQ_GET_CHIPS*)handle;
        logMyLogInfo(@"chips:%d freetime:%d",chipInfo->chips,chipInfo->freeTimes);
        if (chipInfo->status == 0)
        {
            if (chipInfo->chips  <= 0)
            {
                // free(handle);
                free(handle);
                handle = NULL;
                [objShare release];
                objShare = nil;
                return;
            }
           
            logMyLogInfo(@"\n-------------------receive _GET_CHIPS -------------------");
            logMyLogInfo(@"status:%d allchip:%d chips:%d freetimes:%d",chipInfo->status,chipInfo->allchips,chipInfo->chips,chipInfo->freeTimes);
            logMyLogInfo(@"\n-------------------end receive _GET_CHIPS----------------------");
            m_objShareInfo.userChips += chipInfo->chips;
            m_objShareInfo.getChipTimes = chipInfo->freeTimes;
            [labelChips setText:[NSString stringWithNeedTranfanNumber: m_objShareInfo.userChips returnType:COMMOMTYPE]];
            [PublicClass storeMessage:[NSString stringWithFormat:@"领取系统赠送筹码%d",chipInfo->chips] type:0];
    
        }else if (chipInfo->status == 2)
        {
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n\n免费赠送次数已完！", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
        }
        
        
    }else if (requestCode == REQ_PERSON_DATA)
    {
        handle =[objShare PhaseInfoFromData:(int8_t *)[data bytes]      
                             outRequestCode:&requestCode];
        
        DZPK_SERVER_REQ_PERSON_DATA  *info = (DZPK_SERVER_REQ_PERSON_DATA*)handle;
        if (info->status)
        {
            NSLog(@"getInfo fail");
            logMyLogInfo(@"\n\n\n-----------------Get info fail-----------------\n\n\n");
        }else
        {
            logMyLogInfo(@"-------------------receive PERSON_DATA in mainWindow-------------------");
            logMyLogInfo(@"nick:%@,chips:%d,headPicName:%@,idou:%d,level:%d,loseNumber:%d match_score:%d max_own:%d,max_win_%d msg_count:%d",info->nick,info->chips,info->head_pic_name,info->idou,info->level,info->lose_number,info->match_score,info->max_own,info->max_win,info->msg_count);
            for (int i = 0; i < info->maxcardNumber; i++)
            {
                logMyLogInfo(@"infoMaxCards[%i]:%d",i,info->maxCards[i]);
            }
            
            logMyLogInfo(@"-------------------end receive PERSON_DATA in mainWindow-----------------");
            
            logMyLogInfo(@"userinfo score:%d userNick:%@",info->score,info->nick);
            
            m_objShareInfo.userChips = info->chips;
            // [m_objShareInfo.userName setString:info->nick];
            // [m_objShareInfo.userImagePath setString:info->head_pic_name];
            
            if (info->chips < 200 )
            {
                [self getChip:nil];
            }
            
            if (info->sex == 0)
            {
                [m_objShareInfo.Sex setString:NSLocalizedString(@"男", nil)];
            }else
            {
                [m_objShareInfo.Sex setString:NSLocalizedString(@"女", nil)];
            }
            m_objShareInfo.MaxCard1 = info->maxCards[0];
            m_objShareInfo.MaxCard2 = info->maxCards[1];
            m_objShareInfo.MaxCard3 = info->maxCards[2];
            m_objShareInfo.MaxCard4 = info->maxCards[3];
            m_objShareInfo.MaxCard5 = info->maxCards[4];
            
            m_objShareInfo.onlineCount = info->online_count;
            m_objShareInfo.winTimes = info->win_number;
            m_objShareInfo.loseTime = info->lose_number;
            m_objShareInfo.idou = info->idou*1.0f/100.0f;
            m_objShareInfo.maxOwn = info->max_own;
            m_objShareInfo.MaxWinchips = info->max_win;
            m_objShareInfo.userChips = info->chips;
            m_objShareInfo.score = info->score;
            m_objShareInfo.matchscore = info->match_score;
            m_objShareInfo.task = info->task;
            
            
            free(info->maxCards);
            info->maxCards = NULL;
            logMyLogInfo(@"000000000 show my info on the main view");
            [self setUserInfo];
            
        }
        
        
    }else if (requestCode == REQ_PERSON_DATA_ALTER || requestCode == REQ_PERSON_DATA_HEAD_NAME)
    {
        handle =[objShare PhaseInfoFromData:(int8_t *)[data bytes]
                                     
                             outRequestCode:&requestCode];
        [self dealUpdateUserInfo:requestCode Handle:handle];
    }else if (requestCode == REQ_OFFLINE)
    {
    }
    else if (requestCode == REQ_SHARE_CONTENT)
    {
        
        HideHUD(self, YES);
        handle = [objShare PhaseInfoFromData:(int8_t*)[data bytes] outRequestCode:&requestCode];
        DZPK_SERVER_REQ_SHARE_CONTENT   *info = handle;
        logMyLogInfo(@"-------------------receive  REQ_SHARE_CONTENT in mainWindow-------------------");
        
        if (info->status)
        {
            
            logMyLogInfo(@"status:%d",info->status);
        }else
        {
            
            logMyLogInfo(@"status:%d type:%d shareContent:%@ shareBounds:%d",info->status,info->type,info->content,info->shareBounds);
            int   type = m_objShareInfo.userType;
            
            UIImage *image = [UIImage ScreenShotImageFromIphone:self.view];
            if (type == 1 || type == 2)
            {
                JFSharePanel   *sharePanel = [[JFSharePanel alloc] initWithShareType:type
                                                                             content:info->content
                                                                               image:image shareContentType:info->type];
                sharePanel.shareBounds = info->shareBounds;
                [self.view addSubview:sharePanel];
                [sharePanel release];
            }else
            {
                RJFShareViewController   *shareViewcontrol = [[RJFShareViewController alloc] initWithContent:info->content WithImage:image shareContentType:info->type];
                shareViewcontrol.shareBounds = info->shareBounds;
                [self.navigationController pushViewController:shareViewcontrol animated:YES];
                [shareViewcontrol release];
            }
            
        }
     

        
        
    }
    free(handle);
    handle = NULL;
    [objShare release];
    objShare = nil;
    
    
    
}
-(void)dealUpdateUserInfo:(NSInteger)requestCode Handle:(void *)handle
{
    if (requestCode == REQ_PERSON_DATA_ALTER)
    {
        
        DZPK_SERVER_REQ_PERSON_DATA_ALTER   *serinfo = (DZPK_SERVER_REQ_PERSON_DATA_ALTER*)handle;
        
        logMyLogInfo(@"\n-------------------receive PERSON_DATA_ALTER -------------------");
        logMyLogInfo(@"info status:%d",serinfo->status);
        logMyLogInfo(@"\n-------------------end receive PERSON_DATA_ALTER----------------------");
        if (serinfo->status == 0)
        {
            
            m_iProgressCount++;
        }else if (serinfo->status)
        {
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n\n同步个人信息失败!", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
            HideHUD(self, YES);
            [self SendUserGetdeatilInfo];
        }
        
        if (m_iProgressCount >= 2)
        {
            HideHUD(self, YES);
            [self SendUserGetdeatilInfo];
            
        }
        
        
    }else if(requestCode == REQ_PERSON_DATA_HEAD_NAME)
    {
        
        DZPK_SERVER_REQ_PERSON_DATA_HEAD_NAME  *info = (DZPK_SERVER_REQ_PERSON_DATA_HEAD_NAME*)handle;
        if (info->status)
        {
            logMyLogInfo(@"fail head pic name");
            logMyLogInfo(@"\n-------------------receive PERSON_DATA_HEAD_NAME -------------------");
            logMyLogInfo(@"info status:%d",info->status);
            logMyLogInfo(@"\n-------------------end receive PERSON_DATA_HEAD_NAME----------------------");
            HideHUD(self, YES);
            
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n\n 获取图片信息失败！", nil)
                            buttontype:BOTHBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
            
            [self SendUserGetdeatilInfo];
            
        }else
        {
            logMyLogInfo(@"\n-------------------receive PERSON_DATA_HEAD_NAME -------------------");
            logMyLogInfo(@"info status:%d name:%@",info->status,info->name);
            logMyLogInfo(@"\n-------------------end receive PERSON_DATA_HEAD_NAME----------------------");
            RJFTcpSocket    *m_socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
            BasisZipAndUnzip    *shareZip = [[BasisZipAndUnzip alloc] initWithSize:200];
            UserInfo  *objUser = [UserInfo shareInstance];
            int8_t  sex = [m_objShareInfo.Sex isEqualToString:NSLocalizedString(@"男", nil)]?0:1;
            
            self.headpicName = info->name;
            NSString  *strName = [self getSubString:m_objShareInfo.userName lenth:6];
            if ([strName rangeOfString:@"qzuser"].location != NSNotFound)
            {
                strName = [NSString stringWithFormat:@"%d",m_objShareInfo.userIDForDzpk];
                [m_objShareInfo.userName setString:strName];
            }
           
            
            UIImage  *image = [RJFUpAndDown getLocalImage:m_objShareInfo.userImagePath];
            NSData   *data = UIImagePNGRepresentation(image);
            //data = nil;
            if (image == nil || [data length] <= 0 || [data length] >= 30*1024)
            {
                 m_iProgressCount++; 
            }else
            {
                
                NSLog(@"datelength:%d",[data length]);
                RJFUpAndDown  *filesocket = [RJFUpAndDown shareWithTag:0];
                [filesocket setDelegate:nil];
                [filesocket setDelegate:self];
                [filesocket uploadfile:info->name filedata:data];
            }
            
            
            DZPK_CLIENT_REQ_PERSON_DATA_ALTER   personInfo = {strName,self.headpicName,sex};
            
            [m_socket SendCharMessage:[shareZip syncWithRequest:REQ_PERSON_DATA_ALTER
                                                         userID:objUser.userIDForDzpk
                                                    structArray:&personInfo]
                                 size:[shareZip dataSize]];
            [shareZip release];

        }
        
        
    }
    
}


-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotate
{
    return NO;
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
-(void)DownLoadSuOrFail:(UIImage *)image ISSuc:(BOOL)bSUc
{
    if (image)
    {
        
        imageViewlUserimage.image  = [UIImage imageByScalingAndCroppingForSize:imageViewlUserimage.frame.size sourceImages:image];
    }
    
}
-(void)UploadSucOrFail:(BOOL)bSuc
{
    if (bSuc)
    {
        m_iProgressCount++;
        [m_objShareInfo.userImagePath setString:self.headpicName];
        
    }else
    {
        [RJFWarnView addinSelfview:self.view
                          delegate:self
                           message:NSLocalizedString(@"提示\n\n图像上传失败!", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
        
    }
    if (m_iProgressCount >= 2)
    {
        HideHUD(self, YES);
        [self SendUserGetdeatilInfo];
        
    }
    NSLog(@"upload suc:%d",bSuc);
}


-(NSString *)getSubString:(NSString *)strString lenth:(NSInteger)length
{
    NSString  *strInfo = nil;
    // strString = @"我是一个好人";
    for (int i = [strString length];i > 0; i--)
    {
        strInfo = [strString substringToIndex:i];
        //const char *data =(const char *) [strInfo cStringUsingEncoding:NSUTF16StringEncoding];
        int count = sinaCountWord(strInfo);//uni_strlen((char *)data);
        NSLog(@"\n-------i:%d strstring:%@ strinfo:%@ count:%d------\n",i,strString,strInfo,count);
        if (count <= length)
        {
            break;
        }
    }
    
    
    //NSString  *strShowInbtn = [NSString stringWithFormat:@"%@:%@",strNick,strContent];
    return strInfo;
}
-(void)LoginOutByAuto:(id)Thread
{
    
    if (m_objShareInfo.userType == 2)
    {
        SinaWeibo  *sina = [SinaWeibo shareInstance:nil];
        [sina logOut];
    }
    RJFTcpSocket  *socket = nil;
    
    socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    
    BasisZipAndUnzip  *objBasic = [[BasisZipAndUnzip alloc] initWithSize:50];
    [socket SendCharMessage:[objBasic syncWithRequest:REQ_OFFLINE
                                               userID:m_objShareInfo.userIDForDzpk
                                          structArray:NULL]
                       size:[objBasic dataSize]];
    [objBasic release];
    objBasic = nil;
    [socket disConnect];
}





#pragma mark  91  methods
#if MODEFOR91
-(void)SNSLeaveComplatformUI:(NSNotification *)note
{
    if (![[NdComPlatform defaultPlatform] isLogined])
    {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self LoginOutByAuto:nil];
    }else
    {
        NdComPlatform  *coom = [NdComPlatform defaultPlatform];
        NSString      *uin = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENTTHIRDUSERID];
        if (![uin isEqualToString:coom.loginUin])
        {
            m_clickInsureType = LOGINOUTMODE;
            [RJFWarnView addinSelfview:self.view
                              delegate:self
                               message:NSLocalizedString(@"提示\n\n\n您已更改账号，请返回登录界面重新登录，谢谢！", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:NSLocalizedString(@"返回登录", nil)
                          CancelButton:nil];
        }

    }
    
    logMyLogInfo(@"note:%@",note);
}
#endif


#pragma mark   DOWNJOY methods
#if MODEFORDOWNJOY
//进入个人中心出错
-(void) memberCenterError : (NSString *) errorCode errorMsg : (NSString *) errorMsg
{
    logMyLogInfo(@"errcode:%@ errormsg:%@",errorCode,errorMsg);
}

-(void)logoutSuccess
{
     HideHUD(self, YES);
    [self DownJoyAlert:nil];
    logMyLogInfo(@"downJoy logout success,,,,,,,");
}
-(void) logoutError : (NSString *) errorCode errorMsg : (NSString *) errorMsg
{
     HideHUD(self, YES);
     [self DownJoyAlert:nil];
}


-(void)DownJoyAlert:(id)Thread
{
#if MODEFORDOWNJOY
    [Downjoy shareRelease];
#endif
    UIAlertView   *alertView = [[UIAlertView alloc] initWithTitle:@"询问"
                                                          message:NSLocalizedString(@"是否进入当乐论坛", nil)
                                                         delegate:self
                                                cancelButtonTitle:NSLocalizedString(@"是", nil)
                                                otherButtonTitles:NSLocalizedString(@"否", nil), nil];
    [alertView show];
    [alertView release];

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:DOWNJOYLUNTANURL]];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#endif

@end

