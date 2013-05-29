//
//  RJFMainWindow.h
//  Texas-pokes
//
//  Created by popo on 12-7-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"
#ifndef CURRENTTHIRDUSERID
#define CURRENTTHIRDUSERID          @"CURRENTTHIRDUSERID"
#endif

@interface RJFMainWindow : UIViewController<BNRWarnViewDelegate>
{
    IBOutlet    UIButton      *btnHelp;
    IBOutlet    UIButton      *btnSetting;
    IBOutlet    UIButton      *btnQucikStart;
    IBOutlet    UIButton      *btnGameFloor;
    IBOutlet    UIButton      *btnMatchFloor;
    IBOutlet    UIButton      *btnBeginTeach;
    IBOutlet    UIButton      *btnChargemoney;
    IBOutlet    UIButton      *btnLoginOut;
    IBOutlet    UIButton      *btnSetUserInfo;
    IBOutlet    UIButton      *btnMenuMessage;
    IBOutlet    UIButton      *btnRecommand;
    IBOutlet    UIButton      *btnRank;
    IBOutlet    UIButton      *btnShare;
    IBOutlet    UIButton      *btnTask;
    IBOutlet    UIButton      *btnLevelDetail;
    
    IBOutlet    UILabel       *labelName;
    IBOutlet    UILabel       *labelChips;
    IBOutlet    UILabel       *labelLevelNick;
    IBOutlet    UILabel       *labelLevelPercentage;
    IBOutlet    UILabel       *labelScore;
    IBOutlet    UILabel       *labelCardNumber1;
    IBOutlet    UILabel       *labelCardNumber2;
    IBOutlet    UILabel       *labelCardNumber3;
    IBOutlet    UILabel       *labelCardNumber4;
    IBOutlet    UILabel       *labelCardNumber5;
    IBOutlet    UILabel       *labelMaxWinChips;
    IBOutlet    UILabel       *labelMessageNumber;
    IBOutlet    UILabel       *labelCurrentPeople;
    IBOutlet    UILabel       *labelID;
    
    IBOutlet    UIImageView   *imageViewlevelfill;
    IBOutlet    UIImageView   *imageViewlevelBack;
    IBOutlet    UIImageView   *imageViewCard1;
    IBOutlet    UIImageView   *imageViewCard2;
    IBOutlet    UIImageView   *imageViewCard3;
    IBOutlet    UIImageView   *imageViewCard4;
    IBOutlet    UIImageView   *imageViewCard5;
    IBOutlet    UIImageView   *imageViewlUserimage;
    IBOutlet    UIImageView   *imageViewmenuNumber;
    IBOutlet    UIImageView   *imageViewmenuTask;
    
    IBOutlet    UIImageView   *imageViewMedal;
    IBOutlet    UILabel       *labelPer;
    
    ClickinsureMode           m_clickInsureType;
    GameroomInfo                m_roomInfo;
    
    UserInfo                  *m_objShareInfo;
    int32_t                   m_getfreeChips;
    NSString                *m_strPicName;
    NSInteger                m_iProgressCount;
    
}
@property(copy)NSString     *headpicName;
@property(readwrite)NSInteger     dayIndex,dayBounds;
-(IBAction)clickHelp:(UIButton *)sender;
-(IBAction)clickSetting:(UIButton *)sender;
-(IBAction)clickQuickStart:(UIButton *)sender;
-(IBAction)clickGameFloor:(UIButton *)sender;
-(IBAction)clickMatchFloor:(UIButton *)sender;
-(IBAction)clickBeginTeach:(UIButton *)sender;
-(IBAction)clickChargeMoney:(UIButton *)sender;
-(IBAction)clickLohinOut:(UIButton *)sender;
-(IBAction)clickSetuserInfo:(UIButton *)sender;
-(IBAction)clickMenuMessage:(UIButton *)sender;
-(IBAction)clickRecomand:(UIButton *)sender;
-(IBAction)clickRank:(UIButton *)sender;
-(IBAction)clickShare:(UIButton *)sender;
-(IBAction)clickTask:(UIButton *)sender;
-(IBAction)clickLevelDetail:(UIButton *)sender;

@end
