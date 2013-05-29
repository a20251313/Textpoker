//
//  RJFUserImageView.m
//  UserTest
//
//  Created by popo on 12-6-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFUserImageView.h"
#import "RJFUserdetail.h"


#ifndef GAMEOVERTIME
#define GAMEOVERTIME            6
#endif

#define AUTOIMAGETAG 111
#define RECVIMAGETAG 112
#define IMAGEVIEWCARDONE 113
#define IMAGEVIEWCARDTWO 114
#define DOWNLOADREQUESDID   43
@implementation RJFUserImageView

NSString  *BNRSITDOWN = @"BNRSITDOWN";
NSString  *BNRSERVERALLOWSITDOWN = @"BNRSERVERALLOWSITDOWN";
NSString  *BNRUSERINFOVIEW = @"BNRUSERINFOVIEW";
@synthesize imageViewBackGround = imageViewBackGround;
@synthesize imageViewCardOne = imageCardOne;
@synthesize imageViewCardTwo = imageCardTwo;
@synthesize imageViewPhotoView = imageUserphotoView;
@synthesize labelWeath = labelUserWeath;
@synthesize labelNameAndAction = labelUserNameAndAction;
@synthesize labelDialog = labelUserDialog;
@synthesize imageViewWholebg = imageViewWholeBg;
@synthesize userType = m_userType;
@synthesize Gameplayer = m_objPlayer;
@synthesize giveChip = m_iHasGiveChip;
@synthesize chipRect = m_userChiprect;
@synthesize hostLogoRect = m_userHostlogoRect;
@synthesize m_arrayPoint;
@synthesize speakRect = m_userSpeakRect;
@synthesize faceRect = m_userFaceRect;
@synthesize superViewControl = m_superViewControll;
@synthesize objDown = m_objDown;
@synthesize labelRecordGiveChip;
@synthesize arrayStoreChipView = m_arrayStoreChipView;
@synthesize UserNowState = m_iUserState;
@synthesize originalchipRect;
@synthesize originalFrameRect;
@synthesize originalHostLogoRect;
@synthesize originalfaceRect;
@synthesize originalspeakRect;


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *          set subView alpha
 *  @param
 *          alpha
 *              alpha you wanna set
 *	@return
 *          NONE
 *
 */
-(void)setAllViewApha:(CGFloat)alpha
{
    for (UIView *View in [self subviews])
    {
        if (!View.hidden)
        {
            [View setAlpha:alpha];
        }
    }
}



/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *         show the card after game over,and if user win,set win image.
 *  @param
 *          strFirsCard
 *              first card image path
 *  @param
 *          strSecond
 *              second card image path
 *  @param
 *          strWinString
 *              if win, set the card type win, Otherwise set nil
 *	@return
@property (nonatomic,   NONE
 */

-(void)setCardShow:(NSString *)strFirsCard
        SecondCard:(NSString *)strSecond
       winerString:(NSString *)strWinString
{
    
    if (self.hidden || self.userType == NOUSER)
    {
        return;
    }
    CGRect frame = [imageUserphotoView bounds];
    UIImageView  *imageViewCardOne = (UIImageView *)[imageUserphotoView viewWithTag:IMAGEVIEWCARDONE];
    if (imageViewCardOne == nil)
    {
       imageViewCardOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/3*2, frame.size.height)];
        imageViewCardOne.image = [UIImage imageNamed:strFirsCard];
        imageViewCardOne.userInteractionEnabled = YES;
        imageViewCardOne.tag = IMAGEVIEWCARDONE;
        [imageUserphotoView addSubview:imageViewCardOne];
        [imageViewCardOne performSelector:@selector(removeFromSuperview)
                               withObject:nil
                               afterDelay:GAMEOVERTIME];
        [imageViewCardOne release];
    }
    UIImageView  *imageViewCardTwo = (UIImageView *)[imageUserphotoView viewWithTag:IMAGEVIEWCARDTWO];
    if (imageViewCardTwo == nil)
    {
        imageViewCardTwo = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.height/3, 0, frame.size.height/3*2, frame.size.height)];
        imageViewCardTwo.image = [UIImage imageNamed:strSecond];
        imageViewCardTwo.tag = IMAGEVIEWCARDTWO;
        imageViewCardTwo.userInteractionEnabled = YES;
        [imageUserphotoView addSubview:imageViewCardTwo];
        [imageViewCardTwo performSelector:@selector(removeFromSuperview)
                               withObject:nil
                               afterDelay:GAMEOVERTIME];
        [imageViewCardTwo release];
    }
    imageCardOne.image = nil;
    imageCardTwo.image = nil;
    if (strWinString)
    {
        [self performSelector:@selector(AddWinstring:) onThread:[NSThread mainThread] withObject:strWinString waitUntilDone:YES]; 
    }
   

    [self performSelector:@selector(RemoveShowCardAndBackToOringal)
               withObject:nil
               afterDelay:GAMEOVERTIME];
   
    
}

