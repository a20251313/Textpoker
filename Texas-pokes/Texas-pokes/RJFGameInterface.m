//
//  RJFGameInterface.m
//  Texas-pokes
//
//  Created by popo on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFGameInterface.h"
#import "RJFGameInterface+RJFGame_FreshTeach.h"
#import "RJFAddChipView.h"
#import "JHTickerView.h"
#import "RJFUserdetail.h"
#import "RJFChargeViewController.h"
#import "SCGIFImageView.h"


#ifndef GAME_Interface_define
#define GAME_Interface_define

#ifndef GAMEOVERTIME
#define GAMEOVERTIME            6
#endif



#define FIRSTCARD               @"FIRSTCARD"
#define SECONDCARD              @"SECONDCARD"
#define SEATID                  @"SEATID"
#define CARDVIEWHEIGHT           118
#define USERINFOVIEWTAG          9923
#define ANIMATIONWEBVIEWTAG      9924
#define COUNTDOWNVIEWTAG         9925
#define MAINCOUNTVIEWBGVIEWTAG   9926

#define     WINVIEWTAG              2038
#define     COUTNDOWNVIEWTAG        2039
#define     USERIMAGEVIEWTAG        3000
#define     SPEAKVIEWTAGBEGIN       5000
#define     FACEVIEWTAGBEGIN        5100
#define     FRESHTEACHDIALOGTAG         2040
#define     PREVIOUSTEPBUTTONTAG        2041
#define     NEXTSTEPBUTTONTAG           2042
#define     HOSTVIEWTAG                 2043
#define     LABELRECORDCHIPTAG          2046
#define     SPEAKVIEWTAG                2047
#define     FACEVIEWTAG                 2048
#define     YOUWINVIEWTAG               2050
#define     LABELSHOWCARDTYPETAG        2052
#define     ADDBRINGCHIPVIEWTAG         2053
#define     CARDARRAYVIEWTAG            2055
#define     CARDTIPIMAGEVIEWTAG         2056




#ifndef SLIDEBARTAR
#define     SLIDEBARTAR                 2044
#define     SLIDERBGVIEWTAG             2045
#endif

#endif


#define TIMEDISCONNECT           30
#define Time                        @"Time"
#define USERNAME                    @"USERNAME"
#define USERCHIP                    @"USERCHIP"
#define USERID                      @"USERID"

#ifndef CURRENTPROPTAGS
#define CURRENTPROPTAGS             @"CURRENTPROPTAGS"
#define CURRENTPROPPRICES           @"CURRENTPROPPRICES"
#endif


#define SEPSTRING                   @"*********"
#define DZPKFACE                    @"DZPKFACE"
#define MAXPERSONNUMBER             8

#ifndef HUANGJIATONGHUASHUN
#define HULU                               NSLocalizedString(@"葫芦" , nil)
#define DUIZI                              NSLocalizedString(@"一对" , nil)
#define LIANGDUI                           NSLocalizedString(@"两对", nil)
#define GAOPAI                             NSLocalizedString(@"高牌", nil)
#define SHUNZI                             NSLocalizedString(@"顺子", nil)
#define SANTIAO                            NSLocalizedString(@"三条", nil)
#define TONGHUA                            NSLocalizedString(@"同花", nil)
#define SITIAO                             NSLocalizedString(@"四条", nil)
#define TONGHUASHUN                        NSLocalizedString(@"同花顺" , nil)
#define HUANGJIATONGHUASHUN                NSLocalizedString(@"皇家同花顺", nil)


#define HULUWIN                           NSLocalizedString(@"葫芦赢", nil)
#define DUIZIWIN                          NSLocalizedString(@"一对赢", nil)
#define LIANGDUIWIN                       NSLocalizedString(@"两对赢", nil)
#define GAOPAIWIN                         NSLocalizedString(@"高牌赢" , nil)
#define SHUNZIWIN                         NSLocalizedString(@"顺子赢", nil)
#define SANTIAOWIN                        NSLocalizedString(@"三条赢", nil)
#define TONGHUAWIN                        NSLocalizedString(@"同花赢", nil)
#define SITIAOWIN                         NSLocalizedString(@"四条赢", nil)
#define TONGHUASHUNWIN                    NSLocalizedString(@"同花顺赢", nil)
#define HUANGJIATONGHUASHUNWIN            NSLocalizedString(@"皇家同花顺赢", nil)
#endif


extern NSString  *BNRSITDOWN;


extern NSString  *BNRSTOPTIMER;
extern NSString  *BNRUSERINFOVIEW;
extern NSString* const  BNRDISCONNECTSERVER;


@implementation RJFGameInterface
@synthesize currentOp = m_iCurrentOpSeat,gifImaageCenter,isInBackGroundMode,isReconectToServer;



#pragma mark BNRWarnViewDelegate method
/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 03
 *  @brief
 *          invoked by click cancel button
 *  @param
 *          sender
 *                  the cancel button in warnning view
 *	@return
 *          NONE
 *
 */
-(void)ClickCancel:(id)sender
{
    
    m_clickInsureMode = DEFAULTNONEMODE;
    setAllViewEnable(YES, self.view);
    logMyLogInfo(@"NO");
}
/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 03
 *  @brief
 *          invoked by click insyure button
 *  @param
 *          sender
 *                  the insure button in warnning view
 *	@return
 *          NONE
 *
 */
-(void)ClickInsure:(id)sender
{
    RJFChargeViewController  *control = nil;
    RJFUserImageView  *userView = nil;
    switch (m_clickInsureMode)
    {
        case STANDUPMODE:
            
            // ShowHUD(NSLocalizedString(@"请求中，请稍候", nil),self);
            [self sendUserleaveAndstand:2 seatId:m_iRealSeat];
            break;
        case ADDCHIPINGAME:
            [self sendUserAddchips:m_myRoomAllinfo.bringgold seatID:m_iRealSeat];
            break;
        case LEVEANOWVIEWMODE:
            ShowHUD(NSLocalizedString(@"请求中，请稍候", nil),self,20);
#if 0
            NSTimer  *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self
                                                             selector:@selector(backToPre:)
                                                             userInfo:nil
                                                              repeats:NO];
            logMyLogInfo(@"before Time:%@",[NSDate date]);
            
            [timer setFireDate:[NSDate dateWithTimeInterval:3 sinceDate:[NSDate date]]];
#else
            userView = [m_arrayStoreUserView objectAtIndex:m_iSelfIndex];
            
            if (m_objShareUser.userHasSitDown)
            {
                
                m_iNowChips = m_objShareUser.userChips+userView.Gameplayer.bringChip;
            }else
            {
                m_iNowChips = m_objShareUser.userChips;
            }
                
           
            [self sendUserleaveAndstand:3 seatId:m_iRealSeat];
#endif
            break;
        case SITDOWNINCOMGAMEMODE:
            [self sendUserleaveAndstand:1 seatId:m_iRealSeat];
            break;
        case CHARGEIDOUMODE:
            control = [[RJFChargeViewController alloc] initWithNibName:@"RJFChargeViewController" bundle:nil];
            [self.navigationController pushViewController:control animated:YES];
            break;
        case ENTERROOMFAILMODE:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        default:
            break;
    }
    m_clickInsureMode = DEFAULTNONEMODE;
    setAllViewEnable(YES, self.view);
    if (control)
    {
        [control release];
        control = nil;
    }
    logMyLogInfo(@"YES");
}

#pragma mark    send user info

-(void)SendUserGetdeatilInfo
{
    
    if (m_gameControltype != GAMETYPE)
    {
        return;
    }
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    BasisZipAndUnzip  *basic = [[BasisZipAndUnzip alloc] initWithSize:50];
    logMyLogInfo(@"to get userinfo from server time:%@ socket connect:%d",[NSDate date],socket.connectSuc);
    [socket SendCharMessage:[basic syncWithRequest:REQ_PERSON_DATA
                                            userID:m_objShareUser.userIDForDzpk
                                       structArray:NULL] size:[basic dataSize]];
    
    
    
    
    [basic release];
    basic = nil;
    
}

-(void)sendUserAction:(UserAction)action chips:(int32_t)chips
{
    //47
    if (m_gameControltype != GAMETYPE)
    {
        return;
    }
    
    m_inowPutChip = chips;
    logMyLogInfo(@"m_iNowchips:%d chips:%d my action  of userAction:%d \n actionputchip = 1, actionfollowchip = 2, actionaddchip = 3, actionallPut = 4, actionkeepchip = 5,actiongiveupCard = 6",m_inowPutChip,chips,action);
    m_userAction = action;
    
    DZPK_CLIENT_REQ_GAME_SEND_ACTION    actionInfo = {action,m_roomIDandPath->roomPath,m_roomIDandPath->roomID,chips};
    BasisZipAndUnzip  *basicZip = [[BasisZipAndUnzip alloc] initWithSize:80];
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:GAMESOCKETTAG];
    [socket SendCharMessage:[basicZip syncWithRequest:REQ_GAME_SEND_ACTION
                                               userID:m_objShareUser.userIDForDzpk
                                          structArray:&actionInfo]
                       size:[basicZip dataSize]];
    [basicZip release];
    basicZip = nil;
}



-(void)sendUserleaveAndstand:(NSInteger)leavelorStand seatId:(NSInteger)iseatID
{
    
    //45
    
    if (leavelorStand == 3 && !m_objShareUser.userHasSitDown)
    {
        iseatID = -1;
        logMyLogInfo(@"find a uninfo seat:%i",iseatID);
    }
    DZPK_CLIENT_REQ_GAME_SEND_SEAT_ACTION   seatInfo = {leavelorStand,iseatID,m_roomIDandPath->roomPath,m_roomIDandPath->roomID};
    
    logMyLogInfo(@"uuuuuuuuuu userID:%d send user seat action 1  sit down 2  stand up  3 leval room\n user seat Action:%d seat ID:%d",m_objShareUser.userIDForDzpk,leavelorStand,iseatID);
    
    
    if (leavelorStand == 3)
    {
        NSTimer  *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self
                                                         selector:@selector(backToPre:)
                                                         userInfo:nil
                                                          repeats:NO];
        logMyLogInfo(@"before Time:%@",[NSDate date]);
        [timer setFireDate:[NSDate dateWithTimeInterval:3 sinceDate:[NSDate date]]];
    }
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:GAMESOCKETTAG];
    
    NSLog(@"game socket info:%@",socket);
    BasisZipAndUnzip    *baseZip = [[BasisZipAndUnzip alloc] initWithSize:100];
    [socket SendCharMessage:[baseZip syncWithRequest:REQ_GAME_SEND_SEAT_ACTION
                                              userID:m_objShareUser.userIDForDzpk
                                         structArray:&seatInfo]
                       size:[baseZip dataSize]];
    [baseZip release];
    baseZip = nil;
    
}
-(void)sendUsermessage:(NSString *)message messageType:(NSInteger)messageType
{
    if (m_gameControltype != GAMETYPE)
    {
        return;
    }
    //46
    
    logMyLogInfo(@"user send message :%@ type:%d",message,messageType);
    BasisZipAndUnzip    *baseZip = [[BasisZipAndUnzip alloc] initWithSize:1024];
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:GAMESOCKETTAG];
    DZPK_CLIENT_REQ_GAME_SEND_MSG   msgInfo = {messageType,m_roomIDandPath->roomPath,m_roomIDandPath->roomID,message};
    [socket SendCharMessage:[baseZip syncWithRequest:REQ_GAME_SEND_MSG
                                              userID:m_objShareUser.userIDForDzpk
                                         structArray:&msgInfo]
                       size:[baseZip dataSize]];
    [baseZip release];
    baseZip = nil;
    
}

-(void)sendTimeout_back:(NSInteger)playerID  backType:(NSInteger)backType
{
    
    
    backType = 0;
    BasisZipAndUnzip    *baseZip = [[BasisZipAndUnzip alloc] initWithSize:100];
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:GAMESOCKETTAG];
    DZPK_CLIENT_REQ_GAME_TIMEOUT_BACK   backInfo = {playerID,backType,m_iRealSeat};
    [socket SendCharMessage:[baseZip syncWithRequest:REQ_GAME_TIMEOUT_BACK
                                              userID:m_objShareUser.userIDForDzpk
                                         structArray:&backInfo]
                       size:[baseZip dataSize]];
    [baseZip release];
    baseZip = nil;
    
}
-(void)sendUserAddchips:(NSInteger)chipsNumber seatID:(NSInteger)seatID
{
    if (m_gameControltype != GAMETYPE)
    {
        return;
    }
    //57
    
    logMyLogInfo(@"add chipsNumber:%d",chipsNumber);
    BasisZipAndUnzip    *baseZip = [[BasisZipAndUnzip alloc] initWithSize:50];
    DZPK_CLIENT_REQ_GAME_ADD_CHIPS   chipInfo = {seatID,chipsNumber};
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:GAMESOCKETTAG];
    [socket SendCharMessage:[baseZip syncWithRequest:REQ_GAME_ADD_CHIPS
                                              userID:m_objShareUser.userIDForDzpk
                                         structArray:&chipInfo]
                       size:[baseZip dataSize]];
    [baseZip release];
    baseZip = nil;
    
}





#pragma mark card animation
/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 03
 *  @brief
 *          rotate the card show in desk
 *  @param
 *          dicInfo
 *              KEY ------------------   VALUE
 *              @"0" -------     image of card1
 *              @"1" -------     image of card2
 *              @"2" -------     image of card3
 *              @"3" -------     image of card4
 *              @"4" -------     image of card5
 *              Time ---------------- NSNumber:(float)
 *	@return
 *          NONE
 *
 */
-(void)roateCardAccordInfo:(NSDictionary *)dicInfo
{
    
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    [RJFaudioPlay PlayMyAudio:@"check.mp3"];
    NSArray    *array = [dicInfo allKeys];
    NSTimeInterval   ftime = [dicInfo valueForKey:Time] == nil?0.3f:[[dicInfo valueForKey:@"Time"] floatValue];
    [UIView animateWithDuration:ftime
                     animations:^{
     //make the imageview frame as width/10
     for (int i = 0;i < [array count];i++)
     {
     NSInteger iValue = [[array objectAtIndex:i] intValue];
     if (iValue < [m_arrayStoreCardView count])
     {
     UIImageView *imageView = [m_arrayStoreCardView objectAtIndex:iValue];
     // NSString   *strValue = [array objectAtIndex:i];
     imageView.hidden = NO;
     imageView.image = [UIImage imageNamed:@"card_back.png"];
     [imageView setFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y,imageView.frame.size.width/10, imageView.frame.size.height)];
     }
     
     
     }
     } completion:^(BOOL finish)
     {
     [UIView beginAnimations:@"35" context:UIGraphicsGetCurrentContext()];
     [UIView setAnimationCurve:UIViewAnimationCurveLinear];
     //[UIView setAnimationDelay:];
     for (int i = 0;i < [array count];i++)
     {
     NSInteger iValue = [[array objectAtIndex:i] intValue];
     if (iValue < [m_arrayStoreCardView count])
     {
     UIImageView *imageView = [m_arrayStoreCardView objectAtIndex:iValue];
     NSString   *strValue = [array objectAtIndex:i];
     imageView.image = [UIImage imageNamed:[dicInfo valueForKey:strValue]];
     [imageView setFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y,imageView.frame.size.width*10, imageView.frame.size.height)];
     }
     
     
     }
     [UIView setAnimationDuration:ftime];
     [UIView commitAnimations];
     }];
    
    [pool drain];
    
    
}


#pragma mark  you win function animation
-(void)youWinAni:(CGFloat)fYtrantion icount:(NSInteger)iCount
{
    
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    RJFUserImageView  *user = [m_arrayStoreUserView objectAtIndex:m_iSelfIndex];
    UIImageView  *imageView  = (UIImageView *)[self.view viewWithTag:WINVIEWTAG];
    
    if (!imageView)
    {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-2, -22, user.frame.size.width+3, user.frame.size.height+22)];
        imageView.image = [UIImage imageNamed:@"win.png"];
        imageView.tag = WINVIEWTAG;
        [user addSubview:imageView];
        [imageView release];
    }
    
    [user WinerLightlalo:4];
    // [self YouWinAnimationWithCount:@1];
    
    UIImageView  *imageViewYouwin = (UIImageView *)[self.view viewWithTag:YOUWINVIEWTAG];
    if (!imageViewYouwin)
    {
        imageViewYouwin = [[UIImageView alloc] initWithFrame:CGRectMake(140,-60, 240, 60)];
        [self insertViewToFit:imageViewYouwin];
        imageViewYouwin.image = [UIImage imageNamed:@"you_win.png"];
        imageViewYouwin.tag = YOUWINVIEWTAG;
        [imageViewYouwin release];
    }
    
    
    
    [UIView animateWithDuration:0.2f
                     animations:^
     {
     imageViewYouwin.transform = CGAffineTransformMakeTranslation(0, fYtrantion);
     } completion:^(BOOL finish)
     {
     
     
     if (iCount == 15)
     {
     sleep(1);
     
     [imageViewYouwin removeFromSuperview];
     UIView  *View = [user viewWithTag:WINVIEWTAG];
     if (View)
     {
     [View removeFromSuperview];
     }
     
     }else
     {
     if (iCount%2 == 0)
     {
     [self youWinAni:140 icount:iCount+1];
     }else
     {
     [self youWinAni:65+(iCount+1)*5 icount:iCount+1];
     }
     
     }
     
     }];
    
    [pool drain];
    
    
}

-(void)YouWinAnimationWithCount:(NSNumber *)number
{
    
    int icount = [number intValue];
    NSArray     *array = [NSArray  arrayWithObjects:@"20",@"30",@"50",@"60",@"70",@"80",@"90",@"100",@"110",@"120",@"130",@"140",@"1405",@"140",@"135",nil];
    
    UIImageView  *imageViewYouwin = (UIImageView *)[self.view viewWithTag:YOUWINVIEWTAG];
    if (!imageViewYouwin)
    {
        imageViewYouwin = [[UIImageView alloc] initWithFrame:CGRectMake(140,-60, 240, 60)];
        [self insertViewToFit:imageViewYouwin];
        imageViewYouwin.image = [UIImage imageNamed:@"you_win.png"];
        imageViewYouwin.tag = YOUWINVIEWTAG;
        [imageViewYouwin release];
    }
    CGFloat         fYpoint = 140;
    if (icount/2 < [array count] && icount%2 != 0)
    {
        fYpoint = [[array objectAtIndex:icount/2] floatValue];
        
    }else if(icount >= 20)
    {
        UIView  *View = [self.view viewWithTag:WINVIEWTAG];
        if (View)
        {
            [View removeFromSuperview];
        }
        [imageViewYouwin removeFromSuperview];
        return;
    }else if (icount%2 == 0 && icount/2 < [array count])
    {
        fYpoint = 140;
    }
    
    
    NSLog(@"number:%@ fypoint:%f",number,fYpoint);
    
    
    CGFloat  aninTime = 0.3f;
    CABasicAnimation   *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.autoreverses = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.repeatCount = 0;
    animation.cumulative = YES;
    animation.removedOnCompletion = NO;
    
    
    if (fYpoint != 140)
    {
        // animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(imageViewYouwin.center.x, 140)];
        aninTime = 0.25f;
        
    }else
    {
        //  animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(imageViewYouwin.center.x, [[array objectAtIndex:icount/2] floatValue])];
        
    }
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(imageViewYouwin.center.x, fYpoint)];
    animation.duration = aninTime;
    [imageViewYouwin.layer addAnimation:animation forKey:[number description]];
    
    [self performSelector:@selector(YouWinAnimationWithCount:)
               withObject:[NSNumber numberWithInt:icount+1]
               afterDelay:aninTime];
    
}



-(void)setWiner:(RJFUserImageView *)userView  index:(NSInteger)winIndex getChips:(NSInteger)chips
{
    
    return;
    if (userView.hidden || userView.userType == NOUSER)
    {
        return;
    }
    
    [RJFaudioPlay PlayMyAudio:@"chip.mp3"];
    userView.Gameplayer.bringChip += chips;
    
    if (userView.Gameplayer.bringChip >= 0)
    {
        userView.labelWeath.text = [DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:userView.Gameplayer.bringChip returnType:GAMESHOWTYPE]];
    }else
    {
        userView.labelWeath.text = @"0";
        logMyLogInfo(@".....  getWiner unboral chip:%d",userView.Gameplayer.bringChip);
    }
    
    logMyLogInfo(@"))))))))))))) setwiner:%@",userView);
    //  m_lTotalChipIndesk -= chips;
    
    if (0 == m_lTotalChipIndesk)
    {
        labelChips.text = @"";
    }else if(m_lTotalChipIndesk > 0)
    {
        
        labelChips.text = @"";
    }
    
    
    [self performSelector:@selector(CollectALLchip:)
               withObject:userView
               afterDelay:0.2f];
    
    
}


-(void)setUserviewWinCard:(RJFUserImageView *)userView cardSort:(int8_t *)cardSort cardNumber:(int)cardNumber
{
    if (userView.hidden || userView.userType == NOUSER)
    {
        return;
    }
    
    
    
    for (int i = 0;i < 7;i++)
    {
        
        int count = -1;
        for (int j = 0; j < cardNumber; j++)
        {
            
            if (i == cardSort[j])
            {
                count = 1;
                //logMyLogInfo(@"cardsort[%d] == %d",j,cardSort[j]);
                break;
            }
            
            
        }
        if (count == -1)
        {
            if (i < 5)
            {
                UIImageView  *imageView = [m_arrayStoreCardView objectAtIndex:i];
                [imageView setAlpha:0.5f];
                [imageView setFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y+10, imageView.frame.size.width, imageView.frame.size.height)];
            }else
            {
                [userView setCardAlpha:i];
                /*  if (i == 5)
                 {
                 userView.imageViewCardOne.alpha = 0.5;
                 
                 }else if (i == 6)
                 {
                 userView.imageViewCardTwo.alpha = 0.5;
                 }*/
            }
        }
        
    }
    
    
}


//01356
#pragma mark host animation
/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 07
 *  @brief
 *          set the the object as host and move the view host to object
 *  @param
 *          object
 *                  The host userview
 *  @param
 *          bHide
 *              if YES, the view is hidden. Otherwise is unhide
 *	@return
 *          NONE
 *
 */
-(void)setHostLogo:(RJFUserImageView *)object bhide:(BOOL)bHide
{
    
    
    UIImageView   *imgeView = (UIImageView *)[self.view viewWithTag:HOSTVIEWTAG];
    [imgeView setHidden:bHide];
    
    if (object.hidden || object.userType == NOUSER)
    {
        [imgeView setHidden:YES];
        return;
    }
    
    [self setInfoAccordrect:m_arrayStoreUserRectInfo];
    
    if (!imgeView)
    {
        imgeView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 40, 12.5, 12.5)];
        imgeView.image = [UIImage imageNamed:@"hostlogo.png"];
        imgeView.tag = HOSTVIEWTAG;
        [self insertViewToFit:imgeView];
    }
    
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    // [UIView setAnimationDelay:0.3f];
    [UIView setAnimationDuration:0.7f];
    
    [imgeView setFrame:object.hostLogoRect];
    [UIView commitAnimations];
    
    
    
    
    
}




/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 07
 *  @brief
 *          make the userView in desk or change view info
 *  @param
 *          array
 *                  The array conntain the dicInfo(user info)
 *                  array contain 8 dicinfo.
 *                  KEY      --------------------      VALUE
 *                  PLAYER   --------------------      (GamePlayer *)Player
 *                  HasPlayer  -----------------       (NSNumber or NSString)hasPlayer
 *
 *	@return
 *          NONE
 *
 */
#pragma mark add user image


-(void)addUserImagview:(NSArray*) array
{
    
    if ([array count] < MAXPERSONNUMBER)
    {
        logMyLogInfo(@"has not enough person");
        return;
    }
    
    
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    if ([m_arrayStoreUserView count])
    {
        NSArray  *array = [NSArray arrayWithArray:m_arrayStoreUserRectInfo];
        for (int i = 0;i < [m_arrayStoreUserView count];i++)
        {
            RJFUserImageView  *view =[m_arrayStoreUserView objectAtIndex:i];
            [view setFrame:[[[array objectAtIndex:i] valueForKey:@"FRAME"] CGRectValue]];
        }
    }
    //   [m_lockForArray lock];
    [m_arrayStoreUserView removeAllObjects];
    [m_arrayStoreUserRectInfo removeAllObjects];
    
    //NSInteger   itag = 12345;
    int iCount = 3;
    float  fwidth = 55+LINEWIDTH;
    float  fhight = 80+LINEWIDTH;
    float  fSep = 45;
    float  fChipWidth = 80;
    float  fChipHeight = 15;
    CGFloat  ffaceViewHeight = 24;
    for (int i = 0; i < iCount; i++)
    {
        
        
        RJFUserImageView  *userView = (RJFUserImageView *)[self.view viewWithTag:USERIMAGEVIEWTAG+i];
        CGRect   rect = CGRectMake(95+fwidth*i+fSep*i,10,fwidth, fhight);
        if (!userView)
        {
            userView = [[RJFUserImageView alloc] initWithFrame:rect];
            userView.superViewControl = self;
            [self.view addSubview:userView];
            userView.tag = USERIMAGEVIEWTAG+i;
            
            [userView release];
        }else
        {
            [userView setHidden:NO];
        }
        
        //
        switch (i)
        {
            case 0:
                userView.chipRect = CGRectMake(rect.origin.x+rect.size.width+15, rect.origin.y+rect.size.height-30, fChipWidth, fChipHeight);
                userView.hostLogoRect = CGRectMake(87+fwidth*i+fSep*i, fhight, 12.5, 12.5);
                break;
            case 2:
                userView.chipRect = CGRectMake(rect.origin.x+rect.size.width+15, rect.origin.y+rect.size.height-30, fChipWidth, fChipHeight);
                userView.hostLogoRect = CGRectMake(93+fwidth*i+fSep*i, fhight, 12.5, 12.5);
                break;
            case 1:
                userView.chipRect = CGRectMake(rect.origin.x+rect.size.width+15, rect.origin.y+rect.size.height-30, fChipWidth, fChipHeight);
                userView.hostLogoRect = CGRectMake(93+fwidth*i+fSep*i,fhight+2, 12.5, 12.5);
            default:
                break;
        }
        
        userView.speakRect = CGRectMake(95+fwidth*i+fSep*i-50, 10+20, 69, 28);
        userView.faceRect = CGRectMake(rect.origin.x-20, 10, ffaceViewHeight, ffaceViewHeight);
        NSDictionary  *dicInfo  = [NSDictionary dictionaryWithObjectsAndKeys:[NSValue valueWithCGRect:rect],@"FRAME",[NSValue valueWithCGRect:userView.chipRect],@"CHIPRECT",[NSValue valueWithCGRect:userView.hostLogoRect],@"HOSTRECT",[NSValue valueWithCGRect:userView.speakRect],@"SPEAKRECT",[NSValue valueWithCGRect:userView.faceRect],@"FACERECT",nil];
        [m_arrayStoreUserRectInfo addObject:dicInfo];
        [m_arrayStoreUserView addObject:userView];
        
        userView.originalchipRect = userView.chipRect;
        userView.originalfaceRect = userView.originalfaceRect;
        userView.originalFrameRect = userView.frame;
        userView.originalHostLogoRect = userView.hostLogoRect;
        userView.originalspeakRect = userView.originalspeakRect;
        
        NSDictionary   *dicTemp = [array objectAtIndex:i];
        [userView SetSeatState:![[dicTemp valueForKey:@"HasPlayer"] boolValue] MySelfOrOther:NO GAempLayer:[dicTemp valueForKey:@"PLAYER"]];
        
    }
    
    iCount ++;
    RJFUserImageView  *userViewright = (RJFUserImageView *)[self.view viewWithTag:USERIMAGEVIEWTAG+iCount-1];
    CGRect rect = CGRectMake(420,90,fwidth, fhight);
    if (!userViewright)
    {
        userViewright = [[RJFUserImageView alloc] initWithFrame:rect];
        [self.view addSubview:userViewright];
        userViewright.superViewControl = self;
        userViewright.tag = USERIMAGEVIEWTAG+iCount-1;
        [userViewright release];
    }else
    {
        [userViewright setHidden:NO];
    }
    
    userViewright.chipRect = CGRectMake(rect.origin.x-40,rect.origin.y+30, fChipWidth, fChipHeight);
    userViewright.hostLogoRect = CGRectMake(420-8,90-5, 12.5, 12.5);
    userViewright.speakRect = CGRectMake(413, 90-20, 69, 28);
    userViewright.faceRect = CGRectMake(390,90-20, ffaceViewHeight, ffaceViewHeight);
    NSDictionary  *dicTemp  = [NSDictionary dictionaryWithObjectsAndKeys:[NSValue valueWithCGRect:rect],@"FRAME",[NSValue valueWithCGRect:userViewright.chipRect],@"CHIPRECT",[NSValue valueWithCGRect:userViewright.hostLogoRect],@"HOSTRECT",[NSValue valueWithCGRect:userViewright.speakRect],@"SPEAKRECT",[NSValue valueWithCGRect:userViewright.faceRect],@"FACERECT",nil];
    [m_arrayStoreUserRectInfo addObject:dicTemp];
    [m_arrayStoreUserView addObject:userViewright];
    userViewright.originalchipRect = userViewright.chipRect;
    userViewright.originalfaceRect = userViewright.originalfaceRect;
    userViewright.originalFrameRect = userViewright.frame;
    userViewright.originalHostLogoRect = userViewright.hostLogoRect;
    userViewright.originalspeakRect = userViewright.originalspeakRect;
    
    
    NSDictionary  *dicInfo = [array objectAtIndex:3];
    [userViewright SetSeatState:![[dicInfo valueForKey:@"HasPlayer"] boolValue] MySelfOrOther:NO GAempLayer:[dicInfo valueForKey:@"PLAYER"]];
    
    
    for (int i = iCount+2; i >= iCount; i--)
    {
        CGRect rect = CGRectMake(95+fwidth*(i-iCount)+fSep*(i-iCount),185,fwidth, fhight);
        RJFUserImageView  *userView = (RJFUserImageView *)[self.view viewWithTag:USERIMAGEVIEWTAG+i];
        if (!userView)
        {
            userView = [[RJFUserImageView alloc] initWithFrame:rect];
            [self.view addSubview:userView];
            userView.tag = USERIMAGEVIEWTAG+i;
            userView.superViewControl = self;
            [userView release];
        }else
        {
            
            [userView setHidden:NO];
        }
        
        // [m_arrayStoreUserRect addObject:[NSValue valueWithCGRect:rect]];
        [m_arrayStoreUserView addObject:userView];
        userView.chipRect = CGRectMake(rect.origin.x-26,rect.origin.y-3, fChipWidth, fChipHeight);
        userView.hostLogoRect = CGRectMake(95+fwidth*(i-iCount)+fSep*(i-iCount)+fwidth-6.25,185, 12.5, 12.5);
        
        userView.speakRect = CGRectMake(95+fwidth*(i-iCount)+fSep*(i-iCount)-50, 185+20, 69, 28);
        userView.faceRect = CGRectMake(95+fwidth*(i-iCount)+fSep*(i-iCount)-20, 185, ffaceViewHeight, ffaceViewHeight);
        
        NSDictionary  *dicInfo = [array objectAtIndex:i];
        if (i == iCount+2)
        {
            userView.speakRect = CGRectMake(95+fwidth*(i-iCount)+fSep*(i-iCount)+30, 185+20, 69, 28);
            dicInfo = [array objectAtIndex:iCount];
        }else if (i == iCount)
        {
            dicInfo = [array objectAtIndex:iCount+2];
        }
        
        
        
        NSDictionary  *dicTemp1  = [NSDictionary dictionaryWithObjectsAndKeys:[NSValue valueWithCGRect:rect],@"FRAME",[NSValue valueWithCGRect:userView.chipRect],@"CHIPRECT",[NSValue valueWithCGRect:userView.hostLogoRect],@"HOSTRECT",[NSValue valueWithCGRect:userView.speakRect],@"SPEAKRECT",[NSValue valueWithCGRect:userView.faceRect],@"FACERECT",nil];
        [m_arrayStoreUserRectInfo addObject:dicTemp1];
        
        userView.originalchipRect = userView.chipRect;
        userView.originalfaceRect = userView.originalfaceRect;
        userView.originalFrameRect = userView.frame;
        userView.originalHostLogoRect = userView.hostLogoRect;
        userView.originalspeakRect = userView.originalspeakRect;
        
        [userView SetSeatState:![[dicInfo valueForKey:@"HasPlayer"] boolValue] MySelfOrOther:NO GAempLayer:[dicInfo valueForKey:@"PLAYER"]];
    }
    
    
    
    iCount += 3;
    RJFUserImageView  *userViewleft = (RJFUserImageView *)[self.view viewWithTag:USERIMAGEVIEWTAG+iCount];
    CGRect rect2 = CGRectMake(10,90,fwidth, fhight);
    if (!userViewleft)
    {
        
        userViewleft = [[RJFUserImageView alloc] initWithFrame:rect2];
        [self.view addSubview:userViewleft];
        userViewleft.tag = USERIMAGEVIEWTAG+iCount;
        userViewleft.superViewControl = self;
        [userViewleft release];
    }else
    {
        [userViewleft setHidden:NO];
    }
    
    dicInfo = [array objectAtIndex:7];
    [userViewleft SetSeatState:![[dicInfo valueForKey:@"HasPlayer"] boolValue] MySelfOrOther:NO GAempLayer:[dicInfo valueForKey:@"PLAYER"]];
    
    //[m_arrayStoreUserRect addObject:[NSValue valueWithCGRect:rect2]];
    [m_arrayStoreUserView addObject:userViewleft];
    userViewleft.chipRect = CGRectMake(rect2.origin.x+rect.size.width+10,rect2.origin.y+2, fChipWidth, fChipHeight);
    userViewleft.hostLogoRect = CGRectMake(5+fwidth,90+fhight/4, 12.5, 12.5);
    userViewleft.speakRect = CGRectMake(5, 90-20, 69, 28);
    userViewleft.faceRect = CGRectMake(fwidth+10, 75, ffaceViewHeight, ffaceViewHeight);
    
    
    NSDictionary  *dicTemp1  = [NSDictionary dictionaryWithObjectsAndKeys:[NSValue valueWithCGRect:rect2],@"FRAME",[NSValue valueWithCGRect:userViewleft.chipRect],@"CHIPRECT",[NSValue valueWithCGRect:userViewleft.hostLogoRect],@"HOSTRECT",[NSValue valueWithCGRect:userViewleft.speakRect],@"SPEAKRECT",[NSValue valueWithCGRect:userViewleft.faceRect],@"FACERECT",nil];
    [m_arrayStoreUserRectInfo addObject:dicTemp1];
    
    userViewleft.originalchipRect = userViewleft.chipRect;
    userViewleft.originalfaceRect = userViewleft.originalfaceRect;
    userViewleft.originalFrameRect = userViewleft.frame;
    userViewleft.originalHostLogoRect = userViewleft.hostLogoRect;
    userViewleft.originalspeakRect = userViewleft.originalspeakRect;
    
    
    
    //
    
    
    
    
    if (m_gameControltype != FRESHTEACHTYPE)
    {
        
        [self InitUserInfoAfterEnter:*m_initRoomInfo];
        
    }else if(m_gameControltype == FRESHTEACHTYPE)
    {
        RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:1];
        userView.imageViewPhotoView.image = [UIImage imageNamed:@"user5.png"];
        userView = [m_arrayStoreUserView objectAtIndex:2];
        userView.imageViewPhotoView.image = [UIImage imageNamed:@"user3.png"];
    }
    
    //  [m_lockForArray unlock];
    if (m_myRoomAllinfo.bankerIndex < 0 ||
        (m_myRoomAllinfo.bankerIndex == m_iRealSeat && m_objShareUser.userHasSitDown) ||
        m_myRoomAllinfo.bankerIndex > MAXPERSONNUMBER
        || m_gameStatus != GAMENOWISPLAYING)
    {
        [self setHostLogo:[m_arrayStoreUserView objectAtIndex:0] bhide:YES];
        logMyLogInfo(@"4.............set host hidden bankerID:%d m_irealSeatID:%d m_gamestatus:%d",m_myRoomAllinfo.bankerIndex,m_iRealSeat,m_gameStatus);
    }
    
    for (RJFUserImageView  *userView in m_arrayStoreUserView)
    {
        [userView setOtherViewframe:nil];
        if (userView.Gameplayer == nil || userView.Gameplayer.userState == 9)
        {
            [userView setRecvOut:YES];
        }
    }
    
    [pool drain];
}




