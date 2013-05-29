//
//  RJFUserImageView.h
//  UserTest
//
//  Created by popo on 12-6-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UserInfo.h"
#import "GamePlayer.h"
#import "NSString+Number.h"
#import "RJFGameInterface.h"
#import "RJFUserDrawView.h"
#import "RJFUpAndDown.h"

typedef enum usertype
{
    MYSELF,
    OTHERUSER,
    NOUSER,
}UserType;


/*!
 *   @author  
 *           Jingfu Ran
 *   @since
 *           2012 06 29
 *   @brief
 *           Show User detail
 */
@interface RJFUserImageView : UIView
{
    UIImageView         *imageUserphotoView;
    UIImageView         *imageViewBackGround;
    UIImageView         *imageCardOne;
    UIImageView         *imageCardTwo;
    UILabel             *labelUserNameAndAction;
    UILabel             *labelUserDialog;
    UILabel             *labelUserWeath;
    UIImageView         *imageViewWholeBg;
    
    GamePlayer          *m_objPlayer;
    RJFUserDrawView     *userDrawView;
    
    int32_t             m_iHasGiveChip;
    CGRect              m_userHostlogoRect;
    CGRect              m_userChiprect;
    CGRect              m_userSpeakRect;
    CGRect              m_userFaceRect;
    
    UserType            m_userType;
   
    UIViewController    *m_superViewControl;
    
    RJFUpAndDown        *m_objDown;
    
    UILabel              *labelRecordGiveChip;
    NSMutableArray       *m_arrayStoreChipView;
    NSInteger            m_iUserState;
}
@property(retain) UIImageView     *imageViewCardOne;
@property(retain) UIImageView     *imageViewCardTwo;
@property(retain) UIImageView     *imageViewPhotoView;
@property(retain) UIImageView     *imageViewBackGround;
@property(assign) RJFUpAndDown    *objDown;

@property(atomic,retain) UILabel         *labelNameAndAction;
@property(atomic,retain) UILabel         *labelWeath;
@property(retain) UILabel         *labelDialog;
@property(retain) UIImageView     *imageViewWholebg;
@property(readwrite)        UserType        userType;
@property(retain) GamePlayer      *Gameplayer;
@property(readwrite) int32_t   giveChip;
@property(readwrite) CGRect       hostLogoRect;
@property(readwrite) CGRect       chipRect;
@property(readwrite) CGRect       speakRect;
@property(readwrite) CGRect       faceRect;
@property(retain)NSMutableArray             *m_arrayPoint;
@property(retain) UIViewController  *superViewControl;
@property(assign) UILabel           *labelRecordGiveChip;
@property(retain) NSMutableArray    *arrayStoreChipView;
@property(readwrite)NSInteger       UserNowState;
@property(readwrite) CGRect       originalHostLogoRect;
@property(readwrite) CGRect       originalchipRect;
@property(readwrite) CGRect       originalspeakRect;
@property(readwrite) CGRect       originalfaceRect;
@property(readwrite) CGRect       originalFrameRect;


-(void)SetSeatState:(BOOL)bSet MySelfOrOther:(BOOL)bIsMyUser GAempLayer:(GamePlayer *)player;
-(void)setAllViewApha:(CGFloat)alpha;
-(void)setCardShow:(NSString *)strFirsCard SecondCard:(NSString *)strSecond winerString:(NSString *)strWinString;
-(void)RemoveShowCardAndBackToOringal;
-(void)StartTimer:(NSNumber*)timer;
-(void)StopTimer:(NSNotification *)note;
-(void)MoveTheCardToMid;
-(void)WinerLightlalo:(NSTimeInterval)timer;
-(void)IsitDown:(int8_t)seat;
-(void)setUserState:(NSInteger)iState;
-(void)setAutologo:(BOOL)bHide;
-(void)PlayAudio:(NSString *)strPath;
-(void)setRecvOut:(BOOL)bHide;
-(void)ClearMyself:(id)Thread;
-(void)setOtherViewframe:(id)Thread;
//cardnumber is 5, mean first card,cardnumber is 6 means second card
-(void)setCardAlpha:(int8_t)cardnumber;
@end