-(void)AddWinstring:(NSString *)strWinString
{
    labelUserNameAndAction.text = strWinString;
    CGRect   rect = [self bounds];
    UIImageView  *ImageViewWin = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    ImageViewWin.image = [UIImage imageNamed:@"OtherUser_win.png"];
    [self addSubview:ImageViewWin];
    ImageViewWin.tag = 10;
    [ImageViewWin performSelector:@selector(removeFromSuperview)
                       withObject:nil
                       afterDelay:GAMEOVERTIME];
    
    [ImageViewWin release];
    logMyLogInfo(@"show winer info: winstring:%@  winName:%@",strWinString,self.Gameplayer.UserName);
    
}


//cardnumber is 5, mean first card,cardnumber is 6 means second card
-(void)setCardAlpha:(int8_t)cardnumber
{
    if (cardnumber == 5)
    {
        UIImageView * viewTemp = (UIImageView *)[imageUserphotoView viewWithTag:IMAGEVIEWCARDONE];
        [viewTemp setAlpha:0.5];
    }else if (cardnumber == 6)
    {
        UIImageView * viewTemp = (UIImageView *)[imageUserphotoView viewWithTag:IMAGEVIEWCARDTWO];
        [viewTemp setAlpha:0.5];
    }
        
}


-(void)WinerLightlalo:(NSTimeInterval)timer
{
    if (self.hidden || self.userType == NOUSER)
    {
        return;
    }
    UIImageView  *lightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ligh_lalo.png"]];
    lightView.frame = CGRectMake((self.bounds.size.width-lightView.frame.size.width/2)/2,(self.bounds.size.height-lightView.frame.size.width/2)/2 , lightView.frame.size.width/2, lightView.frame.size.height/2);
    lightView.backgroundColor = [UIColor clearColor];
    [self insertSubview:lightView atIndex:0];
    [lightView.layer addAnimation:[self animationRotate:0.5 Count:FLT_MAX] forKey:@"rotate"];
    [lightView performSelector:@selector(removeFromSuperview)
                    withObject:nil
                    afterDelay:timer];
    [lightView release];
    
    
}