/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 07
 *  @brief
 *          fapai
 *  @param
 *          index
 *              The begin index of user
 *  @param
 *          strfirstCard
 *              userFirst card(myuser)
 *  @param
 *          strSecondCard
 *              user second card(myuser)
 *  @see
 *                  Fapai:FirstCard:SecondCard
 *
 *	@return
 *          NONE
 *
 */
#pragma mark add fa card
-(void)BeginFapai:(NSInteger)index FirstCard:(NSString *)strFirstCard SecondCard:(NSString *)strSecondCard
{
    logMyLogInfo(@"we will fapai start");
    m_index = index;
    m_bFirstCard =  YES;
    m_arrbFlag[2] = YES;
    m_bHasFapai = YES;
    for (RJFUserImageView  *imageView in m_arrayStoreUserView)
    {
        imageView.imageViewCardTwo.image = nil;
        imageView.imageViewCardOne.image = nil;
    }
    [self Fapai:index FirstCard:strFirstCard SecondCard:strSecondCard];
    
}



/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 07
 *  @brief
 *         deal card to everyOne
 *  @param
 *          index
 *                  The host userview index
 *  @param
 *          strFirstCard
 *              my first card(such as "black1.png")
 *  @param
 *          strSecondCard
 *              my second card(such as "black2.png")
 *	@return
 *          NONE
 *
 */
-(void)Fapai:(NSInteger)index FirstCard:(NSString *)strFirstCard SecondCard:(NSString *)strSecondCard
{
    
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    index = index%MAXPERSONNUMBER;
    logMyLogInfo(@"************index:%d",index);
    if (index == m_index)
    {
        if (m_arrbFlag[2])
        {
            m_arrbFlag[2] = NO;
        }else
        {
            m_bFirstCard = NO;
        }
    }
    
    RJFUserImageView  *SomeUser = [m_arrayStoreUserView objectAtIndex:index];
    
    
    if (SomeUser.imageViewCardTwo.image != nil)
    {
        for (RJFUserImageView  *UserView in m_arrayStoreUserView)
        {
            if (UserView.hidden || UserView.userType == NOUSER)
            {
                continue;
            }
            /*if (UserView.Gameplayer.seatID != m_iRealSeat  &&
                [self hasUsercardFromServer:UserView.Gameplayer.seatID]
                && UserView.Gameplayer.userState != 9)
            {
                UserView.imageViewCardOne.image =  [UIImage imageNamed:@"card_back_left15.png"];
                UserView.imageViewCardTwo.image = [UIImage imageNamed:@"card_back_right15.png"];
                UserView.alpha = 1.0;
            }else if(UserView.Gameplayer.seatID == m_iRealSeat
                     && [self hasUsercardFromServer:UserView.Gameplayer.seatID])
            {
                UserView.imageViewCardOne.image =  [UIImage imageNamed:strFirstCard];
                UserView.imageViewCardTwo.image = [UIImage imageNamed:strSecondCard];
                
            }*/
        }
        
        [pool drain];
        return;
    }
    
    
    
    if (SomeUser.userType == NOUSER
        || SomeUser.hidden
        || SomeUser.Gameplayer.userState == 9
        || SomeUser.userType == 8)
    {
        [self Fapai:index+1 FirstCard:strFirstCard SecondCard:strSecondCard];
        [pool drain];
        return;
    }
    
    if (m_gameControltype != FRESHTEACHTYPE)
    {
        if (SomeUser.Gameplayer != nil && ![self hasUsercardFromServer:SomeUser.Gameplayer.seatID])
        {
            if (m_roomIDandPath->roomType != 5)
            {
                [SomeUser setUserState:8];
                if (SomeUser.Gameplayer.seatID == m_iRealSeat)
                {
                    [btnStand setHidden:NO];
                    [self setLMREnable:NO Hide:YES];
                }
            }
            
            [self Fapai:index+1 FirstCard:strFirstCard SecondCard:strSecondCard];
            [pool drain];
            return;
        }
        
    }
    
    
    
    
    CGRect rect = CGRectMake(200, 140, 15, 25);
    UIImageView   *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.tag = 13452;
    [self insertViewToFit:imageView];
    
    imageView.image = [UIImage imageNamed:@"card_back.png"];
    [imageView release];
    aniUserInfo *aniInfo = malloc(sizeof(aniUserInfo));
    aniInfo->index = index;
    aniInfo->strFirstCard = strFirstCard;
    aniInfo->strsecondCard = strSecondCard;
    aniInfo->imageView = imageView;
    [UIView beginAnimations:SomeUser.Gameplayer.UserName context:aniInfo];
    [UIView setAnimationDuration:0.2f];
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    CGRect Goalrect = [SomeUser frame];
    float  xPoint = Goalrect.origin.x+Goalrect.size.width-20;
    float  yPoint = Goalrect.origin.y+Goalrect.size.height-20;
    Goalrect = CGRectMake(xPoint,yPoint-15, 15, 25);
    if (SomeUser.userType == MYSELF)
    {
        Goalrect = [SomeUser convertRect:SomeUser.imageViewCardOne.frame toView:self.view];
    }
    [imageView setFrame:Goalrect];
    [UIView commitAnimations];
    
    
    [pool drain];
    
}



- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    
    aniUserInfo  *userInfo = (aniUserInfo*)context;
    RJFUserImageView  *SomeUser = [m_arrayStoreUserView objectAtIndex:userInfo->index];
    // logMyLogInfo(@"11");
    int index = userInfo->index;
    //   logMyLogInfo(@"11");
    NSString *strFirstCard = userInfo->strFirstCard;
    //    logMyLogInfo(@"11");
    NSString *strSecondCard = userInfo->strsecondCard;
    ///   logMyLogInfo(@"11");
    UIImageView  *imageView = userInfo->imageView;
    //   logMyLogInfo(@"11");
    
    [RJFaudioPlay PlayMyAudio:@"board.mp3"];
    if (SomeUser.userType == MYSELF && !m_bFirstCard)
    {
        
        // SomeUser.imageViewCardTwo.image = [UIImage imageNamed:strSecondCard];
        [self roateCardAccordInfo:SomeUser.imageViewCardTwo view:imageView FirstImage:@"card_back.png" SecondImage:strSecondCard];
        [self Fapai:index+1 FirstCard:strFirstCard SecondCard:strSecondCard];
        NSLog(@"RrrrrrrrrrfirstCard:%@",strFirstCard);
        
        //[pool drain];
        return ;
        
    }
    if (SomeUser.userType == MYSELF && m_bFirstCard)
    {
        
        
        [self roateCardAccordInfo:SomeUser.imageViewCardOne view:imageView FirstImage:@"card_back.png" SecondImage:strFirstCard];
        [self Fapai:index+1 FirstCard:strFirstCard SecondCard:strSecondCard];
        NSLog(@"RrrrrrrrrrsecondCard:%@",strSecondCard);
        //  [RJFaudioPlay PlayMyAudio:@"board.mp3"];
        //[pool drain];
        return ;
    }
    
    if (m_bFirstCard)
    {
        SomeUser.imageViewCardOne.image = [UIImage imageNamed:@"card_back_left15.png"];
        NSLog(@"111111111notMyturn:%@",SomeUser.Gameplayer);
        
    }else
    {
        SomeUser.imageViewCardTwo.image = [UIImage imageNamed:@"card_back_right15.png"];
        NSLog(@"111111111notMyturn:%@",SomeUser.Gameplayer);
    }
    
    [imageView removeFromSuperview];
    [self Fapai:index+1 FirstCard:strFirstCard SecondCard:strSecondCard];
    
    free(context);
    context = NULL;
    // logMyLogInfo(@"%@",[dicInfo valueForKey:@"USER"]);
    
}
-(void)roateCardAccordInfo:(UIImageView *)imageCardOneorTwo
view:(UIImageView *)imageView
FirstImage:(NSString *)strFirist
SecondImage:(NSString *)strSecond
{
    
    imageView.image = [UIImage imageNamed:strSecond];
    [UIView animateWithDuration:0.20f
                     animations:^
     {
     imageView.layer.transform = CATransform3DMakeRotation(-2*M_PI, 1, 1, 1);
     
     } completion:^(BOOL finish)
     {
     
     [imageView removeFromSuperview];
     imageCardOneorTwo.image = [UIImage imageNamed:strSecond];
     }];
    
    
}
#pragma mark change seat

-(void)UpdateSeatAccordIndex:(NSInteger)index
{
    
    if (index <= 5)
    {
        index = 5-index;
    }else if(index == 7)
    {
        index = 6;
    }else if (index == 6)
    {
        index = 7;
    }
    
    
    [UIView animateWithDuration:0.7f
                     animations:^
     {
     NSArray  *array = [NSArray arrayWithArray:m_arrayStoreUserRectInfo];
     for (int i = 0; i < [m_arrayStoreUserView count]; i++)
     {
     RJFUserImageView  *UserView = [m_arrayStoreUserView objectAtIndex:i];
     CGRect   rect2 = CGRectZero;
     NSDictionary  *dicInfo =  [array objectAtIndex:(i+index)%[array count]];
     rect2 = [[dicInfo valueForKey:@"FRAME"] CGRectValue];
     [UserView setFrame:rect2];
     UserView.chipRect = [[dicInfo valueForKey:@"CHIPRECT"] CGRectValue];
     UserView.hostLogoRect = [[dicInfo valueForKey:@"HOSTRECT"] CGRectValue];
     UserView.faceRect = [[dicInfo valueForKey:@"FACERECT"] CGRectValue];
     UserView.speakRect = [[dicInfo valueForKey:@"SPEAKRECT"] CGRectValue];
     [UserView setOtherViewframe:nil];
     
     }
     
     } completion:^(BOOL finish)
     {
     
     
     if (m_gameControltype == FRESHTEACHTYPE)
     {
     return;
     }
     [self ActionForEnter:*m_initRoomInfo];
     if ([m_arrayStoreChipView count])
     {
     for (RJFUserImageView  *userView in m_arrayStoreUserView)
     {
     [userView setOtherViewframe:nil];
     int8_t  seat = userView.Gameplayer.seatID;
     if (seat < 0 || seat > MAXPERSONNUMBER)
     {
     continue;
     }
     if (seat == m_myRoomAllinfo.bankerIndex)
     {
     [self setHostLogo:[m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:seat]] bhide:NO];
     }
     
     
     }
     
     
     }
     
     }];
    
    if (m_gameStatus != GAMENOWISPLAYING)
    {
        [self setHostLogo:[m_arrayStoreUserView objectAtIndex:0] bhide:YES];
        logMyLogInfo(@"5.............set host hidden");
    }
    
    
}

#pragma mark count down


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 13
 *  @brief
 *          start count down action
 *  @param
 *          index
 *                  the count number:(sec)
 *	@return
 *          NONE
 *
 */
-(void)StartCountDown:(int)index
{
    // [self stopCountDown:nil];
    
    [self CleanAfterEveryGame:nil];
    for (UIView  *view in m_arrayStoreCardView)
    {
        view.hidden = YES;
    }
    for (RJFUserImageView  *view in m_arrayStoreUserView)
    {
        view.labelRecordGiveChip.text = @"";
        [view setAlpha:1];
        [view setUserState:0];
    }
    m_bNeedStopCountDown = NO;
    m_gameStatus = GAMENOWISCOUNTDOWNING;
    if (m_objShareUser.userHasSitDown)
    {
        [btnStand setHidden:NO];
    }
    if (m_gameControltype == FRESHTEACHTYPE)
    {
        [self setNextAndPreEnable:NO];
        [btnStand setHidden:YES];
    }
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    if (!imageViewCountDownView)
    {
        imageViewCountDownView = [[UIImageView alloc] initWithFrame:CGRectMake(190, 100, 80, 80)];
        [self insertViewToFit:imageViewCountDownView];
        [imageViewCountDownView release];
    }
    
    
    NSArray   *array = [NSArray arrayWithObjects:[UIImage imageNamed:@"9.png"],[UIImage imageNamed:@"8.png"],[UIImage imageNamed:@"7.png"],[UIImage imageNamed:@"6.png"],[UIImage imageNamed:@"5.png"],[UIImage imageNamed:@"4.png"],[UIImage imageNamed:@"3.png"],[UIImage imageNamed:@"2.png"],[UIImage imageNamed:@"1.png"],nil];//[UIImage imageNamed:@"0.png"],nil];
    
    NSMutableArray   *arrayAnitian = [[[NSMutableArray alloc] init] autorelease];
    for (int i = [array count]-index;i < [array count] ;i++)
    {
        [arrayAnitian addObject:[array objectAtIndex:i]];
        
    }
    //[UIView setAnimationDuration:index*1.0f];
    imageViewCountDownView.animationImages = arrayAnitian;
    imageViewCountDownView.tag = COUTNDOWNVIEWTAG;
    imageViewCountDownView.animationDuration = index*1.0f;
    imageViewCountDownView.animationRepeatCount = 1;
    [imageViewCountDownView startAnimating];
    
    
    NSThread   *thread = [[NSThread alloc] initWithTarget:self
                                                 selector:@selector(CountDownStop:)
                                                   object:[NSNumber numberWithInt:index]];
    [thread setName:@"COUNT"];
    [thread start];
    [thread release];
    //  [NSThread detachNewThreadSelector:@selector(CountDownStop:) toTarget:self withObject:[NSNumber numberWithInt:index]];
    
    [pool drain];
    
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 13
 *  @brief
 *         count down stop function
 *  @param
 *          iNumber
 *                  the countdown whole number(iNumber sec)
 *	@return
 *          NONE
 *
 */
-(void)CountDownStop:(NSNumber *)iNumber
{
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    for (int i = [iNumber intValue]; i >= 0; i--)
    {
        logMyLogInfo(@"totalNumbr:%@ countNumber:%d",iNumber,i);
        if (m_bNeedStopCountDown)
        {
            logMyLogInfo(@"stop count because someone stand or leave");
            return;
        }
        
        
        if (i <= 1)
        {
            [btnStand setHidden:YES];
        }
        sleep(1);
    }
    
    if (m_bNeedStopCountDown)
    {
        logMyLogInfo(@"stop count because some reseaon");
        if ([self GetCurrentPlayingCount:nil] < 2)
        {
            [self gatherchips:nil];
            [self CleanAfterEverybetchip:nil];
            [self CleanAfterEveryGame:nil];
        }
        
        return;
    }else
    {
        //m_gameStatus =  GAMENOWISPLAYING;
        [self StartGame:nil];
        logMyLogInfo(@"__________________start game after count down stop___________________");
    }
    
    
    
    [pool drain];
    
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 13
 *  @brief
 *          kill the count down action
 *  @param
 *          Thread
 *                  Now is nil
 *	@return
 *          NONE
 *
 */
-(void)stopCountDown:(id)Thread
{
    m_bNeedStopCountDown = YES;
    UIImageView  *imageview = (UIImageView *)[self.view viewWithTag:COUTNDOWNVIEWTAG];
    if (imageview)
    {
        [imageview stopAnimating];
        // [imageview removeFromSuperview];
    }
    if (m_gameControltype == FRESHTEACHTYPE)
    {
        [self setNextAndPreEnable:NO];
    }
}


-(void)StartGame:(id)Thread
{
    //   [self AnimationTest:nil];
    //    @synchronized (self)
    //    {
    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    dispatch_async(queue, ^
    //    {
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    
    [self stopTimeSlide:nil];
    if (m_objShareUser.userHasSitDown)
    {
        
        [btnStand setHidden:YES];
    }
    if (m_gameControltype == FRESHTEACHTYPE)
    {
        m_gameStatus = GAMENOWISPLAYING;
        [RJFaudioPlay PlayMyAudio:@"start.mp3"];
        [self setNextAndPreEnable:YES];
    }else
    {
        
        if (!m_bHasRecvStratInfo)
        {
            return;
        }
        m_gameStatus = GAMENOWISPLAYING;
        [RJFaudioPlay PlayMyAudio:@"start.mp3"];
        m_bmustWait = YES;
        [self CleanAfterEveryGame:nil];
        
        if ([self GetCurrentPlayingCount:nil] <= 1)
        {
            if (m_objShareUser.userHasSitDown)
            {
                [btnStand setHidden:NO];
            }
            
            [self setHostLogo:[m_arrayStoreUserView objectAtIndex:0] bhide:YES];
            logMyLogInfo(@"6.............set host hidden");
            [pool drain];
            return;
        }
        logMyLogInfo(@"We will start game now");
        RJFUserImageView  *userView = nil;
        if (m_myRoomAllinfo.bankerIndex > -1 && m_myRoomAllinfo.bankerIndex < MAXPERSONNUMBER)
        {
            logMyLogInfo(@"We will sethost now");
            [self setHostLogo:[m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:m_myRoomAllinfo.bankerIndex]] bhide:NO];
        }
        
        
        if (m_bHasRecvStratInfo  && !m_bHasFapai)
        {
            NSString *strFirstCard = @"";
            NSString *strSecondCard = @"";
            
            if ([self hasUsercardFromServer:m_iRealSeat])
            {
                strFirstCard = [self accordSeatGetCard:m_iRealSeat FirstOrSecond:1];
                strSecondCard = [self accordSeatGetCard:m_iRealSeat FirstOrSecond:2];
            }
            [self BeginFapai:m_myRoomAllinfo.bankerIndex FirstCard:strFirstCard SecondCard:strSecondCard];
            
        }
        
        
        logMyLogInfo(@"@@1");
        
        logMyLogInfo(@"------------hehehehe------------\n\n");
        
        logMyLogInfo(@"@@2");
        if (m_myRoomAllinfo.roomSmallIndex > -1 && m_myRoomAllinfo.roomSmallIndex < MAXPERSONNUMBER)
        {
            logMyLogInfo(@"small index small blind:%d  seatID:%d",m_myRoomAllinfo.roomSmallblind,m_myRoomAllinfo.roomSmallIndex);
            userView = [m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:m_myRoomAllinfo.roomSmallIndex]];
            [userView.labelNameAndAction setText:LittleChip];
            [self BeginBetChips:m_myRoomAllinfo.roomSmallblind UserIndex:[self MakeSureNowindexFromNet:m_myRoomAllinfo.roomSmallIndex]];
        }
        
        logMyLogInfo(@"@@3");
        if (m_myRoomAllinfo.roomBigIndex > -1 && m_myRoomAllinfo.roomBigIndex < MAXPERSONNUMBER)
        {
            logMyLogInfo(@"big index big blind:%d  seatID:%d",m_myRoomAllinfo.roomBigbland,m_myRoomAllinfo.roomBigIndex);
            userView = [m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:m_myRoomAllinfo.roomBigIndex]];
            [self BeginBetChips:m_myRoomAllinfo.roomBigbland UserIndex:[self MakeSureNowindexFromNet:m_myRoomAllinfo.roomBigIndex]];
            [userView.labelNameAndAction setText:BigChip];
        }
        
        logMyLogInfo(@"@@4");
        if (m_bHasRecvStratInfo)
        {
            for (int i = 0; i < MAXPERSONNUMBER; i++)
            {
                if (m_arrStoreChip[i] < 0)
                {
                    continue;
                }
                int index = [self MakeSureNowindexFromNet:i];
                RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:index];
                if (userView.hidden || userView.userType == NOUSER)
                {
                    continue;
                }
                
                userView.Gameplayer.bringChip  = m_arrStoreChip[i];
                
                
                [userView.labelWeath setText:[NSString stringWithNeedTranfanNumber:userView.Gameplayer.bringChip returnType:GAMESHOWTYPE]];
                logMyLogInfo(@"**************111name:%@ chip:%d   arrchip:%d",userView.Gameplayer.UserName,userView.Gameplayer.bringChip,m_arrStoreChip[i]);
                logMyLogInfo(@"))))))))))))) Start GameInfo userView:%@",userView);
                
            }
        }
        
        
        
        logMyLogInfo(@"Start userTime here:%@ in STARTTIME",[NSDate date]);
        [self setLMRStateAccordCurrentOperSeat:m_myRoomAllinfo.operationID needShowDefaultInfo:YES];
        [self dealWithUndealrequest];
        
    }
    [pool drain];
    
    //  });
    
    //   }
    
    
}



#pragma mark button acion
//button action
/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 13
 *  @brief
 *          set the all view enable or not
 *  @param
 *          BIsEnable
 *                  if YES,enable. Otherwise unenable
 *	@return
 *          NONE
 *
 */
-(void)setAllcontrolEnable:(BOOL)BIsEnable
{
    for (id  view in [self.view subviews])
    {
        if ([view respondsToSelector:@selector(setEnabled:)])
        {
            [view setEnabled:BIsEnable];
        }
    }
}


