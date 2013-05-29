//
//  GamePlayer.h
//  Texas-pokes
//
//  Created by popo on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GamePlayer : NSObject
{
    NSString        *m_strUserName;
    int32_t         m_iUserID;
    NSString        *m_strUserImagePath;
    
    
    NSInteger       m_iUserChips;
    int32_t      m_iBringChip;

    
    NSInteger       m_iUserSex;
    NSInteger       m_iUserlevel;
    int32_t         m_iUserIdou;
    int32_t         m_iMaxCard[5];
    int8_t          m_iIDtype;
    int32_t         m_iMaxOwn;
    int32_t         m_iMaxWin;
    int8_t          m_iFirstCard;
    int8_t          m_iSecondCard;

    int8_t          m_iseatID;
    int32_t         m_iGiveChip;
    int32_t         m_iTotolBetChip;
}

@property(nonatomic,copy) NSString  *UserName;
@property(readwrite)int32_t UserId;
@property(nonatomic,copy) NSString  *UserImagePath;
@property(nonatomic,readwrite) NSInteger  userChip;
@property(nonatomic,readwrite) int32_t  bringChip;
@property(nonatomic,readwrite) NSInteger    userSex;
@property(nonatomic,readwrite) NSInteger    userLevel;
@property(nonatomic,readwrite) int32_t    userIdou;
@property(nonatomic,readwrite) int8_t     IDType;
@property(nonatomic,readwrite) int32_t     maxOwn;
@property(nonatomic,readwrite) int32_t     maxwin;
@property(nonatomic,readwrite) int8_t      firstCard;
@property(nonatomic,readwrite) int8_t      secondCard;
@property(nonatomic,readwrite) int8_t      seatID;
@property(nonatomic,readwrite) NSInteger   userState;
@property(readwrite)           int32_t     giveChip;
@property(readwrite)           int32_t     hadbetchip;



-(void)setMAxCard:(int32_t*)cardqrray;
@end
