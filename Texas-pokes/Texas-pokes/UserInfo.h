//
//  UserInfo.h
//  Texas-pokes
//
//  Created by popo on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Number.h"
#import "PublicDefine.h"

@interface UserInfo : NSObject<NSCoding,NSCopying>
{
    NSMutableString   *m_strUserName;               //name

    NSMutableString   *m_strUserImagePath;          //imagePath
    NSMutableString   *m_strUserPwd;                //pwd
    NSMutableString   *m_strSex;
    
    int32_t             m_iUserID;                 //ID
    long                m_iUserChips;             //userChops
    long                m_iWinTimes;
    long                m_iLoseTimes;
    long                m_iMaxWinChips;
    NSInteger           m_iMAXcard1;
    NSInteger           m_iMAXcard2;
    NSInteger           m_iMAXcard3;
    NSInteger           m_iMAXcard4;
    NSInteger           m_iMAXcard5;
    int8_t               m_itask;
    float                m_idou;
    long                m_iMaxGain;
    long                m_igetChipTimes;
    NSInteger           m_iMsgCount;
    long                m_iOnlineCount;
    NSInteger          m_iUserType;
    BOOL               m_bUserHasSitdown;
    int32_t            m_iBringChip;
    
    
    //setting
    BOOL              m_bAutoSitdown;               
    BOOL              m_bClearCache;
    BOOL              m_bCheckVersion;
    CGFloat           m_fVolume;
    CGFloat           m_fMusic;
    NSDate            *m_date;
    
    NSString            *m_strFileHost;
    UInt16              m_uiPort;
    
    int32_t             score;
    int32_t             match_score;
    int8_t              level;
    BOOL                m_bHasFreshBounds;
    BOOL                m_bHasCheckVersion;
    BOOL                m_bIsOnGameInterface;
    BOOL                m_bIsNeedSyncInfo;
    
    UIInterfaceOrientationMask      m_userInter;
    
    
}
@property(retain)NSMutableString   *userName;
@property(readwrite)int32_t   userIDForDzpk;
@property(readwrite)long      userChips;
@property(retain)NSMutableString   *userImagePath;
@property(retain)NSMutableString   *userPwd;
@property(readwrite)BOOL                 autoSitDown;
@property(readwrite)BOOL                 clearCache;
@property(readwrite)BOOL                 checkVersion;
@property(readwrite)CGFloat              volume;
@property(readwrite)CGFloat              music;
@property(readwrite)long             winTimes;
@property(readwrite)long             loseTime;
@property(readwrite)long             MaxWinchips;
@property(readwrite)NSInteger             MaxCard1;
@property(readwrite)NSInteger             MaxCard2;
@property(readwrite)NSInteger             MaxCard3;
@property(readwrite)NSInteger             MaxCard4;
@property(readwrite)NSInteger             MaxCard5;
@property(retain)NSMutableString          *Sex;
@property(readwrite)float             idou;
@property(readwrite)long             maxOwn;
@property(readwrite)long             getChipTimes;
@property(readwrite)BOOL                  userHasSitDown;
@property(readwrite)NSInteger             msgCount;
@property(readwrite)long             onlineCount;
@property(copy)NSString                   *userKey;
@property(readwrite)NSInteger             userType;
@property(readwrite)int32_t               bringChip;
@property(copy)NSString                     *fileHost;
@property(readwrite)UInt16                   filePort;
@property(retain)NSDate                     *gamedate;
@property(readwrite)int32_t                  score;
@property(readwrite)int32_t                  matchscore;
@property(readwrite)int8_t                   level;
@property(readwrite)int8_t                   task;
@property(readwrite)UIInterfaceOrientationMask                  userInterface;
@property(readwrite)BOOL        hasCheckVersion;
@property(readwrite)BOOL        IsOnGameInterface;
@property(readwrite)BOOL         hasFreshBounds;
@property(readwrite)BOOL         needSyncInfo;
+(id)shareInstance;
@end