-(void)backToPre:(id)Timer
{
    HideHUD(self, YES);
    if (self.navigationController.topViewController)
    {
        
        m_objShareUser.userHasSitDown = NO;
        [self.navigationController popViewControllerAnimated:YES];
        logMyLogInfo(@"pop if server not resopod");
    }
    logMyLogInfo(@"after Time:%@ topViewControl:%@",[NSDate date],self.navigationController.topViewController);
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 13
 *  @brief
 *         pop the face view
 *  @param
 *          sender
 *                  face button
 *	@return
 *          NONE
 *
 */
-(IBAction)clickFace:(UIButton *)sender
{
    
    if (!m_objShareUser.userHasSitDown)
    {
        
        [self SetWarningAlert:NSLocalizedString(@"未坐下玩家不能够发送信息", nil) withTime:1];
        return;
    }
    [self SetFaceViewHidden:NO];
    
    logMyLogInfo(@"face");
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 13
 *  @brief
 *         pop current view control. back to last view control
 *  @param
 *          sender
 *                  back button
 *	@return
 *          NONE
 *
 */
-(IBAction)clickBack:(UIButton *)sender
{
    
    // m_objShareUser.userHasSitDown = NO;
    //logMyLogInfo(@"%@",[self.navigationController viewControllers]);
    //[self.navigationController popViewControllerAnimated:YES];
    if (m_gameControltype == FRESHTEACHTYPE)
    {
        m_objShareUser.userHasSitDown = NO;
        //logMyLogInfo(@"%@",[self.navigationController viewControllers]);
        [self.navigationController popViewControllerAnimated:YES];
        
    }else
    {
        m_clickInsureMode = LEVEANOWVIEWMODE;
        NSString *strWarning = NSLocalizedString(@"提示\n\n确定离开本房间？", nil);
        if (m_gameStatus == GAMENOWISPLAYING && [self GetCurrentPlayingCount:nil] > 1 && m_iStartCount)
        {
            strWarning = NSLocalizedString(@"提示\n\n确定离开本房间？您已经下注的筹码将被扣除！", nil);
            
        }
        [RJFWarnView addinSelfview:self.view
                          delegate:self
                           message:strWarning
                        buttontype:BOTHBUTTON
                      InsureButton:INSURE CancelButton:CANCEL];
        logMyLogInfo(@"leave");
    }
    
    
    logMyLogInfo(@"back");
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 13
 *  @brief
 *          pop the speak  view
 *  @param
 *          sender
 *                  speak button
 *	@return
 *          NONE
 *
 */
-(IBAction)clickSpeakWord:(UIButton *)sender
{
    if (!m_objShareUser.userHasSitDown)
    {
        [self SetWarningAlert:NSLocalizedString(@"未坐下玩家不能够发送信息", nil) withTime:1];
        return;
    }
    [self SetSpeakViewHidden:NO];
    
    
    
    
    logMyLogInfo(@"speak word");
}


-(void)setSlideBarHide:(id)Thread
{
    UIView   *view = (UIView *)[self.view viewWithTag:SLIDERBGVIEWTAG];
    
    if (!view.hidden)
    {
        [btnRight setBackgroundImage:[UIImage imageNamed:@"button_blue.png"] forState:UIControlStateNormal];
        [btnRight setTitle:AddChip forState:UIControlStateNormal];
        
        UILabel  *label = (UILabel *)[self.view viewWithTag:LABELRECORDCHIPTAG];
        [label setHidden:YES];
        
        [view setHidden:YES];
        
    }
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 13
 *  @brief
 *          responed the left button
 *  @param
 *          sender
 *                  left button
 *	@return
 *          NONE
 *
 */
-(IBAction)clickLeft:(UIButton *)sender
{
    
    [RJFaudioPlay PlayMyAudio:@"click.mp3"];
    [self RemoveSubViewOrHideSubView:CGPointMake(0, 0)];
    UIImageView  *imageView =(UIImageView *) [sender viewWithTag:1];
    if (imageView && !imageView.hidden)
    {
        [self setLMRImageWhenClick:sender senderOrdex:0];
        return;
    }
    
    if (m_gameControltype == FRESHTEACHTYPE)
    {
        return;
    }
    
    [self setSlideBarHide:nil];
    
    
    
    NSString    *strTitle = [sender titleForState:UIControlStateNormal];
    if ([strTitle isEqualToString:KeepCard])
    {
        [self sendUserAction:actionkeepchip chips:0];
        m_userAction = actionkeepchip;
    }else if ([strTitle isEqualToString:GiveUpCard])
    {
        [self sendUserAction:actiongiveupCard chips:0];
        m_userAction = actiongiveupCard;
    }
    
    
    
    // [self youWinAni:nil];
    
    
    
}


-(void)SetWarningAlert:(NSString *)strMsg withTime:(NSTimeInterval)time
{
    
    UILabel   *label = [[UILabel alloc] initWithFrame:CGRectMake(120, 200, 250, 31)];
    [label setBackgroundColor:[UIColor grayColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:strMsg];
    [label setTextColor:[UIColor whiteColor]];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 10;
    [self insertViewToFit:label];
    [label performSelector:@selector(removeFromSuperview)
                withObject:nil
                afterDelay:time];
    [label release];
    
    
}

-(void)SetWarningAlert:(NSString *)strMsg withTime:(NSTimeInterval)time  withFrame:(CGRect)frame
{
    
    UILabel   *label = [[UILabel alloc] initWithFrame:frame];
    [label setBackgroundColor:[UIColor grayColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:strMsg];
    [label setTextColor:[UIColor whiteColor]];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 5;
    [self insertViewToFit:label];
    [label performSelector:@selector(removeFromSuperview)
                withObject:nil
                afterDelay:time];
    [label release];
    
    
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 13
 *  @brief
 *          setLMR button status
 *  @param
 *          sender
 *                  the action button
 *  @param
 *          index. indicate which button among LMR button
 *          index == 0, ----->btnLeft index == 1,------->btnMiddle,index == 2,------->btnRight
 *	@return
 *          NONE
 *
 */
-(void)setLMRImageWhenClick:(UIButton *)sender senderOrdex:(NSUInteger)index
{
    
    
    UIImage   *image = [UIImage imageNamed:@"hook_NO.png"];
    
    UIImageView  *imageView =(UIImageView *) [sender viewWithTag:1];
    BOOL  bHasHook = NO;
    
    if (imageView && !imageView.hidden)
    {
        if ([imageView.image isEqual:[UIImage imageNamed:@"hook_YES.png"]])
        {
            imageView.image = [UIImage imageNamed:@"hook_NO.png"];
            bHasHook = NO;
        }else
        {
            imageView.image = [UIImage imageNamed:@"hook_YES.png"];
            bHasHook = YES;
            // image = [UIImage imageNamed:@"hook_NO.png"];
        }
    }
    
    switch (index)
    {
        case 0:
            if (bHasHook)
            {
                m_userAutoAction = 1;
            }else
            {
                m_userAutoAction = -1;
            }
            imageView =(UIImageView *) [btnMiddle viewWithTag:1];
            imageView.image = image;
            imageView =(UIImageView *) [btnRight viewWithTag:1];
            imageView.image = image;
            break;
        case 1:
            imageView =(UIImageView *) [btnLeft viewWithTag:1];
            imageView.image = image;
            imageView =(UIImageView *) [btnRight viewWithTag:1];
            imageView.image = image;
            if (bHasHook)
            {
                m_userAutoAction = 2;
            }else
            {
                m_userAutoAction = -1;
            }
            break;
        case 2:
            imageView =(UIImageView *) [btnLeft viewWithTag:1];
            imageView.image = image;
            imageView =(UIImageView *) [btnMiddle viewWithTag:1];
            imageView.image = image;
            if (bHasHook)
            {
                m_userAutoAction = 3;
            }else
            {
                m_userAutoAction = -1;
            }
            break;
        default:
            break;
    }
    
    
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 13
 *  @brief
 *          responed the middle button
 *  @param
 *          sender
 *                  middle button
 *	@return
 *          NONE
 *
 */
-(IBAction)clickMiddle:(UIButton *)sender
{
    [RJFaudioPlay PlayMyAudio:@"click.mp3"];
    UIImageView  *imageView =(UIImageView *) [sender viewWithTag:1];
    [self RemoveSubViewOrHideSubView:CGPointMake(0, 0)];
    if (imageView && !imageView.hidden)
    {
        [self setLMRImageWhenClick:sender senderOrdex:1];
        return;
    }
    
    [self setSlideBarHide:nil];
    RJFUserImageView  *myuserView = [m_arrayStoreUserView objectAtIndex:m_iSelfIndex];
    if (m_gameControltype == FRESHTEACHTYPE)
    {
        
        switch (m_iSentenseIndex)
        {
            case 10:
                [self BeginBetChips:20 UserIndex:m_iSelfIndex];
                myuserView.labelNameAndAction.text = FollowChip;
                break;
            case 15:
                myuserView.labelNameAndAction.text = KeepCard;
                break;
            case 19:
                [self BeginBetChips:40 UserIndex:m_iSelfIndex];
                myuserView.labelNameAndAction.text = FollowChip;
                break;
            default:
                break;
        }
        
        UIButton   *btn = (UIButton *)[self.view viewWithTag:PREVIOUSTEPBUTTONTAG];
        [btn setEnabled:YES];
        btn = (UIButton *)[self.view viewWithTag:NEXTSTEPBUTTONTAG];
        [btn setEnabled:YES];
        [sender setEnabled:NO];
    }else
    {
        //        if (myuserView.Gameplayer.bringChip <= 0)
        //        {
        //            logMyLogInfo(@"lllllllll sorry  i have no chips:%d",myuserView.Gameplayer.bringChip);
        //            return;
        //        }
        NSString  *strAction = [sender titleForState:UIControlStateNormal];
        if ([strAction isEqualToString:FollowChip] || [strAction isEqualToString:ALLChipBet])
        {
            if (m_inowMaxChip-myuserView.Gameplayer.giveChip > 0)
            {
                
                if(myuserView.Gameplayer.bringChip > m_inowMaxChip-myuserView.Gameplayer.giveChip)
                {
                    [self sendUserAction:actionfollowchip chips:m_inowMaxChip-myuserView.Gameplayer.giveChip];
                }else if(myuserView.Gameplayer.bringChip <= m_inowMaxChip-myuserView.Gameplayer.giveChip)
                {
                    [self sendUserAction:actionallPut chips:myuserView.Gameplayer.bringChip];
                }
                logMyLogInfo(@"nowputchip:%d",m_inowPutChip);
            }
        }else if ([strAction isEqualToString:KeepCard])
        {
            [self sendUserAction:actionkeepchip chips:0];
            m_userAction = actionkeepchip;
        }
    }
    
    logMyLogInfo(@"middle");
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 13
 *  @brief
 *          responed the right button
 *  @param
 *          sender
 *                  right button
 *	@return
 *          NONE
 *
 */
-(IBAction)clickRight:(UIButton *)sender
{
    [RJFaudioPlay PlayMyAudio:@"click.mp3"];
    //[self roateCardAni:@"red1.png" secondCard:@"black2.png" ThirdCard:@"mei2.png"];
    [self RemoveSubViewOrHideSubView:CGPointMake(0, 0)];
    UIImageView  *imageView =(UIImageView *) [sender viewWithTag:1];
    if (imageView && !imageView.hidden)
    {
        [self setLMRImageWhenClick:sender senderOrdex:2];
        return;
    }
    
    if ([[sender titleForState:UIControlStateNormal] isEqualToString:AddChip])
    {
        m_bHasClicksureAddchip = NO;
    }else if ([[sender titleForState:UIControlStateNormal] isEqualToString:INSURE])
    {
        m_bHasClicksureAddchip = YES;
    }
    
    
    
    if (m_gameControltype == FRESHTEACHTYPE)
    {
        if (!m_bHasClicksureAddchip)
        {
            [RJFaudioPlay PlayMyAudio:@"bet.mp3"];
            [sender setTitle:INSURE forState:UIControlStateNormal];
            [sender setBackgroundImage:[UIImage imageNamed:@"button_green.png"] forState:UIControlStateNormal];
            
            [self AddChipSliderView:NO chip:100 maxChip:1940 minChip:100 Ani:YES];
            UISlider  *slider = (UISlider *)[self.view viewWithTag:SLIDEBARTAR];
            if (slider)
            {
                
                UILabel  *label = (UILabel *)[self.view viewWithTag:LABELRECORDCHIPTAG];
                [label setText:ALLChipBet];
                [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
                [UIView setAnimationCurve:UIViewAnimationCurveLinear];
                [UIView setAnimationDuration:0.5f];
                [slider setValue:[slider maximumValue]];
                [UIView commitAnimations];
                //[slider setEnabled:NO];
            }
            
        }else
        {
            [btnRight setTitle:AddChip forState:UIControlStateNormal ];
            UIButton   *btn = (UIButton *)[self.view viewWithTag:PREVIOUSTEPBUTTONTAG];
            [btn setEnabled:YES];
            btn = (UIButton *)[self.view viewWithTag:NEXTSTEPBUTTONTAG];
            [btn setEnabled:YES];
            [sender setEnabled:NO];
            UISlider  *slider = (UISlider *)[self.view viewWithTag:SLIDEBARTAR];
            if (slider)
            {
                
                [slider setEnabled:YES];
            }
            [self BeginBetChips:1940 UserIndex:m_iSelfIndex];
            [self AddChipSliderView:YES chip:100 maxChip:100 minChip:100 Ani:YES];
            [btnRight setBackgroundImage:[UIImage imageNamed:@"button_blue.png"] forState:UIControlStateNormal];
        }
        
        
    }else
    {
        RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:m_iSelfIndex];
        if (!m_bHasClicksureAddchip)
        {
            if (userView.Gameplayer.bringChip <= 0)
            {
                m_bHasClicksureAddchip = NO;
                return;
            }
            [sender setTitle:INSURE forState:UIControlStateNormal];
            [sender setBackgroundImage:[UIImage imageNamed:@"button_green.png"] forState:UIControlStateNormal];
            
            int32_t minChip = m_inowMaxChip-userView.Gameplayer.giveChip > m_myRoomAllinfo.roomBigbland ? m_inowMaxChip-userView.Gameplayer.giveChip: m_myRoomAllinfo.roomBigbland;
            int32_t maxchip = [userView Gameplayer].bringChip;
            if (minChip >= userView.Gameplayer.bringChip && maxchip > 0)
            {
                minChip = 0;
            }
            if (minChip < 0)
            {
                minChip = 0;
            }
            
            [self AddChipSliderView:NO chip:minChip maxChip:maxchip minChip:minChip Ani:NO];
            
            
            
            
            logMyLogInfo(@"minchip:%d maxchip:%d",minChip,userView.Gameplayer.bringChip);
            
        }else
        {
         
            [btnRight setTitle:AddChip forState:UIControlStateNormal ];
            UISlider  *slider = (UISlider *)[self.view viewWithTag:SLIDEBARTAR];
            int32_t  nowChip =[slider value];
            if (nowChip == 0)
            {
                return;
            }
            if (nowChip == [slider maximumValue])
            {
                [self sendUserAction:actionallPut chips:nowChip];
            }else
                [self sendUserAction:actionaddchip chips:nowChip];
            m_inowPutChip = nowChip;
            
            
            [self AddChipSliderView:YES chip:0 maxChip:[slider value] minChip:0 Ani:NO];
            [btnRight setBackgroundImage:[UIImage imageNamed:@"button_blue.png"] forState:UIControlStateNormal];
            
        }
        
        
    }
    
    
    
    logMyLogInfo(@"right");
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 13
 *  @brief
 *          if user has sit down, user stand. Otherwise do nothing
 *  @param
 *          sender
 *                  stand button
 *	@return
 *          NONE
 *
 */
-(IBAction)clickStand:(UIButton *)sender
{
    
    
    if (m_objShareUser.userHasSitDown)
    {
        // ShowHUD(NSLocalizedString(@"请求中，请稍候", nil), self);
        [self sendUserleaveAndstand:2 seatId:m_iRealSeat];
        //        m_clickInsureMode = STANDUPMODE;
        //        [RJFWarnView addinSelfview:self.view
        //                          delegate:self
        //                           message:NSLocalizedString(@"提示\n\n玩儿累了，想休息一会？", nil)
        //                        buttontype:BOTHBUTTON
        //                      InsureButton:NSLocalizedString(@"站起", nil) CancelButton:CANCEL];
        logMyLogInfo(@"stand  m_irealSeat:%d",m_iRealSeat);
        
    }
    
    
    NSLog(@"1111111111 m_irealSeat:%d",m_iRealSeat);
    
}

-(void)btnClose:(UIButton *)btn
{
    if ([btn superview])
    {
        [[btn superview] setHidden:YES];
        [self.view endEditing:YES];
    }
}

-(void)SpeakNormalPressed:(UIButton *)sender
{
    [sender setBackgroundImage:[UIImage imageNamed:@"Speak_Normal_word_pressed.png"] forState:UIControlStateNormal];
    [self Speak:sender];
}




-(void)SetLabelTextAndReamin:(NSDictionary *)dicInfo
{
    
    NSInteger  index = [[dicInfo valueForKey:@"INDEX"] integerValue];
    
    NSInteger   icount = 10;
    UILabel  *label = [dicInfo valueForKey:@"LABEL"];
    NSString *strWord = [dicInfo valueForKey:@"WORD"];
    
    
    
    if ([strWord length]*2 < strlen([strWord UTF8String]) )
    {
        icount = 4;
    }
    int subindex = index*icount < 0 ? 0:index*icount;
    
    
    logMyLogInfo(@"subindex:%d",subindex);
    //  logMyLogInfo(@"%@",[NSString stringWithCString:destChar encoding:NSUTF8StringEncoding]);
    if ([strWord length] > index*icount)
    {
        NSString  *strTemp = @"";
        if ([strWord length] > (index+1)*icount)
        {
            strTemp = [strWord substringWithRange:NSMakeRange(subindex, icount)];
            logMyLogInfo(@"strTemp:%@",strTemp);
            //[label setText:];
            
        }else
        {
            strTemp = [strWord substringFromIndex:subindex];
            logMyLogInfo(@"strTemp:%@",strTemp);
            //  [label setText:];
        }
        [label setText:strTemp];
        sleep(5);
        [self performSelectorInBackground:@selector(SetLabelTextAndReamin:)
                               withObject:[NSDictionary dictionaryWithObjectsAndKeys:label,@"LABEL",strWord,@"WORD",@(index+1),@"INDEX", nil]];
    }else
    {
        sleep(5);
        [[label superview] removeFromSuperview];
        return;
    }
    
    
    
    
    
}
-(void)SpeakAndAnounceOther:(NSString *)strWord User:(RJFUserImageView *)user
{
    
    
    //  NSAutoreleasePool   *pool = [[NSAutoreleasePool alloc] init];
    if (user.hidden || user.userType == NOUSER)
    {
        return;
    }
    
    
    NSString   *strUserName = user.Gameplayer.UserName;
    if (user == nil && !m_objShareUser.userHasSitDown)
    {
        strUserName = m_objShareUser.userName;
    }else if(user == nil && m_objShareUser.userHasSitDown)
    {
        strUserName = m_objShareUser.userName;
        user = [m_arrayStoreUserView objectAtIndex:m_iSelfIndex];
    }
    
    [self showMsgInSpeakField:strWord UserNick:strUserName];
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:user.speakRect];
    //NSInteger  index = [m_arrayStoreUserView indexOfObject:user];
    imageView.image = [UIImage imageNamed:@"Speak_Intime.png"];
    if (CGRectEqualToRect(user.speakRect, [[[m_arrayStoreUserRectInfo objectAtIndex:3] valueForKey:@"SPEAKRECT"] CGRectValue])
        || CGRectEqualToRect(user.speakRect, [[[m_arrayStoreUserRectInfo objectAtIndex:4] valueForKey:@"SPEAKRECT"] CGRectValue]))
    {
        imageView.image = [UIImage imageNamed:@"Speak_Intime2.png"];
    }
    
    RJFShowWordLabel *label = [[RJFShowWordLabel alloc] initWithFrame:CGRectMake(0,-5, user.speakRect.size.width, user.speakRect.size.height)];
    [label setBackgroundColor:[UIColor clearColor]];
    //[label setText:strWord];
    [label setTextColor:[UIColor blackColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:12]];
    [label setText:strWord];
    imageView.tag = user.Gameplayer.seatID+SPEAKVIEWTAGBEGIN;
    
    
    
    
    
    [label performSelector:@selector(StartShow)
                  onThread:[NSThread currentThread]
                withObject:nil
             waitUntilDone:YES];
    [imageView addSubview:label];
    [label release];
    [self insertViewToFit:imageView];
    [imageView release];
    
    logMyLogInfo(@"strWord:%@",strWord);
    //   [pool drain];
    
    // }
    
}




-(void)showMsgInSpeakField:(NSString *)strContent UserNick:(NSString *)strNick
{
    
    
    NSString  *strShowInbtn = [NSString stringWithFormat:@"%@:%@",strNick,strContent];
    const char *data =(const char *) [strShowInbtn cStringUsingEncoding:NSUTF16BigEndianStringEncoding];
    //int count = sinaCountWord(strShowInbtn);
    int count =  uni_strlen((char*)data);
    logMyLogInfo(@"1111count:%d",count);
    JHTickerView   *viewShowword = (JHTickerView*)[btnSpeakWord viewWithTag:1254];
    [viewShowword removeFromSuperview];
    viewShowword = nil;
    
    if (count < 32)
    {
        
        [labelSpeakWord setText:strShowInbtn];
        
        return;
    }else
    {
        [labelSpeakWord setText:@""];
    }
    
    if (viewShowword == nil)
    {
        viewShowword = [[JHTickerView alloc] initWithFrame:CGRectMake(0, 2, 160, 30)];
        viewShowword.tag = 1254;
        [viewShowword setDirection:JHTickerDirectionLTR];
        
        for (UIView  *view in [viewShowword subviews])
        {
            view.userInteractionEnabled = YES;
        }
        [btnSpeakWord addSubview:viewShowword];
        
        [viewShowword setTickerSpeed:60.0f];
        viewShowword.loops = NO;
        
        UITapGestureRecognizer  *tabgest = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(clickSpeakWord:)];
        [viewShowword addGestureRecognizer:tabgest];
        [tabgest release];
        [viewShowword release];
    }
    [viewShowword setTickerStrings:[NSArray arrayWithObject:strShowInbtn]];
    
    
    
    
    
    
    
    [viewShowword start];
    
}
-(void)Speak:(UIButton *)button
{
    NSString  *strTitle = [button titleForState:UIControlStateNormal];
    UITextField  *text =(UITextField *) [[button superview] viewWithTag:1500];
    if (![text isKindOfClass:[UITextField class]])
    {
        return;
    }
    NSString  *strWord = nil;
    if ([strTitle isEqualToString:NSLocalizedString(@"发送", nil)])
    {
        strWord = text.text;
    }else
    {
        strWord = strTitle;
    }
    // const char  *data = [strWord cStringUsingEncoding:NSUTF16BigEndianStringEncoding];
    if (sinaCountWord(strWord) > 100)
    {
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:NSLocalizedString(@"提示\n\n您发送的消息太长，请重新输入", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
        return;
        
    }
    // [self SetSpeakViewHidden:YES];
    UIImageView   *speakView = (UIImageView *)[self.view  viewWithTag:SPEAKVIEWTAG];
    [speakView removeFromSuperview];
    
    if ([strWord isEqualToString:@""])
    {
        return;
    }
    
    [self sendUsermessage:strWord messageType:1];
    [self SpeakAndAnounceOther:strWord User:nil];
    logMyLogInfo(@"speak title: %@",[button titleForState:UIControlStateNormal]);
    
}
-(void)SetSpeakViewHidden:(BOOL)bHide
{
    UIImageView   *speakView = (UIImageView *)[self.view  viewWithTag:SPEAKVIEWTAG];
    CGFloat  fwidth = 480;
    CGFloat  fheght = 127;
    if (speakView != nil)
    {
        for (UIView  *view in [self.view subviews])
        {
            if (view.tag == SPEAKVIEWTAG)
            {
                [view removeFromSuperview];
            }
        }
        speakView = nil;
        //  return;
    }
    if (!speakView)
    {
        speakView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-fheght, fwidth, fheght)];
        speakView.userInteractionEnabled = YES;
        speakView.tag = SPEAKVIEWTAG;
        speakView.image = [UIImage imageNamed:@"Speak_Norma_bg.png"];
        [self.view addSubview:speakView];
        
        //CGRect  frame = [speakView bounds];
        UIButton    *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(fwidth-14, 5, 11.5, 12.5)];
        [btnClose setImage:[UIImage imageNamed:@"Speak_Close.png"] forState:UIControlStateNormal];
        [btnClose addTarget:self
                     action:@selector(btnClose:)
           forControlEvents:UIControlEventTouchUpInside];
        [speakView addSubview:btnClose];
        [btnClose release];
        
        
        int ibuttonCount = 3;
        CGFloat   fSepWidth = 3;
        for (int i = 0;i < ibuttonCount;i++)
        {
            UIButton   *button = [[UIButton alloc] initWithFrame:CGRectMake(5+154.5*i+fSepWidth*i, 5+12.5+10, 154.5, 39.5)];
            [button setBackgroundImage:[UIImage imageNamed:@"Speak_Normal_word.png"] forState:UIControlStateNormal];
            [button addTarget:self
                       action:@selector(SpeakNormalPressed:)
             forControlEvents:UIControlEventTouchUpInside];
            NSString  *strTitle = NSLocalizedString(@"全下！全下！", nil);
            switch (i)
            {
                case 0:
                    break;
                case 1:
                    strTitle = NSLocalizedString( @"大家好！", nil);
                    break;
                case 2:
                    strTitle = NSLocalizedString(@"算您狠！", nil);
                    break;
                default:
                    break;
            }
            [button setTitle:strTitle forState:UIControlStateNormal];
            [[button titleLabel] setTextColor:[UIColor blackColor]];
            [speakView addSubview:button];
            button.tag = 2;
            [button release];
        }
        
        
        
        UITextField   *textSpeak = [[UITextField alloc] initWithFrame:CGRectMake(5, fheght-36.5-10, 396.5, 36.5)];
        [textSpeak setTag:1500];
        [textSpeak setText:@""];
        [textSpeak setBorderStyle:UITextBorderStyleRoundedRect];
        [textSpeak setTextColor:[UIColor blackColor]];
        [textSpeak setDelegate:self];
        [speakView addSubview:textSpeak];
        [textSpeak setPlaceholder:NSLocalizedString(@"点此输入您的发言！", nil)];
        [textSpeak setFont:[UIFont systemFontOfSize:24]];
        [textSpeak setTextAlignment:NSTextAlignmentLeft];
        [textSpeak setReturnKeyType:UIReturnKeyDone];
        textSpeak.rightViewMode = UITextFieldViewModeAlways;
        [textSpeak release];
        
        
        UIButton   *buttonSend = [[UIButton alloc] initWithFrame:CGRectMake(5+396.5+5, fheght-36.5-10, 65.5, 36.5)];
        [buttonSend setBackgroundImage:[UIImage imageNamed:@"Speak_Send.png"] forState:UIControlStateNormal];
        [buttonSend setTitle:NSLocalizedString(@"发送", nil) forState:UIControlStateNormal];
        [buttonSend addTarget:self
                       action:@selector(Speak:)
             forControlEvents:UIControlEventTouchUpInside];
        [speakView addSubview:buttonSend];
        [buttonSend release];
        [speakView release];
        
    }
    
    //  speakView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-fheght, fwidth, fheght)];
    [speakView setFrame:CGRectMake(0, SCREENHEIGHT-fheght, fwidth, fheght)];
    
    for (UIButton  *button in [speakView subviews])
    {
        if (button.tag == 2 && [button isKindOfClass:[UIButton class]])
        {
            [button setBackgroundImage:[UIImage imageNamed:@"Speak_Normal_word.png"] forState:UIControlStateNormal];
            [[button titleLabel] setTextColor:[UIColor blackColor]];
        }
    }
    
    UITextField   *textSpeak = (UITextField *)[self.view viewWithTag:1500];
    [textSpeak setText:@""];
    [speakView setHidden:bHide];
    
    
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIView  *view = [self.view viewWithTag:SPEAKVIEWTAG];
    UIButton  *button = (UIButton *)[view viewWithTag:2];
    if (view && !button.hidden)
    {
        
        [view setFrame:CGRectMake(0,60, view.frame.size.width, view.frame.size.height-55)];
        for (UIButton  *btn in [view subviews])
        {
            if (btn.tag == 2)
            {
                [btn setHidden:YES];
            }else if ([btn isKindOfClass:[UITextField class]])
            {
                [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y-55, btn.frame.size.width, btn.frame.size.height)];
            }else if ([btn isKindOfClass:[UIButton class]] && [[btn titleForState:UIControlStateNormal] isEqualToString:NSLocalizedString(@"发送", nil)])
            {
                [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y-55, btn.frame.size.width, btn.frame.size.height)];
            }
        }
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text

//- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    UIView  *view = [self.view viewWithTag:SPEAKVIEWTAG];
    [view setFrame:CGRectMake(0,SCREENHEIGHT-127+65, view.frame.size.width, view.frame.size.height)];
    [textField resignFirstResponder];
    return YES;
}

-(void)ShowFaceInUserView:(RJFUserImageView *)userView Image:(UIImage *)image
{
    if (userView.hidden || userView.userType == NOUSER)
    {
        return;
    }
    if (userView == nil && !m_objShareUser.userHasSitDown)
    {
        return;
    }else if (userView == nil && m_objShareUser.userHasSitDown)
    {
        userView = [m_arrayStoreUserView objectAtIndex:m_iSelfIndex];
    }
    
    CGRect  rect = userView.faceRect;
    //rect.origin.x = userView.speakRect.origin.x-rect.size.width;
    // rect.origin.y -= rect.size.height;
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = image;
    imageView.tag = FACEVIEWTAGBEGIN+userView.Gameplayer.seatID;
    [self insertViewToFit:imageView];
    
    [imageView performSelector:@selector(removeFromSuperview)
                    withObject:imageView
                    afterDelay:5.0f];
    [imageView release];
    
    
}
-(void)showTheFace:(UIButton *)sender
{
    //UIImageView  *view =[thread valueForKey:@"view"];
    
    NSArray    *arrayFace = [[[NSBundle mainBundle] infoDictionary] valueForKey:DZPKFACE];
    NSString   *strImage = [[[arrayFace objectAtIndex:sender.tag-1] allValues] lastObject];
    NSString   *strMsgContent = [[[arrayFace objectAtIndex:sender.tag-1] allKeys] lastObject];
    
    [self performSelector:@selector(ShowFaceInUserView:Image:)
               withObject:nil
               withObject:[UIImage imageNamed:strImage]];
    
    
    //[self showMsgInSpeakField:strMsgContent UserNick:m_objShareUser.userName];
    
    [self sendUsermessage:strMsgContent messageType:2];
    if ([sender superview])
    {
        [[sender superview] removeFromSuperview];
    }
    
    
    /*  switch (sender.tag)
     {
     case 0:
     break;
     
     default:
     break;
     }*/
    logMyLogInfo(@"thread:%@",sender);
}

-(void)SetFaceViewHidden:(BOOL)bHide
{
    UIImageView   *FaceView = (UIImageView *)[self.view  viewWithTag:FACEVIEWTAG];
    
    if (!FaceView)
    {
        CGFloat  fwidth = 480;
        CGFloat  fheght = 127;
        
        FaceView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-fheght, fwidth, fheght)];
        FaceView.userInteractionEnabled = YES;
        FaceView.tag = FACEVIEWTAG;
        FaceView.image = [UIImage imageNamed:@"Speak_Norma_bg.png"];
        [self.view addSubview:FaceView];
        
        UIButton    *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(fwidth-14, 5, 11.5, 12.5)];
        [btnClose setImage:[UIImage imageNamed:@"Speak_Close.png"] forState:UIControlStateNormal];
        [btnClose addTarget:self
                     action:@selector(btnClose:)
           forControlEvents:UIControlEventTouchUpInside];
        [FaceView addSubview:btnClose];
        [btnClose release];
        
        int kCount = 0;
        CGFloat fSep = 20;
        CGFloat fViewWidth = 25;
        CGFloat  fXpoint = 20;
        int iCount = 0;
        NSArray    *arrayFace = [[[NSBundle mainBundle] infoDictionary] valueForKey:DZPKFACE];
        
        for (int i = 0; i < 2; i++)
        {
            CGFloat  fheight = 5+12.5+20;
            if (i)
            {
                fheight = 5+12.5+5+24+20+10;
            }
            iCount = 0;
            fXpoint = 0;
            while (fXpoint+fViewWidth < fwidth && kCount < [arrayFace count])
            {
                fXpoint = 10+fViewWidth*iCount+fSep*iCount;
                
                UIButton  *button = [[UIButton alloc] initWithFrame:CGRectMake(fXpoint,fheight, fViewWidth, fViewWidth)];
                button.backgroundColor = [UIColor clearColor];
                button.tag = kCount+1;
                
                
                NSString   *strImage = [[[arrayFace objectAtIndex:kCount] allValues] lastObject];
                
                [button setImage:[UIImage imageNamed:strImage] forState:UIControlStateNormal];
                [button addTarget:self
                           action:@selector(showTheFace:)
                 forControlEvents:UIControlEventTouchUpInside];
                [FaceView addSubview:button];
                logMyLogInfo(@"button:+++%@",button);
                [button release];
                iCount++;
                kCount++;
            }
            
        }
        
        [FaceView release];
        
    }
    
    [FaceView setHidden:bHide];
}

-(void)setLMRButton:(BOOL)bIsMyTurn MiddleTitle:(NSString *)strTitle
{
    if (!m_objShareUser.userHasSitDown || m_bHasGiveUpOrAllput)
    {
        [self setLMREnable:YES Hide:YES];
        return;
    }
    [self setLMREnable:YES Hide:NO];
    [self setSlideBarHide:nil];
    CGFloat  fwidth = 15;
    CGFloat  fXpoint = 3;
    UIImageView  *imageView = (UIImageView *)[btnLeft viewWithTag:1];
    if (!imageView)
    {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint, (btnLeft.frame.size.height-fwidth)/2, fwidth, fwidth)];
        imageView.tag = 1;
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:@"hook_NO.png"];
        imageView.backgroundColor = [UIColor clearColor];
        
        [btnLeft addSubview:imageView];
        [imageView release];
    }
    imageView.image = [UIImage imageNamed:@"hook_NO.png"];
    
    if (!bIsMyTurn)
    {
        [imageView setHidden:NO];
        [btnLeft setTitle:[GiveOrKeepCard stringByAppendingString:@"  "] forState:UIControlStateNormal];
        // [[btnLeft titleLabel] setFont:[UIFont systemFontOfSize:16]];
        // [[btnMiddle titleLabel] setFont:[UIFont systemFontOfSize:16]];
        //  [[btnRight titleLabel] setFont:[UIFont systemFontOfSize:16]];
        [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [btnMiddle setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [btnRight setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }else
    {
        [imageView setHidden:YES];
        [btnLeft setTitle:GiveUpCard forState:UIControlStateNormal];
        // [[btnLeft titleLabel] setFont:[UIFont systemFontOfSize:17]];
        //  [[btnMiddle titleLabel] setFont:[UIFont systemFontOfSize:17]];
        // [[btnRight titleLabel] setFont:[UIFont systemFontOfSize:17]];
        [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [btnMiddle setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [btnRight setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    }
    
    
    imageView = (UIImageView *)[btnMiddle viewWithTag:1];
    if (!imageView)
    {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint, (btnMiddle.frame.size.height-fwidth)/2, fwidth, fwidth)];
        imageView.tag = 1;
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:@"hook_NO.png"];
        [btnMiddle addSubview:imageView];
        [imageView release];
    }
    imageView.image = [UIImage imageNamed:@"hook_NO.png"];
    
    if (!bIsMyTurn)
    {
        [imageView setHidden:NO];
        [btnMiddle setTitle:[KeepCard stringByAppendingString:@"     "] forState:UIControlStateNormal];
    }else
    {
        [imageView setHidden:YES];
        [btnMiddle setTitle:strTitle forState:UIControlStateNormal];
        
    }
    
    
    imageView = (UIImageView *)[btnRight viewWithTag:1];
    if (!imageView)
    {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint, (btnRight.frame.size.height-fwidth)/2, fwidth, fwidth)];
        imageView.tag = 1;
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:@"hook_NO.png"];
        [btnRight addSubview:imageView];
        [imageView release];
    }
    imageView.image = [UIImage imageNamed:@"hook_NO.png"];
    
    if (!bIsMyTurn)
    {
        [imageView setHidden:NO];
        [btnRight setTitle:FollowAnyChip forState:UIControlStateNormal];
        btnRight.contentEdgeInsets = UIEdgeInsetsMake(5, 2, 5, 5);
        [btnRight setHidden:NO];
    }else
    {
        [imageView setHidden:YES];
        [btnRight setTitle:AddChip forState:UIControlStateNormal];
        if ([strTitle isEqualToString:ALLChipBet])
        {
            [btnRight setHidden:YES];
        }
    }
}



#pragma mark  -init method


- (id)initWithNibName:(NSString *)nibNameOrNil
bundle:(NSBundle *)nibBundleOrNil
roomInfo:(GameroomInfo*)info
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        // logMyLogInfo(@"baaaaaaaaagameStatus:%d",gameInfo->gamestatus);
        [self initVariable:nil];
        
        
        m_gameControltype = GAMETYPE;
        m_gameStatus = GAMENOWISNONE;
        
        m_roomIDandPath = info;
        
        m_myRoomAllinfo.roomCategory = info->roomType;
        m_myRoomAllinfo.roomPath = info->roomPath;
        m_myRoomAllinfo.roomID = info->roomID;
        m_myRoomAllinfo.bringgold = 2000;
        m_myRoomAllinfo.enterFee = info->enterFee;
        m_myRoomAllinfo.serverCharge = info->enterFee;
        
        
        m_timerGame = nil;
        m_bmustWait = YES;
        m_bFirstCard = NO;
        m_bNeedStopCountDown = NO;
        m_bHasRecvStratInfo = NO;
        m_bHasFapai = NO;
        m_bHasGiveUpOrAllput = NO;
        m_ibuyPropChips = 0;
        self.currentOp = -1;
        
        
        
        
        
        
        //set info
        // Custom initialization
    }
    return self;
}

-(void)initVariable:(id)Thread
{
    m_arrayStoreCardView = [[NSMutableArray alloc] init];
    m_arrayStoreUserRectInfo = [[NSMutableArray alloc] init];
    m_arrayStoreUserView = [[NSMutableArray alloc] init];
    m_arrStoreUsercard = [[NSMutableArray alloc] init];
    m_arrStorCardNumber = [[NSMutableArray alloc] init];
    m_arrayUndealInfo = [[NSMutableArray alloc] init];
    
    
    m_arrayStoreChipView = [[NSMutableArray alloc] init];
    m_lock = [[NSLock alloc] init];
    m_lockForArray = [[NSLock alloc] init];
    m_lockCountTimes = [[NSLock alloc] init];
    m_objShareUser = [UserInfo shareInstance];
  
    
    m_index = 0;
    m_bFirstCard = NO;
    m_iRealSeat = -1;
    m_userAutoAction = -1;
    m_iStartCount = 0;
    
    if ([m_arrayStoreCardView count])
    {
        logMyLogInfo(@"remove");
        [m_arrayStoreCardView removeAllObjects];
    }
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gameType:(MyGameControlType)gametype
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self initVariable:nil];
        m_gameControltype = gametype;
        m_initRoomInfo = NULL;
        m_bmustWait = NO;
        // Custom initialization
    }
    return self;
}


-(void)setMyInfoAboutRoom:(DZPK_SERVER_REQ_GAME_ENTER_ROOM)info
{
    m_myRoomAllinfo.allChipOndesk = info.alreadAnte;
    m_myRoomAllinfo.bankerIndex = info.bankerIndex;
    m_myRoomAllinfo.hasTurnCard = info.cards;
    m_myRoomAllinfo.hasTurnCardNumber = info.cardsNumber;
    m_myRoomAllinfo.myseatID = info.mySeatID;
    m_myRoomAllinfo.operationID = info.operationID;
    m_myRoomAllinfo.roomCountDown = info.countdown_times;
    m_myRoomAllinfo.roomSmallblind = info.smallBlind;
    m_myRoomAllinfo.roomBigbland = info.bigBlind;
    m_myRoomAllinfo.roomBigIndex = info.bigIndex;
    m_myRoomAllinfo.roomSmallIndex = info.smallIndex;
    m_myRoomAllinfo.operationTime = info.speed;
    m_myRoomAllinfo.roomStatus = info.gamestatus;
    
    
}

-(void)setPerSonForGame:(DZPK_SERVER_REQ_GAME_ENTER_ROOM*)roomInfo
{
    //m_iSelfIndex = 5;
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    NSMutableArray  *array = [[NSMutableArray alloc] init];
    
    if (roomInfo->nick == nil || roomInfo->headPicString == nil)
    {
        [array release];
        return;
    }
    NSString *strTemp = roomInfo->nick;
    NSArray  *arrNick = [strTemp componentsSeparatedByString:COMPONETSTRING];
    strTemp = roomInfo->headPicString;
    NSArray *arrHeaPic = [strTemp componentsSeparatedByString:COMPONETSTRING];
    for (int i = 0; i < MAXPERSONNUMBER; i++)
    {
        NSDictionary  *dicInfo = nil;
        int seat = (i+1)%MAXPERSONNUMBER;
        if (roomInfo->playerIDArray[seat] == -1 || roomInfo->playerIDArray[seat] == m_objShareUser.userIDForDzpk)
        {
            dicInfo = [NSDictionary dictionaryWithObject:@"0" forKey:@"HasPlayer"];
            [array addObject:dicInfo];
            if (roomInfo->playerIDArray[seat] == m_objShareUser.userIDForDzpk)
            {
                m_objShareUser.bringChip = roomInfo->chipsArray[seat];
            }
            
        }else
        {
            
            GamePlayer  *Player = [[GamePlayer alloc] init];
            if (seat < [arrNick count])
            {
                Player.UserName = [arrNick objectAtIndex:seat];
            }
            if (seat < [arrHeaPic count])
            {
                Player.UserImagePath = [arrHeaPic objectAtIndex:seat];
            }
            Player.UserId =roomInfo->playerIDArray[seat];
            Player.bringChip = roomInfo->chipsArray[seat];
            Player.firstCard = roomInfo->firstCardarray[seat];
            Player.secondCard = roomInfo->SecondArray[seat];
            Player.hadbetchip = roomInfo->anteArray[seat];
            Player.seatID = seat;
            Player.userState = roomInfo->statusArray[seat];
            
            dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:Player,@"PLAYER",@"1",@"HasPlayer",nil];
            [array addObject:dicInfo];
            
            logMyLogInfo(@"seatID init:%d player:%@",seat,Player);
            [Player release];
            
        }
    }
    
    
    [self addUserImagview:array];
    [array release];
    [pool drain];
}

-(void)actionAfterIStand:(id)Thread
{
    m_bmustWait = YES;
    m_iStartCount = 0;
    m_objShareUser.userHasSitDown = NO;
    RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:m_iSelfIndex];
    if(m_myRoomAllinfo.bankerIndex == userView.Gameplayer.seatID)
    {
        [self setHostLogo:userView bhide:YES];
        logMyLogInfo(@"7.............set host hidden");
    }
    UIView  *view = [self.view viewWithTag:SPEAKVIEWTAGBEGIN+userView.Gameplayer.seatID];
    if (view)
    {
        [view removeFromSuperview];
    }
    view = [self.view viewWithTag:FACEVIEWTAGBEGIN+userView.Gameplayer.seatID];
    if (view)
    {
        [view removeFromSuperview];
    }
    
    [m_lockForArray lock];
    for (RJFAddChipView  *chipView in  [self.view subviews])
    {
        if ([chipView isKindOfClass:[RJFAddChipView class]] && chipView.tag == ADDBRINGCHIPVIEWTAG)
        {
            [chipView removeFromSuperview];
            break;
        }
    }
    [m_lockForArray unlock];
    
    [userView SetSeatState:YES MySelfOrOther:NO GAempLayer:nil];
    
    userView.imageViewCardOne.image = nil;
    userView.imageViewCardTwo.image = nil;
    [self setUnseatHide:NO];
    [userView setUserState:0];
    [self StandAndrestoreOrigailRoom:nil];
    [btnStand setHidden:YES];
    // [self gatherchips:nil];
    if ([self GetCurrentPlayingCount:nil] < 2)
    {
        //m_CountDownNumber = 0;
        [self setHostLogo:[m_arrayStoreUserView objectAtIndex:0] bhide:YES];
        logMyLogInfo(@".8............set host hidden");
        [self stopCountDown:nil];
        [self CleanAfterEveryGame:nil];
        NSLog(@"stop:CountDown");
        
    }
    
    if (m_gameStatus != GAMENOWISPLAYING)
    {
        [self setHostLogo:[m_arrayStoreUserView objectAtIndex:0] bhide:YES];
        logMyLogInfo(@"1.............set host hidden");
    }
    [self dealWithUndealrequest];
}

-(void)ActionForEnter:(DZPK_SERVER_REQ_GAME_ENTER_ROOM)info
{
    switch (info.gamestatus)
    {
        case -1:
            return;
        case 0:
        case 2:
            m_gameStatus = GAMENOWISCOUNTDOWNING;
            break;
        case 1:
        case 3:
            m_gameStatus = GAMENOWISPLAYING;
            break;
        default:
            break;
    }
    
    NSLog(@"1111111");
    
    
    
    
    
    NSArray  *array = [NSArray arrayWithArray:m_arrayStoreUserView];
    
    
    
    
    if (info.chipsArray &&
        info.anteArray &&
        info.firstCardarray &&
        info.SecondArray &&
        info.statusArray &&
        info.playerIDArray &&
        (info.gamestatus != 0 && info.gamestatus != 2))
    {
        logMyLogInfo(@"9999999999999");
        
        
        
        for (int i = 0; i < info.playerIDNumber; i++)
        {
            if (info.playerIDArray[i] < 0)
            {
                continue;
            }
            int8_t  index = [self MakeSureNowindexFromNet:i];
            RJFUserImageView  *userView = [array objectAtIndex:index];
            userView.labelNameAndAction.text = userView.Gameplayer.UserName;
            
            if (info.anteArray[i] > 0)
            {
                userView.Gameplayer.giveChip = 0;
                [self BeginBetChips:info.anteArray[i] UserIndex:index];
            }
            
            [userView setUserState:info.statusArray[i]];
            logMyLogInfo(@"userName:%@ seat:%d status:%d",userView.Gameplayer.UserName,userView.Gameplayer.seatID,userView.Gameplayer.userState);
            if (userView.Gameplayer.bringChip >= 0)
            {
                userView.labelWeath.text = [NSString stringWithNeedTranfanNumber:userView.Gameplayer.bringChip returnType:GAMESHOWTYPE];
            }else
            {
                userView.labelWeath.text = @"0";
                logMyLogInfo(@"..........das userID:%d, chips:%d",info.playerIDArray[i],info.chipsArray[i]);
            }
            
            logMyLogInfo(@")))))))))))))action for enter :%@",userView);
            
            
            
            NSLog(@"userView.Gameplayer:%@   givechip:%d    hasAnte:%d",userView.Gameplayer,userView.Gameplayer.giveChip,info.anteArray[i]);
            
            
            
            if (info.firstCardarray[i] < 0 || info.SecondArray[i] < 0)
            {
                continue;
            }else
            {
                
                NSDictionary  *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:[self AccordNumberGetCardimage:info.firstCardarray[i]],FIRSTCARD,[self AccordNumberGetCardimage:info.SecondArray[i]],SECONDCARD,@(i),SEATID,nil];
                [m_arrStoreUsercard addObject:dicInfo];
            }
            
        }
        
        if (info.countdown_times < 0 && m_gameStatus == GAMENOWISPLAYING)
        {
            
            for (RJFUserImageView  *userTempView in m_arrayStoreUserView)
            {
                if (userTempView.Gameplayer && [self hasUsercardFromServer:userTempView.Gameplayer.seatID])
                {
                    userTempView.imageViewCardOne.image = [UIImage imageNamed:@"card_back_left15.png"];
                    userTempView.imageViewCardTwo.image = [UIImage imageNamed:@"card_back_right15.png"];
                }else
                {
                    [userTempView setUserState:8];
                }
            }
            
        }
        
        
        
    }
    
    
    
    if (info.bankerIndex > -1 && info.bankerIndex <  MAXPERSONNUMBER)
    {
        int8_t  bankeIndex = [self MakeSureNowindexFromNet:info.bankerIndex];
        [self setHostLogo:[array objectAtIndex:bankeIndex] bhide:NO];
    }
    if (info.operationID > -1 &&
        info.operationID < MAXPERSONNUMBER
        && (info.gamestatus != 0 && info.gamestatus != 2))
    {
        
        //  [self SetUserStartTimer:info.operationID timer:info.speed];
    }
    NSLog(@"2111111");
    if (info.alreadAnte > 0)
    {
        [labelChips setText:[NSString stringWithNeedTranfanNumber:info.alreadAnte returnType:GAMESHOWTYPE]];
        m_lTotalChipIndesk = info.alreadAnte;
    }
    
    
    
    
    
    if (m_initRoomInfo->gamestatus == 3)
    {
        // complete hide the seat
        [self setUnseatHide:YES];
    }
    m_initRoomInfo->gamestatus = -1;
    
    
    NSLog(@"3111111111111111111111");
    
    RJFUserImageView  *userView = [array objectAtIndex:m_iSelfIndex];
    if (m_gameStatus == GAMENOWISPLAYING)
    {
        m_gameStatus = GAMENOWISPLAYING;
        [userView setUserState:8];
    }else
    {
        m_gameStatus = GAMENOWISCOUNTDOWNING;
        [userView setUserState:0];
    }
    
    if (info.playerIDArray &&
        info.chipsArray
        && !(info.countdown_times == 0 || info.countdown_times == 1))
    {
        
        for (int i = 0; i < info.playerIDNumber; i++)
        {
            if (info.playerIDArray[i] < 0)
            {
                continue;
            }
            int8_t  index = [self MakeSureNowindexFromNet:i];
            RJFUserImageView  *userView = [array objectAtIndex:index];
            userView.Gameplayer.bringChip = info.chipsArray[i];
            if (userView.Gameplayer.bringChip >= 0)
            {
                userView.labelWeath.text = [NSString stringWithNeedTranfanNumber:userView.Gameplayer.bringChip returnType:GAMESHOWTYPE];
                
            }else
            {
                userView.labelWeath.text = @"0";
                logMyLogInfo(@"..........userIDForDzpk:%d  get unnormal bring chips:%d",info.playerIDArray[i],info.chipsArray[i]);
            }
            
            // userView.labelNameAndAction.text = userView.Gameplayer.UserName;
        }
        
        
        logMyLogInfo(@"888888888888");
    }
    
    if (info.countdown_times > 1  && m_gameStatus == GAMENOWISCOUNTDOWNING)
    {
        logMyLogInfo(@"................... begin count after I enter, countdownTimes:%d",info.countdown_times);
        [self StartCountDown:info.countdown_times];
    }
    
    
    
}