- (CAAnimation *)animationRotate:(NSTimeInterval)duration Count:(NSInteger)iCount
{
    // rotate animation
    CATransform3D rotationTransform  = CATransform3DMakeRotation(M_PI, 0.0,0.0, 1.0f);
    
    CABasicAnimation* animation = nil;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue        = [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration        = duration;
    animation.autoreverses    = NO;
    animation.cumulative    = YES;
    animation.repeatCount    = iCount;  //"forever"
    //设置开始时间，能够连续播放多组动画
    animation.beginTime        = 0.0;
    //设置动画代理
    //animation.delegate        = self;
    return animation;
}
/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *          make userView back to orignal
 *	@return
 *          NONE
 */
-(void)RemoveShowCardAndBackToOringal
{
    labelUserNameAndAction.text = m_objPlayer.UserName;
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 06 06
 *  @brief
 *          init method
 *  @param
 *          frame
 *              CGRect
 *	@return
 *          id(self)
 *
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        userDrawView = [[RJFUserDrawView alloc] initWithFrame:[self bounds]];
        imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(LINEWIDTH, LINEWIDTH, frame.size.width-LINEWIDTH*2, frame.size.height-LINEWIDTH*2)];
        self.layer.cornerRadius = 10;
        imageViewBackGround.layer.cornerRadius = 10;
        CGFloat  fHeight = frame.size.height;
        CGFloat  fwidth = frame.size.width;
        CGFloat  fImageheight = 48;
        CGFloat  fNowHeight = 14;
        labelUserNameAndAction  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imageViewBackGround.frame.size.width,fNowHeight)];
        [imageViewBackGround addSubview:labelUserNameAndAction];
        imageUserphotoView = [[UIImageView alloc] initWithFrame:CGRectMake(1,fNowHeight, imageViewBackGround.frame.size.width-2, fImageheight)];
        imageUserphotoView.userInteractionEnabled = YES;
        fNowHeight += fImageheight+2;
        imageUserphotoView.image = [UIImage imageNamed:@"user.png"];
        labelUserWeath = [[UILabel alloc] initWithFrame:CGRectMake(0, fNowHeight-4-LINEWIDTH/2, fwidth, fHeight-fNowHeight)];
        [imageViewBackGround addSubview:imageUserphotoView];
        [imageViewBackGround addSubview:labelUserWeath];
        [imageUserphotoView release];
        [labelUserWeath release];
        
        [labelUserNameAndAction setTextAlignment:NSTextAlignmentCenter];
        [labelUserWeath setTextAlignment:NSTextAlignmentCenter];
        UIFont  *font = [UIFont fontWithName:[[UIFont familyNames] objectAtIndex:0] size:10];
        [labelUserWeath setFont:font];
        [labelUserNameAndAction setFont:font];
        [labelUserNameAndAction setTextAlignment:NSTextAlignmentCenter];
        [labelUserNameAndAction setBackgroundColor:[UIColor clearColor]];
        [labelUserWeath setBackgroundColor:[UIColor clearColor]];
        [labelUserWeath setTextColor:[UIColor whiteColor]];
        [labelUserNameAndAction setTextColor:[UIColor whiteColor]];
        labelUserWeath.text = @"1234";
        [labelUserWeath setTextAlignment:NSTextAlignmentCenter];
        labelUserNameAndAction.text = @"玩儿码字";
        [userDrawView addSubview:imageViewBackGround];
        [self setBackgroundColor:[UIColor clearColor]];
        // Initialization code
        
        imageCardOne = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewBackGround.frame.size.width-14, imageViewBackGround.frame.size.height-30, 18, 24)];
        imageCardTwo = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewBackGround.frame.size.width-6, imageViewBackGround.frame.size.height-30, 18, 24)];
        // imageCardOne.image = [UIImage imageNamed:@"card back left15.png"];
        // imageCardTwo.image = [UIImage imageNamed:@"card back right15.png"];
        [self addSubview:userDrawView];
        [self addSubview:imageCardOne];
        [self addSubview:imageCardTwo];
        imageCardOne.layer.masksToBounds = YES;
        imageCardOne.layer.cornerRadius = 5.0f;
        imageCardTwo.layer.masksToBounds = YES;
        imageCardTwo.layer.cornerRadius = 5.0f;
        
        [imageCardOne release];
        [imageCardTwo release];
        m_iHasGiveChip = 0;
        m_userHostlogoRect = CGRectZero;
        m_userChiprect = CGRectZero;
        m_arrayStoreChipView = [[NSMutableArray alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(sitDown:)
                                                     name:BNRSERVERALLOWSITDOWN
                                                   object:nil];
        
        UITapGestureRecognizer *reco = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendMyRequest:)];
        [self addGestureRecognizer:reco];
        [reco release];
        
        
    }
    return self;
    
    
}

-(void)setFrame:(CGRect)frame
{
    
 
    [super setFrame:frame];
    NSLog(@"label:%@ userID:%d",labelRecordGiveChip,self.Gameplayer.UserId);
}

-(void)setOtherViewframe:(id)Thread
{
    for (UIView *view in m_arrayStoreChipView)
    {
        [view setFrame:self.chipRect];
    }
    
    CGRect   rect = self.chipRect;
//    rect.origin.x += 12;
//    rect.origin.y -= 2;
//    rect.size.width = 67;
//    rect.size.height = 15;
    
    rect.origin.x -= 54/2;
    rect.origin.y += rect.size.height-5;
    rect.size.width = 67;
    rect.size.height = 15;
    [labelRecordGiveChip setFont:[UIFont systemFontOfSize:12]];
    [labelRecordGiveChip setTextAlignment:NSTextAlignmentCenter];
    [labelRecordGiveChip setFrame:rect];
    
}
-(void)sendMyRequest:(id)Thread
{
    UserInfo  *objuser = [UserInfo shareInstance];
    if (m_userType == NOUSER && !objuser.userHasSitDown)
    {
        
        NSNotificationCenter  *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:BNRSITDOWN object:self];
        
        //  ShowHUDInview(self);
        
    }else
    {
        [self ShowUserInfo];
    }
    
}

