//
//  UserInfo.m
//  Texas-pokes
//
//  Created by popo on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserInfo.h"

#ifndef USERINFO
#define USERINFO            @"USERINFO"
#define kautoSitDown      @"autoSitDown"
#define kclearCache      @"clearCache"
#define kcheckVersion      @"checkVersion"
#define kvolume      @"volume"
#define kmusic     @"music"
#endif

@implementation UserInfo
@synthesize userIDForDzpk = m_iUserID;
@synthesize userName = m_strUserName;
@synthesize userChips = m_iUserChips;
@synthesize userPwd = m_strUserPwd;
@synthesize userImagePath = m_strUserImagePath;
@synthesize autoSitDown = m_bAutoSitdown;
@synthesize clearCache = m_bClearCache;
@synthesize checkVersion = m_bCheckVersion;
@synthesize volume = m_fVolume;
@synthesize music = m_fMusic;
@synthesize MaxCard1 = m_iMAXcard1;
@synthesize MaxCard2 = m_iMAXcard2;
@synthesize MaxCard3 = m_iMAXcard3;
@synthesize MaxCard4 = m_iMAXcard4;
@synthesize MaxCard5 = m_iMAXcard5;
@synthesize loseTime = m_iLoseTimes;
@synthesize winTimes = m_iWinTimes;
@synthesize MaxWinchips = m_iMaxWinChips;
@synthesize Sex = m_strSex;
@synthesize idou = m_idou;
@synthesize maxOwn = m_iMaxGain;
@synthesize getChipTimes = m_igetChipTimes;
@synthesize userHasSitDown = m_bUserHasSitdown;
@synthesize msgCount = m_iMsgCount;
@synthesize onlineCount = m_iOnlineCount;
@synthesize userKey = m_strUserkey;
@synthesize userType = m_iUserType;
@synthesize bringChip = m_iBringChip;
@synthesize fileHost = m_strFileHost;
@synthesize filePort = m_uiPort;
@synthesize gamedate = m_date;
@synthesize level;
@synthesize score;
@synthesize matchscore = match_score;
@synthesize userInterface = m_userInter;
@synthesize hasCheckVersion = m_bHasCheckVersion;
@synthesize IsOnGameInterface = m_bIsOnGameInterface;
@synthesize task = m_itask;
@synthesize hasFreshBounds;
@synthesize needSyncInfo = m_bIsNeedSyncInfo;
static UserInfo  *userinfo = nil;



#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{

    
    
    /*[aCoder encodeObject:m_strUserName forKey:kuserName];
    
    [aCoder encodeInt:m_iuserChips forKey:kuserChips];
    [aCoder encodeObject:m_strUserID forKey:kuserIDKey];
    [aCoder encodeObject:m_strUserImagePath forKey:kuserImagePath];
    [aCoder encodeObject:m_strUserPwd forKey:kuserPwd];
    [aCoder encodeObject:m_strlevel forKey:klevel];
    [aCoder encodeObject:m_strSex forKey:kSex];
    [aCoder encodeInteger:m_iWinTimes forKey:kwinTimes];
    [aCoder encodeInteger:m_iLoseTimes forKey:kloseTime];
    [aCoder encodeInteger:m_iMaxWinChips forKey:kMaxWinchips];
    [aCoder encodeInteger:m_iMAXcard1 forKey:kMaxCard1];
    [aCoder encodeInteger:m_iMAXcard2 forKey:kMaxCard2];
    [aCoder encodeInteger:m_iMAXcard3 forKey:kMaxCard3];
    [aCoder encodeInteger:m_iMAXcard4 forKey:kMaxCard4];
    [aCoder encodeInteger:m_iMAXcard5 forKey:kMaxCard5];
    [aCoder encodeInteger:m_iBeans forKey:kBeans];
    [aCoder encodeInteger:m_iMaxGain forKey:kmaxOwn];
    [aCoder encodeInteger:m_igetChipTimes forKey:kgetChipTimes];
    [aCoder encodeBool:m_bUserHasSitdown forKey:kuserHasSitDown];
    [aCoder encodeBool:m_bAutoSitdown forKey:kautoSitDown];
    [aCoder encodeBool:m_bClearCache forKey:kclearCache];
    [aCoder encodeBool:m_bCheckVersion forKey:kcheckVersion];
    [aCoder encodeFloat:m_fVolume forKey:kvolume];
    [aCoder encodeFloat:m_fMusic forKey:kmusic];*/
    
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {

        
        /*m_strUserName = [aDecoder decodeObjectForKey:kuserName];
        m_strUserID = [aDecoder decodeObjectForKey:kuserIDKey];
        m_strUserImagePath = [aDecoder decodeObjectForKey:kuserImagePath];
        m_strUserPwd = [aDecoder decodeObjectForKey:kuserPwd];
        m_strlevel = [aDecoder decodeObjectForKey:klevel];
        m_strSex = [aDecoder decodeObjectForKey:kSex];
        
        m_iuserChips = [aDecoder decodeIntForKey:kuserChips];
        m_iWinTimes = [aDecoder decodeIntForKey:kwinTimes];
         m_iLoseTimes = [aDecoder decodeIntForKey:kloseTime];
         m_iMaxWinChips = [aDecoder decodeIntForKey:kMaxWinchips];
         m_iMAXcard1 = [aDecoder decodeIntForKey:kMaxCard1];
         m_iMAXcard2 = [aDecoder decodeIntForKey:kMaxCard2];
         m_iMAXcard3 = [aDecoder decodeIntForKey:kMaxCard3];
         m_iMAXcard4 = [aDecoder decodeIntForKey:kMaxCard4];
         m_iMAXcard5 = [aDecoder decodeIntForKey:kMaxCard5];
         m_iBeans = [aDecoder decodeIntForKey:kBeans];
         m_iMaxGain = [aDecoder decodeIntForKey:kmaxOwn];
         m_igetChipTimes = [aDecoder decodeIntForKey:kgetChipTimes];
         m_iWinTimes = [aDecoder decodeIntForKey:kwinTimes];
         m_bUserHasSitdown = [aDecoder decodeBoolForKey:kuserHasSitDown];
         m_bAutoSitdown = [aDecoder decodeBoolForKey:kautoSitDown];
         m_bClearCache = [aDecoder decodeBoolForKey:kclearCache];
         m_bCheckVersion = [aDecoder decodeBoolForKey:kcheckVersion];
         m_fVolume = [aDecoder decodeFloatForKey:kvolume];
         m_fMusic = [aDecoder decodeFloatForKey:kmusic];*/
  
    }
    return self;
}