-(void)InitUserInfoAfterEnter:(DZPK_SERVER_REQ_GAME_ENTER_ROOM)info
{
    if (info.status || info.nick == nil || info.headPicString == nil)
    {
        return;
    }
    
    
    
    
    logMyLogInfo(@"AaaaaaaaaagameStatus:%d",info.gamestatus);
    if (info.mySeatID >= 0 && info.mySeatID < MAXPERSONNUMBER+1)
    {
        m_iRealSeat = info.mySeatID;
        m_iSelfIndex = [self MakeSureNowindexFromNet:info.mySeatID];
        
        [self UpdateSeatAccordIndex:m_iSelfIndex];
        
        [self setUnseatHide:YES];
        RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:m_iSelfIndex];
        logMyLogInfo(@"m_irealSeat:%d",m_iRealSeat);
        [userView IsitDown:m_iRealSeat];
        
        if (m_objShareUser.userHasSitDown)
        {
            [btnStand setHidden:NO];
        }
        
        if (info.gamestatus == 0 || info.gamestatus == 2)
        {
            m_gameStatus = GAMENOWISCOUNTDOWNING;
            [userView setUserState:0];
        }else if (info.gamestatus == 1 || info.gamestatus == 3)
        {
            m_gameStatus = GAMENOWISPLAYING;
            [userView setUserState:8];
        }
        
    }else
    {
        [self ActionForEnter:info];
    }
    
    
    m_initRoomInfo->mySeatID = -1;
    
    
    logMyLogInfo(@"seat down after enter room myseatID:%d",info.mySeatID);
    
    
    
    
    
}


#pragma mark   Other methods



-(void)CollectALLchip:(RJFUserImageView *)userView
{
    NSArray  *arrayUserView = [NSArray arrayWithArray:m_arrayStoreUserView];
    NSArray  *arrayChipView = [NSArray arrayWithArray:m_arrayStoreChipView];
    [UIView animateWithDuration:2.0f
                     animations:^
     {
     
     for (RJFUserImageView  *userImageView in arrayUserView)
     {
     [userImageView.labelRecordGiveChip setText:@""];
     }
     int i = 0;
     
     for (UIView *view in arrayChipView)
     {
     [view setFrame:CGRectMake(211, 98, 40, 15)];
     [self insertViewToFit:view];
     //logMyLogInfo(@"before %d\nview:%@",i,view);
     if ([view superview])
     {
     /* for (id object in [view subviews])
      {
      if ([object isKindOfClass:[UILabel class]])
      {
      //  logMyLogInfo(@"object:%@",object);
      [object setHidden:NO];
      }
      }*/
     [view setFrame:CGRectMake(userView.frame.origin.x+userView.frame.size.width/2, userView.frame.origin.y+userView.frame.size.height/2, view.frame.size.width, view.frame.size.height)];
     //   logMyLogInfo(@"after %d\nview:%@",i,view);
     }
     i++;
     [view setHidden:NO];
     }
     UIView  *view = [arrayChipView lastObject];
     if (view)
     {
     
     [self insertViewToFit:view];
     [view setFrame:CGRectMake(userView.frame.origin.x+userView.frame.size.width/2, userView.frame.origin.y+userView.frame.size.height/2, view.frame.size.width, view.frame.size.height)];
     }
     } completion:^(BOOL finish)
     {
     [m_arrayStoreChipView makeObjectsPerformSelector:@selector(removeFromSuperview)];
     for (RJFUserImageView  *userImageView in arrayUserView)
     {
     [userImageView.labelRecordGiveChip setText:@""];
     }
     }];
    
    
}

-(void)setInfoAccordrect:(NSMutableArray *)array
{
    ;
    for (RJFUserImageView  *view in m_arrayStoreUserView)
    {
        for (NSDictionary *dicInfo in array)
        {
            
            if (CGRectEqualToRect(view.frame, [[dicInfo valueForKey:@"FRAME"] CGRectValue]))
            {
                view.chipRect = [[dicInfo valueForKey:@"CHIPRECT"] CGRectValue];
                view.hostLogoRect = [[dicInfo valueForKey:@"HOSTRECT"] CGRectValue];
                //  logMyLogInfo(@"dicinfo:%@ \n++++++ view:%@",dicInfo,view);
                break;
            }
        }
    }
    ;
}
-(void)setLabelValueAndreCord:(UISlider *)slider
{
    
    if (m_gameControltype == FRESHTEACHTYPE)
    {
        [slider setValue:[slider maximumValue]];
        return;
    }
    UILabel  *label = (UILabel *)[self.view viewWithTag:LABELRECORDCHIPTAG];
    NSString      *strValue = nil;
    strValue = [DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:[slider value] returnType:GAMESHOWTYPE]];
    if ([slider value] >= [slider maximumValue])
    {
        strValue = ALLChipBet;
    }
    [label setText:strValue];
    
}
-(void)AddChipSliderView:(BOOL)bHide chip:(NSInteger)chip maxChip:(NSInteger)maxChip minChip:(NSInteger)minchip Ani:(BOOL)bAni
{
    
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    RJFSliderView   *viewbg = (RJFSliderView  *)[self.view viewWithTag:SLIDERBGVIEWTAG];
    UISlider  *slider = (UISlider *) [viewbg viewWithTag:SLIDEBARTAR];
    if (!viewbg)
    {
        viewbg =   [[RJFSliderView alloc] initWithFrame:CGRectMake(310, 109, 250, 100)];
        [self.view addSubview:viewbg];
        slider = (UISlider *) [viewbg viewWithTag:SLIDEBARTAR];
        [slider addTarget:self
                   action:@selector(setLabelValueAndreCord:)
         forControlEvents:UIControlEventValueChanged];
    }
    
    
    [slider setValue:chip];
    [slider setMaximumValue:maxChip];
    [slider setMinimumValue:minchip];
    [viewbg setHidden:bHide];
    NSString *strChip = [DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:chip returnType:GAMESHOWTYPE]];
    UILabel  *labelChip = (UILabel *)[self.view viewWithTag:LABELRECORDCHIPTAG];
    if (!labelChip)
    {
        labelChip = [[UILabel alloc] initWithFrame:CGRectMake(385,34,100, 30)];
        [labelChip setBackgroundColor:[UIColor clearColor]];
        [labelChip setTextColor:[UIColor whiteColor]];
        [labelChip setFont:[UIFont systemFontOfSize:16]];
        labelChip.tag = LABELRECORDCHIPTAG;
        [labelChip setTextAlignment:NSTextAlignmentCenter];
        [self insertViewToFit:labelChip];
        [labelChip release];
    }
    
    [labelChip setHidden:bHide];
    if (!bHide)
    {
        [labelChip setText:strChip];
        [slider setValue:chip];
    }
    if (bAni)
    {
        [NSThread detachNewThreadSelector:@selector(BeginslideAni) toTarget:viewbg withObject:nil];
        //[viewbg BeginslideAni];
    }
    [pool drain];
    
    
}



-(void)gatherchips:(id)Thread
{
    
    NSArray  *arrayChipView = [NSArray arrayWithArray:m_arrayStoreChipView];
    if (m_lTotalChipIndesk <= 0)
    {
        [labelChips setText:@""];
    }else
    {
        NSString  *strChip = [DORLLARSYMBOL stringByAppendingFormat:@"%@",[NSString stringWithNeedTranfanstring:[NSNumber numberWithInt:m_lTotalChipIndesk] returnType:GAMESHOWTYPE]];
        [labelChips setText:strChip];
    }
    
    
    for (RJFUserImageView *userView in m_arrayStoreUserView)
    {
        [userView.labelRecordGiveChip setText:@""];
    }
    
    [UIView animateWithDuration:0.4f
                     animations:^
     {
     
     
     for (UIView  *view in arrayChipView)
     {
     [view setFrame:CGRectMake(211, 98, 40, 15)];
     
     }
     } completion:^(BOOL finish)
     {
     [m_arrayStoreChipView makeObjectsPerformSelector:@selector(removeFromSuperview)];
     }];
    
    
}

-(void)setLMREnable:(BOOL)bEnable Hide:(BOOL)bHide
{
    [btnLeft setHidden:bHide];
    [btnMiddle setHidden:bHide];
    [btnRight setHidden:bHide];
    [btnLeft setEnabled:bEnable];
    [btnMiddle setEnabled:bEnable];
    [btnRight setEnabled:bEnable];
    
}


-(void)removeOldView:(id)Thread
{
    //[NSThread sleepForTimeInterval:0.3f];
    NSInteger  iTag = [[m_arrayStoreChipView lastObject] tag];
    int iCount = 0;
    for (int i = 0; i < [m_arrayStoreChipView count]; i++)
    {
        
        UIView  *view = [m_arrayStoreChipView objectAtIndex:i];
        if (view.tag == iTag)
        {
            iCount++;
        }
    }
    if (iCount > 1)
    {
        iCount = 0;
        for (int i = [m_arrayStoreChipView count]-1; i < [m_arrayStoreChipView count]; i--)
        {
            
            UIView  *view = [m_arrayStoreChipView objectAtIndex:i];
            if (view.tag == iTag)
            {
                if (!iCount)
                {
                    iCount++;
                    continue;
                }
                iCount++;
                [view removeFromSuperview];
                //[m_arrayStoreUserView removeObjectAtIndex:i];
                break;
            }
        }
        
    }
    
    
}

-(void)CleanAfterEverybetchip:(id)Thread
{
    [self stopTimeSlide:nil];
    for (RJFUserImageView  *view in m_arrayStoreUserView)
    {
        view.Gameplayer.giveChip = 0;
        [view.labelRecordGiveChip setText:@""];
    }
    

    m_inowMaxChip = 0;
    m_inowPutChip = 0;
}
-(void)CleanAfterEveryGame:(id)thread
{
    
    [self stopTimeSlide:nil];
    for (int i = 0;i < [m_arrayStoreUserView count];i++)
    {
        RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:i];
        [userView.arrayStoreChipView removeAllObjects];
        [userView.labelRecordGiveChip setText:@""];
        if (userView.hidden)
        {
            continue;
        }
        userView.labelNameAndAction.text = userView.Gameplayer.UserName;
        userView.Gameplayer.hadbetchip = 0;
        if (userView.Gameplayer.bringChip >= 0)
        {
            userView.labelWeath.text = [NSString stringWithNeedTranfanNumber:userView.Gameplayer.bringChip returnType:GAMESHOWTYPE];
        }else
        {
            userView.labelWeath.text = @"0";
        }
        
        //logMyLogInfo(@")))))))))))))clean info with User view:%@",userView);
        userView.Gameplayer.giveChip = 0;
        [userView setAutologo:YES];
        //  [userView setRecvOut:YES];
        
        //  userView.imageViewCardOne.hidden = YES;
        //userView.imageViewCardTwo.hidden = YES;
        userView.imageViewCardOne.image = nil;
        userView.imageViewCardTwo.image = nil;
        userView.imageViewCardTwo.alpha = 1.0f;
        userView.imageViewCardOne.alpha = 1.0f;
        userView.alpha = 1.0f;
        
        
    }
    m_inowMaxChip = 0;
    m_inowPutChip = 0;
    m_lTotalChipIndesk = 0;
    m_userAutoAction = -1;
    m_bHasGiveUpOrAllput = NO;
    
    labelChips.text = @"";
    for (UIImageView *imageView in m_arrayStoreCardView)
    {
        if ([imageView isKindOfClass:[UIImageView class]])
        {
            logMyLogInfo(@"qq");
            imageView.image = nil;
            imageView.hidden = YES;
            imageView.alpha = 1.0f;
            [imageView setFrame:CGRectMake(imageView.frame.origin.x, CARDVIEWHEIGHT, imageView.frame.size.width, imageView.frame.size.height)];
            logMyLogInfo(@"hello");
            
        }
        
    }
    
    [m_lockForArray lock];
    NSArray  *arrayChipView = [NSArray arrayWithArray:m_arrayStoreChipView];
    for (UIView  *view in arrayChipView)
    {
        [view removeFromSuperview];
    }
    [m_arrayStoreChipView removeAllObjects];
    [m_lockForArray unlock];
    [self SendUserGetdeatilInfo];
    
    
    
}
-(void)makeArrayCon:(NSInteger)index sortedarray: (NSMutableArray *)array
{
    NSMutableArray  *arraytemp  = [[NSMutableArray alloc] init];
    if (index > 5)
    {
        index -= 5;
    }
    if (index < [array count])
    {
        for (int i = 0; i < index; i++)
        {
            [arraytemp addObject:[array objectAtIndex:0]];
            [array removeObjectAtIndex:0];
        }
        
    }
    [array addObjectsFromArray:arraytemp];
    [arraytemp release];
}


-(UIImage *)getImageAccordchip:(int32_t)chip
{
    
    UIImage  *image = nil;
    
    if (chip > 1000)
    {
        image = [UIImage imageNamed:@"chip_purple.png"];
    }else  if(chip > 500)
    {
        image = [UIImage imageNamed:@"chip_brown.png"];
    }else  if(chip > 100)
    {
        image = [UIImage imageNamed:@"chip_black.png"];
    }else  if(chip > 50)
    {
        image = [UIImage imageNamed:@"chip_blue.png"];
    }else  if(chip > 25)
    {
        image = [UIImage imageNamed:@"chip_green.png"];
    }else  if(chip > 5)
    {
        image = [UIImage imageNamed:@"chip_red.png"];
    }else  if(chip > 0)
    {
        image = [UIImage imageNamed:@"chip_white.png"];
    }
    
    
    
    return image;
    
}
-(void)BeginBetChips:(NSInteger)chip UserIndex:(NSUInteger)index
{
    logMyLogInfo(@"beginBetchips:%d index:%d",chip,index);
    if (m_gameStatus == GAMENOWISOVER)
    {
        logMyLogInfo(@"Now game is over,no need action");
        return;
    }
    
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    UIImage  *image = [self getImageAccordchip:chip];
    if (image == nil)
    {
        [pool drain];
        logMyLogInfo(@"because chip not illegal");
        return;
        
    }
    int  itagBegin = 7010;
    
    [RJFaudioPlay PlayMyAudio:@"chip.mp3"];
    
    RJFUserImageView  *userImageview = [m_arrayStoreUserView objectAtIndex:index];
    int8_t  seat = userImageview.Gameplayer.seatID;
    if (userImageview.hidden || userImageview.userType == NOUSER)
    {
        logMyLogInfo(@"because userImageViewState not illegal:%@",userImageview);
        return;
    }
    m_lTotalChipIndesk += chip;
    
    userImageview.Gameplayer.bringChip -= chip;
    logMyLogInfo(@"******beforegivechip:%d ",userImageview.Gameplayer.giveChip);
    
    userImageview.Gameplayer.giveChip += chip;
    logMyLogInfo(@"******aftergivechip:%d",userImageview.Gameplayer.giveChip);
    
    
    
    if (m_inowMaxChip <= userImageview.Gameplayer.giveChip)
    {
        m_inowMaxChip = userImageview.Gameplayer.giveChip;
    }
    userImageview.Gameplayer.hadbetchip += chip;
    if (userImageview.Gameplayer.bringChip >= 0)
    {
        userImageview.labelWeath.text = [NSString stringWithNeedTranfanNumber:userImageview.Gameplayer.bringChip returnType:GAMESHOWTYPE];
    }else
    {
        userImageview.labelWeath.text = @"0";
        logMyLogInfo(@"......... bet chip unbomal chip user:%@ chip:%d",userImageview.Gameplayer.UserName,userImageview.Gameplayer.bringChip);
    }
    
    
    logMyLogInfo(@")))))))))))))betbetbetbetbet info :%@",userImageview);
    
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 12.5, 12.5)];
    UIImageView       *view = [[UIImageView alloc] initWithFrame:CGRectMake(userImageview.frame.origin.x+userImageview.frame.size.width/2, userImageview.frame.origin.y+userImageview.frame.size.height/2, 80, 15)];
    [view addSubview:imageView];
    view.tag = itagBegin+seat;
    UILabel     *label = (UILabel *)[self.view viewWithTag:itagBegin+seat*1000];
    if (label == nil)
    {
        CGRect   rect = userImageview.chipRect;
        label = [[UILabel alloc] initWithFrame:rect];
        [label setBackgroundColor:[UIColor clearColor]];
        [self insertViewToFit:label];
        label.tag = itagBegin+seat*1000;
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont systemFontOfSize:16]];
        
        if ([userImageview.labelRecordGiveChip superview])
        {
            [userImageview.labelRecordGiveChip removeFromSuperview];
        }
        userImageview.labelRecordGiveChip = label;
        [userImageview setOtherViewframe:nil];
        [label release];
    }
    
    
    //[label setHidden:YES];
    
    imageView.image = image;
    
    logMyLogInfo(@"nowMaxChip:%d now hadchip:%d",m_inowMaxChip,m_inowPutChip);
    [self insertViewToFit:view];
    [m_lockForArray lock];
    // [self.view insertSubview:view aboveSubview:self.view];
    [m_arrayStoreChipView addObject:view];
    [userImageview.arrayStoreChipView addObject:view];
    
    
    [UIView animateWithDuration:0.3f
                     animations:^
     {
     [view setFrame:userImageview.chipRect];
     
     
     } completion:^(BOOL finish)
     {
     if (userImageview.Gameplayer.giveChip > 0)
     {
     [label setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:userImageview.Gameplayer.giveChip  returnType:GAMESHOWTYPE]]];
     }
     
     // [self removeOldView:nil];
     }];
    
    [imageView release];
    [view release];
    [m_lockForArray unlock];
    [pool drain];
    
    
}



-(void)insertViewToFit:(UIView*)view
{
    
    [m_lockCountTimes lock];
    //   logMyLogInfo(@"begin insert view in self view");
    BOOL  bHasOldView = NO;
    NSArray  *array = [self.view subviews];
    for (UIView *oldView in array)
    {
        //        if (oldView.hidden)
        //        {
        //            continue;
        //        }
        if ([oldView isKindOfClass:[RJFWarnView class]])
        {
            [self.view insertSubview:view belowSubview:oldView];
            bHasOldView = YES;
            break;
        }
        
        if (oldView.tag == USERINFOVIEWTAG)
        {
            [self.view insertSubview:view belowSubview:oldView];
            bHasOldView = YES;
            break;
        }
        if (oldView.tag == SPEAKVIEWTAG)
        {
            [self.view insertSubview:view belowSubview:oldView];
            bHasOldView = YES;
            break;
        }
        if (oldView.tag == FACEVIEWTAG)
        {
            [self.view insertSubview:view belowSubview:oldView];
            bHasOldView = YES;
            break;
        }
        if ([oldView isKindOfClass:[RJFAddChipView class]])
        {
            [self.view insertSubview:view belowSubview:oldView];
            bHasOldView = YES;
            break;
        }
        if (oldView.tag == CARDARRAYVIEWTAG)
        {
            [self.view insertSubview:view belowSubview:oldView];
            bHasOldView = YES;
            break;
        }
    }
    
    
    if (!bHasOldView)
    {
        //  logMyLogInfo(@"add subview i  self.view");
        [self.view addSubview:view];
    }
    // logMyLogInfo(@"end insert view in self view");
    [m_lockCountTimes unlock];
}

-(void)setUnseatHide:(BOOL)bHide
{
    for (RJFUserImageView *view in m_arrayStoreUserView)
    {
        if (view.userType == NOUSER)
        {
            [view setHidden:bHide];
        }
        [view setAutologo:YES];
        [view setRecvOut:YES];
    }
}



-(void)userSitdown:(NSNotification *)note
{
    RJFUserImageView  *user = [note object];
    if (![user isKindOfClass:[RJFUserImageView class]])
    {
        return;
    }
    user.superViewControl = self;
    NSInteger index = [m_arrayStoreUserView indexOfObject:user];
    m_iRealSeat = (index+1)%MAXPERSONNUMBER;
    m_iSelfIndex = index;
    NSLog(@"userhassitdown ******** m_irealindex:%d index:%d",m_iRealSeat,index);
    
    
    if (m_gameControltype == FRESHTEACHTYPE)
    {
        [self UpdateSeatAccordIndex:m_iSelfIndex];
        [self setUnseatHide:YES];
        [self setNextAndPreEnable:YES];
        [self RemoveArrowViewIn345Location];
        user = [m_arrayStoreUserView objectAtIndex:m_iSelfIndex];
        
        [user IsitDown:m_iRealSeat];
        user.userInteractionEnabled = NO;
        user.Gameplayer.bringChip = 2000;
        user.labelWeath.text = @"2,000";
        
        return;
    }
    
    
    
    if (m_myRoomAllinfo.roomCategory == 5)
    {
        
        // int32_t   TotalbringGold = m_myRoomAllinfo.enterFee*MAXPERSONNUMBER;
        
        
        NSString  *strWaring = [NSString stringWithFormat:NSLocalizedString(@"提示\n您需要支付%d筹码参与本次比赛，结束或在中途退出比赛将不会返还，本次比赛取前二名，所得奖励如下:\n第一名:%d筹码 积分+3\n第二名:%d筹码 积分+2\n", nil),m_myRoomAllinfo.enterFee,m_roomIDandPath->roomFirstPrize,m_roomIDandPath->roomSecondPrize];
        
        m_clickInsureMode = SITDOWNINCOMGAMEMODE;
        [RJFWarnView addinSelfview:self.view
                          delegate:self
                           message:strWaring
                        buttontype:BOTHBUTTON
                      InsureButton:NSLocalizedString(@"坐下", nil)
                      CancelButton:NSLocalizedString(@"放弃", nil)];
        return;
    }else if ( m_objShareUser.userChips < m_myRoomAllinfo.roomBigbland+m_myRoomAllinfo.serverCharge)
    {
        m_clickInsureMode = CHARGEIDOUMODE;
        [RJFWarnView addinSelfview:self.view
                          delegate:self
                           message:@"提示\n\n\n您的账号所拥有的筹码不能够在此房间玩牌，请充值！"
                        buttontype:BOTHBUTTON
                      InsureButton:NSLocalizedString(@"充值", nil)
                      CancelButton:CANCEL];
        
        // [[m_arrayStoreUserView objectAtIndex:index] setHidden:YES];
        
    }else
    {
        [self sendUserleaveAndstand:1 seatId:m_iRealSeat];
    }
    
    
    
    // logMyLogInfo(@"userSitdown:%@",[note object]);
}


#pragma mark - fresh unipue method

-(void)setFreshTeachInterface:(id)thread
{
    
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    m_arrStoreSentences = [[NSMutableArray alloc] init];
    m_iBalIndex = 2;
    m_iJoshIndex = 1;
    m_iSelfIndex = 5;
    m_iSentenseIndex = 0;
    [btnFace setHidden:YES];
    [btnLeft setHidden:YES];
    [btnRight setHidden:YES];
    [btnMiddle setHidden:YES];
    [btnStand setHidden:YES];
    [btnSpeakWord setHidden:YES];
    
    
    NSString    *strSentencesPath = [[NSBundle mainBundle] pathForResource:@"NewFresh" ofType:@"txt"];
    NSError  *error = nil;
    NSString  *strSences = [NSString stringWithContentsOfFile:strSentencesPath encoding:NSUTF8StringEncoding error:&error];
    [m_arrStoreSentences addObjectsFromArray:[strSences componentsSeparatedByString:SEPSTRING]];
    if (error)
    {
        logMyLogInfo(@"error:%@",[error localizedDescription]);
    }
    
    UIImageView  *ViewMeimei = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-133, 146, 133)];
    ViewMeimei.image = [UIImage imageNamed:@"beauty.png"];
    [ViewMeimei setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:ViewMeimei];
    ViewMeimei.userInteractionEnabled = YES;
    [ViewMeimei release];
    
    UIImageView  *viewDialog = [[UIImageView alloc] initWithFrame:CGRectMake(2, 40, 140, 135)];
    viewDialog.image = [UIImage imageNamed:@"dialog.png"];
    [viewDialog setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:viewDialog];
    
    UITextView  *textView = [[UITextView alloc] initWithFrame:CGRectMake(-2, 3, 148, 135-40)];
    [textView setBackgroundColor:[UIColor clearColor]];
    [textView setTextColor:[UIColor whiteColor]];
    [textView setFont:[UIFont systemFontOfSize:13]];
    [textView setEditable:NO];
    [textView setScrollEnabled:NO];
    [textView setTag:FRESHTEACHDIALOGTAG];
    if ([m_arrStoreSentences count])
    {
        [textView setText:[m_arrStoreSentences objectAtIndex:m_iSentenseIndex]];
    }
    
    [viewDialog addSubview:textView];
    textView.userInteractionEnabled = YES;
    [textView release];
    
    UIFont  *font = [UIFont systemFontOfSize:14];
    UIButton   *button = [[UIButton alloc] initWithFrame:CGRectMake(5,10+135-60+10+5,60, 22)];
    [button setBackgroundImage:[UIImage imageNamed:@"buttonfresh.png"] forState:UIControlStateNormal];
    [button setTitle:NSLocalizedString(@"上一步", nil) forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(PreviouStep:)
     forControlEvents:UIControlEventTouchUpInside];
    button.tag = PREVIOUSTEPBUTTONTAG;
    [viewDialog addSubview:button];
    viewDialog.userInteractionEnabled = YES;
    button.userInteractionEnabled = YES;
    [button setEnabled:NO];
    [[button titleLabel] setFont:font];
    [button release];
    
    UIButton   *btnNextStep = [[UIButton alloc] initWithFrame:CGRectMake(viewDialog.frame.size.width-5-60,10+135-60+10+5,60, 22)];
    [btnNextStep setBackgroundImage:[UIImage imageNamed:@"buttonfresh.png"] forState:UIControlStateNormal];
    [btnNextStep setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
    [btnNextStep addTarget:self
                    action:@selector(NextStep:)
          forControlEvents:UIControlEventTouchUpInside];
    [btnNextStep setEnabled:NO];
    btnNextStep.tag = NEXTSTEPBUTTONTAG;
    [viewDialog addSubview:btnNextStep];
    [[btnNextStep titleLabel] setFont:font];
    [btnNextStep release];
    [viewDialog release];
    [pool drain];
    
    
    
    [self SetSeatForFresh:nil];
    
    
    
}

#pragma mark -view life

- (void)viewDidLoad
{
    
    
    //init
    
    
    [m_arrayStoreCardView addObject:imageViewCardOne];
    [m_arrayStoreCardView addObject:imageViewCardTwo];
    [m_arrayStoreCardView addObject:imageViewCardThree];
    [m_arrayStoreCardView addObject:imageViewCardFour];
    [m_arrayStoreCardView addObject:imageViewCardFive];
    for (UIImageView  *view in m_arrayStoreCardView)
    {
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 5.0f;
    }
    
    [btnSpeakWord setBackgroundImage:[UIImage imageNamed:@"speakword.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"button_blue.png"] forState:UIControlStateNormal];
    [btnMiddle setBackgroundImage:[UIImage imageNamed:@"button_blue.png"] forState:UIControlStateNormal];
    [btnRight setBackgroundImage:[UIImage imageNamed:@"button_blue.png"] forState:UIControlStateNormal];
    [btnStand setBackgroundImage:[UIImage imageNamed:@"stand.png"] forState:UIControlStateNormal];
    
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
}



-(void)ViewEnterBackground:(NSNotification *)note
{
    self.isInBackGroundMode = YES;
}
-(void)ViewEnterForeground:(NSNotification*)note
{
    self.isInBackGroundMode = NO;
   /* NSDate  *date = [[NSUserDefaults standardUserDefaults] valueForKey:VIEWENTERBGTIME];
    
    NSTimeInterval  ftimeInter = [[NSDate date] timeIntervalSinceDate:date];
    if (ftimeInter > 30)
    {
        [self disConnectGameSocket:nil];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:BNRDISCONNECTSERVER
         object:self];
        logMyLogInfo(@"TIEMHASENTERBG:%f",ftimeInter);
    }*/
}

-(void)viewWillAppear:(BOOL)animated
{
    HideHUD(self, YES);
    self.isInBackGroundMode = NO;
    m_objShareUser.IsOnGameInterface = YES;
    m_lTotalChipIndesk = 0;
    [btnStand setHidden:YES];
    [labelChips setText:@""];
    m_objShareUser = [UserInfo shareInstance];
    m_iSelfIndex = 5;
    m_clickInsureMode = DEFAULTNONEMODE;
    [btnSpeakWord setTitle:@"" forState:UIControlStateNormal];
    [labelSpeakWord setTextAlignment:NSTextAlignmentLeft];
    [labelSpeakWord setTextColor:[UIColor whiteColor]];
    [labelSpeakWord setText:@""];
    // labelSpeakWord.userInteractionEnabled = NO;
    m_inowPutChip = 0;
    for (UIView  *view in [self.view subviews])
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            view.exclusiveTouch = YES;
        }
    }
    
    NSNotificationCenter  *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(userSitdown:)
               name:BNRSITDOWN
             object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotiFromServer:)
                                                 name:BNRRECEIVEMESSAGEFROMSERVER
                                               object:nil];
    
    if (m_gameControltype == FRESHTEACHTYPE)
    {
        [self setFreshTeachInterface:nil];
    }else
    {
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receivStopTimeFromUserView:)
                                                     name:BNRSTOPTIMER
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(HandleUserInfo:)
                                                     name:BNRUSERINFOVIEW
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ViewEnterForeground:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ViewEnterBackground:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        
        
        [self setLMRButton:YES MiddleTitle:FollowChip];
        [self setLMREnable:YES Hide:YES];
        [self setCardTipImageView:NO];
        if (m_roomIDandPath->roomType == 5 )
        {
            [btnStand setTitle:NSLocalizedString(@"退赛", nil) forState:UIControlStateNormal];
        }
        m_objShareUser.bringChip = m_myRoomAllinfo.bringgold;
        
        [self sendEnterRoomRequest:m_roomIDandPath type:1];
        
        
        
        
    }
    
    setAllViewautoResize(self.view);
    [super viewWillAppear:animated];
    
    
}

//type 1 not reconnect   0 is reconnect

-(void)sendEnterRoomRequest:(GameroomInfo*)info  type:(NSInteger)type
{
    ShowHUD(@"正在进入房间，请稍候", self, 30);
    
    DZPK_CLIENT_REQ_GAME_ENTER_ROOM  roomInfo = {info->roomPath,info->roomID,info->selfChooseSeat,type};
    
    if (!type)
    {
       
        [self disConnectGameSocket:nil];
         self.isReconectToServer = YES;
    }else
    {
         self.isReconectToServer = NO;
    }
    
    
    RJFTcpSocket  *socket = [RJFTcpSocket shareInitWithHost:info->HostIP
                                                       Port:info->hostport
                                                   Delagate:nil
                                                        tag:GAMESOCKETTAG];
    BasisZipAndUnzip  *objBasic = [[BasisZipAndUnzip alloc] initWithSize:200];
    [socket SendCharMessage:[objBasic syncWithRequest:REQ_GAME_ENTER_ROOM
                                               userID:m_objShareUser.userIDForDzpk
                                          structArray:&roomInfo]
                       size:[objBasic size]];
    [objBasic release];
    objBasic = nil;
}

-(void)showRoomInfo:(id)Thread
{
    UILabel  *labelroomID = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH-200)/2, 160, 200, 30)];
    [labelroomID setFont:[UIFont systemFontOfSize:10]];
    [labelroomID setTextColor:[UIColor lightTextColor]];
    [labelroomID setTextAlignment:NSTextAlignmentCenter];
    [labelroomID setBackgroundColor:[UIColor clearColor]];
    
    
    if (m_roomIDandPath->roomType != 5)
    {
        labelroomID.text = [NSString stringWithFormat:NSLocalizedString(@"游戏场:%d   %d/%d", nil),m_roomIDandPath->roomID,m_myRoomAllinfo.roomSmallblind,m_myRoomAllinfo.roomBigbland];
    }else
    {
        labelroomID.text = [NSString stringWithFormat:NSLocalizedString(@"比赛场:%d", nil),m_roomIDandPath->roomID];
    }
    [self.view addSubview:labelroomID];
    [labelroomID release];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    

    
    [self setCountDicInfo:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
   
    [self disConnectGameSocket:nil];
    [super viewWillDisappear:animated];
    if (m_gameControltype == FRESHTEACHTYPE)
    {
        [self RemoveArrowViewIn345Location];
    }
    
    m_objShareUser.IsOnGameInterface = NO;
    
}


-(void)setCountDicInfo:(id)Thread
{
    if (m_gameControltype == FRESHTEACHTYPE)
    {
        return;
    }
    NSMutableDictionary  *dicInfo = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:USERCHIPCOUNTDIC]];
    int32_t      beforechip = [[dicInfo valueForKey:USERBEFORCHIPNUMBER] intValue];
    
    int32_t      nowchip = m_iNowChips;
    if (m_roomIDandPath->roomType == 5)
    {
        
        
        nowchip = m_objShareUser.userChips;
        if (m_iStartCount == 0  && m_objShareUser.userHasSitDown)
        {
            nowchip += m_roomIDandPath->enterFee;
        }
        
    }
    
    
    if (beforechip  != nowchip)
    {
        [dicInfo setObject:@(nowchip) forKey:USERNOWCHIPNUMBER];
        [dicInfo setObject:@(1) forKey:USERCHIPHASCHANGE];
        [dicInfo setObject:@(m_ibuyPropChips) forKey:USERPROPCHIPNUMBER];
    }else
    {
         [dicInfo setObject:@(0) forKey:USERCHIPHASCHANGE];
    }
    [[NSUserDefaults standardUserDefaults] setObject:dicInfo forKey:USERCHIPCOUNTDIC];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
     logMyLogInfo(@"USERCHIPCOUNTDIC:%@  %@",USERCHIPCOUNTDIC,dicInfo);
}
-(void)viewDidAppear:(BOOL)animated
{
    
    //  [self setCountViewHide:NO countNumber:900];
    if (m_gameControltype == FRESHTEACHTYPE)
    {
        [self AddChipSliderView:YES chip:100 maxChip:200 minChip:100 Ani:YES];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    return;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    
    
    if (m_gameControltype == FRESHTEACHTYPE)
    {
        return;
    }
    
    BOOL   bHasSeat = NO;
    if (m_objShareUser.autoSitDown &&
        !m_objShareUser.userHasSitDown)
    {
        for (int i = 0; i < MAXPERSONNUMBER; i++)
        {
            if ([[m_arrayStoreUserView objectAtIndex:i] userType] == NOUSER)
            {
                NSNotificationCenter  *nc = [NSNotificationCenter defaultCenter];
                [nc postNotificationName:BNRSITDOWN object:[m_arrayStoreUserView objectAtIndex:i]];
                bHasSeat = YES;
                break;
            }
            
        }
        if (!bHasSeat)
        {
            m_clickInsureMode = ENTERROOMFAILMODE;
            [RJFWarnView addinSelfview:self.view
                              delegate:self
                               message:NSLocalizedString(@"\n提示\n房间里已经没有座位，请重新选择房间！", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
        }
        
    }
    
    [super viewDidAppear:animated];
    
    
    
}
- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // e.g. self.myOutlet = nil;
}


#pragma mark - override method
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint  point = [[touches anyObject] locationInView:self.view];
    

    
    RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:m_iSelfIndex];
    if (userView.UserNowState == 7)
    {
           logMyLogInfo(@"send timeout back info");
       [self sendTimeout_back:m_objShareUser.userIDForDzpk backType:0];
    }
   
    [self RemoveSubViewOrHideSubView:point];
    
}



