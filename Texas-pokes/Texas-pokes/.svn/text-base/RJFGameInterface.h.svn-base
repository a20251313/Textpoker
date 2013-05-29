//
//  RJFGameInterface.h
//  Texas-pokes
//
//  Created by popo on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PublicDefine.h"
#import "RJFWarnView.h"
#import "NSString+Number.h"
#import <QuartzCore/QuartzCore.h>
#import "RJFSliderView.h"
#import "RJFUserImageView.h"
#import "GamePlayer.h"
#import "RJFaudioPlay.h"
#import "UserInfo.h"
#import "RJFShowWordLabel.h"
#import "RJFAddChipView.h"
#import "JFItemShowView.h"

typedef struct userInfo
{
    int   index;
    NSString *strFirstCard;
    NSString *strsecondCard;
    UIImageView  *imageView;
   // RJFUserImageView  *SomeUser;
}aniUserInfo;

typedef struct collectChip
{
    int32_t  collectchips;
    int32_t  allchips;
    int      index;
}collectChipstruct;
@class RJFUserImageView;
//@class UserInfo;

typedef enum CONTROLTYPE1234
{
    GAMETYPE,
    FRESHTEACHTYPE
}MyGameControlType;


typedef enum action
{
    actionputchip = 1,
    actionfollowchip = 2,
    actionaddchip = 3,
    actionallPut = 4,
    actionkeepchip = 5,
    actiongiveupCard = 6
    
    
}UserAction;


typedef struct
{
    int32_t   roomID;
    int32_t   roomPath;
    int8_t    roomCategory;
    int32_t   roomBigbland;
    int32_t   roomSmallblind;
    //int32_t   roomSpeed;
    int32_t   playerNumber;
    int32_t   serverCharge;
    int32_t   bringgold;
    int8_t    roomStatus;
    int32_t   roomPrize;
    int32_t   enterFee;
    
    int8_t    roomCountDown;
    int8_t    roomBigIndex;                 //net seat
    int8_t    roomSmallIndex;                 // net seat
    int8_t    bankerIndex;                  //net seat
    int8_t    operationID;
    int8_t    myseatID;                     //myseat
    int8_t*   hasTurnCard;
    int32_t   allChipOndesk;                //dest
    int8_t    operationTime;
    
    
    
    
    int       hasTurnCardNumber;
    
    
    
    
}allRoomInfo;

typedef enum
{
    GAMENOWISCOUNTDOWNING = 0,
    GAMENOWISPLAYING,
    GAMENOWISOVER,
    GAMENOWISNONE,
}GameNowStatus;

@interface RJFGameInterface : UIViewController <BNRWarnViewDelegate,UITextFieldDelegate,BNRAddChipDelegate,BNRUSERITEMSOLD>
{
    IBOutlet      UIButton          *btnFace;
    IBOutlet      UIButton          *btnBack;
    IBOutlet      UIButton          *btnSpeakWord;
    IBOutlet      UIButton          *btnLeft;
    IBOutlet      UIButton          *btnMiddle;
    IBOutlet      UIButton          *btnRight;
    IBOutlet      UIButton          *btnStand;
    
    IBOutlet      UILabel           *labelSpeakWord;
    IBOutlet      UILabel           *labelChips;
    
    IBOutlet      UIImageView       *imageViewCardOne;
    IBOutlet      UIImageView       *imageViewCardTwo;
    IBOutlet      UIImageView       *imageViewCardThree;
    IBOutlet      UIImageView       *imageViewCardFour;
    IBOutlet      UIImageView       *imageViewCardFive;
    
    
    UIImageView                     *imageViewCountDownView;
    
  
    NSTimer                         *m_timerGame;
    NSTimer                         *m_timeCheckGame;
    NSTimer                         *m_countTimer;
    
    NSLock                          *m_lockForArray;
    NSLock                          *m_lock;
    NSLock                          *m_lockCountTimes;
   // NSConditionLock
    
   
    
    
    NSMutableArray                  *m_arrayStoreUserRectInfo;     // store all rect info (NSValue)
    NSMutableArray                  *m_arrayStoreUserView;         //store all userView (RJFUserView)
    NSMutableArray                  *m_arrayStoreCardView;         //Store five imageviewOn dest;
    NSMutableArray                  *m_arrayStoreChipView;         // store chip view every time game
    NSMutableArray                  *m_arrStoreSentences;          // store all fresh teah words
    NSMutableArray                  *m_arrStoreUsercard;
    NSMutableArray                  *m_arrStorCardNumber;
    NSMutableArray                  *m_arrayUndealInfo;
    
    
    UserInfo                        *m_objShareUser;
    