-(void)IsitDown:(int8_t)seat
{
    //HideHUDinView(self);
    UserInfo  *Myuser = [UserInfo shareInstance];
    logMyLogInfo(@"sitdown userinfo:%p",Myuser);
    if (!Myuser.userHasSitDown)
    {
        GamePlayer  *player = [[GamePlayer alloc] init];
        player.UserName = Myuser.userName;
        player.UserId = Myuser.userIDForDzpk;
        player.userChip = Myuser.userChips;
        player.UserImagePath = Myuser.userImagePath;
        if (Myuser.bringChip > 0)
        {
            player.bringChip = Myuser.bringChip;
           
        }
        Myuser.userChips -= player.bringChip;
        player.seatID = seat;
        [self SetSeatState:NO MySelfOrOther:YES GAempLayer:player];
        [player release];
        Myuser.userHasSitDown = !Myuser.userHasSitDown;
        [self setHidden:NO];
        self.userType = MYSELF;
    }
    
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *          set seat state
 *  @param
 *          bSet
 *             if yes. the view show unseat status
 *  @param
 *          bIsMyUser
 *              if YES,user self sit down and show self info
 *  @param
 *          player
 *              player info,such as username,id,bringchip and so on
 *	@return
 *          NONE
 *
 */
-(void)SetSeatState:(BOOL)bSet MySelfOrOther:(BOOL)bIsMyUser GAempLayer:(GamePlayer *)player
{
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    m_iHasGiveChip = 0;
    [labelUserNameAndAction setHidden:bSet];
    [labelUserWeath setHidden:bSet];
    logMyLogInfo(@"%@",player);
    [self StopTimer:nil];
    if (bSet)
    {
        self.alpha = 1.0f;
        [labelUserNameAndAction setTextColor:[UIColor clearColor]];
        [self setRecvOut:YES];
        [self setAutologo:YES];
        imageUserphotoView.image = [UIImage imageNamed:@"selectseat.png"];
        imageViewBackGround.image = nil;
        [imageCardOne setFrame:CGRectMake(imageViewBackGround.frame.size.width-14, imageViewBackGround.frame.size.height-30, 18, 24)];
        [imageCardTwo setFrame:CGRectMake(imageViewBackGround.frame.size.width-6, imageViewBackGround.frame.size.height-30, 18, 24)];
        imageCardOne.image = nil;
        imageCardTwo.image = nil;
        m_userType = NOUSER;
        self.Gameplayer = nil;
        [pool drain];
        return;
    }else
    {
        [labelUserNameAndAction setTextColor:[UIColor whiteColor]];
        // imageViewBackGround.image = userImage;
    }
    
    imageUserphotoView.image = nil;
    UserInfo  *myUser = [UserInfo shareInstance];
    if (player.UserId == myUser.userIDForDzpk)
    {
        bIsMyUser = YES;
    }
   
   
    
    imageUserphotoView.image = [UIImage imageNamed:@"userDefault.png"];
    UIImage  *image = [RJFUpAndDown getLocalImage:player.UserImagePath];
    if (image)
    {
        imageUserphotoView.image = image;
        
    }else
    {
        [self performSelector:@selector(StartDownLoadPic:) withObject:player];
    }
    
    if (bIsMyUser && !bSet)
    {
        imageViewBackGround.image = [UIImage imageNamed:@"Myuser.png"];
        self.Gameplayer = player;
        imageCardOne.frame = CGRectMake(imageViewBackGround.frame.size.width+4, imageViewBackGround.frame.size.height-50, 30, 40);
        imageCardTwo.frame = CGRectMake(imageViewBackGround.frame.size.width+18, imageViewBackGround.frame.size.height-50, 30, 40);
        labelUserNameAndAction.text = [myUser userName];
        labelUserWeath.text = [NSString stringWithNeedTranfanstring:[NSNumber numberWithInt:player.bringChip] returnType:GAMESHOWTYPE];
        m_userType = MYSELF;
        
    }else if(!bSet && !bIsMyUser)
    {
        imageViewBackGround.image = [UIImage imageNamed:@"player_square.png"];
        self.userType = OTHERUSER;
        labelUserNameAndAction.text = player.UserName;
        labelUserWeath.text = [NSString stringWithNeedTranfanstring:[NSNumber numberWithInt:player.bringChip] returnType:GAMESHOWTYPE];
        self.Gameplayer = player;
        m_userType = OTHERUSER;
        
    }
    imageCardOne.image = nil;
    imageCardTwo.image = nil;
    [pool drain];
    
}


-(void)StartDownLoadPic:(GamePlayer*)player
{
    
    if ([player.UserImagePath length] < 30)
    {
        return;
    }
    UserInfo  *shareUser = [UserInfo shareInstance];
    RJFUpAndDown  *UpandDown = [[RJFUpAndDown alloc] initWithHost:shareUser.fileHost
                                                             Port:shareUser.filePort
                                                         Delagate:self
                                                              tag:1];
    [UpandDown setDelegate:self];
    [UpandDown SendDownRequest:player.UserImagePath requestID:DOWNLOADREQUESDID];
    
}




-(void)ClearMyself:(id)Thread
{
    [self setRecvOut:YES];
    [self setAutologo:YES];
    [self.arrayStoreChipView removeAllObjects];
    [self.labelRecordGiveChip setText:@""];
}
/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *          override method:dealloc
 *	@return
 *          NONE
 *
 */
-(void)dealloc
{
    if (m_arrayStoreChipView)
    {
        [m_arrayStoreChipView removeAllObjects];
        [m_arrayStoreChipView release];
        m_arrayStoreChipView = nil;
    }
    
    if (userDrawView)
    {
        [userDrawView release];
        userDrawView = nil;
    }
    if (labelUserNameAndAction)
    {
        [labelUserNameAndAction release];
        labelUserNameAndAction = nil;
    }
    if (labelUserDialog)
    {
        [labelUserDialog release];
        labelUserDialog = nil;
    }
    if (labelUserWeath)
    {
        [labelUserWeath release];
        labelUserWeath = nil;
    }
    if (imageUserphotoView)
    {
        [imageUserphotoView release];
        imageUserphotoView = nil;
    }
    if (imageViewWholeBg)
    {
        [imageViewWholeBg release];
    }
    
    [super dealloc];
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *          override method:
 *  @param
 *          touches
 *              touch
 *  @param
 *          event
 *              event
 *	@return
 *          NONE
 *
 */
/*-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UserInfo  *objuser = [UserInfo shareInstance];
    if (m_userType == NOUSER && !objuser.userHasSitDown)
    {
        
        NSNotificationCenter  *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:BNRSITDOWN object:self];
        
      //  ShowHUDInview(self);
        
    }else
    {
        [self ShowUserInfo];
    }
    // logMyLogInfo(@"self:%@",self);
    
}*/

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *          override method: description.
 *	@return
 *          description of self
 *
 */
-(NSString *)description
{
    return [NSString  stringWithFormat:@"--RJFUserImageView-- \n rect:%@,player:%@,labelNameAndAction.text:%@ labelWeath:%@ userType:%d tag:%d chiprect:%@ hostRect:%@ status:%d",[NSValue valueWithCGRect:self.frame],m_objPlayer,labelUserNameAndAction.text,labelUserWeath.text,m_userType,self.tag,[NSValue valueWithCGRect:m_userChiprect],[NSValue valueWithCGRect:m_userHostlogoRect],m_iUserState];
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *          start count down
 *  @param
 *          timer
 *              the time(float)
 *	@return
 *          NONE
 *
 */
-(void)StartTimer:(NSNumber*)timer
{
    logMyLogInfo(@"userView startTimer:%@",timer);
    if (self.hidden || self.userType == NOUSER)
    {
        return;
    }
    if (self.userType == MYSELF)
    {
        userDrawView.lineColor = [UIColor greenColor];
    }else
    {
        userDrawView.lineColor = [UIColor blueColor];
    }
    [userDrawView StartTimer:timer];
    /*[userDrawView performSelector:@selector(StartTimer:)
                         onThread:[NSThread mainThread]
                       withObject:timer
                    waitUntilDone:NO];
     */
   // [userDrawView StartTimer:timer];
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *          stop count down
 *  @param
 *          note
 *              note
 *	@return
 *          NONE
 *
 */
-(void)StopTimer:(NSNotification *)note
{
    

    [userDrawView StopTimer:note];
}

-(void)MoveTheCardToMid
{
    if (self.hidden || self.userType == NOUSER)
    {
        return;
    }
    CGRect frame = [imageUserphotoView bounds];
    UIImage  *imageOne = imageCardOne.image;
    UIImage  *imageTwo = imageCardTwo.image;
    CGRect   rectOne = [imageUserphotoView convertRect:CGRectMake(0, 0, frame.size.width/3*2, frame.size.height) toView:self];
    CGRect   rectTwo = [imageUserphotoView convertRect:CGRectMake(frame.size.height/3, 0, frame.size.height/3*2, frame.size.height) toView:self];
    
    
    [UIView animateWithDuration:0.5f
                     animations:^
     {
         [imageCardTwo setFrame:rectTwo];
         [imageCardOne setFrame:rectOne];
     } completion:^(BOOL finish)
     {
         UIImageView  *imageViewCardOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/3*2, frame.size.height)];
         imageViewCardOne.image = imageOne;
         UIImageView  *imageViewCardTwo = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.height/3, 0, frame.size.height/3*2, frame.size.height)];
         imageViewCardTwo.image = imageTwo;
         imageViewCardOne.userInteractionEnabled = YES;
         imageViewCardOne.tag = 1;
         imageViewCardTwo.tag = 2;
         imageViewCardTwo.userInteractionEnabled = YES;
         [imageUserphotoView addSubview:imageViewCardOne];
         [imageUserphotoView addSubview:imageViewCardTwo];
         
         [imageViewCardOne release];
         [imageViewCardTwo release];
         
         
         imageCardOne.frame = CGRectMake(imageViewBackGround.frame.size.width+4, imageViewBackGround.frame.size.height-50, 30, 40);
         imageCardTwo.frame = CGRectMake(imageViewBackGround.frame.size.width+18, imageViewBackGround.frame.size.height-50, 30, 40);
         imageCardOne.image = nil;
         imageCardTwo.image = nil;
         
     }];
    
}


