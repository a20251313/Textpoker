//
//  GamePlayer.m
//  Texas-pokes
//
//  Created by popo on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GamePlayer.h"

@implementation GamePlayer
@synthesize userChip = m_iUserChips;
@synthesize UserName = m_strUserName;
@synthesize UserId = m_iUserID;
@synthesize UserImagePath = m_strUserImagePath;
@synthesize bringChip = m_iBringChip;
@synthesize userIdou = m_iUserIdou;
@synthesize userLevel = m_iUserlevel;
@synthesize userSex  = m_iUserSex;
@synthesize maxOwn = m_iMaxOwn;
@synthesize maxwin = m_iMaxWin;
@synthesize IDType = m_iIDtype;
@synthesize firstCard = m_iFirstCard;
@synthesize secondCard = m_iSecondCard;
@synthesize seatID = m_iseatID;
@synthesize userState;
@synthesize giveChip = m_iGiveChip;
@synthesize hadbetchip = m_iTotolBetChip;
/*!
 *  @author 
 *          jingfu Ran
 *  @since  
 *          2012 08 02
 *  @brief  
 *          override method init
 *	@return	
 *          id(self)
 *          
 */
-(id)init
{
    self = [super init];
    if (self) 
    {
        m_iUserID = 0;
        m_strUserName = @"";
        m_iUserChips = 0;
        m_strUserImagePath = @"Defaul.png";
        m_iBringChip = 0;
        m_iIDtype = -1;
        m_iMaxCard[0] = -1;
        m_iMaxCard[1] = -1;
        m_iMaxCard[2] = -1;
        m_iMaxCard[3] = -1;
        m_iMaxCard[4] = -1;
        m_iMaxOwn = 0;
        m_iMaxWin = 0;
        m_iUserIdou = 0;
        m_iUserlevel = -1;
        m_iUserSex = 0;
        m_iseatID = -1; //none;
        m_iGiveChip = 0;
        m_iTotolBetChip = 0;
        self.userState = 0;

    }
    return self;
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 07
 *  @brief
 *          override method description
 *	@return
 *          self description
 *
 */

-(NSString *)description
{
    return [NSString stringWithFormat:@"userID:%d name:%@, ID:%d, Chips:%d,userImagePath：%@ bringChip:%d firstCard:%d secondCard:%d",m_iUserID,m_strUserName,m_iUserID,m_iUserChips,m_strUserImagePath,m_iBringChip,m_iFirstCard,m_iSecondCard];
}

-(void)setMAxCard:(int32_t*)cardarray
{
    for (int i = 0; i < 5; i++)
    {
        m_iMaxCard[i] = cardarray[i];
    }
}
@end