-(void)dealloc
{
    if (m_arrStorCardNumber)
    {
        [m_arrStorCardNumber removeAllObjects];
        [m_arrStorCardNumber release];
        m_arrStorCardNumber = nil;
    }
    if (m_lockCountTimes)
    {
        [m_lockCountTimes release];
        m_lockCountTimes = nil;
    }
    if (m_arrayUndealInfo)
    {
        [m_arrayUndealInfo removeAllObjects];
        [m_arrayUndealInfo release];
        m_arrayUndealInfo = nil;
    }
    if (m_initRoomInfo != NULL)
    {
        free(m_initRoomInfo);
        m_initRoomInfo = NULL;
    }
    if (m_arrStoreUsercard)
    {
        [m_arrStoreUsercard removeAllObjects];
        [m_arrStoreUsercard release];
        m_arrStoreUsercard = nil;
    }
    
    if (m_arrayStoreUserRectInfo)
    {
        [m_arrayStoreUserRectInfo removeAllObjects];
        [m_arrayStoreUserRectInfo release];
        m_arrayStoreUserRectInfo = nil;
    }
    if (m_arrayStoreCardView)
    {
        [m_arrayStoreCardView removeAllObjects];
        [m_arrayStoreCardView release];
        m_arrayStoreCardView = nil;
    }
    if (m_arrayStoreUserView)
    {
        [m_arrayStoreUserView removeAllObjects];
        [m_arrayStoreUserView release];
        m_arrayStoreUserView = nil;
    }
    if (btnFace)
    {
        [btnFace release];
        btnFace = nil;
    }
    if (btnBack)
    {
        [btnBack release];
        btnBack = nil;
    }
    if (btnSpeakWord)
    {
        [btnSpeakWord release];
        btnSpeakWord = nil;
    }
    if (btnLeft)
    {
        [btnLeft release];
        btnLeft = nil;
    }
    if (btnMiddle)
    {
        [btnMiddle release];
        btnMiddle = nil;
    }
    if (btnRight)
    {
        [btnRight release];
        btnRight = nil;
    }
    if (btnStand)
    {
        [btnStand release];
        btnStand = nil;
    }
    if (imageViewCardOne)
    {
        [imageViewCardOne release];
        imageViewCardOne = nil;
    }
    if (imageViewCardTwo)
    {
        [imageViewCardTwo release];
        imageViewCardTwo = nil;
    }
    if (imageViewCardThree)
    {
        [imageViewCardThree release];
        imageViewCardThree = nil;
    }
    if (imageViewCardFour)
    {
        [imageViewCardFour release];
        imageViewCardFour = nil;
    }
    if (imageViewCardFive)
    {
        [imageViewCardFive release];
        imageViewCardFive = nil;
    }
    if (m_lock)
    {
        [m_lock release];
        m_lock = nil;
    }
    
    if (m_lockForArray)
    {
        [m_lockForArray release];
        m_lockForArray = nil;
    }
    
    
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



#pragma mark -   UnSure methods

-(void)RemoveSubViewOrHideSubView:(CGPoint)point
{
    
    for (UIView *view in [self.view subviews])
    {
        switch (view.tag)
        {
            case FACEVIEWTAG:
            case SPEAKVIEWTAG:
                if (!view.hidden && !CGRectContainsPoint(view.frame, point))
                {
                    [view removeFromSuperview];
                }
                break;
            case CARDARRAYVIEWTAG:
                if (m_gameControltype == FRESHTEACHTYPE)
                {
                    return;
                }
                [view removeFromSuperview];
                break;
                //            case SLIDERBGVIEWTAG:
                //                if (!view.hidden && !CGRectContainsPoint(view.frame, point))
                //                {
                //                    [btnRight setBackgroundImage:[UIImage imageNamed:@"button_blue.png"] forState:UIControlStateNormal];
                //                    [btnRight setTitle:AddChip forState:UIControlStateNormal];
                //
                //                    [view setHidden:YES];
                //                }
                //
                //                break;
            case USERINFOVIEWTAG:
                if (!view.hidden && !CGRectContainsPoint(view.frame, point))
                {
                    [UIView animateWithDuration:0.2f
                                     animations:^(void)
                     {
                     
                     
                     view.transform = CGAffineTransformMakeScale(0.01,0.01);
                     
                     } completion:^(BOOL finished)
                     {
                     [view removeFromSuperview];
                     }];
                    
                    
                }
                break;
                
            default:
                break;
        }
    }
    
}



-(void)receivStopTimeFromUserView:(NSNotification*)note
{
    if ([[note object] isKindOfClass:[RJFUserImageView class]])
    {
        RJFUserImageView  *userView = [note object];
        [userView setUserState:7];
        if (userView.Gameplayer.seatID == m_iRealSeat)
        {
            
            [self setLMRButton:NO MiddleTitle:KeepCard];
            logMyLogInfo(@"auto bet :%@",userView);
        }
    }
}


-(void)HandleUserInfo:(NSNotification*)note
{
    
    NSDictionary  *dicInfo = [note userInfo];
    if ([dicInfo valueForKey:USERID] && [dicInfo valueForKey:@"SEATID"])
    {
        UserInfo  *obiUser = [UserInfo shareInstance];
        RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:GAMESOCKETTAG];
        BasisZipAndUnzip  *basic = [[BasisZipAndUnzip alloc] initWithSize:80];
        
        DZPK_CLIENT_REQ_GAME_PLAYER_DATA info = {[[dicInfo valueForKey:@"SEATID"] integerValue],[[dicInfo valueForKey:USERID] intValue]};
        [socket SendCharMessage:[basic syncWithRequest:REQ_GAME_PLAYER_DATA
                                                userID:obiUser.userIDForDzpk
                                           structArray:&info] size:[basic dataSize]];
        [basic release];
        basic = nil;
        
    }
    
    /*UIView  *view = [dicInfo valueForKey:USERINFOVIEW];
     view.tag = USERINFOVIEWTAG;
     [self insertViewToFit:view];
     [UIView animateWithDuration:0.2f
     animations:^(void)
     {
     
     
     view.transform = CGAffineTransformMakeScale(1, 1);
     
     }];*/
}


-(void)dealNotiForproREQ_REQ_GAME_PLAYER_DATA:(int32_t)requestCode handle:(void*)handle
{
    DZPK_SERVER_REQ_GAME_PLAYER_DATA  *info = handle;
    if (!info->status && info->userID > 0)
    {
        
        logMyLogInfo(@"-------------------receive _REQ_GAME_PLAYER_DATA: -------------------");
        
        logMyLogInfo(@"获取个人信息成功\nstatus:%d nick:%@ chips:%d headPicName:%@ level:%d lose_number:%d matchScore:%d maxwin:%d nick:%@ score:%d seatID:%d sex:%d status:%d userID:%d winnumber:%d cardArraynumber:%d",info->status,info->nick,info->chips,info->headPicName,info->level,info->lose_number,info->matchscore,info->max_win,info->nick,info->score,info->seatID,info->sex,info->status,info->userID,info->win_number,info->cardArrayNumber);
        for (int i = 0; i < info->cardArrayNumber; i++)
        {
            logMyLogInfo(@"card[%i]:%d",i,info->maxCards[i]);
        }
        
        logMyLogInfo(@"-------------------end receive _REQ_GAME_PLAYER_DATA-----------------");
        
        RJFUserdetail *detail = [[RJFUserdetail alloc] initWithFrame:CGRectMake((SCREENWIDTH-385)/2,(SCREENHEIGHT-277)/2, 385, 277)
                                                              withID:info->userID];
        
      

        NSArray  *prices = [NSArray arrayWithObjects:@10,@2,@30,@40,@35,@20, nil];
        NSArray  *arrayTag = [NSArray arrayWithObjects:@1,@2,@3,@4,@5,@6, nil];
        
        if ([[NSUserDefaults standardUserDefaults] valueForKey:CURRENTPROPPRICES]  && [[NSUserDefaults standardUserDefaults] valueForKey:CURRENTPROPTAGS])
        {
            prices = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENTPROPPRICES];
            arrayTag = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENTPROPTAGS];
            
        }
        
        NSMutableArray    *arrayItems = [NSMutableArray array];
        //price【0】 is chip max chip
        for (int i = 0; i < [arrayTag count]  && i < [prices count]; i++)
        {
            int32_t    fprice = [[prices objectAtIndex:i] intValue];
            BOOL       bCanUser = YES;
            if (fprice > m_objShareUser.userChips  ||
                info->seatID == m_iRealSeat ||
                !m_objShareUser.userHasSitDown)
            {
                bCanUser = NO;
            }
            NSString     *strItemNames = nil;
            switch ([[arrayTag objectAtIndex:i] intValue])
            {
                case 1:
                    if (bCanUser)
                    {
                        strItemNames = @"dzpk_prop_lovebox.png";
                    }else
                    {
                        strItemNames = @"dzpk_prop_gray_lovebox.png";
                    }
                    break;
                case 3:
                    if (bCanUser)
                    {
                        strItemNames = @"dzpk_prop_wineglass.png";
                    }else
                    {
                        strItemNames = @"dzpk_prop_gray_wineglass.png";
                    }
                    break;
                case 2:
                    if (bCanUser)
                    {
                        strItemNames = @"dzpk_prop_kiss.png";
                    }else
                    {
                        strItemNames = @"dzpk_prop_gray_kiss.png";
                    }
                    break;
                case 4:
                    if (bCanUser)
                    {
                        strItemNames = @"dzpk_prop_boom.png";
                    }else
                    {
                        strItemNames = @"dzpk_prop_gray_boom.png";
                    }
                    break;
                case 5:
                    if (bCanUser)
                    {
                        strItemNames = @"dzpk_prop_eggs.png";
                    }else
                    {
                        strItemNames = @"dzpk_prop_gray_eggs.png";
                    }
                    break;
               /* case 6:
                    if (bCanUser)
                    {
                        strItemNames = @"dzpk_prop_boomerang.png";
                    }else
                    {
                        strItemNames = @"dzpk_prop_gray_boomerang.png";
                    }
                    break;*/
                case 6:
                    if (bCanUser)
                    {
                        strItemNames = @"dzpk_prop_lighting.png";
                    }else
                    {
                        strItemNames = @"dzpk_prop_gray_lighting.png";
                    }
                    break;
                    
                default:
                    break;
            }
            if (strItemNames)
            {
                [arrayItems addObject:strItemNames];
            }
        }
        
                
        detail.arrayItems = arrayItems;
        detail.arrayPrices = prices;
        detail.arrayTags = arrayTag;
        detail.seatID = info->seatID;
        detail.delegate = self;
        
        
        int32_t   serverMaxchip = [[prices objectAtIndex:0] intValue];
        int32_t   maxChip = (m_objShareUser.userChips > serverMaxchip ?serverMaxchip:m_objShareUser.userChips);
        detail.MaxChip = maxChip;


        
        [detail SetInfoAccorddata:info];
        [self insertViewToFit:detail];
        detail.tag = USERINFOVIEWTAG;
        [UIView animateWithDuration:0.2f
                         animations:^(void)
         {
         
         
         detail.transform = CGAffineTransformMakeScale(1, 1);
         
         }];
        
        [detail release];
    }else
    {
        logMyLogInfo(@"获取个人信息失败！");
    }
    
}
#pragma mark receive noti from server
-(void)dealNotiForproREQ_GAME_SEND_ACTION:(int32_t)requestCode  handle:(void*)handle
{
    //47
    
   
    DZPK_SERVER_REQ_GAME_SEND_ACTION *info = (DZPK_SERVER_REQ_GAME_SEND_ACTION*)handle;
    logMyLogInfo(@"-------------------receive SEND_ACTION: -------------------");
    
    logMyLogInfo(@"status:%d ",info->status);
    
    logMyLogInfo(@"-------------------end receive SEND_ACTION-----------------");
    
    
    logMyLogInfo(@"..................Send action timer:%@",[NSDate date]);
    if (info->status)
    {
        logMyLogInfo(@"++++++++++action fail++++++++++++++");
        return;
    }
    
    
    
    RJFUserImageView    *userview = [m_arrayStoreUserView objectAtIndex:m_iSelfIndex];
    [userview StopTimer:nil];
    [self setLMRButton:NO MiddleTitle:KeepCard];
    switch (m_userAction)
    {
        case actionputchip:
            [userview setUserState:1];
            [self BeginBetChips:m_inowPutChip UserIndex:m_iSelfIndex];
            break;
        case actionfollowchip:
            [userview setUserState:2];
            [self BeginBetChips:m_inowPutChip UserIndex:m_iSelfIndex];
            break;
        case actionaddchip:
            [userview setUserState:3];
            [self BeginBetChips:m_inowPutChip UserIndex:m_iSelfIndex];
            logMyLogInfo(@"nowputchip:%d",m_inowMaxChip);
            break;
        case actionallPut:
            [userview setUserState:4];
            [RJFaudioPlay PlayMyAudio:@"all_in.mp3"];
            [self BeginBetChips:m_inowPutChip UserIndex:m_iSelfIndex];
            m_bHasGiveUpOrAllput = YES;
            [self setLMREnable:NO Hide:YES];
            break;
        case actionkeepchip:
            [userview setUserState:m_userAction];
            break;
        case actiongiveupCard:
            m_bHasGiveUpOrAllput = YES;
            [userview setUserState:m_userAction];
            [RJFaudioPlay PlayMyAudio:@"fold.mp3"];
            [self setLMREnable:NO Hide:YES];
            break;
        default:
            break;
    }
   //  usleep(30000);
    
    
}
-(void)dealNotiForproREQ_GAME_SEND_SEAT_ACTION:(int32_t)requestCode  handle:(void*)handle
{
    //45
    
    DZPK_SERVER_REQ_GAME_SEND_SEAT_ACTION  *info = (DZPK_SERVER_REQ_GAME_SEND_SEAT_ACTION*)handle;
    logMyLogInfo(@"wwwww  status :%d",info->status);
    HideHUD(self, YES);
    
    
    if (info->status)
    {
        return;
    }
    if (info->status && info->action == 1)
    {
        if (m_objShareUser.userHasSitDown)
        {
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n\n操作失败！", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
        }
        return;
    }else if(info->status && info->action == 2)
    {
        if (!m_objShareUser.userHasSitDown)
        {
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n\n操作失败！", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
        }
        return;
    }
    
    logMyLogInfo(@"-------------------receive SEND_SEAT_ACTION: -------------------");
    
    logMyLogInfo(@"status:%d action:%d leaveChip:%d tablechips:%d",info->status,info->action,info->leavelChips,info->tableChip);
    
    logMyLogInfo(@"-------------------end receive SEND_SEAT_ACTION-----------------");
    
    RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:m_iSelfIndex];
    switch (info->action)
    {
        case 1:
            
            [self UpdateSeatAccordIndex:m_iSelfIndex];
            
            [self setUnseatHide:YES];
            
            [btnStand setHidden:NO];
            
            [[m_arrayStoreUserView objectAtIndex:m_iSelfIndex] IsitDown:m_iRealSeat];
            
            BOOL  bHasMyCard = [self hasUsercardFromServer:m_iRealSeat];
            
            
            if (!bHasMyCard && m_gameStatus == GAMENOWISPLAYING)
            {
                [userView setUserState:8];
            }else
            {
                [userView setUserState:0];
            }
            [self SendUserGetdeatilInfo];
            break;
        case 2:
            [self actionAfterIStand:nil];
            [self SendUserGetdeatilInfo];
            break;
        case 3:
           
            m_objShareUser.bringChip = m_myRoomAllinfo.bringgold;
            [self.navigationController popViewControllerAnimated:YES];
           
            if (m_gameStatus == GAMENOWISCOUNTDOWNING)
            {
                [self stopCountDown:nil];
            }
            
            m_objShareUser.userHasSitDown = NO;
            
            break;
            
        default:
            break;
    }
    
    
   
    m_objShareUser.userChips = info->leavelChips;
    m_myRoomAllinfo.bringgold = info->tableChip;
    userView.Gameplayer.bringChip = info->tableChip;
    [userView.labelWeath setText:[NSString stringWithNeedTranfanNumber:userView.Gameplayer.bringChip returnType:GAMESHOWTYPE]];
    logMyLogInfo(@")))))))))))))seat action userView :%@",userView);
    logMyLogInfo(@"wwwww  1 sitdown 2 stand 3 levea room\nuser action:%d",info->action);
    // m_myRoomAllinfo.bringGold = info->tableChip;
    
    
}


-(BOOL)hasUsercardFromServer:(int8_t)seat
{
    BOOL  bHasMyCard = NO;
    NSArray *arrayUserCard = [NSArray arrayWithArray:m_arrStoreUsercard];
    for (NSDictionary  *dicInfo in arrayUserCard)
    {
        if ([dicInfo valueForKey:SEATID] &&
            [[dicInfo valueForKey:SEATID] intValue] == seat)
        {
            bHasMyCard = YES;
            break;
        }
    }
    return bHasMyCard;
}

-(void)dealNotiForproREQ_GAME_SEND_MSG:(int32_t)requestCode  handle:(void*)handle
{
    //46
    DZPK_SERVER_REQ_GAME_SEND_MSG  *info = (DZPK_SERVER_REQ_GAME_SEND_MSG*)handle;
    logMyLogInfo(@"-------------------receive REQ_GAME_SEND_MSG: -------------------");
    
    logMyLogInfo(@"status:%d",info->status);
    
    logMyLogInfo(@"-------------------end receive REQ_GAME_SEND_MSG:-----------------");
    if (info->status)
    {
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:NSLocalizedString(@"提示\n\n发送消息失败", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
    }
    
    
}
-(void)dealNotiForproREQ_GAME_RECV_SEAT_DOWN:(int32_t)requestCode handle:(void*)handle
{
    //51
    
    DZPK_SERVER_REQ_GAME_RECV_SEAT_DOWN  *info = (DZPK_SERVER_REQ_GAME_RECV_SEAT_DOWN*)handle;
    
    logMyLogInfo(@"-------------------receive _RECV_SEAT_DOWN: -------------------");
    
    logMyLogInfo(@"seatID:%d ,nick:%@,headPicName:%@, chips:%d, info->playerUserID:%d",info->seatID,info->nick,info->headPic,info->chips,info->userID);
    
    logMyLogInfo(@"-------------------end receive _RECV_SEAT_DOWN:-----------------");
    
    
    GamePlayer  *player = [[GamePlayer alloc] init];
    player.UserId = info->userID;
    if (info->nick)
    {
        player.UserName = info->nick;
    }
    if (info->headPic)
    {
        player.UserImagePath = info->headPic;
    }
    
    
    player.bringChip = info->chips;
    player.seatID = info->seatID;
    RJFUserImageView  *userView  = nil;
    if (info->seatID > -1 && info->seatID < MAXPERSONNUMBER)
    {
        userView = [m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:info->seatID]];
        [userView setHidden:NO];
        [userView SetSeatState:NO MySelfOrOther:NO  GAempLayer:player];
        if (info->seatID == m_iRealSeat)
        {
            m_iRealSeat = -1;
        }
        if ((m_gameStatus == GAMENOWISPLAYING && [self GetCurrentPlayingCount:nil] > 1))
        {
            [userView setUserState:8];
        }else
        {
            [userView setUserState:0];
        }
        
    }
    
    [player release];
    player = nil;
    
    
}
-(void)dealNotiForproREQ_GAME_RECV_ACTION:(int32_t)requestCode handle:(void*)handle
{
    
    [self stopTimeSlide:nil];

    //49
    
    DZPK_SERVER_REQ_GAME_RECV_ACTION  *info = (DZPK_SERVER_REQ_GAME_RECV_ACTION*)handle;
    
    
    logMyLogInfo(@"\n\n\n\n\n\nreceiveAction time:%@\n\n\n\n\n\n\n\n\n\n",[NSDate date]);
    logMyLogInfo(@"-------------------receive RECV_ACTION -------------------");
    
    logMyLogInfo(@"seatID:%d ,action:%d,anteNumber(chips):%d, operationID:%d, info->playerID:%d  m_irealSeat:%d",info->seatID,info->action,info->anteNumber,info->operationID,info->playerID,m_iRealSeat);
    
    logMyLogInfo(@"-------------------end receive RECV_ACTION-----------------");
    
    if  (info->seatID < 0 || info->seatID >= MAXPERSONNUMBER)
    {
        logMyLogInfo(@"wait....");
        return;
    }
    
    if (info->seatID == m_iRealSeat && info->action != 7)
    {
        logMyLogInfo(@"Start userTime here:%@ in RECV_ACTION",[NSDate date]);
        [self setLMRStateAccordCurrentOperSeat:info->operationID needShowDefaultInfo:NO];
        return;
    }
    int index = [self MakeSureNowindexFromNet:info->seatID];
    RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:index];
    logMyLogInfo(@"Start userTime here:%@ in RECV_ACTION later",[NSDate date]);
    
    
    logMyLogInfo(@"info->seat:%d m_irealSeatID:%d",info->seatID,m_iRealSeat);
    [userView setUserState:info->action];
    switch (info->action)
    {
        case 1:
            break;
        case 2:
        case 3:
            [self BeginBetChips:info->anteNumber UserIndex:index];
            //[RJFaudioPlay PlayMyAudio:@"all_in.mp3"];
            break;
        case 4:
            if (info->anteNumber > userView.Gameplayer.bringChip)
            {
                [self BeginBetChips:userView.Gameplayer.bringChip UserIndex:index];
            }else
            {
                [self BeginBetChips:userView.Gameplayer.bringChip UserIndex:index];
            }
            
            [RJFaudioPlay PlayMyAudio:@"all_in.mp3"];
            break;
        case 5:
            break;
        case 6:
            [RJFaudioPlay PlayMyAudio:@"fold.mp3"];
            break;
        case 7:
            break;
            
        default:
            break;
    }
      [self setLMRStateAccordCurrentOperSeat:info->operationID needShowDefaultInfo:NO];
    
    
   
    if (info->action == 7 && info->seatID == m_iRealSeat)
    {
        [self setLMRButton:NO MiddleTitle:FollowAnyChip];
    }

    
}
-(void)dealNotiForproREQ_GAME_RECV_LEAVE:(int32_t)requestCode handle:(void*)handle
{
    //50
    
    DZPK_SERVER_REQ_GAME_RECV_LEAVE  *info = (DZPK_SERVER_REQ_GAME_RECV_LEAVE*)handle;
    logMyLogInfo(@"userID:%d seatID:%d",info->userID,info->seatID);
    
    logMyLogInfo(@"-------------------receive RECV_LEAVE -------------------");
    
    logMyLogInfo(@"seatID:%d userID:%d",info->seatID,info->userID);
    
    logMyLogInfo(@"-------------------end receive RECV_LEAVE-----------------");
    
    if (info->seatID == m_iRealSeat)
    {
        [self actionAfterIStand:nil];
        logMyLogInfo(@"my self leaval");
    }else
    {
        logMyLogInfo(@"userID:%d  seat:%d stand up or leave",info->userID,info->seatID);
        
        [self setUserLeaveAccordNetSeat:info->seatID];
    }
    if ([self GetCurrentPlayingCount:nil] < 2)
    {
        //  m_CountDownNumber = 0;
        [self stopCountDown:nil];
        [self CleanAfterEveryGame:nil];
        logMyLogInfo(@"stop:CountDown");
        
    }
    
    
    
}



-(void)stopTimeSlide:(id)Thread
{
    for (RJFUserImageView  *userView in m_arrayStoreUserView)
    {
        [userView StopTimer:nil];
   
    }
    
}
-(void)dealNotiForREQ_GAME_RECV_CARDS:(int32_t)requestCode handle:(void*)handle
{
    
    [self stopTimeSlide:nil];
    DZPK_SERVER_REQ_GAME_RECV_CARDS  *info = (DZPK_SERVER_REQ_GAME_RECV_CARDS*)handle;
    
    
    logMyLogInfo(@"\n\n\n\n\n\nreceive  cards time:%@\n\n\n\n\n\n\n\n\n\n",[NSDate date]);
    logMyLogInfo(@"-------------------receive cards-------------------");
    for (int i = 0; i < info->systemNumbeer; i++)
    {
        logMyLogInfo(@"card[%i]:%d  seatID:%d",i,info->systemIDArray[i],info->seatID);
    }
    logMyLogInfo(@"-------------------end receive card-----------------");
    [self gatherchips:nil];
    [self CleanAfterEverybetchip:nil];
    
    
    int8_t  *card = malloc(sizeof(int8_t)*7);
    int   iNumber = 0;
    NSMutableArray  *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < info->systemNumbeer; i++)
    {
        
        logMyLogInfo(@"card %d  %d number:%d",i,info->systemIDArray[i],info->systemNumbeer);
        [m_arrStorCardNumber addObject:@(info->systemIDArray[i])];
        [array addObject:[self AccordNumberGetCardimage:info->systemIDArray[i]]];
    }
    
    NSArray  *arrCardNumber = [NSArray arrayWithArray:m_arrStorCardNumber];
    for (int i = 0; i < [arrCardNumber count] && i < 8; i++)
    {
        card[i] = [[arrCardNumber objectAtIndex:i] intValue];
        iNumber++;
        logMyLogInfo(@"card[%i]:%d",i,card[i]);
    }
    
    if (!(info->systemNumbeer > 3 || info->systemNumbeer == 2))
    {
        [self showTheCardType:card number:iNumber];
    }
    
    logMyLogInfo(@"àaaaaaaa array receive cards:++++++\n%@",array);
    if (info->systemNumbeer > 1)
    {
        imageViewCardFour.image = nil;
        imageViewCardFive.image = nil;
    }
    
    logMyLogInfo(@"seatID:%d cardNumber:%d n_irealSeatID:%d",info->seatID,info->systemNumbeer,m_iRealSeat);
    if ([array count] == 3)
    {
        [self roateCardAccordInfo:[NSDictionary dictionaryWithObjectsAndKeys:[array objectAtIndex:0],@"0",[array objectAtIndex:1],@"1",[array objectAtIndex:2],@"2",nil]];
    }else if ([array count] == 4)
    {
        [self roateCardAccordInfo:[NSDictionary dictionaryWithObjectsAndKeys:[array objectAtIndex:0],@"0",[array objectAtIndex:1],@"1",[array objectAtIndex:2],@"2",[array objectAtIndex:3],@"3",nil]];
    }
    else if ([array count] == 5)
    {
        [self roateCardAccordInfo:[NSDictionary dictionaryWithObjectsAndKeys:[array objectAtIndex:0],@"0",[array objectAtIndex:1],@"1",[array objectAtIndex:2],@"2",[array objectAtIndex:3],@"3",[array objectAtIndex:4],@"4",nil]];
    }
    
    logMyLogInfo(@"----------------array count:%d  imageViewCardFour.image:%@ imageViewCardFive.image:%@--------------\n\n\n",[array count],imageViewCardFour.image,imageViewCardFive.image);
    if ([array count] == 1 && imageViewCardFour.image == nil)
    {
        [self roateCardAccordInfo:[NSDictionary dictionaryWithObjectsAndKeys:[array objectAtIndex:0],@"3", nil]];
        
    }else if ([array count] == 1 && imageViewCardFive.image == nil)
    {
        [self roateCardAccordInfo:[NSDictionary dictionaryWithObjectsAndKeys:[array objectAtIndex:0],@"4", nil]];
    }else if ([array count] == 2 && imageViewCardFour.image == nil && imageViewCardFive.image == nil)
    {
        [self roateCardAccordInfo:[NSDictionary dictionaryWithObjectsAndKeys:[array objectAtIndex:0],@"3",[array objectAtIndex:1],@"4",nil]];
    }
    logMyLogInfo(@"has rorate card");
    if([array count])
    {
        m_inowMaxChip = 0;
    }
    
    logMyLogInfo(@"Start userTime here:%@ in RECV_Cards",[NSDate date]);
    
    if (info->seatID > -1 && info->seatID < MAXPERSONNUMBER)
    {
        [self setLMRStateAccordCurrentOperSeat:info->seatID needShowDefaultInfo:NO];
        usleep(200000);
    }
    
    // [NSThread sleepForTimeInterval:1];
    
    free(card);
    card = NULL;
    free(info->systemIDArray);
    info->systemIDArray = NULL;
    [array removeAllObjects];
    [array release];
    array = nil;
    
    
    
    
}

-(void)setLMRStateAccordCurrentOperSeat:(int8_t)seatID needShowDefaultInfo:(BOOL)bIsShow
{
  
    
    logMyLogInfo(@"setLMRStateAccordCurrentOperSeat:  seatID:%d bisHSow:%d",seatID,bIsShow);
    if (seatID > -1 && seatID < MAXPERSONNUMBER)
    {
        logMyLogInfo(@"has make sure operaterd seatid:%d",seatID);
        RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:seatID]];
        [self SetUserStartTimer:seatID timer:m_myRoomAllinfo.operationTime];
        
        
        
        if (seatID == m_iRealSeat)
        {
            if ([self AccordUserDefault:m_userAutoAction])
            {
                [self setLMRButton:NO MiddleTitle:FollowAnyChip];
                m_userAutoAction = -1;
                return;
            }
            
            
            if (m_inowMaxChip == userView.Gameplayer.giveChip || m_inowMaxChip == 0)
            {
                [self setLMRButton:YES MiddleTitle:KeepCard];
                logMyLogInfo(@"1 m_inowMax:%d giveChip:%d",m_inowMaxChip,userView.Gameplayer.giveChip);
            }else if(m_inowMaxChip > userView.Gameplayer.giveChip
                     && (userView.Gameplayer.bringChip-m_inowMaxChip > 0))
            {
                
                [self setLMRButton:YES MiddleTitle:FollowChip];
                logMyLogInfo(@"2 m_inowMax:%d giveChip:%d",m_inowMaxChip,userView.Gameplayer.giveChip);
            }else if (m_inowMaxChip > userView.Gameplayer.giveChip
                      && (userView.Gameplayer.bringChip-m_inowMaxChip <= 0))
            {
                [self setLMRButton:YES MiddleTitle:ALLChipBet];
                logMyLogInfo(@"3 m_inowMax:%d giveChip:%d",m_inowMaxChip,userView.Gameplayer.giveChip);
            }
            
            if (self.isInBackGroundMode)
            {
                [self PresentLocalication:@"轮到你下注了！" SoundName:nil fireDate:nil];
            }
       // UIApplication  *appl = [UIApplication sharedApplication];
        
        
        }
        
        
        if (bIsShow  && m_objShareUser.userHasSitDown && seatID != m_iRealSeat)
        {
            [self setLMRButton:NO MiddleTitle:FollowAnyChip]; 
        }
        
        
    }
    
}
-(void)dealNotiForproREQ_GAME_RECV_WINNER:(int32_t)requestCode handle:(void*)handle
{
    //53
    [self stopTimeSlide:nil];
    self.currentOp = -1;
    m_bHasRecvStratInfo = NO;
    m_gameStatus = GAMENOWISOVER;
    DZPK_SERVER_REQ_GAME_RECV_WINNER  *info = (DZPK_SERVER_REQ_GAME_RECV_WINNER*)handle;
    
    logMyLogInfo(@"-------------------receive winner-------------------");
    for (int i = 0; i < info->playerNumbeer; i++)
    {
        logMyLogInfo(@"playerIDarray:[%i]:%d ",i,info->playerArray[i]);
    }
    for (int i = 0; i < info->seatIDNumbeer; i++)
    {
        logMyLogInfo(@"seatIDarray[%i]:%d ",i,info->seatIDArray[i]);
    }
    for (int i = 0; i < info->allPlayerChipNumber; i++)
    {
        logMyLogInfo(@"allPlayerChip[%d]:%d ",i,info->allPlayerchip[i]);
    }
    for (int i = 0; i < info->allplayerNumber; i++)
    {
        logMyLogInfo(@"allplayerID[%i]:%d ",i,info->allplayerID[i]);
    }
    for (int i = 0; i < info->chipsNumbeer; i++)
    {
        logMyLogInfo(@"chipsArray[%i]:%d ",i,info->chipsArray[i]);
    }
    for (int i = 0; i < info->cardSortNumbeer; i++)
    {
        logMyLogInfo(@"cardSort[%i]:%d ",i,info->cardSort[i]);
    }
    for (int i = 0; i < info->cardTypesNumbeer; i++)
    {
        logMyLogInfo(@"cardTypesArray[%i]:%d",i,info->cardTypesArray[i]);
    }
    
    for (int i = 0; i < info->firstCardArrayNumber; i++)
     {
     logMyLogInfo(@"first[%i]:%d second[%i]:%i  ismax[%i]:%i",i,info->firstCardArray[i],i,info->secondArray[i],i,info->isMaxCardArray[i]);
     }
    logMyLogInfo(@"-------------------end receive winner-----------------");
    
    
    if (info->firstCardArray  && info->secondArray && info->isMaxCardArray)
    {
        if (info->firstCardArrayNumber != info->secondCardArrayNumber  && info->secondCardArrayNumber != info->ismaxCardArrayNumber)
        {
            
        }else
        {
            for (int i = 0; i < info->firstCardArrayNumber; i++)
            {
                logMyLogInfo(@"first[%i]:%d second[%i]:%i  ismax[%i]:%i",i,info->firstCardArray[i],i,info->secondArray[i],i,info->isMaxCardArray[i]);
                if (info->firstCardArray[i] < 0 || info->secondArray[i] < 0)
                {
                    continue;
                }else
                {
                    
                    NSDictionary  *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:[self AccordNumberGetCardimage:info->firstCardArray[i]],FIRSTCARD,[self AccordNumberGetCardimage:info->secondArray[i]],SECONDCARD,@(i),SEATID,nil];
                    [m_arrStoreUsercard addObject:dicInfo];
                    if (i == m_iRealSeat)
                    {
                        if (!info->isMaxCardArray[i])
                        {
                            [self shareMsg:NSLocalizedString(@"分享我的最大手牌！", nil) iSScreen:YES];
                        }
                        [m_arrStorCardNumber removeAllObjects];
                        [m_arrStorCardNumber addObject:@(info->secondArray[i])];
                        [m_arrStorCardNumber addObject:@(info->firstCardArray[i])];
                    }
                }
            }
        }
    }
    
    [self gatherchips:nil];
    m_bHasFapai = NO;
    
    for (RJFUserImageView  *userView in m_arrayStoreUserView)
    {
        if (userView.hidden || userView.userType == NOUSER)
        {
            continue;
        }

        NSString  *strFirstCard = [self accordSeatGetCard:userView.Gameplayer.seatID FirstOrSecond:1];
        NSString  *strSecond= [self accordSeatGetCard:userView.Gameplayer.seatID FirstOrSecond:2];
        [userView setCardShow:strFirstCard SecondCard:strSecond winerString:nil];
        
        /*for (int j = 0; j < info->seatIDNumbeer; j++)
         {
         if (userView.Gameplayer.seatID == info->seatIDArray[j] &&
         (info->seatIDArray[j] != m_iRealSeat) && userView.Gameplayer.hadbetchip < info->chipsArray[j])
         {
         bWiner = YES;
         break;
         }
         }
         
         if (!bWiner)
         {
         NSString  *strFirstCard = [self accordSeatGetCard:userView.Gameplayer.seatID FirstOrSecond:1];
         NSString  *strSecond= [self accordSeatGetCard:userView.Gameplayer.seatID FirstOrSecond:2];
         [userView setCardShow:strFirstCard SecondCard:strSecond winerString:nil];
         NSLog(@"info->seatID:%d m_iRealID:%d",userView.Gameplayer.seatID,m_iRealSeat);
         }*/
        
    }
    logMyLogInfo(@"before NStime:%@",[NSDate date]);
    int  winnerCount  = 0;
    
    
    for (int i = 0; i < info->seatIDNumbeer; i++)
    {
        
        NSString   *strWinString = @"";
        if (info->seatIDArray[i] > -1)
        {
            switch (info->cardTypesArray[i])
            {
                case 1:
                    strWinString = HUANGJIATONGHUASHUNWIN;
                    break;
                case 2:
                    strWinString = TONGHUASHUNWIN;
                    break;
                case 3:
                    strWinString = SITIAOWIN;
                    break;
                case 4:
                    strWinString = HULUWIN;
                    break;
                case 5:
                    strWinString = TONGHUAWIN;
                    break;
                case 6:
                    strWinString = SHUNZIWIN;
                    break;
                case 7:
                    strWinString = SANTIAOWIN;
                    break;
                case 8:
                    strWinString = LIANGDUIWIN;
                    break;
                case 9:
                    strWinString = DUIZIWIN;
                    break;
                case 10:
                    strWinString = GAOPAIWIN;
                    break;
                default:
                    break;
            }
            
        }
        
        RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:info->seatIDArray[i]]];
        
        if (userView.Gameplayer.hadbetchip <= info->chipsArray[i])
        {
            winnerCount++;
            
            logMyLogInfo(@"...............seatId:%d   strwinerString :%@",info->seatIDArray[i],strWinString);
            if (info->seatIDArray[i] == m_iRealSeat)
            {
                [RJFaudioPlay PlayMyAudio:@"oh.mp3"];
                [[userView labelNameAndAction] setText:strWinString];
                [self youWinAni:140 icount:0];
                [self setUserviewWinCard:userView cardSort:info->cardSort cardNumber:info->cardSortNumbeer];
                
            }else
            {
                if (info->seatIDArray[i] < 0 || info->seatIDArray[i] >= MAXPERSONNUMBER)
                {
                    continue;
                }
                NSString  *strFirstCard = [self accordSeatGetCard:info->seatIDArray[i] FirstOrSecond:1];
                NSString  *strSecond= [self accordSeatGetCard:info->seatIDArray[i] FirstOrSecond:2];
                [userView setCardShow:strFirstCard SecondCard:strSecond winerString:strWinString];
                
                
                [self setUserviewWinCard:userView cardSort:info->cardSort cardNumber:info->cardSortNumbeer];
                [userView WinerLightlalo:4];
                
                
                
                
                // [userView WinerLightlalo:3];
            }
            
            
            logMyLogInfo(@"seat:%d chip:%d  i:%i infoNumber:%d",info->seatIDArray[i],info->chipsArray[i],i,info->seatIDNumbeer);
            
        }else
        {
            
        }
        if (i == info->seatIDNumbeer-1)
        {
            
            [self UserCollectChips:m_lTotalChipIndesk userView:userView allchips:info->allPlayerchip[info->seatIDArray[i]]];
            
        }else
        {
            [self UserCollectChips:info->chipsArray[i] userView:userView allchips:info->allPlayerchip[info->seatIDArray[i]]];
            
        }
        if (winnerCount > 1)
        {
            for (UIImageView *imageView in m_arrayStoreCardView)
            {
                if ([imageView isKindOfClass:[UIImageView class]])
                {
                    imageView.alpha = 1.0f;
                    [imageView setFrame:CGRectMake(imageView.frame.origin.x, CARDVIEWHEIGHT, imageView.frame.size.width, imageView.frame.size.height)];
                    logMyLogInfo(@"hello");
                    
                }
                
            }
        }
        
        
    }
    
    if (m_myRoomAllinfo.roomCategory != 5)
    {
        NSTimer  *timer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeInterval:GAMEOVERTIME
                                                                               sinceDate:[NSDate date]]
                                                   interval:0
                                                     target:self
                                                   selector:@selector(setStandNOHide:)
                                                   userInfo:nil
                                                    repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [timer release];
        
    }
    
    
    
    //  [self AddchipShowAndRequest:@(NO)];
    
    [self setLMREnable:NO Hide:YES];
    
    
    
    
    
    for (int i = 0;i < info->allPlayerChipNumber;i++)
    {
        m_arrStoreChip[i] = info->allPlayerchip[i];
        if (info->allPlayerchip[i] < 0)
        {
            continue;
        }
        
    }
    
    
    NSTimer   *timer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeInterval:3
                                                                            sinceDate:[NSDate date]]
                                                interval:0
                                                  target:self
                                                selector:@selector(UpdateUserChips:)
                                                userInfo:nil
                                                 repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer
                                 forMode:NSDefaultRunLoopMode];
    [timer release];
    
    
    NSTimer *addChipTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeInterval:GAMEOVERTIME+1
                                                                                 sinceDate:[NSDate date]]
                                                     interval:0
                                                       target:self
                                                     selector:@selector(AddchipShowAndRequest:)
                                                     userInfo:nil
                                                      repeats:NO] ;
    [[NSRunLoop currentRunLoop] addTimer:addChipTimer
                                 forMode:NSDefaultRunLoopMode];
    [addChipTimer release];
    
    
    
    free(info->allPlayerchip);
    free(info->allplayerID);
    free(info->cardSort);
    free(info->cardTypesArray);
    free(info->chipsArray);
    free(info->seatIDArray);
    free(info->playerArray);
    info->allPlayerchip = NULL;
    info->cardSort = NULL;
    info->allplayerID = NULL;
    info->cardTypesArray = NULL;
    info->chipsArray = NULL;
    info->seatIDArray = NULL;
    info->playerArray = NULL;
    
}