    long                            m_lTotalChipIndesk;             // total chips on desk
    
    NSInteger                       m_iCount;                       //only for fresh teach
    NSInteger                       m_index;                        //the index for fapai
    NSInteger                       m_iSentenseIndex;               // for teach
    NSInteger                       m_iJoshIndex;                   //for teach
    NSInteger                       m_iBalIndex;                    // for teach
    NSInteger                       m_iSelfIndex;                   //for teach
    NSInteger                       m_iStartCount;
    NSInteger                       m_iCountDownNumber;
    
    int32_t                         m_inowPutChip;                  
    int32_t                         m_inowMaxChip;                  //curren turn max chip
    int32_t                         m_arrStoreChip[8];
    
    
    int8_t                          m_iRealSeat;                    // user real seat
    int8_t                          m_userAutoAction;             //1 弃牌与看牌   2 看牌   3.跟任何注
    int8_t                          m_iCurrentOpSeat;
    int32_t                         m_ibuyPropChips;
    int32_t                         m_iNowChips;

 
   
    
    
    
    BOOL                            m_bFirstCard;                   //judge for fapai
    BOOL                            m_arrbFlag[3];                  //only  for fresh teash
    BOOL                            m_bHasClicksureAddchip;
    BOOL                            m_bHasAction;
    BOOL                            m_bNeedStopCountDown;
    BOOL                            m_bHasRecvStratInfo;
    BOOL                            m_bHasFapai;
    BOOL                            m_bHasGiveUpOrAllput;               //user has give up thie time
    BOOL                            m_bmustWait;                //if need wait set it as YES,while after set NO and m_arrayUndealInfo remove all
   

    MyGameControlType                   m_gameControltype;
    ClickinsureMode                     m_clickInsureMode;
    DZPK_SERVER_REQ_GAME_ENTER_ROOM     *m_initRoomInfo;
    GameroomInfo                        *m_roomIDandPath;
    allRoomInfo                         m_myRoomAllinfo;
    UserAction                          m_userAction;
    GameNowStatus                       m_gameStatus;
    
}
@property(atomic,readwrite)int8_t           currentOp;
@property(nonatomic,readwrite)CGPoint       gifImaageCenter;
@property(nonatomic,readwrite)BOOL          isInBackGroundMode;
@property(nonatomic,readwrite)BOOL          isReconectToServer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gameType:(MyGameControlType)gametype;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
             roomInfo:(GameroomInfo*)info;
-(IBAction)clickFace:(UIButton *)sender;
-(IBAction)clickBack:(UIButton *)sender;
-(IBAction)clickSpeakWord:(UIButton *)sender;
-(IBAction)clickLeft:(UIButton *)sender;
-(IBAction)clickMiddle:(UIButton *)sender;
-(IBAction)clickRight:(UIButton *)sender;
-(IBAction)clickStand:(UIButton *)sender;


//#pragma mark erase warning in cate



-(void)addUserImagview:(NSArray*) array;

-(void)BeginBetChips:(NSInteger)chip UserIndex:(NSUInteger)index;
-(void)setLMREnable:(BOOL)bEnable Hide:(BOOL)bHide;
-(void)gatherchips:(id)Thread;
-(void)CleanAfterEverybetchip:(id)Thread;
-(void)BeginFapai:(NSInteger)index FirstCard:(NSString *)strFirstCard SecondCard:(NSString *)strSecondCard;
-(void)StartCountDown:(int)index;
-(void)roateCardAccordInfo:(NSDictionary *)dicInfo;
-(void)setWiner:(RJFUserImageView *)userView  index:(NSInteger)winIndex getChips:(NSInteger)chips;
-(void)setHostLogo:(RJFUserImageView *)object bhide:(BOOL)bHide;
-(void)youWinAni:(CGFloat)fYtrantion icount:(NSInteger)iCount;
-(BOOL)respondsToSelector:(SEL)aSelector;


@end