-(void)ShowUserInfo
{
    
    if (self.Gameplayer != nil && self.Gameplayer.UserId > 0)
    {
        
        NSDictionary  *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@(self.Gameplayer.UserId),@"USERID",@(self.Gameplayer.seatID),@"SEATID",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:BNRUSERINFOVIEW
                                                            object:self
                                                          userInfo:dicInfo];
    }
    
       
   
    
    // remain to show userinfo
    logMyLogInfo(@"self frame:%@",[NSValue valueWithCGRect:self.frame]);
}




-(void)HadleMessage:(NSNotification*)note
{
    RJFTcpSocket  *m_socket = [note object];
    NSDictionary  *dicInfo = [note userInfo];
    if (dicInfo && (m_socket.tag == GAMESOCKETTAG) )
    {
        
    }else
    {
        return;
    }
    
    size_t  size = [[dicInfo valueForKey:TCPSOCKETSIZE] intValue];
    BasisZipAndUnzip   *objZip = [[BasisZipAndUnzip alloc] initWithSize:size+5];
    int  requestCode = -1;
   
    NSData  *data = [[note userInfo] valueForKey:TCPSOCKETMESSAGE];
    int8_t  *bytes =(int8_t*) [data bytes];
    int  pos = 4;
    if (bytes[0] != 'D')
    {
        pos = 5;
    }
    requestCode = [BasisZipAndUnzip unbyte_to_int16:bytes pos:pos];
    void *handle = NULL;
    logMyLogInfo(@"++++++++++++++++++++requestcode:%d   recasize:%ld",requestCode,size);
    if (requestCode == REQ_GAME_PLAYER_DATA)
    {
        handle = [objZip PhaseInfoFromData:bytes
                           
                   outRequestCode:&requestCode];
        DZPK_SERVER_REQ_GAME_PLAYER_DATA  *info = handle;
        if (!info->status && info->userID == self.Gameplayer.UserId)
        {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            RJFUserdetail *detail = [[[RJFUserdetail alloc] initWithFrame:CGRectMake(60, 60, 335, 200)
                                                                  withID:self.Gameplayer.UserId] autorelease];
            [detail SetInfoAccorddata:info];
          
            
        }else
        {
            logMyLogInfo(@"获取个人信息失败！");
        }
    }
    free(handle);
    handle = NULL;
    [objZip release];
    objZip = nil;
    
}
-(NSInteger)getUserState
{
    return m_iUserState;
}
//"1:下注  2:跟注  3:加注  4:全下 5:让牌  6:弃牌 7托管 8等待下一局 9 淘汰  0 NoState
//"