-(void)UpdateUserChips:(id)Thread
{
    if (m_gameStatus == GAMENOWISOVER)
    {
        for (int i = 0; i < MAXPERSONNUMBER; i++)
        {
            if (m_arrStoreChip[i] < 0)
            {
                continue;
            }
            RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:i]];
            userView.labelWeath.text = [NSString stringWithNeedTranfanNumber:m_arrStoreChip[i] returnType:GAMESHOWTYPE];
        }
        
    }
}

-(NSString *)GetCardType:(int8_t)cardtype
{
    NSString *strWinString = nil;
    switch (cardtype)
    {
        case 1:
            strWinString = HUANGJIATONGHUASHUN;
            break;
        case 2:
            strWinString = TONGHUASHUN;
            break;
        case 3:
            strWinString = SITIAO;
            break;
        case 4:
            strWinString = HULU;
            break;
        case 5:
            strWinString = TONGHUA;
            break;
        case 6:
            strWinString = SHUNZI;
            break;
        case 7:
            strWinString = SANTIAO;
            break;
        case 8:
            strWinString = LIANGDUI;
            break;
        case 9:
            strWinString = DUIZI;
            break;
        case 10:
            strWinString = GAOPAI;
            break;
        default:
            break;
    }
    return strWinString;
    
}

#if 0
-(void)showWinnerInfoForwinner:(id)Timer
{
    /*   [arrinfo addObject:[NSDictionary dictionaryWithObjectsAndKeys:@(userView.Gameplayer.UserId),@"ID",@(userView.Gameplayer.hadbetchip),@"PUTCHIP",@(info->cardTypesArray[i]),@"WINTYPE",userView.Gameplayer.UserName,@"NAME",@(info->chipsArray[i]),@"CHIP",@(0),@"ISWINNER",nil]];*/
    
    NSArray  *array = [[Timer userInfo] valueForKey:@"info"];
    NSString *strInfo = @"获得筹码玩家情况:\n";
    
    for (int i = 0;i < [array count];i++)
    {
        NSDictionary  *dicInfo = [array objectAtIndex:i];
        
        if ([[dicInfo valueForKey:@"ISWINNER"] boolValue])
        {
            
            NSString *strTemp = [NSString stringWithFormat:@"胜利者：%@ ,id:%@,胜利牌型：%@, 已下注:%@, 赢取:%@\n",[dicInfo valueForKey:@"NAME"],[dicInfo valueForKey:@"ID"],[self GetCardType:[[dicInfo valueForKey:@"WINTYPE"] intValue]],[dicInfo valueForKey:@"PUTCHIP"],[dicInfo valueForKey:@"CHIP"]];
            strInfo = [strInfo stringByAppendingString:strTemp];
            
            
        }else
        {
            
            
            NSString *strTemp = [NSString stringWithFormat:@"胜利者：%@ ,id:%@,牌型：%@, 已下注:%@, 赢取:%@\n",[dicInfo valueForKey:@"NAME"],[dicInfo valueForKey:@"ID"],[self GetCardType:[[dicInfo valueForKey:@"WINTYPE"] intValue]],[dicInfo valueForKey:@"PUTCHIP"],[dicInfo valueForKey:@"CHIP"]];
            strInfo = [strInfo stringByAppendingString:strTemp];
            
            
        }
        
    }
    
    
    strInfo = [strInfo stringByAppendingString:@"\n五张公共牌:  "];
    if ([m_arrStoreCardName count] > 5)
    {
        int count = 0;
        for (int i = [m_arrStoreCardName count]-1; i >= 0; i--)
        {
            count++;
            strInfo = [strInfo stringByAppendingFormat:@"%i:%@  ",count,[self cardNameAccordCard:[m_arrStoreCardName objectAtIndex:i]]];
            if (count == 5)
            {
                break;
            }
        }
    }
    
    strInfo = [strInfo stringByAppendingString:@"\n"];
    strInfo = [strInfo stringByAppendingString:@"\n所有玩家下注情况：\n"];
    
    for (RJFUserImageView  *userView in m_arrayStoreUserView)
    {
        if (userView.hidden || userView.userType == NOUSER)
        {
            continue;
        }
        
        NSString *strCard1 = [self accordSeatGetCard:userView.Gameplayer.seatID FirstOrSecond:1];
        NSString *strCard2 = [self accordSeatGetCard:userView.Gameplayer.seatID FirstOrSecond:2];
        strCard1 = [self cardNameAccordCard:strCard1];
        
        NSString *strTemp = [NSString stringWithFormat:@"玩家：%@, id:%d,已下注:%d\n card1:%@ card2:%@",userView.Gameplayer.UserName,userView.Gameplayer.UserId,userView.Gameplayer.hadbetchip,strCard1,strCard2];
        strInfo = [strInfo stringByAppendingString:strTemp];
        
    }
    
    
    CGFloat  fxmargin = 100;
    CGFloat  fYmargin = 140;
    UIView   *view = [[UIView alloc] initWithFrame:CGRectMake(fxmargin, 30, SCREENWIDTH-fxmargin*2, SCREENHEIGHT-fYmargin/2)];
    view.backgroundColor = [UIColor cyanColor];
    UITextView  *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height-40)];
    [textView setText:strInfo];
    [textView setEditable:NO];
    [view addSubview:textView];
    [textView release];
    
    UIButton  *button = [[UIButton alloc] initWithFrame:CGRectMake((view.frame.size.width-60)/2, view.frame.size.height-30, 60, 20)];
    [button setTitle:@"关闭" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self
               action:@selector(closeWinerInfo:)
     forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [button release];
    [self.view addSubview:view];
    [view release];
}
#endif

-(NSString *)cardNameAccordCard:(NSString *)strCard
{
    NSString *strCardReturn = [strCard stringByReplacingOccurrencesOfString:@".png" withString:@""];
    strCardReturn = [strCardReturn stringByReplacingOccurrencesOfString:@"mei" withString:@"梅"];
    strCardReturn = [strCardReturn stringByReplacingOccurrencesOfString:@"red" withString:@"红"];
    strCardReturn = [strCardReturn stringByReplacingOccurrencesOfString:@"square" withString:@"方"];
    strCardReturn = [strCardReturn stringByReplacingOccurrencesOfString:@"black" withString:@"黑"];
    return strCardReturn;
}
-(void)closeWinerInfo:(UIButton *)btn
{
    if ([btn superview])
    {
        [[btn superview] removeFromSuperview];
    }
}
-(void)setStandNOHide:(id)Thread
{
    logMyLogInfo(@".......after current time:%@",[NSDate date]);
    if (m_objShareUser.userHasSitDown)
    {
        [btnStand setHidden:NO];
    }
    
}
-(void)AddchipShowAndRequest:(id)Thread
{
    if (m_roomIDandPath->roomType != 5 &&
        [[[m_arrayStoreUserView objectAtIndex:m_iSelfIndex] Gameplayer] bringChip] < m_myRoomAllinfo.roomBigbland+m_myRoomAllinfo.serverCharge
        && [m_objShareUser userHasSitDown])
    {
        
        [self addChipthread:nil];
        
        /* NSTimer  *timer = [[[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeInterval:0
         sinceDate:[NSDate date]]
         interval:0 target:self selector:@selector(addChipthread:)
         userInfo:nil
         repeats:NO] autorelease];
         // [timer setFireDate:[NSDate dateWithTimeInterval:5 sinceDate:[NSDate date]]];
         [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];*/
        
        
        //  m_clickInsureMode = ADDCHIPINGAME;
        
        
    }
    
    
}


- (void)CollectanimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    NSArray  *arrayUserView = [NSArray arrayWithArray:m_arrayStoreUserView];
    NSArray  *arrayChipView = [NSArray arrayWithArray:m_arrayStoreChipView];
    UIView  *view = [arrayChipView lastObject];
    
    collectChipstruct *aniUserinfo = (collectChipstruct *)context;
    RJFUserImageView  *userView  = [arrayUserView objectAtIndex:aniUserinfo->index];
    int32_t collectchips = aniUserinfo->collectchips;
    int32_t chips = aniUserinfo->allchips;
    
    if (view)
    {
        
        [self insertViewToFit:view];
        [view setFrame:CGRectMake(userView.frame.origin.x+userView.frame.size.width/2, userView.frame.origin.y+userView.frame.size.height/2, view.frame.size.width, view.frame.size.height)];
    }
    
    [m_arrayStoreChipView makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (RJFUserImageView  *userImageView in arrayUserView)
    {
        [userImageView.labelRecordGiveChip setText:@""];
    }
    m_lTotalChipIndesk -= collectchips;
    if (m_lTotalChipIndesk > 0)
    {
        [labelChips setText:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]];
    }else
    {
        [labelChips setText:@""];
    }
    
    userView.Gameplayer.bringChip = chips;
    if (userView.Gameplayer.bringChip >= 0)
    {
        userView.labelWeath.text = [NSString stringWithNeedTranfanNumber:userView.Gameplayer.bringChip returnType:GAMESHOWTYPE];
    }else
    {
        userView.labelWeath.text = @"0";
        
    }
    free(context);
    context = NULL;
    logMyLogInfo(@"end m_lTotalChipIndesk:%ld  collectchips:%d",m_lTotalChipIndesk,collectchips);
    
}

/*-(void)UserCollectChips:(int32_t)collectchips userView:(RJFUserImageView *)userView allchips:(int32_t)chips
 {
 
 logMyLogInfo(@"begin m_lTotalChipIndesk:%ld  collectchips:%d",m_lTotalChipIndesk,collectchips);
 logMyLogInfo(@"collectchips:%d allchips:%d m_ltotalchips:%ld",collectchips,chips,m_lTotalChipIndesk);
 
 collectChipstruct *aniInfo = malloc(sizeof(collectChipstruct));
 aniInfo->index = [m_arrayStoreUserView indexOfObject:userView];
 aniInfo->allchips = chips;
 aniInfo->collectchips = collectchips;
 
 [UIView beginAnimations:userView.Gameplayer.UserName context:aniInfo];
 [UIView setAnimationDuration:3.0f];
 [UIView setAnimationDelegate:self];
 [UIView setAnimationDidStopSelector:@selector(CollectanimationDidStop:finished:context:)];
 
 NSArray  *arrayUserView = [NSArray arrayWithArray:m_arrayStoreUserView];
 NSArray  *arrayChipView = [NSArray arrayWithArray:m_arrayStoreChipView];
 for (RJFUserImageView  *userImageView in arrayUserView)
 {
 [userImageView.labelRecordGiveChip setText:@""];
 }
 int i = 0;
 
 for (UIView *view in arrayChipView)
 {
 // logMyLogInfo(@"--------======before view:%@",view);
 [view setHidden:NO];
 [view setFrame:CGRectMake(211, 98, 40, 15)];
 [self.view addSubview:view];
 //logMyLogInfo(@"before %d\nview:%@",i,view);
 if ([view superview])
 {
 [view setFrame:CGRectMake(userView.frame.origin.x+userView.frame.size.width/2, userView.frame.origin.y+userView.frame.size.height/2, view.frame.size.width, view.frame.size.height)];
 //   logMyLogInfo(@"after %d\nview:%@",i,view);
 }
 i++;
 //  logMyLogInfo(@"--------======After view:%@",view);
 }
 
 [UIView commitAnimations];
 
 
 
 
 
 
 //  [imageView release];
 
 }*/

-(void)UserCollectChips:(int32_t)collectchips userView:(RJFUserImageView *)userView allchips:(int32_t)chips
{
    
    logMyLogInfo(@"begin m_lTotalChipIndesk:%ld  collectchips:%d",m_lTotalChipIndesk,collectchips);
    logMyLogInfo(@"collectchips:%d allchips:%d m_ltotalchips:%ld",collectchips,chips,m_lTotalChipIndesk);
    
    
    
    
    for (RJFUserImageView  *userImageView in m_arrayStoreUserView)
    {
        [userImageView.labelRecordGiveChip setText:@""];
    }
    
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(211, 98, 12.5, 12.5)];
    imageView.image = [self getImageAccordchip:collectchips];
    [self insertViewToFit:imageView];
    
    
    CABasicAnimation  *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    NSValue  *value = [NSValue valueWithCGPoint:userView.center];
    animation.fromValue = [NSValue valueWithCGPoint:imageView.frame.origin];
    animation.toValue = value;
    animation.duration = 1.0f;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    
    [imageView.layer addAnimation:animation forKey:@"aa"];
    [imageView performSelector:@selector(removeFromSuperview)
                    withObject:nil
                    afterDelay:1.0f];
    [imageView release];
    
    
    
    
    m_lTotalChipIndesk -= collectchips;
    if (m_lTotalChipIndesk > 0)
    {
        [labelChips setText:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]];
    }else
    {
        [labelChips setText:@""];
    }
    
    userView.Gameplayer.bringChip = chips;
    if (userView.Gameplayer.bringChip >= 0)
    {
        userView.labelWeath.text = [NSString stringWithNeedTranfanNumber:userView.Gameplayer.bringChip returnType:GAMESHOWTYPE];
    }else
    {
        userView.labelWeath.text = @"0";
        
    }
    logMyLogInfo(@"imageview animation::%@  \nuserView:%@ ",value,userView);
    
}







-(void)addChipthread:(id)Timer
{
    int  minchip = m_roomIDandPath->roomSmallChip;
    int  maxchip = m_roomIDandPath->roomBigChip;
    
    if (m_objShareUser.userChips < maxchip)
    {
        maxchip = m_objShareUser.userChips;
    }
    
    if (m_objShareUser.userChips < minchip && m_objShareUser.userChips < m_myRoomAllinfo.roomBigbland+m_myRoomAllinfo.serverCharge)
    {
        m_clickInsureMode = CHARGEIDOUMODE;
        [RJFWarnView addinSelfview:self.view
                          delegate:self
                           message:@"提示\n\n\n您的账号所拥有的筹码不能够在此房间玩牌，请充值！"
                        buttontype:BOTHBUTTON
                      InsureButton:NSLocalizedString(@"充值", nil)
                      CancelButton:CANCEL];
        [self sendUserleaveAndstand:2 seatId:m_iRealSeat];
        return;
    }else if (m_objShareUser.userChips < minchip && m_objShareUser.userChips >= m_myRoomAllinfo.roomBigbland+m_myRoomAllinfo.serverCharge)
    {
        minchip = m_myRoomAllinfo.roomBigbland+m_myRoomAllinfo.serverCharge;
        maxchip = m_objShareUser.userChips;
    }
    NSLog(@"maxchip:%d minchip:%d  bigland:%d samll bland:%d enterfee:%d servercharge:%d",maxchip,minchip,m_roomIDandPath->roomBigChip,m_roomIDandPath->roomSmallChip,m_roomIDandPath->enterFee,m_myRoomAllinfo.serverCharge);
    
    
    RJFAddChipView   *chipView = [[RJFAddChipView alloc] initWithFrame:CGRectMake(60, 40, 320, 200) withInfo:[NSDictionary dictionaryWithObjectsAndKeys:@(m_objShareUser.userChips),@"USERCHIP",@(minchip),@"MINCHIP",@(maxchip),@"MAXCHIP",nil]];
    chipView.tag = ADDBRINGCHIPVIEWTAG;
    [chipView setDelegate:self];
    [self insertViewToFit:chipView];
    [chipView release];
    
}



-(void)dealNotiForproREQ_GAME_TIMEOUT_BACK:(int32_t)requestCode  handle:(void*)handle
{
    DZPK_SERVER_REQ_GAME_TIMEOUT_BACK   *info = handle;
    logMyLogInfo(@"\n-------------------receive ENTER_ROOM -------------------");
 
    if (info->status == 0)
    {
        logMyLogInfo(@"status:%d playerID:%d seatID:%d",info->status,info->playerID,info->seatID);
        RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:info->seatID]];
        [userView setAutologo:YES];
        [userView setUserState:0];
        
    }
    
    
    logMyLogInfo(@"\n-------------------end receive ENTER_ROOM----------------------");
    
    
}


-(void)dealNotiForproREQ_GAME_ENTER_ROOM:(int32_t)requestCode handle:(void*)handle
{
    
    HideHUD(self, YES);
    m_initRoomInfo = malloc(sizeof(DZPK_SERVER_REQ_GAME_ENTER_ROOM));
    memcpy(m_initRoomInfo, handle, sizeof(DZPK_SERVER_REQ_GAME_ENTER_ROOM));
    DZPK_SERVER_REQ_GAME_ENTER_ROOM *info = handle;
    if (m_initRoomInfo->status == 0)
    {
        logMyLogInfo(@"\n-------------------receive ENTER_ROOM -------------------");
        logMyLogInfo(@"alreadAnte:%d bankerIndex:%d bigBlind:%d bigSeat:%d countdown_times:%d gamestatus:%d headPicString:%@,myseatID:%d nick:%@ operationID:%d,smallBlind:%d smallSeatID:%d speed:%d status:%d cardarrayNumber:%d anteArrayNumber:%d playerIDarrNumber:%d firstArrayNumber:%d chipsArrayNumber:%d maxAnte:%d",m_initRoomInfo->alreadAnte,m_initRoomInfo->bankerIndex,m_initRoomInfo->bigBlind,m_initRoomInfo->bigIndex,m_initRoomInfo->countdown_times,m_initRoomInfo->gamestatus,m_initRoomInfo->headPicString,m_initRoomInfo->mySeatID,m_initRoomInfo->nick,m_initRoomInfo->operationID,m_initRoomInfo->smallBlind,m_initRoomInfo->smallIndex,m_initRoomInfo->speed,m_initRoomInfo->status,m_initRoomInfo->cardsNumber,m_initRoomInfo->anteArrayNumber,m_initRoomInfo->playerIDNumber,m_initRoomInfo->firstCardNumber,m_initRoomInfo->chipsArrayNumber,m_initRoomInfo->maxAnte);
        for (int i = 0; i < m_initRoomInfo->anteArrayNumber; i++)
        {
            logMyLogInfo(@"SeatID:%d anteChip:%d chips:%d firstCard:%d playerID:%d secondCard:%d status:%d",i,m_initRoomInfo->anteArray[i],m_initRoomInfo->chipsArray[i],m_initRoomInfo->firstCardarray[i],m_initRoomInfo->playerIDArray[i],m_initRoomInfo->SecondArray[i],m_initRoomInfo->statusArray[i]);
        }
        for (int i = 0; i < m_initRoomInfo->cardsNumber; i++)
        {
            logMyLogInfo(@"card[%i]:%d",i,m_initRoomInfo->cards[i]);
        }
        logMyLogInfo(@"\n-------------------end receive ENTER_ROOM----------------------");
        [self setMyInfoAboutRoom:*m_initRoomInfo];
        
      
        
        if (!self.isReconectToServer)
        {
          
            if (m_initRoomInfo->cardsNumber > 0 && m_initRoomInfo->cardsNumber < 6)
            {
                
                NSMutableDictionary  *dicInfo = [NSMutableDictionary dictionaryWithCapacity:m_initRoomInfo->cardsNumber];
                for (int i = 0; i < m_initRoomInfo->cardsNumber; i++)
                {
                    if (m_initRoomInfo->cards[i] < 0 || m_initRoomInfo->cards[i] > 52)
                    {
                        continue;
                    }
                    [dicInfo setObject:[self AccordNumberGetCardimage:m_initRoomInfo->cards[i]] forKey:[NSString stringWithFormat:@"%d",i]];
                    
                }
                [self roateCardAccordInfo:dicInfo];
                logMyLogInfo(@"....................entercard dicInfo:\n%@",dicInfo);
                
            }
            
            [self setPerSonForGame:m_initRoomInfo];
            [self showRoomInfo:nil];
            [self AddChipSliderView:YES chip:100 maxChip:200 minChip:100 Ani:NO];
            [self StartGameTimerNoti:nil];
            [self dealWithUndealrequest];
            
        }else
        { //reconnecting ...................
            
            logMyLogInfo(@"reconnect To server");
            m_bmustWait = YES;
            [self setMyInfoAboutRoom:*m_initRoomInfo];
            
            if (m_initRoomInfo->cardsNumber > 0 && m_initRoomInfo->cardsNumber < 6)
            {
                for (int i = 0; i < m_initRoomInfo->cardsNumber; i++)
                {
                    if (m_initRoomInfo->cards[i] < 0 || m_initRoomInfo->cards[i] > 52)
                    {
                        continue;
                    }
                    UIImageView  *imageCardview = [m_arrayStoreCardView objectAtIndex:i];
                    
                    imageCardview.image = [UIImage imageNamed:[self AccordNumberGetCardimage:m_initRoomInfo->cards[i]]];
                    imageCardview.alpha = 1;
                    imageCardview.hidden = NO;
                    
                }
            }
            
            if(m_objShareUser.userHasSitDown && m_initRoomInfo->mySeatID < 0 )
            {
                [self actionAfterIStand:nil];
            }else if (!m_objShareUser.userHasSitDown && m_initRoomInfo->mySeatID > 0)
            {
                
                m_iRealSeat = m_initRoomInfo->mySeatID;
                m_iSelfIndex = [self MakeSureNowindexFromNet:m_initRoomInfo->mySeatID];
                [self UpdateSeatAccordIndex:m_iSelfIndex];
                [self setUnseatHide:YES];
                RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:m_iSelfIndex];
                logMyLogInfo(@"m_irealSeat:%d",m_iRealSeat);
                [userView IsitDown:m_iRealSeat];
                
                if (m_objShareUser.userHasSitDown)
                {
                    [btnStand setHidden:NO];
                }
                
                if (m_initRoomInfo->gamestatus == 0 || m_initRoomInfo->gamestatus == 2)
                {
                    m_gameStatus = GAMENOWISCOUNTDOWNING;
                    [userView setUserState:0];
                }else if (m_initRoomInfo->gamestatus == 1 || m_initRoomInfo->gamestatus == 3)
                {
                    m_gameStatus = GAMENOWISPLAYING;
                    [userView setUserState:8];
                }
            }else if (m_objShareUser.userHasSitDown && m_initRoomInfo->mySeatID != m_iRealSeat)
            {
                //......
            }
            
            if (m_initRoomInfo->gamestatus == 0 || m_initRoomInfo->gamestatus == 2 || m_initRoomInfo->gamestatus == -1)
            {
                [self CleanAfterEveryGame:nil];
            }
            
            if (m_initRoomInfo->countdown_times > 2  & m_initRoomInfo->countdown_times < 10)
            {
                [self StartCountDown:m_initRoomInfo->countdown_times];
            }
            
            if (m_initRoomInfo->firstCardarray != NULL  &&
                m_initRoomInfo->SecondArray != NULL &&
                m_initRoomInfo->firstCardNumber > 0
                && m_initRoomInfo->secondCardNumber >0)
            {
                
                
                [m_arrStoreUsercard removeAllObjects];
                for (int i = 0;i < m_initRoomInfo->firstCardNumber;i++)
                {
                    if (m_initRoomInfo->firstCardarray[i] < 0 || m_initRoomInfo->secondCardNumber < 0)
                    {
                        continue;
                    }else
                    {
                        
                        NSDictionary  *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:[self AccordNumberGetCardimage:m_initRoomInfo->firstCardarray[i]],FIRSTCARD,[self AccordNumberGetCardimage:m_initRoomInfo->SecondArray[i]],SECONDCARD,@(i),SEATID,nil];
                        [m_arrStoreUsercard addObject:dicInfo];
                        if (i == m_iRealSeat)
                        {
                            [m_arrStorCardNumber removeAllObjects];
                            [m_arrStorCardNumber addObject:@(m_initRoomInfo->SecondArray[i])];
                            [m_arrStorCardNumber addObject:@(m_initRoomInfo->firstCardarray[i])];
                        }
                    }
                }
                
                
                
            }
            
            
            
            NSArray    *arrayNick = nil;
            NSArray    *arrayHeadpic = nil;
            if (m_initRoomInfo->nick && m_initRoomInfo->headPicString)
            {
                arrayNick = [m_initRoomInfo->nick componentsSeparatedByString:COMPONETSTRING];
                arrayHeadpic = [m_initRoomInfo->headPicString componentsSeparatedByString:COMPONETSTRING];
            }
            
            for (int i = 0; i < m_initRoomInfo->playerIDNumber; i++)
            {
                RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:i]];
                if (m_initRoomInfo->playerIDArray[i] < 0)
                {
                    if (userView.hidden  || userView.userType == NOUSER)
                    {
                        continue;
                    }else
                    {
                        [userView SetSeatState:YES MySelfOrOther:NO GAempLayer:nil];
                    }
                }else if (m_initRoomInfo->playerIDArray[i] > 0  )
                {
                    if (userView.hidden  || m_initRoomInfo->playerIDArray[i] != userView.Gameplayer.UserId)
                    {
                        GamePlayer   *Objgameplayer = [[GamePlayer alloc] init];
                        if (i < [arrayNick count])
                        {
                            Objgameplayer.UserName = [arrayNick objectAtIndex:i];
                        }
                        if (i < [arrayHeadpic count])
                        {
                            Objgameplayer.UserImagePath = [arrayHeadpic objectAtIndex:i];
                        }
                        Objgameplayer.UserId = m_initRoomInfo->playerIDArray[i];
                        Objgameplayer.bringChip = m_initRoomInfo->chipsArray[i];
                        Objgameplayer.firstCard = m_initRoomInfo->firstCardarray[i];
                        Objgameplayer.secondCard = m_initRoomInfo->SecondArray[i];
                        Objgameplayer.seatID = i;
                        Objgameplayer.userState = m_initRoomInfo->SecondArray[i];
                        [userView SetSeatState:NO MySelfOrOther:NO GAempLayer:Objgameplayer];
                        [Objgameplayer release];
       
                        
                    }else if(!userView.hidden  && m_initRoomInfo->playerIDArray[i] == userView.Gameplayer.UserId)
                    {
                        userView.Gameplayer.userState = m_initRoomInfo->statusArray[i];
                        
                    }
            
            if (userView.Gameplayer.hadbetchip > 0 && m_initRoomInfo->anteArray[i] <= 0)
            {
                userView.labelRecordGiveChip.text = @"";
                for (UIImageView *imageView in userView.arrayStoreChipView)
                {
                    imageView.hidden = YES;
                }
            }else if (userView.Gameplayer.hadbetchip < m_initRoomInfo->anteArray[i])
            {
                userView.labelRecordGiveChip.text = [NSString stringWithNeedTranfanNumber:m_initRoomInfo->anteArray[i] returnType:GAMESHOWTYPE];
            }
                    
                    userView.giveChip = m_initRoomInfo->anteArray[i];
                    userView.Gameplayer.hadbetchip = m_initRoomInfo->anteArray[i];
            
        }
    }
    
    
    m_initRoomInfo->gamestatus = -1;
    [self StartGameTimerNoti:nil];
    [self dealWithUndealrequest];
    
}


    }else if (m_initRoomInfo->status == 1)
    {
        
        m_iNowChips = m_objShareUser.userChips;
        logMyLogInfo(@"\n-------------------receive _ENTER_ROOM -------------------");
        logMyLogInfo(@"status   :%d",m_initRoomInfo->status);
      
        logMyLogInfo(@"\n-------------------end receive _ENTER_ROOM----------------------");
    
        m_clickInsureMode = ENTERROOMFAILMODE;
        [RJFWarnView addinSelfview:self.view
                          delegate:self
                           message:NSLocalizedString(@"提示\n\n很抱歉，进入房间失败！", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
        free(handle);
        handle = NULL;
        
        return;
        
    }
    
   
    
    free(info->cards);
    info->cards = NULL;
    free(info->anteArray);
    info->anteArray = NULL;
    free(info->chipsArray);
    info->chipsArray = NULL;
    free(info->firstCardarray);
    info->firstCardarray = NULL;
    free(info->playerIDArray);
    info->playerIDArray = NULL;
    free(info->SecondArray);
    info->SecondArray = NULL;
    free(info->statusArray);
    info->statusArray = NULL;
    
    free(handle);
    handle = NULL;
    
}
-(void)dealNotiForproREQ_GAME_RECV_READYTIME:(int32_t)requestCode  handle:(void*)handle
{
    //55
    
    
    
    
    DZPK_SERVER_REQ_GAME_RECV_READYTIME  *info = (DZPK_SERVER_REQ_GAME_RECV_READYTIME*)handle;
    
    if (info->readyTime >= 0 && info->readyTime < 11 && m_gameStatus != GAMENOWISPLAYING)
    {
        
        [self StartCountDown:info->readyTime];
    }
    
    /*if (m_roomIDandPath->roomType != 5 && m_objShareUser.userHasSitDown )
     {
     RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:m_iRealSeat]];
     
     if (userView.Gameplayer.bringChip <= 0)
     {
     
     logMyLogInfo(@"current time:%@",[NSDate date]);
     
     
     }
     
     }*/
    
    logMyLogInfo(@"-------------------receive READYTIME -------------------");
    logMyLogInfo(@"info->readyTime:%d",info->readyTime);
    logMyLogInfo(@"-------------------end receive READYTIME-----------------");
    
    
}
-(void)dealNotiForproREQ_GAME_RECV_START_INFOR:(int32_t)requestCode handle:(void*)handle
{
    
     [self CleanAfterEveryGame:nil];
    
    
    if (m_objShareUser.userHasSitDown)
    {
        m_iStartCount++;
    }
    
    
    
    //56
    DZPK_SERVER_REQ_GAME_RECV_START_INFOR  *info = (DZPK_SERVER_REQ_GAME_RECV_START_INFOR*)handle;
    
    self.currentOp = info->operationID;
    m_myRoomAllinfo.bankerIndex = info->bankerID;
    m_myRoomAllinfo.roomBigIndex = info->bigSeatID;
    m_myRoomAllinfo.roomSmallIndex = info->smallSeatID;
    m_myRoomAllinfo.operationID = info->operationID;
    m_myRoomAllinfo.myseatID = m_iRealSeat;
    m_myRoomAllinfo.roomBigbland = info->bigChip;
    m_myRoomAllinfo.roomSmallblind = info->smallChip;
    
    
    logMyLogInfo(@"-------------------receive start Info -------------------");
    
    logMyLogInfo(@"info->bankerID:%d bigChip:%d bigSeatID:%d operationID:%d,smallchip:%d,smallSeatID:%d  m_irealSeatID:%d firstCardNumber:%d secondArrayNumber:%d  ",info->bankerID,info->bigChip,info->bigSeatID,info->operationID,info->smallChip,info->smallSeatID,m_iRealSeat,info->firstNumber,info->secondNumber);
    
    
    for (int i = 0; i < info->firstNumber; i++)
    {
        logMyLogInfo(@"seatID:%d firstCard:%d second:%d  chip:%d times:%d",i,info->firstCardArray[i],info->SecondCardArray[i],info->chipsArray[i],info->timesArray[i]);
    }
    
    
    for (int i = 0; i < info->taskBoundsArrayNumber; i++)
    {
        logMyLogInfo(@"task[%i]:%i",i,info->taskBounds[i]);
    }
    
    
    logMyLogInfo(@"-------------------end receive start Info-----------------");
    // logMyLogInfo(@";;;;;;;start info m_arrStorCardNumber:%@",m_arrStorCardNumber);
    
    
    
    
    if (info->firstCardArray != NULL  &&
        info->SecondCardArray != NULL &&
        info->firstNumber > 0
        && info->secondNumber >0)
    {
        
        
        [m_arrStoreUsercard removeAllObjects];
        for (int i = 0;i < info->firstNumber;i++)
        {
            if (info->firstCardArray[i] < 0 || info->SecondCardArray < 0)
            {
                continue;
            }else
            {
                
                NSDictionary  *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:[self AccordNumberGetCardimage:info->firstCardArray[i]],FIRSTCARD,[self AccordNumberGetCardimage:info->SecondCardArray[i]],SECONDCARD,@(i),SEATID,nil];
                [m_arrStoreUsercard addObject:dicInfo];
                if (i == m_iRealSeat)
                {
                    [m_arrStorCardNumber removeAllObjects];
                    [m_arrStorCardNumber addObject:@(info->SecondCardArray[i])];
                    [m_arrStorCardNumber addObject:@(info->firstCardArray[i])];
                }
            }
        }
        
        
        
    }
    
    
    if (info->chipsArray!= NULL && info->chipsArrayNumber > 0 && info->chipsArrayNumber < MAXPERSONNUMBER+1)
    {
        for (int i = 0; i < info->chipsArrayNumber; i++)
        {
            
            m_arrStoreChip[i] = info->chipsArray[i];
            if (info->chipsArray[i] > -1)
            {
                // int8_t index = [self MakeSureNowindexFromNet:i];
                //  RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:index];
                // userView.Gameplayer.bringChip = info->chipsArray[i];
                m_arrStoreChip[i] = info->chipsArray[i];
                logMyLogInfo(@"ffffffffffffff make  m_arrrStore[%d]:%d",i,m_arrStoreChip[i]);
                
            }
            logMyLogInfo(@"result  m_arrrStore[%d]:%d",i,m_arrStoreChip[i]);
            
            
        }
        
    }
    
    m_bHasRecvStratInfo = YES;
    if (m_roomIDandPath->roomType == 5 )
    {
        
        
        logMyLogInfo(@"I am in the complete room.  info->bankerindex:%d big seat:%d small seat:%d bigChip:%d smallChip:%d operarSeat:%d m_irealSeat:%d",info->bankerID,info->bigSeatID,info->smallSeatID,info->bigChip,info->smallSeatID,info->operationID,m_iRealSeat);
        [self CleanAfterEveryGame:nil];
        [self StartGame:nil];
        
    }else if (m_gameStatus == GAMENOWISPLAYING)
    {
        if (!m_bHasFapai)
        {
            
            NSString *strFirstCard = @"";
            NSString *strSecondCard = @"";
            
            if ([self hasUsercardFromServer:m_iRealSeat])
            {
                strFirstCard = [self accordSeatGetCard:m_iRealSeat FirstOrSecond:1];
                strSecondCard = [self accordSeatGetCard:m_iRealSeat FirstOrSecond:2];
            }
            [self BeginFapai:m_myRoomAllinfo.bankerIndex FirstCard:strFirstCard SecondCard:strSecondCard];
            logMyLogInfo(@"Now is playing................... we start game here");
        }
        
    }else if(m_gameStatus == GAMENOWISCOUNTDOWNING)
    {
        
        [self stopCountDown:nil];
        //  [self CleanAfterEveryGame:nil];
        logMyLogInfo(@"stop count down when receive startInfo");
        [self StartGame:nil];
        
    }
    
    logMyLogInfo(@"I am in the room.  info->bankerindex:%d big seat:%d small seat:%d bigChip:%d smallChip:%d operarSeat:%d m_irealSeat:%d ",info->bankerID,info->bigSeatID,info->smallSeatID,info->bigChip,info->smallSeatID,info->operationID,m_iRealSeat);
    
    if (m_iRealSeat > -1 && m_iRealSeat < MAXPERSONNUMBER  && m_objShareUser.userHasSitDown)
    {
        [self setCountViewHide:NO countNumber:info->timesArray[m_iRealSeat]];
    }else
    {
        [self setCountViewHide:NO countNumber:-1];
    }
    
    
    
    
    //[self SetUserStartTimer:self.currentOp timer:m_myRoomAllinfo.operationTime];
    
    free(info->chipsArray);
    info->chipsArray = NULL;
    free(info->firstCardArray);
    info->firstCardArray = NULL;
    free(info->SecondCardArray);
    info->SecondCardArray = NULL;
    free(info->chipsArray);
    info->chipsArray = NULL;
    free(info->timesArray);
    info->timesArray = NULL;
    free(info->taskBounds);
    info->taskBounds = NULL;
    
    logMyLogInfo(@"receive startInfo");
    
    
}
-(void)dealNotiForproREQ_GAME_ADD_CHIPS:(int32_t)requestCode  handle:(void*)handle
{
    //57
    DZPK_SERVER_REQ_GAME_ADD_CHIPS  *info = (DZPK_SERVER_REQ_GAME_ADD_CHIPS*)handle;
    if (info->status)
    {
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:NSLocalizedString(@"提示\n很抱歉\n添加筹码失败\n", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
        return;
    }
    logMyLogInfo(@"-------------------receive ADD_CHIPS -------------------");
    logMyLogInfo(@"chips:%d playerID:%d seatID:%d status:%d",info->Chips,info->playerID,info->seatID,info->status);
    logMyLogInfo(@"-------------------end receive ADD_CHIPS-----------------");
    if (info->seatID > -1 && info->seatID < MAXPERSONNUMBER)
    {
        //[RJFaudioPlay PlayMyAudio:@"chip.mp3"];
        RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:info->seatID]];
        userView.Gameplayer.bringChip = info->Chips;
        if (info->seatID == m_iRealSeat)
        {
            [self SendUserGetdeatilInfo];
        }
        if (userView.Gameplayer.bringChip >= 0)
        {
            userView.labelWeath.text = [NSString stringWithNeedTranfanNumber:userView.Gameplayer.bringChip returnType:GAMESHOWTYPE];
        }else
        {
            userView.labelWeath.text = @"0";
            logMyLogInfo(@"..........get unnormal bring chips:%d",info->Chips);
        }
        
    }
    
    
}
-(void)dealNotiForproREQ_GAME_RECV_MSG:(int32_t)requestCode  handle:(void*)handle
{
    DZPK_SERVER_REQ_GAME_RECV_MSG  *msg = (DZPK_SERVER_REQ_GAME_RECV_MSG*)handle;
    
    logMyLogInfo(@"-------------------receive ADD_CHIPS -------------------");
    logMyLogInfo(@"seatID:%d nick:%@ playerID:%d msgType:%d content:%@",msg->seatID,msg->nick,msg->playerID,msg->msgType,msg->msgContent);
    logMyLogInfo(@"-------------------end receive ADD_CHIPS-----------------");
    if (msg->seatID < 0 || msg->seatID >= MAXPERSONNUMBER)
    {
        return;
    }
    
    logMyLogInfo(@"aaaaaa 1 words 2 face user:%@ recv msg:%@ type:%d",msg->nick,msg->msgContent,msg->msgType);
    int8_t  index = [self MakeSureNowindexFromNet:msg->seatID];
    if (msg->msgType == 1)
    {
        //word
        [self SpeakAndAnounceOther:msg->msgContent User:[m_arrayStoreUserView objectAtIndex:index]];
    }else if (msg->msgType == 2)
    {
        NSString *strImage = nil;
        NSString *strInfo = nil;
        
        //face    wait
        NSArray    *arrayFace = [[[NSBundle mainBundle] infoDictionary] valueForKey:DZPKFACE];
        for (NSDictionary *dicInfo in arrayFace)
        {
            strInfo = [[dicInfo allKeys] lastObject];
            if ([msg->msgContent rangeOfString:strInfo].location != NSNotFound)
            {
                logMyLogInfo(@"msg:%@ dicinfo:%@",msg->msgContent,dicInfo);
                strImage = [[dicInfo allValues] lastObject];
                
                break;
            }
        }
        
        //[self showMsgInSpeakField:strInfo UserNick:msg->nick];
        [self ShowFaceInUserView:[m_arrayStoreUserView objectAtIndex:index] Image:[UIImage imageNamed:strImage]];
    }
    
    //    free(msg->msgContent);
    //    msg->msgContent = nil;
    //    free(msg->nick);
    //    msg->nick = nil;
    
}
-(void)dealNotiForproREQ_GAME_CONNECT_AGAIN:(int32_t)requestCode handle:(void*)handle
{
    
}
-(void)dealNotiForproREQ_GAME_RECV_OUT:(int32_t)requestCode  handle:(void*)handle
{
    
    DZPK_SERVER_REQ_GAME_RECV_OUT   *info = (DZPK_SERVER_REQ_GAME_RECV_OUT*)handle;
    
    logMyLogInfo(@"-------------------receive RECV_OUT -------------------");
    logMyLogInfo(@"Type:%d",info->type);
    
    for (int i = 0; i < info->goldArrayNumber; i++)
    {
        logMyLogInfo(@"infoGoldArray[%i]:%d",i,info->goldArray[i]);
    }
    for (int i = 0; i < info->indexArrayNumber; i++)
    {
        logMyLogInfo(@"indexArray[%i]:%d",i,info->indexArray[i]);
    }
    for (int i = 0; i < info->rangArrayNumber; i++)
    {
        logMyLogInfo(@"rankingArray[%i]:%d",i,info->rankingArray[i]);
    }
    for (int i = 0; i < info->userIDArrayNumber; i++)
    {
        logMyLogInfo(@"userIDArray[%i]:%d",i,info->userIDArray[i]);
    }
    logMyLogInfo(@"-------------------end receive RECV_OUT-----------------");
    
    logMyLogInfo(@"info->userIDArrayNumber:%d",info->userIDArrayNumber);
    BOOL  bGameOver = NO;
    for (int i = 0; i < info->rangArrayNumber; i++)
    {
        logMyLogInfo(@",,,,,,rankingArrayNumber:%d number:%d comlete recv out:  ranking:%d, seat:%d  m_irealSeat:%d\n",info->rangArrayNumber,i,info->rankingArray[i],info->indexArray[i],m_iRealSeat);
        if (info->rankingArray[i] > -1)
        {
            bGameOver = YES;
            if (info->rankingArray[i] < 4 && info->indexArray[i] == m_iRealSeat)
            {
                NSString  *strWarning = [NSString stringWithFormat:NSLocalizedString(@"恭喜您获得本次比赛第%d名，奖励筹码%d", nil),info->rankingArray[i],info->goldArray[i]];
                [self SetWarningAlert:strWarning withTime:5 withFrame:CGRectMake(60, 230,370, 21)];
                /*  [RJFWarnView addinSelfview:self.view
                 delegate:nil
                 message:strWarning
                 buttontype:INSUREBUTTON
                 InsureButton:INSURE
                 CancelButton:nil];*/
                m_objShareUser.userChips += info->goldArray[i];
                
                //                if (m_objShareUser.userHasSitDown)
                //                {
                //                    [btnStand setHidden:NO];
                //                }
                // return;
            }
            
        }else if (info->rankingArray[i] == -1)
        {
            if (info->indexArray[i] > -1 && info->indexArray[i] < MAXPERSONNUMBER)
            {
                RJFUserImageView *userView = [m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:info->indexArray[i]]];
                [userView setUserState:9];
                //                if (info->indexArray[i] == m_iRealSeat)
                //                {
                //                    [btnStand setHidden:NO];
                //                }
                // [userView SetSeatState:YES MySelfOrOther:NO GAempLayer:nil];
                // [userView setHidden:YES];
            }
            
        }
    }
    
    if (bGameOver)
    {
        m_objShareUser.userHasSitDown = NO;
        m_iRealSeat = -1;
        [self CleanAfterEveryGame:nil];
        m_myRoomAllinfo.bankerIndex = -1;
        
        for (RJFUserImageView  *userView in m_arrayStoreUserView)
        {
            [userView SetSeatState:YES MySelfOrOther:NO GAempLayer:nil];
        }
        [self StandAndrestoreOrigailRoom:nil];
        [self setUnseatHide:NO];
    }else
    {
        [btnStand setHidden:YES];
    }
    
    free(info->indexArray);
    info->indexArray = NULL;
    free(info->goldArray);
    info->goldArray = NULL;
    free(info->rankingArray);
    info->rankingArray = NULL;
    free(info->userIDArray);
    info->userIDArray = NULL;
    
    
}


