//
//  RJFDealGameMessage.h
//  Texas-pokes
//
//  Created by Ran Jingfu on 12/15/12.
//
//

#import <Foundation/Foundation.h>
#import "PublicDefine.h"

@protocol BNRDealWithGameMEssage <NSObject>
@optional
-(void)dealNotiForproREQ_REQ_GAME_PLAYER_DATAhandle:(void*)handle;
-(void)dealNotiForproREQ_GAME_SEND_ACTIONhandle:(void*)handle;
-(void)dealNotiForproREQ_GAME_SEND_SEAT_ACTIONhandle:(void*)handle;
-(void)dealNotiForproREQ_GAME_SEND_MSGhandle:(void*)handle;
-(void)dealNotiForproREQ_GAME_RECV_SEAT_DOWNhandle:(void*)handle;
-(void)dealNotiForproREQ_GAME_RECV_ACTIONhandle:(void*)handle;
-(void)dealNotiForproREQ_GAME_RECV_LEAVEhandle:(void*)handle;
-(void)dealNotiForREQ_GAME_RECV_CARDShandle:(void*)handle;
-(void)dealNotiForproREQ_GAME_RECV_WINNERhandle:(void*)handle;
-(void)dealNotiForproREQ_GAME_ENTER_ROOMhandle:(void*)handle;
-(void)dealNotiForproREQ_GAME_RECV_READYTIMEhandle:(void*)handle;
-(void)dealNotiForproREQ_GAME_RECV_START_INFORhandle:(void*)handle;
-(void)dealNotiForproREQ_GAME_ADD_CHIPShandle:(void*)handle;
-(void)dealNotiForproREQ_GAME_RECV_MSGhandle:(void*)handle;
-(void)dealNotiForproREQ_GAME_RECV_OUThandle:(void*)handle;
-(void)dealNotiForproREQ_PERSON_DATAhandle:(void*)handle;
-(void)dealNotiForproREQ_GET_BOUNDShandle:(void*)handle;
-(void)disConnectGameSocket:(id)Thread;
-(void)extuceMethod:(SEL)sel handle:(void*)handle;
@end
@interface RJFDealGameMessage : NSOperation
{
    id<BNRDealWithGameMEssage>    delegate;
    int32_t                       m_irequest;
    NSMutableData                 *m_data;
}
@property(assign)id<BNRDealWithGameMEssage> delegate;
@property(readwrite)int32_t         reqyestCode;
-(id)initWithData:(NSData*)data andDelegate:(id<BNRDealWithGameMEssage>)delegateMessage request:(int32_t)requestcode;



@end