-(void)setUserState:(NSInteger)iState
{
    if (self.hidden || self.userType == NOUSER)
    {
        return;
    }
    m_iUserState = iState;
    self.Gameplayer.userState = iState;
    
    [self setAlpha:1.0];
    NSString   *strStatus = @"";
    [self setAutologo:YES];
    [self setRecvOut:YES];
    switch (iState)
    {
   
        case 2:
            strStatus = FollowChip;
            break;
        case 3:
            strStatus = AddChip;
            break;
        case 4:
            strStatus = ALLChipBet;
            break;
        case 5:
            strStatus = KeepCard;
            break;
        case 6:
            strStatus = GiveUpCard;
            [self setAlpha:0.5];
            break;
        case 7:
            strStatus = AutoBet;
            [self setAutologo:NO];
            break;
        case 8:
            strStatus = WaitnextBet;
            [self setAlpha:0.5];
            break;
        case 9:
            strStatus = Recv_out;
            [self setAlpha:0.5];
            [self setRecvOut:NO];
            break;
        case 0:
        case 1:
            strStatus = self.Gameplayer.UserName;
            [self setRecvOut:YES];
            [self setAutologo:YES];
            break;
            
          //  recv_out
            
        default:
            break;
    }
    [labelUserNameAndAction setText:strStatus];
    
}