-(void)dealNotiForproREQ_PERSON_DATA:(int32_t)requestCode handle:(void*)handle
{
    
    
    
    DZPK_SERVER_REQ_PERSON_DATA  *info = (DZPK_SERVER_REQ_PERSON_DATA*)handle;
    if (info->status)
    {
        NSLog(@"getInfo fail");
    }else
    {
        logMyLogInfo(@"-------------------receive PERSON_DATA -------------------");
        logMyLogInfo(@"nick:%@,chips:%d,headPicName:%@,idou:%d,level:%d,loseNumber:%d match_score:%d max_own:%d,max_win_%d msg_count:%d",info->nick,info->chips,info->head_pic_name,info->idou,info->level,info->lose_number,info->match_score,info->max_own,info->max_win,info->msg_count);
        for (int i = 0; i < info->maxcardNumber; i++)
        {
            logMyLogInfo(@"infoMaxCards[%i]:%d",i,info->maxCards[i]);
        }
        
        logMyLogInfo(@"-------------------end receive PERSON_DATA-----------------");
        
        logMyLogInfo(@"userinfo score:%d userNick:%@",info->score,info->nick);
        if (info->sex == 0)
        {
            [m_objShareUser.Sex setString:NSLocalizedString(@"男", nil)];
        }else
        {
            [m_objShareUser.Sex setString:NSLocalizedString(@"女", nil)];
        }
        m_objShareUser.msgCount = info->msg_count;
        if (info->nick != nil)
        {
            [m_objShareUser.userName setString:info->nick];
        }
        if (info->head_pic_name != nil)
        {
            [m_objShareUser.userImagePath setString:info->head_pic_name];
            
        }
        if (info->maxCards != NULL && info->maxcardNumber > 0 && info->maxcardNumber < 6)
        {
            m_objShareUser.MaxCard1 = info->maxCards[0];
            m_objShareUser.MaxCard2 = info->maxCards[1];
            m_objShareUser.MaxCard3 = info->maxCards[2];
            m_objShareUser.MaxCard4 = info->maxCards[3];
            m_objShareUser.MaxCard5 = info->maxCards[4];
            
            m_objShareUser.onlineCount = info->online_count;
            m_objShareUser.winTimes = info->win_number;
            m_objShareUser.loseTime = info->lose_number;
            m_objShareUser.idou = info->idou*1.0f/100.0f;
            m_objShareUser.maxOwn = info->max_own;
            m_objShareUser.MaxWinchips = info->max_win;
            m_objShareUser.userChips = info->chips;
            m_objShareUser.score = info->score;
            m_objShareUser.matchscore = info->match_score;
            m_objShareUser.task = info->task;
            NSLog(@"userchip:%d",info->chips);
        }
        free(info->maxCards);
        info->maxCards = NULL;
        //        free(info->nick);
        //        info->nick = NULL;
        
        
        
    }
    
}


//dealNotiForproREQ_GET_COUNTDOWN_HONUS
-(void)dealNotiForproREQ_GET_BOUNDS:(int32_t)requestCode handle:(void*)handle
{
    DZPK_SERVER_REQ_GET_BONUDS   *boundsInfo = (DZPK_SERVER_REQ_GET_BONUDS*)handle;
    if (boundsInfo->status)
    {
        logMyLogInfo(@"get bouns fail idtype: -2   fresh teach");
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:NSLocalizedString(@"提示\n\n\n您已经领取过新手奖励！", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
        
        
    }else if(boundsInfo->idNumber == -2)
    {
        m_objShareUser.hasFreshBounds = NO;
        logMyLogInfo(@"-------------------receive REQ_GET_BOUNDS -------------------");
        
        logMyLogInfo(@"chips:%d idNumber:%d status:%d",boundsInfo->chips,boundsInfo->idNumber,boundsInfo->status);
        
        logMyLogInfo(@"-------------------end receive REQ_GET_BOUNDS-----------------");
        if (boundsInfo->chips < 1)
        {
            return;
        }
        [self ShowPrizeNumber:boundsInfo->chips];
        [PublicClass storeMessage:[NSString stringWithFormat:@"恭喜您，新手教学任务，奖励%d筹码",boundsInfo->chips] type:0];
    }
}

-(void)dealNotiForproREQ_GET_COUNTDOWN_HONUS:(int32_t)requestCode handle:(void*)handle
{
    DZPK_SERVER_REQ_GET_COUNTDOWN_HONUS   *info = (DZPK_SERVER_REQ_GET_COUNTDOWN_HONUS*)handle;
    if (info->status)
    {
        logMyLogInfo(@"get bouns fail idtype: -2   fresh teach");

        
        
    }else 
    {
     
        
        logMyLogInfo(@"-------------------receive REQ_GET_COUNTDOWN_HONUS -------------------");
        
        logMyLogInfo(@"status:%d bounts:%d boundNext:%d times:%d",info->status,info->bounds,info->bounds_next,info->times);
        
        logMyLogInfo(@"-------------------end receive REQ_GET_COUNTDOWN_HONUS-----------------");
        [self ShowPrizeNumber:info->bounds];
        NSString   *strMsg = [NSString stringWithFormat:NSLocalizedString(@"恭喜您，完成倒计时任务，奖励%d筹码", nil),info->bounds];
        [PublicClass storeMessage:strMsg type:0];
        
        [self setCountViewHide:NO countNumber:info->times];
        UIView  *bgView = [self.view viewWithTag:MAINCOUNTVIEWBGVIEWTAG];
       // UIImageView  *bgImageview = (UIImageView *)[bgView viewWithTag:COUNTDOWNVIEWTAG];
        UIImageView  *imageView = (UIImageView *)[bgView viewWithTag:233];
        imageView.image = [UIImage imageNamed:@"countdown_prizebox.png"];
        

    }
}

-(void)dealNotiForproREQ_GAME_USE_GIFT:(int32_t)requestCode  handle:(void*)handle
{
    DZPK_SERVER_REQ_GAME_USE_GIFT   *giftInfo = (DZPK_SERVER_REQ_GAME_USE_GIFT*)handle;
    if (giftInfo->status)
    {
        logMyLogInfo(@"giftfail");
        
    }
    logMyLogInfo(@"status:%d fromSeatID:%d toseatID:%d proptag:%d chips:%d",giftInfo->status,giftInfo->fromseat,giftInfo->toseat,giftInfo->giftID,giftInfo->userchips);
    
    if (giftInfo->giftID == 0)
    {
        [self GiftChipTofriendFrom:giftInfo->fromseat toSeatID:giftInfo->toseat chip:giftInfo->userchips];
    }else
    {
       [self AddpropAnimationWithFromSeat:giftInfo->fromseat toSeatID:giftInfo->toseat tag:giftInfo->giftID]; 
    }
    
}


-(void)receiveNotiFromServer:(NSNotification *)note
{
    
    
    @synchronized (self)
    {
        [m_lock lock];
        NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
        RJFTcpSocket  *m_socket = [note object];
        NSDictionary  *dicInfo = [note userInfo];
        if (dicInfo &&(m_socket.tag == GAMESOCKETTAG  || m_socket.tag == RESOURCESOCKEtTAG) )
        {
            
        }else
        {
            [pool drain];
            [m_lock unlock];
            return;
        }
        
        if (m_socket.tag == GAMESOCKETTAG)
        {
            [m_objShareUser setGamedate:[NSDate date]];
            //NSLog(@"NSDate:%@",[NSDate date]);
        }
        
        int  requestCode = -1;
        NSData  *data = [[note userInfo] valueForKey:TCPSOCKETMESSAGE];
        
        
        
        int8_t  *bytes =(int8_t*) [data bytes];
        int  pos = 4;
        if (bytes[0] != 'D')
        {
            pos = 5;
        }
        requestCode = [BasisZipAndUnzip unbyte_to_int16:bytes pos:pos];
        
        if(m_bmustWait  && requestCode != REQ_GAME_ENTER_ROOM)
        {
            [m_arrayUndealInfo addObject:data];
            logMyLogInfo(@"\n-------------------undealrequest:%d-----------------------\n",requestCode);
            [pool drain];
            [m_lock unlock];
            return;
        }
        logMyLogInfo(@"tag:%d game room requestCode:%d m_bmustWait:%d",m_socket.tag,requestCode,m_bmustWait);
        [self dealServerMessageWithData:data];
        [pool drain];
        [m_lock unlock];
    }
    
    
}

-(void)dealWithUndealrequest
{
    //NSMutableIndexSet  *indexSets = [[NSMutableIndexSet alloc] init];
    
    NSMutableArray  *array = [NSMutableArray arrayWithArray:m_arrayUndealInfo];
    for (NSData *data in array)
    {
        logMyLogInfo(@"[[[[[[[[[[[[[[[[[[[deal undeal info]]]]]]]]]]]]]]]]");
        [self dealServerMessageWithData:data];
        usleep(20000);
    }
    
    if ([array count] < [m_arrayUndealInfo count])
    {
        // int count = [m_arrayUndealInfo count]-[array count];
        for (int i = [array count];i < [m_arrayUndealInfo count];i++)
        {
            logMyLogInfo(@"[[[[[[[[[[[[[[[[[[[deal undeal info again]]]]]]]]]]]]]]]]");
            NSData  *data = [m_arrayUndealInfo objectAtIndex:i];
            [self dealServerMessageWithData:data];
            
        }
    }
    m_bmustWait = NO;
    [m_arrayUndealInfo removeAllObjects];
}
-(void)dealServerMessageWithData:(NSData *)data
{
    BasisZipAndUnzip   *objShare = [[BasisZipAndUnzip alloc] initWithSize:[data length]+5];
    
    int  requestCode = -1;
    
    
    void *handle = NULL;
    int8_t  *bytes =(int8_t*) [data bytes];
    int  pos = 4;
    if (bytes[0] != 'D')
    {
        pos = 5;
    }
    requestCode = [BasisZipAndUnzip unbyte_to_int16:bytes pos:pos];
    switch (requestCode)
    {
        case REQ_GAME_ENTER_ROOM:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GAME_ENTER_ROOM:REQ_GAME_ENTER_ROOM  handle:handle];
            break;
        case REQ_GAME_SEND_ACTION:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GAME_SEND_ACTION:requestCode  handle:handle];
            break;
        case REQ_GAME_SEND_SEAT_ACTION:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GAME_SEND_SEAT_ACTION:requestCode  handle:handle];
            break;
        case REQ_GAME_SEND_MSG:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GAME_SEND_MSG:requestCode  handle:handle];
            break;
        case REQ_GAME_RECV_ACTION:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GAME_RECV_ACTION:requestCode  handle:handle];
            break;
        case REQ_GAME_RECV_LEAVE://
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GAME_RECV_LEAVE:requestCode  handle:handle];
            break;
        case REQ_GAME_RECV_SEAT_DOWN:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GAME_RECV_SEAT_DOWN:requestCode  handle:handle];
            break;
        case REQ_GAME_RECV_CARDS:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForREQ_GAME_RECV_CARDS:requestCode  handle:handle];
            break;
        case REQ_GAME_RECV_WINNER:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GAME_RECV_WINNER:requestCode  handle:handle];
            break;
        case REQ_GAME_TIMEOUT_BACK:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GAME_TIMEOUT_BACK:requestCode  handle:handle];
            break;
        case REQ_GAME_RECV_READYTIME:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GAME_RECV_READYTIME:requestCode  handle:handle];
            break;
        case REQ_GAME_RECV_START_INFOR:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GAME_RECV_START_INFOR:requestCode  handle:handle];
            break;
        case REQ_GAME_ADD_CHIPS:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GAME_ADD_CHIPS:requestCode  handle:handle];
            break;
        case REQ_GAME_RECV_MSG:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GAME_RECV_MSG:requestCode  handle:handle];
            break;
        case REQ_GAME_CONNECT_AGAIN:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GAME_CONNECT_AGAIN:requestCode  handle:handle];
            break;
        case REQ_GAME_RECV_OUT:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GAME_RECV_OUT:requestCode  handle:handle];
            break;
        case REQ_PERSON_DATA:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_PERSON_DATA:requestCode  handle:handle];
            break;
        case REQ_GET_BONUDS:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GET_BOUNDS:requestCode handle:handle];
            break;
        case REQ_GET_COUNTDOWN_HONUS:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GET_COUNTDOWN_HONUS:requestCode handle:handle];
            break;
        case REQ_SYNC_SIGNAL_GAME:
            if (bytes[22] == 0)
            {
                [m_objShareUser setGamedate:[NSDate date]];
                logMyLogInfo(@"gameHeart beat");
                logMyLogInfo(@"game active");
            }else if(bytes[22] == 1)
            {
               
                logMyLogInfo(@"start  The status is unvalue disconnect self   \n\n");
                [self disConnectGameSocket:nil];
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:BNRDISCONNECTSERVER
                 object:self];
                
                
               // [self sendEnterRoomRequest:m_roomIDandPath type:0];
                 logMyLogInfo(@"end  The status is unvalue disconnect self   \n\n");
            }
            break;
        case REQ_GAME_PLAYER_DATA:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_REQ_GAME_PLAYER_DATA:requestCode  handle:handle];
            break;
        case REQ_GAME_USE_GIFT:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GAME_USE_GIFT:requestCode handle:handle];
            break;
       /* case REQ_GAME_TIMEOUT_BACK:
            handle = [objShare PhaseInfoFromData:bytes outRequestCode:&requestCode];
            [self dealNotiForproREQ_GAME_TIMEOUT_BACK:requestCode handle:handle];*/
            break;
            
        default:
            break;
    }
    if (objShare)
    {
        [objShare release];
        objShare = nil;
    }
    free(handle);
    handle = NULL;
    
    
}
#pragma mark  user seat info and game info

-(void)setUserLeaveAccordNetSeat:(int8_t)seatID
{
    
    if (seatID < -1 || seatID >= MAXPERSONNUMBER)
    {
        return;
    }
    int seat = [self MakeSureNowindexFromNet:seatID];
    
    
    UIView  *view = [self.view viewWithTag:SPEAKVIEWTAGBEGIN+seatID];
    if (view)
    {
        [view removeFromSuperview];
    }
    view = [self.view viewWithTag:FACEVIEWTAGBEGIN+seatID];
    if (view)
    {
        [view removeFromSuperview];
    }
    RJFUserImageView *userView = [m_arrayStoreUserView objectAtIndex:seat];
    if(m_myRoomAllinfo.bankerIndex == seatID
       || m_myRoomAllinfo.bankerIndex < 0 ||
       m_myRoomAllinfo.bankerIndex > MAXPERSONNUMBER
       )
    {
        [self setHostLogo:userView bhide:YES];
        logMyLogInfo(@"2.............set host hidden");
    }
    [userView SetSeatState:YES MySelfOrOther:NO GAempLayer:nil];
    //[m_arrayStoreUserView objectAtIndex:seat].Gameplayer = nil;
    if (m_objShareUser.userHasSitDown)
    {
        [[m_arrayStoreUserView objectAtIndex:seat] setHidden:YES];
    }
    if ([self GetCurrentPlayingCount:nil] <= 1)
    {
        [self CleanAfterEveryGame:nil];
        [self setHostLogo:[m_arrayStoreUserView objectAtIndex:0] bhide:YES];
        logMyLogInfo(@"3.............set host hidden");
    }
    
}



-(int8_t)MakeSureNowindexFromNet:(int8_t)seat
{
    int8_t index = 0;
    if (!m_objShareUser.userHasSitDown)
    {
        if (seat == 0)
        {
            index = 7;
        }
        else
        {
            index = seat-1;
        }
        
        logMyLogInfo(@"not sit seat:%d index:%d",seat,index);
        return index;
    }
    int8_t dis = seat-m_iRealSeat;
    if (dis >= 0)
    {
        index = m_iSelfIndex+dis;
        index = index%MAXPERSONNUMBER;
        
    }else
    {
        dis = m_iRealSeat-seat;
        index = m_iSelfIndex-dis;
        if (index < 0)
        {
            index = 7;
        }
    }
    
    logMyLogInfo(@"seat:%d\nindex:%d  m_irealSeat:%d",seat,index,m_iRealSeat);
    return index;
}


-(NSString *)AccordNumberGetCardimage:(int8_t)iNumber
{
    if (iNumber < 0)
    {
        return @"";
    }
    NSString  *strName = @"";
    switch (iNumber/13)
    {
        case 3:
            strName = @"black";
            break;
        case 2:
            strName = @"red";
            break;
        case 1:
            strName = @"mei";
            break;
        case 0:
            strName = @"square";
            break;
        default:
            break;
    }
    
    
    
    if (iNumber % 13 == 12)
    {
        strName = [strName stringByAppendingFormat:@"1.png"];
    }else
    {
        strName = [strName stringByAppendingFormat:@"%d.png",iNumber%13+2];
    }
    //NSLog(@"strName:%@ iNumber:%d",strName,iNumber);
    // logMyLogInfo(@"iNumber:%d imageCardName:%@",iNumber,strName);
    return strName;
}

-(BOOL)AccordUserDefault:(NSInteger)userAction
{
    
    //clear -> useraction = -1
    if (userAction <= 0)
    {
        return NO;
    }
    
    RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:m_iSelfIndex];
    if (userAction == 1)
    {
        if (m_inowMaxChip > userView.Gameplayer.giveChip)
        {
            [self sendUserAction:actiongiveupCard chips:0];
        }else if(m_inowMaxChip == userView.Gameplayer.giveChip)
        {
            [self sendUserAction:actionkeepchip chips:0];
        }else
        {
            return NO;
        }
        
    }else if (userAction == 2)
    {
        if (m_inowMaxChip == userView.Gameplayer.giveChip)
        {
            [self sendUserAction:actionkeepchip chips:0];
        }else
        {
            return NO;
        }
        
        
    }else if(userAction == 3)
    {
        if (m_inowMaxChip-userView.Gameplayer.giveChip > 0
            && userView.Gameplayer.bringChip > (m_inowMaxChip-userView.Gameplayer.giveChip))
        {
            [self sendUserAction:actionfollowchip chips:m_inowMaxChip-userView.Gameplayer.giveChip];
        }else if ((m_inowMaxChip-userView.Gameplayer.giveChip > 0)
                  && userView.Gameplayer.bringChip <= (m_inowMaxChip-userView.Gameplayer.giveChip))
        {
            [self sendUserAction:actionallPut chips:userView.Gameplayer.bringChip ];
        }else if(m_inowMaxChip == userView.Gameplayer.giveChip)
        {
            [self sendUserAction:actionkeepchip chips:0];
            
        }else
        {
            return NO;
        }
        
    }
    // [self setLMRButton:NO MiddleTitle:FollowAnyChip];
    
    return YES;
}


// seat  -- seatID    iNumber    1 FIRSTCARD   2 SECONDCARD
-(NSString *)accordSeatGetCard:(int8_t)seat FirstOrSecond:(NSInteger)iNumber
{
    NSArray *arrayUserCard = [NSArray arrayWithArray:m_arrStoreUsercard];
    for (NSDictionary  *dicInfo in arrayUserCard)
    {
        if ([[dicInfo valueForKey:SEATID] intValue] == seat)
        {
            if (iNumber == 1)
            {
                return [dicInfo valueForKey:FIRSTCARD];
            }else if (iNumber == 2)
            {
                return [dicInfo valueForKey:SECONDCARD];
            }
        }
    }
    return @"";
}


-(void)StandAndrestoreOrigailRoom:(id)Thread
{
    [UIView animateWithDuration:0.7f
                     animations:^
     {
     
     
     for (int i = 0; i < [m_arrayStoreUserView count]; i++)
     {
     RJFUserImageView  *UserView = [m_arrayStoreUserView objectAtIndex:i];
     
     
     [UserView setFrame:UserView.originalFrameRect];
     [UserView setHostLogoRect:UserView.originalHostLogoRect];
     [UserView setChipRect:UserView.originalchipRect];
     [UserView setSpeakRect:UserView.originalspeakRect];
     [UserView setFaceRect:UserView.originalfaceRect];
     if (UserView.hidden || UserView.userType == NOUSER)
     {
     UserView.imageViewCardOne.image = nil;
     UserView.imageViewCardTwo.image = nil;
     }else if(UserView.Gameplayer && m_bHasFapai)
     {
     UserView.imageViewCardOne.image = [UIImage imageNamed:@"card_back_left15.png"];
     UserView.imageViewCardTwo.image = [UIImage imageNamed:@"card_back_right15.png"];
     }
     [UserView setOtherViewframe:nil];
     
     }
     
     } completion:^(BOOL finish)
     {
     
     
     
     if (m_gameControltype == FRESHTEACHTYPE)
     {
     return;
     }
     if ([m_arrayStoreChipView count])
     {
     for (RJFUserImageView  *userView in m_arrayStoreUserView)
     {
     [userView setOtherViewframe:nil];
     int8_t  seat = userView.Gameplayer.seatID;
     if (seat < 0 || seat > MAXPERSONNUMBER)
     {
     continue;
     }
     if (seat == m_myRoomAllinfo.bankerIndex)
     {
     [self setHostLogo:[m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:seat]] bhide:NO];
     }
     
     }
     
     
     }
     //m_objShareUser
     // [self dealWithUndealrequest];
     
     }];
    
    
    //   sleep(1);
    
}

-(int)GetCurrentPlayingCount:(id)Thread
{
    int icount = 0;
    for (RJFUserImageView *userView in m_arrayStoreUserView)
    {
        if (!userView.hidden && userView.userType != NOUSER)
        {
            if (userView.Gameplayer.bringChip > 0)
            {
                icount++;
            }
            
        }
    }
    return icount;
}

-(void)ShowOperition:(BOOL)bSuc
{
    return;
    if (bSuc)
    {
        return;
    }
    RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:m_iSelfIndex];
    int tag =  3247326;
    UIImageView   *view = (UIImageView*)[userView viewWithTag:tag];
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, userView.frame.size.height/3*2, userView.frame.size.width, 40)];
        view.tag = tag;
        view.backgroundColor = [UIColor clearColor];
        // view.image = [UIImage imageNamed:@""];
        [userView addSubview:view];
        [view release];
    }
    view.hidden = NO;
    UILabel  *label = (UILabel *)[view viewWithTag:tag+1];
    if (label == nil)
    {
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(-15, 10, userView.frame.size.width+30, 20)];
        [label setTextColor:[UIColor blackColor]];
        [label setBackgroundColor:[UIColor darkGrayColor]];
        [label setTextAlignment:NSTextAlignmentRight];
        label.tag = tag+1;
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 5.0;
        label.alpha = 0.7;
        [view addSubview:label];
        [label release];
        
    }
    if (bSuc)
    {
        //  [label setText:NSLocalizedString(@"操作成功！", nil)];
    }else
    {
        [label setText:NSLocalizedString(@"操作失败！", nil)];
    }
    
    [view performSelector:@selector(removeFromSuperview
                                    ) withObject:nil
               afterDelay:1];
    
    
    
}


#pragma mark delegate  BNRAddchips
-(void)getAddChipInfo:(NSDictionary *)dicInfo
{
    if (dicInfo == nil)
    {
        
        [self sendUserleaveAndstand:2 seatId:m_iRealSeat];
        return;
    }
    
    int chips = [[dicInfo valueForKey:@"CHIP"] intValue];
    
    [self sendUserAddchips:chips seatID:m_iRealSeat];
}


#pragma mark  keyBord  method
- (void)keyboardWillShown:(NSNotification *)aNotification
{
    
    
    NSLog(@"[[UITextInputMode currentInputMode]primaryLanguage] is %@",[[UITextInputMode currentInputMode] primaryLanguage]);
    
    
    [UIView animateWithDuration:0.3f
                     animations:^
     {
     CGRect  rect = [[[aNotification userInfo] valueForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
     UIView  *view = [self.view viewWithTag:SPEAKVIEWTAG];
     UIButton  *button = (UIButton *)[view viewWithTag:2];
     if (view && !button.hidden)
     {
     
     CGFloat  fYpoint = view.frame.origin.y-rect.origin.x;
     if (fYpoint > 0)
     {
     [view setFrame:CGRectMake(0,fYpoint-30+70, view.frame.size.width, view.frame.size.height-65)];
     }
     
     for (UIButton  *btn in [view subviews])
     {
     if (btn.tag == 2)
     {
     [btn setHidden:YES];
     }else if ([btn isKindOfClass:[UITextField class]])
     {
     [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y-60, btn.frame.size.width, btn.frame.size.height)];
     }else if ([btn isKindOfClass:[UIButton class]] && [[btn titleForState:UIControlStateNormal] isEqualToString:NSLocalizedString(@"发送", nil)])
     {
     [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y-60, btn.frame.size.width, btn.frame.size.height)];
     }
     }
     }
     logMyLogInfo(@"11111show view:%@",view);
     } completion:^(BOOL finish)
     {
     // [textViewAdvice becomeFirstResponder];
     
     }];
    
}

- (void)keyboardWillHidden:(NSNotification *)aNotification
{
    
    //  logMyLogInfo(@"all views:%@",[self.view subviews]);
    if (m_clickInsureMode != DEFAULTNONEMODE)
    {
        [self SetSpeakViewHidden:YES];
    }
    //    [UIView animateWithDuration:0.3f
    //                     animations:^
    //     {
    //         CGRect  rect = [[[aNotification userInfo] valueForKey:@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    //         UIView  *view = [self.view viewWithTag:SPEAKVIEWTAG];
    //
    //         if (view && view.frame.size.height < 70)
    //         {
    //             CGFloat  fYpoint = view.frame.origin.y+rect.origin.x+65;
    //             if (fYpoint > 120)
    //             {
    //                 [view setFrame:CGRectMake(0,SCREENHEIGHT-127+65, view.frame.size.width, view.frame.size.height)];
    //             }
    //         }
    //
    //
    //
    //
    //        logMyLogInfo(@"11111hide view:%@",view);
    //     } completion:^(BOOL finish)
    //     {
    //
    //     }];
    
}