#pragma mark NSCoping
- (id)copyWithZone:(NSZone *)zone
{

   // ArchivingData *Mycopy = [[[self class] allocWithZone:zone] init];
    
    
    return nil;
}
+(id)shareInstance
{
    if (!userinfo) 
    {
        userinfo = [[UserInfo alloc] init];
        NSUserDefaults  *userDe = [NSUserDefaults standardUserDefaults];
        if ([userDe valueForKey:USERINFO] != nil)
        {
            NSDictionary  *dicInfo = [userDe valueForKey:USERINFO];
            userinfo.autoSitDown = [[dicInfo valueForKey:kautoSitDown] boolValue];
            userinfo.volume = [[dicInfo valueForKey:kvolume] floatValue];
            userinfo.clearCache = [[dicInfo valueForKey:kclearCache] boolValue];
            userinfo.checkVersion = [[dicInfo valueForKey:kcheckVersion] boolValue];
            userinfo.music = [[dicInfo valueForKey:kmusic] floatValue];
        }
    }
    return userinfo;
}

-(id)init
{
    self = [super init];
    if (self) 
    {
        m_bUserHasSitdown = NO;
       
        self.userIDForDzpk = 0;
        self.userName = [NSMutableString stringWithString:@"苦命吊死"];
        self.userImagePath = [NSMutableString stringWithString:USERIMAGEPATH];
        m_iUserChips  = 2000;
        self.level = 0;
        self.Sex = [NSMutableString stringWithString:NSLocalizedString(@"男", nil)];
        m_iLoseTimes = 0;
        m_iMaxWinChips = 0;
        m_iWinTimes = 0;
        m_iMAXcard1 = 11;
        m_iMAXcard2 = 22;
        m_iMAXcard3 = 33;
        m_iMAXcard4 = 44;
        m_iMAXcard5 = 34;
        
        m_bAutoSitdown = YES;
        m_fVolume = 1;
        m_fMusic = 1;
        m_bCheckVersion = YES;
        m_bClearCache = YES;
        m_idou = 20000;
        m_igetChipTimes = 2;
        m_iMsgCount = 0;
        level = 0;
        score = 0;
        match_score = 0;
        m_userInter = UIInterfaceOrientationMaskLandscape;
        m_bHasCheckVersion = NO;
        m_bIsOnGameInterface = NO;
        m_itask = 0;
        m_bHasFreshBounds = NO;
        m_bIsNeedSyncInfo = NO;
        m_igetChipTimes = 0;
        //self.gamedate = [NSDate date];
    }
    return self;
}

-(void)dealloc
{

    if (m_strUserImagePath)
    {
        [m_strUserImagePath release];
        m_strUserImagePath = nil;
    }
    if (m_strUserName) 
    {
        [m_strUserName release];
        m_strUserName = nil;
    }

    [super dealloc];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"m_bUserHasSitdown:%d,userID:%d,userName:%@,userImagePath:%@,userChips:%ld,userLevel:%d,userSex:%@,userBeans:%f",m_bUserHasSitdown,m_iUserID,m_strUserName,m_strUserImagePath,m_iUserChips,level,m_strSex,self.idou];
}

@end