-(void)setAutologo:(BOOL)bHide
{
   
    logMyLogInfo(@"autoHide:%d",bHide);
    UIImageView  *imageView = (UIImageView *)[self viewWithTag:AUTOIMAGETAG];
    if (!bHide)
    {
        if (imageView == nil)
        {
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-35,15, 26, 26)];
            imageView.tag = AUTOIMAGETAG;
            imageView.image = [UIImage imageNamed:@"autologo.png"];
            [self addSubview:imageView];
            [imageView release];
        }
        
    }
    [imageView setHidden:bHide];
    if (m_userType == NOUSER || self.hidden)
    {
        [imageView removeFromSuperview];
        return;
    }
    
    // autologo
}

-(void)setRecvOut:(BOOL)bHide
{
    
    UIImageView  *imageView = (UIImageView *)[self viewWithTag:RECVIMAGETAG];
    if (imageView == nil)
    {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-40,15, 35, 31)];
        imageView.tag = RECVIMAGETAG;
        imageView.image = [UIImage imageNamed:@"recv_out.png"];
        [self addSubview:imageView];
        [imageView release];
    }
    
      [imageView setHidden:bHide];
    if (m_userType == NOUSER || self.hidden)
    {
        [imageView setHidden:YES];
        return;
    }
  
    // autologo
}



-(void)PlayAudio:(NSString *)strPath
{
    if (m_userType == MYSELF)
    {
        [RJFaudioPlay PlayMyAudio:strPath];
    }
    
}
-(void)DownLoadSuOrFail:(UIImage *)image ISSuc:(BOOL)bSUc
{
    if (image)
    {
         imageUserphotoView.image = image;
    }
    
   
    [m_objDown release];
    m_objDown = nil;
}
-(BOOL)respondsToSelector:(SEL)aSelector
{
    logMyLogInfo(@"userDrawView.........SELECTOR: %@...........\n", NSStringFromSelector(aSelector));
    return [super respondsToSelector:aSelector];
}

@end