#pragma mark  getCard type
//getCard Type
-(NSString *)cardType:(int8_t *)Card Number:(int8_t)iNumber
{
    //const int  max = 51;
    if(iNumber < 5)
    {
        return @"";
    }
    NSString   *strType = @"";
    int8_t     *CardColor = malloc(sizeof(iNumber));
    
    int8_t     *CardNumber =malloc(sizeof(iNumber));
    NSMutableArray  *array = [[NSMutableArray alloc] init];
    for(int i = 0;i < iNumber;i++)
    {
        
        CardColor[i] = Card[i]/13+1;
        CardNumber[i] = Card[i]%13;
        if (CardNumber[i] == 0)
        {
            CardNumber[i] = 13;
        }
        
        logMyLogInfo(@">>>>>>>>>>number:%d card:%d cardNumber:%d cardColor:%d\n",i,Card[i],CardNumber[i],CardColor[i]);
        
    }
    
    BOOL  bsameColorOverFive = NO;
    
    for(int i = 0;i < iNumber;i++)
    {
        int jcount = 0;
        
        for(int j = 0;j < iNumber;j++)
        {
            
            if(CardColor[i] == CardColor[j])
            {
                jcount++;
                [array addObject:@(CardNumber[j])];
            }
        }
        
        if(jcount >= 5)
        {
            //tonghua
            bsameColorOverFive = YES;
            break;
        }else
        {
            [array removeAllObjects];
        }
    }
    
    
    
    if(bsameColorOverFive)
    {
        
        NSArray  *arraySorted = [array sortedArrayUsingSelector:@selector(compare:)];
        NSLog(@"arrsorted:%@",arraySorted);
        if ([self isShunzi:arraySorted arrStoreSHunzi:array])
        {
            NSLog(@"array:%@",array);
            if ([[arraySorted lastObject] integerValue] == 13)
            {
                strType = HUANGJIATONGHUASHUN;
            }else
            {
                strType = TONGHUASHUN;
            }
            
        }else
            
        {
            strType = TONGHUA;
        }
        
    }else
    {
        
        
        
        [array removeAllObjects];
        for (int i = 0; i < iNumber; i++)
        {
            [array addObject:@(CardNumber[i])];
            
        }
        
        NSMutableSet   *set = [NSMutableSet setWithArray:array];
        NSArray        *arrInput = [set allObjects];
        arrInput = [arrInput sortedArrayUsingSelector:@selector(compare:)];
        if ([self isShunzi:arrInput arrStoreSHunzi:nil])
        {
            strType = SHUNZI;
        }else
        {
            NSInteger   type = [self getCardType:array];
            if (type  != -1)
            {
                //0  hulu  1 duizi 2  santiao  3 liangdui  -1 gaopai  4 sitiao
                switch (type)
                {
                    case 0:
                        strType = HULU;
                        break;
                    case 1:
                        strType = NSLocalizedString(@"一对", nil);
                        break;
                    case 2:
                        strType = SANTIAO;
                        break;
                    case 3:
                        strType = LIANGDUI;
                        break;
                    case 4:
                        strType = SITIAO;
                        break;
                    default:
                        break;
                }
            }else
            {
                strType = GAOPAI;
                // strType = NSLocalizedString(@"错误牌型解析", nil);
            }
            
        }
    }
    
    free(CardNumber);
    free(CardColor);
    [array removeAllObjects];
    [array release];
    array = nil;
    logMyLogInfo(@">>>>>>>>>>>>>>>mycard Type:%@",strType);
    return strType;
}


-(BOOL)isShunzi:(NSArray*)array  arrStoreSHunzi:(NSMutableArray *)arrayStoreShunzi
{
    int   count = 0;
    [arrayStoreShunzi removeAllObjects];
    for (int i = [array count]-1; i > 0; i--)
    {
        if ([[array objectAtIndex:i] intValue] - 1 == [[array objectAtIndex:i-1] intValue])
        {
            count++;
            [arrayStoreShunzi addObject:[array objectAtIndex:i]];
        }else
        {
            count = 0;
        }
        if (count >= 4)
        {
            [arrayStoreShunzi addObject:[array objectAtIndex:i-1]];
            return YES;
        }
        
    }
    if(count == 3)
    {
        // BOOL hasA = NO;
        if([[arrayStoreShunzi lastObject] intValue] == 4)
        {
            for(NSNumber *number in array)
            {
                if([number intValue] == 13)
                {
                    return YES;
                }
            }
        }
        
    }
    return NO;
}



//0  hulu  1 duizi 2  santiao  3 liangdui  -1 gaopai  4 sitiao
-(NSInteger)getCardType:(NSArray*)array
{
    NSMutableArray  *arrInfo = [NSMutableArray arrayWithArray:array];
    int    countOfDuiZi = 0;
    int    countOfThree = 0;
    int    countOfFour = 0;
    for (int i = 0; i < [arrInfo count]; i++)
    {
        int count = 0;
        int value = [[arrInfo objectAtIndex:i] intValue];
        for (int j = 0; j < [arrInfo count]; j++)
        {
            if (i == j)
            {
                continue;
            }
            
            if (value == [[arrInfo objectAtIndex:j] intValue])
            {
                count++;
                [arrInfo removeObjectAtIndex:j];
                j--;
                if ([arrInfo count] <= 1)
                {
                    break;
                }
                
            }
        }
        [arrInfo removeObjectAtIndex:i];
        i--;
        if (count == 2)
        {
            countOfThree++;
        }
        if (count == 1)
        {
            countOfDuiZi++;
        }
        if (count == 3)
        {
            countOfFour++;
        }
        if ([arrInfo count] <= 1)
        {
            break;
        }
        
    }
    
    NSLog(@"*********duizi:%d santiao:%d sige:%d",countOfDuiZi,countOfThree,countOfFour);
    if (countOfFour >= 1)
    {
        return 4;
    }
    if(countOfDuiZi >= 1 && countOfThree >= 1)
    {
        return 0;
    }
    if(countOfThree >= 1)
    {
        return 2;
    }
    if(countOfDuiZi >= 2)
    {
        return 3;
    }
    if(countOfDuiZi == 1)
    {
        return 1;
    }
    
    
    return -1;
}

-(void)showTheCardType:(int8_t*)card number:(NSInteger)inumber
{
    if (!m_objShareUser.userHasSitDown || m_iStartCount < 1 || m_bHasGiveUpOrAllput)
    {
        return;
    }
    UILabel  *label = (UILabel *)[self.view viewWithTag:LABELSHOWCARDTYPETAG];
    if (label)
    {
        [label removeFromSuperview];
    }
    label = [[UILabel alloc] initWithFrame:CGRectMake(200, 165, 60, 25)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor purpleColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.tag = LABELSHOWCARDTYPETAG;
    [label setText:[self cardType:card Number:inumber]];
    
    [self insertViewToFit:label];
    [label performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:3.0f];
    [label release];
}
-(void)ShowPrizeNumber:(int)chipNumber
{
    
    UIImageView  *imageViewPrize = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH-429)/2, (SCREENHEIGHT-57)/2, 429, 57)];
    imageViewPrize.image = [UIImage imageNamed:@"prizes.png"];
    UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (57-30)/2, 429, 30)];
    [label setText:[NSString stringWithFormat:NSLocalizedString(@"恭喜您获得奖励%d", nil),chipNumber]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor blackColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:22]];
    [imageViewPrize addSubview:label];
    [label release];
    
    [self.view addSubview:imageViewPrize];
    [imageViewPrize performSelector:@selector(removeFromSuperview)
                         withObject:nil
                         afterDelay:3.0f];
    [imageViewPrize release];
}

-(void)setCountViewHide:(BOOL)bHide countNumber:(NSInteger)seconds
{
    [m_lockCountTimes lock];
    UIView   *MainbgView = (UIView *)[self.view viewWithTag:MAINCOUNTVIEWBGVIEWTAG];
    logMyLogInfo(@"seconds:%d",seconds);
    if (seconds <= 0 || !m_objShareUser.userHasSitDown)
    {
        if (m_countTimer)
        {
            [m_countTimer invalidate];
            [m_countTimer release];
            m_countTimer = nil;
        }
        
        if (MainbgView)
        {
            [MainbgView setHidden:YES];
            
        }
        
        [m_lockCountTimes unlock];
        logMyLogInfo(@"Time:%@\n .......................stop countdown number count...........",[NSDate date]);
        return;
    }
    
    
    
    
    UIImageView     *MainView = nil;
    if (MainbgView == nil)
    {
        
        MainbgView   = [[UIView alloc] initWithFrame:CGRectMake(380, 225, 90, 54)];
        MainbgView.backgroundColor = [UIColor clearColor];
        MainbgView.tag = MAINCOUNTVIEWBGVIEWTAG;
        UIImageView  *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((90-35)/2, 1, 35, 28)];
        imageview.image = [UIImage imageNamed:@"countdown_prizebox.png"];
        [MainbgView addSubview:imageview];
        imageview.tag = 3345;
        imageview.userInteractionEnabled = YES;
        [imageview release];
        
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(IsCanGainCountDownPrize:)];
        [imageview addGestureRecognizer:tap];
        [tap release];
        
        
        MainView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 90, 24)];
        MainView.image = [UIImage imageNamed:@"countdown_vector.png"];
        MainView.userInteractionEnabled = YES;
        MainView.tag = COUNTDOWNVIEWTAG;
        
        CGFloat  fsep = 0;
        CGFloat  fwidth = 9;
        for (int i = 0;i < 8;i++)
        {
            UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5+(fwidth+fsep)*i, 7, fwidth, 13)];
            imageView.tag = 800+i+1;
            if (i == 2 || i == 5)
            {
                imageView.image = [UIImage imageNamed:@"countdown_septor.png"];
            }
            [MainView addSubview:imageView];
            imageView.userInteractionEnabled = YES;
            [imageView release];
        }
        //[self.view addSubview:MainView];
        
        [MainbgView addSubview:MainView];
        [MainView release];
        for (UIView  *view in [self.view subviews])
        {
            if (view.tag == SLIDERBGVIEWTAG)
            {
                [self.view insertSubview:MainbgView belowSubview:view];
                [MainbgView release];
                break;
            }
        }
        // [self insertViewToFit:MainView];
        //  [MainView release];
    }
    if (bHide)
    {
        MainbgView.hidden = YES;
        [m_lockCountTimes unlock];
        return;
    }
    
    
    UIImageView   *prizebox = (UIImageView *)[MainbgView viewWithTag:3345];
    prizebox.image =[UIImage imageNamed:@"countdown_prizebox.png"];
    [MainbgView setHidden:bHide];
    int  showHours = seconds/3600;
    int  showseconds = seconds%60;
    int  showMin = (seconds-3600*showHours)/60;
    
    
    logMyLogInfo(@"//////////////coutdowntimes:%d%d:%d%d:%d%d",showHours/10,showHours%10,showMin/10,showMin%10,showseconds/10,showseconds%10);
    UIImageView  *imageView = (UIImageView *)[MainView viewWithTag:801];
    if (imageView)
    {
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"countdown_%d.png",showHours/10]];
    }
    imageView = (UIImageView *)[self.view viewWithTag:802];
    if (imageView)
    {
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"countdown_%d.png",showHours%10]];
    }
    imageView = (UIImageView *)[self.view viewWithTag:804];
    if (imageView)
    {
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"countdown_%d.png",showMin/10]];
    }
    
    imageView = (UIImageView *)[self.view viewWithTag:805];
    if (imageView)
    {
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"countdown_%d.png",showMin%10]];
    }
    
    imageView = (UIImageView *)[self.view viewWithTag:807];
    if (imageView)
    {
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"countdown_%d.png",showseconds/10]];
    }
    
    imageView = (UIImageView *)[self.view viewWithTag:808];
    if (imageView)
    {
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"countdown_%d.png",showseconds%10]];
    }
    
    
    if (m_iCountDownNumber < 1 || m_countTimer == nil)
    {
        
        m_iCountDownNumber = seconds;
        
        if (m_countTimer == nil)
        {
            logMyLogInfo(@"Time:%@\n .......................start countdown number count...........",[NSDate date]);
            m_countTimer = [[NSTimer alloc] initWithFireDate:[NSDate date]
                                                    interval:1.0f
                                                      target:self
                                                    selector:@selector(showCountDownNumber:)
                                                    userInfo:nil
                                                     repeats:YES];
            
            [[NSRunLoop currentRunLoop] addTimer:m_countTimer forMode:NSDefaultRunLoopMode];
            
            
        }
        
    }

    [m_lockCountTimes unlock];
}



-(void)IsCanGainCountDownPrize:(id)sender
{
    logMyLogInfo(@"sender:%@",sender);
    
    
  /*  BasisZipAndUnzip  *obj_basiz = [[BasisZipAndUnzip alloc] initWithSize:40];
    
    RJFTcpSocket  *socketGame = [RJFTcpSocket shareWithTag:GAMESOCKETTAG];
    [socketGame SendCharMessage: [obj_basiz syncWithRequest:REQ_GET_COUNTDOWN_HONUS
                                                     userID:m_objShareUser.userIDForDzpk
                                                structArray:NULL] size:[obj_basiz dataSize]];
    [obj_basiz release];
    obj_basiz = nil;*/
    
    
    
    
    NSLog(@"m_iCountDownNumber:%d",m_iCountDownNumber);
    if (m_iCountDownNumber >= 1)
    {
        int  showHours = m_iCountDownNumber/3600;
        int  showseconds = m_iCountDownNumber%60;
        int  showMin = (m_iCountDownNumber-3600*showHours)/60;
        NSString *strWarning = nil;
        if (showHours > 0)
        {
            strWarning = [NSString stringWithFormat:NSLocalizedString(@"再过%d小时%d分%d秒就能够领取奖励了，继续加油吧!", nil),showHours,showMin,showseconds];
        }else
        {
            strWarning = [NSString stringWithFormat:NSLocalizedString(@"再过%d分%d秒就能够领取奖励了，继续加油吧!", nil),showMin,showseconds];
        }
        ShowMsgInTopView(strWarning, 5, self);
    }else if (m_iCountDownNumber == 0 && m_objShareUser.userHasSitDown)
    {
       // DZPK_CLIENT_REQ_GAME
       BasisZipAndUnzip  *obj_basiz = [[BasisZipAndUnzip alloc] initWithSize:40];
       
        RJFTcpSocket  *socketGame = [RJFTcpSocket shareWithTag:GAMESOCKETTAG];
        [socketGame SendCharMessage: [obj_basiz syncWithRequest:REQ_GET_COUNTDOWN_HONUS
                                                         userID:m_objShareUser.userIDForDzpk
                                                    structArray:NULL] size:[obj_basiz dataSize]];
        [obj_basiz release];
        obj_basiz = nil;
    }
}

-(void)showCountDownNumber:(id)Timer
{
    
    
    [m_lockCountTimes lock];
    //logMyLogInfo(@"id Timer:%@",Timer);
    
    
    UIView  *mainBgView = [self.view viewWithTag:MAINCOUNTVIEWBGVIEWTAG];
    
    UIImageView   *MainView = (UIImageView *)[mainBgView viewWithTag:COUNTDOWNVIEWTAG];
    if (!MainView)
    {
        [m_lockCountTimes unlock];
        return;
    }
    if (m_iCountDownNumber < 1 || !m_objShareUser.userHasSitDown)
    {
        
        if (m_countTimer)
        {
            [m_countTimer invalidate];
            [m_countTimer release];
            m_countTimer = nil;
            logMyLogInfo(@"stop countdown number count  time:%@",[NSDate date]);
        }
        
        if (m_objShareUser.userHasSitDown)
        {
            UIImageView   *imageView = (UIImageView *)[mainBgView viewWithTag:3345];
            if (imageView)
            {
                imageView.image = [UIImage imageNamed:@"countdown_prizebox_open.png"];
            }
            
        }else
        {
            [mainBgView setHidden:YES];
        }
       
        
        [m_lockCountTimes unlock];
        return;
    }
    m_iCountDownNumber--;
    int  showHours = m_iCountDownNumber/3600;
    int  showseconds = m_iCountDownNumber%60;
    int  showMin = (m_iCountDownNumber-3600*showHours)/60;
    
    
    
    ///  logMyLogInfo(@"//////////////coutdowntimes:%d%d:%d%d:%d%d",showHours/10,showHours%10,showMin/10,showHours%10,showseconds/10,showseconds%10);
    UIImageView  *imageView = (UIImageView *)[MainView viewWithTag:801];
    if (imageView)
    {
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"countdown_%d.png",showHours/10]];
    }
    imageView = (UIImageView *)[self.view viewWithTag:802];
    if (imageView)
    {
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"countdown_%d.png",showHours%10]];
    }
    imageView = (UIImageView *)[self.view viewWithTag:804];
    if (imageView)
    {
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"countdown_%d.png",showMin/10]];
    }
    
    imageView = (UIImageView *)[self.view viewWithTag:805];
    if (imageView)
    {
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"countdown_%d.png",showMin%10]];
    }
    
    imageView = (UIImageView *)[self.view viewWithTag:807];
    if (imageView)
    {
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"countdown_%d.png",showseconds/10]];
    }
    
    imageView = (UIImageView *)[self.view viewWithTag:808];
    if (imageView)
    {
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"countdown_%d.png",showseconds%10]];
    }
    
    [m_lockCountTimes unlock];
    
}

#pragma mark check status



-(void)StartGameTimerNoti:(NSNotification *)note
{
    if (m_timerGame)
    {
        [m_timerGame invalidate];
        [m_timerGame release];
        m_timerGame = nil;
    }
    m_timerGame = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeInterval:10 sinceDate:[NSDate date]]
                                           interval:10
                                             target:self
                                           selector:@selector(StartGameHeart:)
                                           userInfo:nil
                                            repeats:YES];
    
    
    
    if (m_timeCheckGame)
    {
        [m_timeCheckGame invalidate];
        [m_timeCheckGame release];
        m_timeCheckGame = nil;
    }
    
    m_timeCheckGame = [[NSTimer alloc] initWithFireDate:[NSDate date]
                                               interval:TIMEDISCONNECT
                                                 target:self
                                               selector:@selector(CheckGameStatus:)
                                               userInfo:nil
                                                repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:m_timeCheckGame forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:m_timerGame forMode:NSDefaultRunLoopMode];
}

-(void)CheckGameStatus:(id)Timer
{
    if (m_objShareUser.gamedate == nil)
    {
        m_objShareUser.gamedate = [NSDate date];
    }
    logMyLogInfo(@"________________CheckGameStatus  time:%@____________________",[NSDate date]);
    NSDate  *date = [NSDate date];
    NSTimeInterval   fTimer = [date timeIntervalSinceDate:m_objShareUser.gamedate];
    
    if (fTimer > TIMEDISCONNECT)
    {
        
        logMyLogInfo(@"------------------disConnect because time over TIMEDISCONNECT-----------------");
        [self disConnectGameSocket:nil];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:BNRDISCONNECTSERVER
         object:self];
        
    }
    
    
}
-(void)StartGameHeart:(id)Timer
{
    if (!m_objShareUser.IsOnGameInterface)
    {
        if (m_timerGame)
        {
            [m_timerGame invalidate];
            [m_timerGame release];
            m_timerGame = nil;
            logMyLogInfo(@"stop game time:%@",[NSDate date]);
        }
        if (m_timeCheckGame)
        {
            [m_timeCheckGame invalidate];
            [m_timeCheckGame release];
            m_timeCheckGame = nil;
            logMyLogInfo(@"stop check game time:%@",[NSDate date]);
        }
        m_objShareUser.gamedate = nil;
        return;
        
    }
    BasisZipAndUnzip  *objBasic = [[BasisZipAndUnzip alloc] initWithSize:40];
    
    RJFTcpSocket  *sockGame = [RJFTcpSocket shareWithTag:GAMESOCKETTAG];
    [sockGame SendCharMessage:[objBasic syncWithRequest:REQ_SYNC_SIGNAL_GAME
                                                 userID:m_objShareUser.userIDForDzpk
                                            structArray:NULL]
                         size:[objBasic dataSize]];
    [objBasic release];
    logMyLogInfo(@"________________send game heart  time:%@____________________",[NSDate date]);
    //NSLog(@"gameHeart beat time: %@",[NSDate date]);
}
-(void)disConnectGameSocket:(id)Timer
{
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:GAMESOCKETTAG];
    [socket disConnect];
    // socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    // [socket disConnect];
    if (m_timerGame)
    {
        [m_timerGame invalidate];
        [m_timerGame release];
        m_timerGame = nil;
        logMyLogInfo(@"stop game time:%@",[NSDate date]);
    }
    if (m_timeCheckGame)
    {
        [m_timeCheckGame invalidate];
        [m_timeCheckGame release];
        m_timeCheckGame = nil;
        logMyLogInfo(@"stop check game time:%@",[NSDate date]);
    }
    if (m_countTimer)
    {
        [m_countTimer invalidate];
        [m_countTimer release];
        m_countTimer = nil;
    }
    m_objShareUser.gamedate = nil;
    
}

-(BOOL)respondsToSelector:(SEL)aSelector
{
    logMyLogInfo(@"gameinterface.........SELECTOR: %@...........\n", NSStringFromSelector(aSelector));
    return [super respondsToSelector:aSelector];
}

-(void)setCardTipImageView:(BOOL)bHide
{
    UIImageView  *imageView = (UIImageView *)[self.view viewWithTag:CARDTIPIMAGEVIEWTAG];
    
    if (imageView == nil)
    {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, SCREENHEIGHT-70, 25, 27)];
        imageView.image = [UIImage imageNamed:@"card_type_tip.png"];
        imageView.userInteractionEnabled = YES;
        imageView.tag = CARDTIPIMAGEVIEWTAG;
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(ShowCardArrayViewInselfview)];
        [imageView addGestureRecognizer:tap];
        [tap release];
        [self.view addSubview:imageView];
        [imageView release];
    }
    [imageView setHidden:bHide];
}

/*
 iLocation  0  left  1 right
 */
-(void)ShowCardArrayViewInselfview
{
    UIImageView   *imageView    = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 155, 265)];
    imageView.tag = CARDARRAYVIEWTAG;
    imageView.image = [UIImage imageNamed:@"cardArray.png"];
    
    
    
    [UIView animateWithDuration:0.7f
                     animations:^
     {
     // imageView.layer.transform = CATransform3DMakeScale(1, 1, 1);
     imageView.transform = CGAffineTransformMakeScale(1, 1);
     
     }];
    [self.view addSubview:imageView];
    [imageView release];
    
    
}

-(void)SetUserStartTimer:(int8_t)seat timer:(int8_t)time
{
    if (seat < 0 || seat > MAXPERSONNUMBER-1)
    {
        return;
    }
    
   
    [self stopTimeSlide:nil];
    
    usleep(10000);
    NSDate    *date = [NSDate date];
    self.currentOp = seat;
    RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:seat]];
    [userView StartTimer:@(time)];
    
    logMyLogInfo(@"\n_______________Userseat:%d timer:%d_______________\n",seat,time);
    
    logMyLogInfo(@"sepTime:%f[[[[[[[[[[[[[[",[[NSDate date] timeIntervalSinceDate:date]);
    
}

-(void)shareMsg:(NSString*)strMsg   iSScreen:(BOOL)bScreen
{
    int   type = m_objShareUser.userType;
    
    UIImage *image = nil;
    if (bScreen)
    {
        image = [UIImage ScreenShotImageFromIphone:self.view];
    }
    
    if (type == 1 || type == 2)
    {
        JFSharePanel   *sharePanel = [[JFSharePanel alloc] initWithShareType:type
                                                                     content:@"我在干坏事，你来吗！"
                                                                       image:image shareContentType:0];
        [self.view addSubview:sharePanel];
        [sharePanel release];
    }else
    {
        RJFShareViewController   *shareViewcontrol = [[RJFShareViewController alloc] initWithContent:@"我在哈哈" WithImage:image  shareContentType:0];
        [self.navigationController pushViewController:shareViewcontrol animated:YES];
        [shareViewcontrol release];
    }
}


/*
 CGRect frame = CGRectMake(50,50,0,0);
 frame.size = [UIImage imageNamed:@"guzhang.gif"].size;
 // 读取gif图片数据
 NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"guzhang" ofType:@"gif"]];
 // view生成
 UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
 webView.userInteractionEnabled = NO;//用户不可交互
 [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
 [self.view addSubview:webView];
 [webView release];*/
//

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    
    
    
    if (anim.name != nil)
    {
        UIImageView  *imageview = (UIImageView *)[self.view viewWithTag:ANIMATIONWEBVIEWTAG];
        imageview.image = nil;
        
        NSString *filePath = nil;
       // CGFloat   fremoveTime = 1.5f;
        if ([anim.name isEqualToString:@"boom"])
        {
            filePath = [[NSBundle mainBundle] pathForResource:@"dzpk_profile_boom.gif" ofType:nil];
          //  fremoveTime = 1.5f;
        }else if ([anim.name isEqualToString: @"pan"])
        {
            filePath = [[NSBundle mainBundle] pathForResource:@"dzpk_prop_pan.gif" ofType:nil];
          //  fremoveTime = 0.4f;
            
        }else if ([anim.name isEqualToString:@"kiss"])
        {
            filePath = [[NSBundle mainBundle] pathForResource:@"dzpk_profile_kiss.gif" ofType:nil];
         //   fremoveTime = 0.9f;
            
        }else if ([anim.name isEqualToString:@"egg"])
        {
            filePath = [[NSBundle mainBundle] pathForResource:@"dzpk_profile_eggs.gif" ofType:nil];
          //  fremoveTime = 0.9f;
           //
        }else if ([anim.name isEqualToString: @"love"])
        {
            filePath = [[NSBundle mainBundle] pathForResource:@"dzpk_profile_love.gif" ofType:nil];
          //  fremoveTime = 1.2f;
            //dzpk_profile_love
        }else if ([anim.name isEqualToString:@"giftchip"])
        {
            [anim.aniView.layer addAnimation:[CABasicAnimation aninopacity:2 name:nil] forKey:@"[["];
            [anim.aniView.layer addAnimation:[CABasicAnimation aniWithTransition:2 tovalue:0-anim.aniView.frame.size.height fromValue:anim.aniView.frame.size.height] forKey:nil];
        }else if ([anim.name isEqualToString:@"boomerang"])
        {
            filePath = [[NSBundle mainBundle] pathForResource:@"dzpk_profile_boomerang.gif" ofType:nil];
           // fremoveTime = 0.5;
        }else if ([anim.name isEqualToString:@"wine"])
        {
            filePath = [[NSBundle mainBundle] pathForResource:@"dzpk_proile_wine.gif" ofType:nil];
          // fremoveTime = 0.9;
        }else if ([anim.name isEqualToString:@"lighting"])
        {
            filePath = [[NSBundle mainBundle] pathForResource:@"dzpk_profile_lighting.gif" ofType:nil];
           // fremoveTime = 0.9;
        }
        
        
        [imageview removeFromSuperview];
        if (filePath  != nil)
        {
            SCGIFImageView* gifImageView = [[SCGIFImageView alloc] initWithGIFFile:filePath];
            gifImageView.frame = CGRectMake(0, 0, gifImageView.image.size.width/2, gifImageView.image.size.height/2);
            gifImageView.center = self.gifImaageCenter;
            [self.view addSubview:gifImageView];
          //  [gifImageView release];
            [gifImageView startAnimating];
           /* [gifImageView performSelector:@selector(removeFromSuperview)
                               withObject:nil
                               afterDelay:fremoveTime];*/
        }
   
        
    }
    
    
    logMyLogInfo(@"didStop:%@ finish:%d",anim,flag);
}





-(void)AddpropAnimationWithFromSeat:(int8_t)fromseatID toSeatID:(int8_t)toseatID tag:(NSInteger)tag
{
    
    [self RemoveSubViewOrHideSubView:CGPointZero];
    if (fromseatID  == toseatID)
    {
        return;
    }
    RJFUserImageView  *touserView = [m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:toseatID]];
    RJFUserImageView  *fromUserView = [m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:fromseatID]];
    NSString *strImageName = @"dzpk_prop_boom_first.png";
    CABasicAnimation  *ani = [CABasicAnimation aniWithPosition:1 fromValue:fromUserView.center tovalue:touserView.center];
    self.gifImaageCenter = touserView.center;
    
    switch (tag)
    {
        case 4:
            ani.name = @"boom";
            strImageName = @"dzpk_profile_boom.png";
            break;
        case 3:
            ani.name = @"wine";
            strImageName = @"dzpk_profile_wine.png";
            break;
        case 6:
            ani.name = @"lighting";
            strImageName = @"dzpk_profile_lighting.png";
            break;
        case 5:
            ani.name = @"egg";
            strImageName =  @"dzpk_profile_eggs.png";
            break;
        case 1:
            ani.name = @"love";
            strImageName =  @"dzpk_profile_love.png";
            break;
        case 2:
            ani.name = @"kiss";
            strImageName =  @"dzpk_profile_kiss.png";
            break;
            //  break;
            
        default:
            return;
            break;
    }
    
    
    UIImage  *image = [UIImage imageNamed:strImageName];
    UIImageView       *imageview = [[UIImageView alloc] initWithImage:image];
    imageview.center = fromUserView.center;
    imageview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:imageview];
    imageview.bounds = CGRectMake(0, 0, image.size.width/2, image.size.height/2);
    imageview.tag = ANIMATIONWEBVIEWTAG;
    
    
    ani.delegate = self;
    [imageview.layer addAnimation:ani forKey:@"nil"];
   /* if (tag == 2)
    {
        [imageview.layer addAnimation:[CABasicAnimation aniRotate:1 tovalue:M_PI_2 fromValue:0] forKey:nil];
    }*/
    [imageview release];
    
    
}

-(void)GiftChipTofriendFrom:(int8_t)fromseatID  toSeatID:(int8_t)toseatID chip:(int32_t)chip
{
    //  logMyLogInfo(@"seatID:%d  chip:%d",seatID,chip);
    
    if (fromseatID > -1 && toseatID > -1  && fromseatID != toseatID)
    {
        
        
        RJFUserImageView   *fromUserView = [m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:fromseatID]];
        RJFUserImageView   *toseatUserView = [m_arrayStoreUserView objectAtIndex:[self MakeSureNowindexFromNet:toseatID]];
        
        
        UIView            *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 90)];
        
        NSString *strNumber = [NSString stringWithFormat:@"%d",chip];
        int    count = [strNumber length]+1;
        CGFloat   fwidth = 10;
        CGFloat   fXpoint = (100-fwidth*count)/2;
        CGFloat   fYpoint = 20;
        UIView      *numberView = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, fwidth*count, 14)];
        numberView.alpha = 0;
        for(int i = 0;i < count;i++)
        {
            UIImageView  *imageViewTemp = [[UIImageView alloc] initWithFrame:CGRectMake(fwidth*i, 0, fwidth, 14)];
            if (i == 0)
            {
                imageViewTemp.image = [UIImage imageNamed:@"dzpk_gift_chip_add.png"];
            }else
            {
                NSString *strSingNumber  = [strNumber substringWithRange:NSMakeRange(i-1, 1)];
                imageViewTemp.image = [UIImage imageNamed:[NSString stringWithFormat:@"dzpk_gift_chip_%@.png",strSingNumber]];
            }
            
            
            [numberView addSubview:imageViewTemp];
            [imageViewTemp release];
        }
        [bgView addSubview:numberView];
        [numberView release];
        
        fYpoint += 0;
        
        UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((100-60)/2, fYpoint, 60, 68)];//60 68   10   14
        imageView.image = [UIImage imageNamed:@"dzpk_gift_chip_gold.png"];
        [bgView addSubview:imageView];
        [imageView release];
        
        bgView.center = fromUserView.center;
        [self insertViewToFit:bgView];
        
        CABasicAnimation  *ani = [CABasicAnimation aniWithPosition:2 fromValue:fromUserView.center tovalue:toseatUserView.center];
        
      
        ani.delegate = self;
        ani.name = @"giftchip";
        ani.aniView = numberView;
        [bgView.layer addAnimation:ani forKey:@"as"];
        [bgView performSelector:@selector(removeFromSuperview)
                     withObject:nil
                     afterDelay:4];
        
    
      //  [numberView add];
        
        
        [bgView release];
        
        
      /*  if (fromseatID == m_iRealSeat || toseatID == m_iRealSeat)
        {
            
            NSString        *strMsg = nil;
            if (fromseatID == m_iRealSeat)
            {
                strMsg = [NSString stringWithFormat:NSLocalizedString(@"您赠送了%d筹码给玩家%@", nil),chip,toseatUserView.Gameplayer.UserName];
                
            }else
            {
                 strMsg = [NSString stringWithFormat:NSLocalizedString(@"玩家%@赠送了%d筹码给您", nil),fromUserView.Gameplayer.UserName,chip];
                 
            }
          //  ShowMsgInTopView(strMsg, 3, self);
            
        }*/
        
    }
    
   
 
    
}

-(void)PresentLocalication:(NSString *)strMsg SoundName:(NSString *)soundName  fireDate:(NSDate *)date
{
    UIApplication  *app = [UIApplication sharedApplication];
    [app cancelAllLocalNotifications];
    UILocalNotification  *alarm = [[UILocalNotification alloc] init];
    if (alarm)
    {
        if (strMsg)
        {
            alarm.alertBody = strMsg;
        }
        if (soundName)
        {
            alarm.soundName = soundName;
        }
        alarm.timeZone = [NSTimeZone defaultTimeZone];
        if (date)
        {
            alarm.fireDate = date;
        }else
        {
            alarm.fireDate = [NSDate date];
        }
        
        alarm.repeatInterval = 0;
        
        [app scheduleLocalNotification:alarm];
        //[app presentLocalNotificationNow:alarm];
        [alarm release];
    }
    
}


#pragma mark   BNRUSERITEMSOLD   delegate  method
-(void)AddAnimationWithSeatID:(int8_t)seatID tag:(NSInteger)tag withChip:(int32_t)chips
{
    if (!m_objShareUser.userHasSitDown)
    {
        return;
    }
    
    
    DZPK_CLIENT_REQ_GAME_USE_GIFT   userInfo = {m_iRealSeat,seatID,tag,chips};
    BasisZipAndUnzip  *obj_basic = [[BasisZipAndUnzip alloc] initWithSize:100];
    RJFTcpSocket   *gamesocket = [RJFTcpSocket shareWithTag:GAMESOCKETTAG];
    [gamesocket SendCharMessage:[obj_basic syncWithRequest:REQ_GAME_USE_GIFT
                                                    userID:m_objShareUser.userIDForDzpk
                                               structArray:&userInfo]
                           size:[obj_basic dataSize]];
    [obj_basic release];
    obj_basic = nil;
    
  //  [self AddpropAnimationWithFromSeat:m_iRealSeat toSeatID:seatID tag:tag];
    
}


-(void)GiftChipTofriend:(int8_t)seatID chip:(int32_t)chip
{
    logMyLogInfo(@"seatID:%d  chip:%d",seatID,chip);
    [self RemoveSubViewOrHideSubView:CGPointZero];
    if (!m_objShareUser.userHasSitDown)
    {
        return;
    }
    
    
    DZPK_CLIENT_REQ_GAME_USE_GIFT   userInfo = {m_iRealSeat,seatID,0,chip};
    BasisZipAndUnzip  *obj_basic = [[BasisZipAndUnzip alloc] initWithSize:100];
    RJFTcpSocket   *gamesocket = [RJFTcpSocket shareWithTag:GAMESOCKETTAG];
    [gamesocket SendCharMessage:[obj_basic syncWithRequest:REQ_GAME_USE_GIFT
                                                    userID:m_objShareUser.userIDForDzpk
                                               structArray:&userInfo]
                           size:[obj_basic dataSize]];
    [obj_basic release];
    obj_basic = nil;
 //   [self GiftChipTofriendFrom:m_iRealSeat toSeatID:seatID chip:chip];
    
}



@end

