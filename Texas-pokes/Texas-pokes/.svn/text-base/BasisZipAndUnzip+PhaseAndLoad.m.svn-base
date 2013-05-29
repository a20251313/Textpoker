//
//  BasisZipAndUnzip+PhaseAndLoad.m
//  TestZip
//
//  Created by ran on 12-8-22.
//  Copyright (c) 2012年 ran. All rights reserved.
//

#import "BasisZipAndUnzip+PhaseAndLoad.h"

@implementation BasisZipAndUnzip (PhaseAndLoad)

-(void)sethead:(int32_t)userID requestID:(uint16_t)requestCode type:(uint)type
{
    if (!type)      //0 is DZOK protol   //1 is i366
    {
        [self HearStructInit:nil];
        m_pro_Header.requestCode = requestCode;
        m_pro_Header.userID = userID;
    }else
    {
        
    }
    
    
}
-(void)setTailwork:(uint8_t)type
{
    size_t  nowSize = 0;
    if(_data_size > CLIENT_UPLOAD_HEADERSIZE)
    {
        nowSize = _data_size;
    }else
    {
        nowSize = CLIENT_UPLOAD_HEADERSIZE;
    }
    [self setPakeageSize:nowSize];
    [self setPos:0];
    [self PushHeaderStructData:nil];
    [self setPos:nowSize];

    
}
-(int8_t *)syncWithRequest:(int16_t)requestCode
                    userID:(int32_t)userID
               structArray:(void*)handle
{
    
    [m_lock lock];
    [self clear];
    
    switch (requestCode)
    {
        case REQ_LOGIN:
            [self sethead:userID requestID:requestCode type:0];
            [self PushDZPK_CLIENT_REQ_LOGINData:(DZPK_CLIENT_REQ_LOGIN *)handle];
            [self setTailwork:0];
            break;
        case REQ_LOGIN_RESOURCES:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_LOGIN_RESOURCESInData:(DZPK_CLIENT_REQ_LOGIN_RESOURCES *)handle];
            [self setTailwork:0];
            break;
        case REQ_GAME_QUICK:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_GAME_QUICKRData:(DZPK_CLIENT_REQ_GAME_QUICK *)handle];
            [self setTailwork:0];
            break;
        case REQ_GAME_ROOM_LIST_NORMAL:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_GAME_ROOM_LIST_NORMALData:(DZPK_CLIENT_REQ_GAME_ROOM_LIST_NORMAL *)handle];
            [self setTailwork:0];
            break;
        case REQ_GAME_ENTER_ROOM:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_GAME_ENTER_ROOMData:(DZPK_CLIENT_REQ_GAME_ENTER_ROOM *)handle];
            [self setTailwork:0];
            break;
        case REQ_GAME_SEND_SEAT_ACTION:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_GAME_SEND_SEAT_ACTIONData:(DZPK_CLIENT_REQ_GAME_SEND_SEAT_ACTION*)handle];
            [self setTailwork:0];
            break;
        case REQ_GAME_SEND_MSG:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_GAME_SEND_MSGData:(DZPK_CLIENT_REQ_GAME_SEND_MSG*)handle];
            [self setTailwork:0];
            break;
        case REQ_GAME_SEND_ACTION:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_GAME_SEND_ACTIONData:(DZPK_CLIENT_REQ_GAME_SEND_ACTION*)handle];
            [self setTailwork:0];
            break;
        case REQ_GAME_TIMEOUT_BACK:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_GAME_TIMEOUT_BACKData:(DZPK_CLIENT_REQ_GAME_TIMEOUT_BACK*)handle];
            [self setTailwork:0];
            break;
        case REQ_GAME_ADD_CHIPS:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_GAME_ADD_CHIPSData:(DZPK_CLIENT_REQ_GAME_ADD_CHIPS*)handle];
            [self setTailwork:0];
            break;
        case REQ_GAME_SEARCH_ROOM:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_GAME_SEARCH_ROOMData:(DZPK_CLIENT_REQ_GAME_SEARCH_ROOM*)handle];
            [self setTailwork:0];
            break;
        case REQ_FEEDBACK:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_FEEDBACKData:(DZPK_CLIENT_REQ_FEEDBACK*)handle];
            [self setTailwork:0];
            break;
        case REQ_CONVERT:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_CONVERTData:(DZPK_CLIENT_REQ_CONVERT*)handle];
            [self setTailwork:0];
            break;
        case REQ_PERSON_DATA_ALTER:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_PERSON_DATA_ALTERData:(DZPK_CLIENT_REQ_PERSON_DATA_ALTER*)handle];
            [self setTailwork:0];
            break;
        case REQ_GAME_PLAYER_DATA:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_GAME_PLAYER_DATAData:handle];
            [self setTailwork:0];
            break;
        case REQ_GAME_RANKING:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_GAME_RANKINGData:handle];
            [self setTailwork:0];
            break;
        case REQ_GET_BONUDS:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_GET_BONUDSData:handle];
            [self setTailwork:0];
            break;
        case REQ_SHARE_CONTENT:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_SHARE_CONTENTData:handle];
            [self setTailwork:0];
            break;
        case REQ_GAME_USE_GIFT:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_GAME_USE_GIFTData:handle];
            [self setTailwork:0];
            break;
        case REQ_SHARE_BONUS:
            [self sethead:userID requestID:requestCode type:0];
            [self PushREQ_SHARE_BOUNDData:handle];
            [self setTailwork:0];
            break;
        case REQ_GAME_RECV_OUT:
        case REQ_GAME_QUICK_SERVER:
        case REQ_GAME_ROOM_LIST_MATCH:
        case REQ_GAME_RECV_ACTION:
        case REQ_GAME_RECV_LEAVE:
        case REQ_GAME_RECV_SEAT_DOWN:
        case REQ_GAME_RECV_WINNER:
        case REQ_GAME_RECV_READYTIME:
        case REQ_GAME_RECV_START_INFOR:
        case REQ_GAME_RECV_MSG:
        case REQ_GAME_CONNECT_AGAIN:
        case REQ_RECV_NEW_MSG:
        case REQ_RECV_GET_MSG:
        case REQ_RECOMMENDATION:
        case REQ_SYNC_SIGNAL_RESOURCE:
        case REQ_SYNC_SIGNAL_GAME:
        case REQ_OFFLINE:
        case REQ_GET_CHIPS:
        case REQ_PERSON_DATA_HEAD_NAME:
        case REQ_PERSON_DATA:
        case REQ_VERSION:
        case REQ_GET_TASK:
        case REQ_BASIC_INFOR:
        case REQ_GET_COUNTDOWN_HONUS:
            [self sethead:userID requestID:requestCode type:0];
            [self setTailwork:0];;
            break;
            
            //i366begin
        case REQ_LOGIN_BY_QQ_EMAIL:
            [self PushREQ_LOGIN_BY_QQ_EMAILData:(DZPK_CLIENT_REQ_LOGIN_BY_QQ_EMAIL*)handle];
            [self i366PushHeadStruct:_data_size request:requestCode];
            [self setPos:_data_size];
            break;
        case REQ_GET_BACK_PWD:
            [self PushREQ_GET_BACK_PWDLData:(DZPK_CLIENT_REQ_GET_BACK_PWD*)handle];
            [self i366PushHeadStruct:_data_size request:requestCode];
            [self setPos:_data_size];
            break;
        case REQ_GET_CHANGE_PWD:
            [self PushREQ_GET_CHANGE_PWDLData:(DZPK_CLIENT_REQ_GET_CHANGE_PWD*)handle];
            [self i366PushHeadStruct:_data_size request:requestCode];
            [self setPos:_data_size];
            break;
        case REQ_GET_CHARGE:
            [self PushREQ_GET_CHARGELData:(DZPK_CLIENT_REQ_GET_CHARGE*)handle];
            [self i366PushHeadStruct:_data_size request:requestCode];
            [self setPos:_data_size];
            break;
        case REQ_READ_CHARGE_RESULT:
            [self PushREQ_CHARGE_RESULTData:(DZPK_CLIENT_REQ_CHARGE_RESULT*)handle];
            [self i366PushHeadStruct:_data_size request:requestCode];
            [self setPos:_data_size];
            break;
        case REQ_USER_BING_AGAIN:
            [self PushREQ_USER_BING_AGAINData:(DZPK_CLIENT_REQ_USER_BING_AGAIN*)handle];
            [self i366PushHeadStruct:_data_size request:requestCode];
            [self setPos:_data_size];
            break;
        case REQ_USER_CONNECT_RECORD:
            [self PushREQ_USER_CONNECT_RECORDData:(DZPK_CLIENT_REQ_USER_CONNECT_RECORD*)handle];
            [self i366PushHeadStruct:_data_size request:requestCode];
            [self setPos:_data_size];
            break;
        case REQ_ORDER_SUCCESS:
            [self PushREQ_ORDER_SUCCESSData:(DZPK_CLIENT_REQ_ORDER_SUCCESS*)handle];
            [self i366PushHeadStruct:_data_size request:requestCode];
            [self setPos:_data_size];
            break;
        case YEE_PAY_CHARGE_RESULT:
            [self PushYEE_PAY_CHARGE_RESULTEData:(DZPK_CLIENT_YEE_PAY_CHARGE_RESULT*)handle];
            [self i366PushHeadStruct:_data_size request:requestCode];
            [self setPos:_data_size];
            break;
        case REQ_CHARGE_RESULT:
            [self PushREQ_CHARGE_RESULTData:(DZPK_CLIENT_REQ_CHARGE_RESULT*)handle];

            [self i366PushHeadStruct:_data_size request:requestCode];
            [self setPos:_data_size];
            break;
        case REQ_CHARGE_FOR_IPHONE:
            [self PushREQ_CHARGE_FOR_IPHONEData:(DZPK_CLIENT_REQ_CHARGE_FOR_IPHONE *)handle];
            [self i366PushHeadStruct:_data_size request:requestCode];
            [self setPos:_data_size];
            break;
        case REQ_CHANGE_PWD_BY_EMAIL:
            [self PushREQ_CHANGE_PWD_BY_EMAILData:handle];
            [self i366PushHeadStruct:_data_size request:requestCode];
            [self setPos:_data_size];
            break;
        case REQ_GET_CHARGE_FORDOWNJOY:
            [self PushREQ_GET_CHARGE_FORDOWNJOYData:handle];
            [self i366PushHeadStruct:_data_size request:requestCode];
            [self setPos:_data_size];
            break;
        default:
            break;
    }
    
    
    
    [m_lock unlock];
    return _data;
}

-(void *)PhaseInfoFromData:(int8_t *)data  outRequestCode:(int*)outReqiestCode
{
    
    //[self clear];
    size_t pos = 7;
    if (data[0] == 'P')
    {
        pos = 8;
    }
    size_t  size = [self unbyte_to_int16:data pos:pos];
    m_realSize = size;
    [self setPos:0];
    [self pushData:data size:_size-1];
    int16_t   numberCount = 0;
    size_t    headSize = 0;
    
    if ([self isI366ProtolOrDZPKprotol] == 0)
    {
        if (![self getHeadFromDownloadData:nil])
        {
            return NULL;
        }
        *outReqiestCode = [self GetRequestCodeFromDownHear];
        numberCount = [self getItemNumberForDownLoad];
        headSize = [self GetHeadSizeFromDownLoadHead];
        [self setPos:headSize];
        //  NSLog(@"1111111111");
        
    }else if(1 == [self isI366ProtolOrDZPKprotol])
    {
        I366_CLIENT_RECEIVED_PCHC_HEADER  server = [self i366GetHeadFromDownServer];
        *outReqiestCode = server.requestCode;
        headSize = server.headSize;
        [self setPos:headSize];
        numberCount = [self getInt8Accordpos:headSize];
    }
    
    void *returnhandle = NULL;
    if (!numberCount)
    {
        return returnhandle;
    }else
    {
        switch (*outReqiestCode)
        {
            case REQ_LOGIN:
                returnhandle  = [self PullREQ_LOGIN];
                break;
            case REQ_LOGIN_RESOURCES:
                returnhandle  = [self PullREQ_LOGIN_RESOURCES];
                break;
            case REQ_GAME_QUICK_SERVER:
                returnhandle  = [self PullREQ_GAME_QUICK_SERVER];
                break;
            case REQ_GAME_QUICK:
                returnhandle  = [self PullREQ_GAME_QUICK];
                break;
            case REQ_GAME_ROOM_LIST_MATCH:
                returnhandle  = [self PullREQ_GAME_ROOM_LIST_MATCH];
                break;
            case REQ_GAME_ROOM_LIST_NORMAL:
                returnhandle  = [self PullREQ_GAME_ROOM_LIST_NORMAL];
                break;
            case REQ_GAME_ENTER_ROOM:
                returnhandle  = [self PullREQ_GAME_ENTER_ROOM];
                break;
            case REQ_GAME_SEND_SEAT_ACTION:
                returnhandle  = [self PullREQ_GAME_SEND_SEAT_ACTION];
                break;
            case REQ_GAME_SEND_MSG:
                returnhandle  = [self PullREQ_GAME_SEND_MSG];
                break;
            case REQ_GAME_SEND_ACTION:
                returnhandle  = [self PullREQ_GAME_SEND_ACTION];
                break;
            case REQ_GAME_RECV_ACTION:
                returnhandle  = [self PullREQ_GAME_RECV_ACTION];
                break;
            case REQ_GAME_RECV_LEAVE:
                returnhandle  = [self PullREQ_GAME_RECV_LEAVE];
                break;
            case REQ_GAME_RECV_WINNER:
                returnhandle  = [self PullREQ_GAME_RECV_WINNERS];
                break;
            case REQ_GAME_TIMEOUT_BACK:
                returnhandle  = [self PullREQ_GAME_TIMEOUT_BACKS];
                break;
            case REQ_GAME_RECV_READYTIME:
                returnhandle  = [self PullREQ_GAME_RECV_READYTIME];
                break;
            case REQ_GAME_RECV_START_INFOR:
                returnhandle  = [self PullREQ_GAME_RECV_START_INFORE];
                break;
            case REQ_GAME_ADD_CHIPS:
                returnhandle  = [self PullREQ_GAME_ADD_CHIPSE];
                break;
            case REQ_GAME_RECV_MSG:
                returnhandle  = [self PullREQ_GAME_RECV_MSG];
                break;
            case REQ_GAME_CONNECT_AGAIN:
                returnhandle  = [self PullREQ_GAME_CONNECT_AGAIN];
                break;
            case REQ_GAME_SEARCH_ROOM:
                returnhandle  = [self PullREQ_GAME_SEARCH_ROOM];
                break;
            case REQ_RECV_NEW_MSG:
                returnhandle  = [self PullREQ_RECV_NEW_MSG];
                break;
            case REQ_RECV_GET_MSG:
                returnhandle  = [self PullREQ_RECV_GET_MSGG];
                break;
            case REQ_GAME_RANKING:
                returnhandle  = [self PullREQ_GAME_RANKINGG];
                break;
            case REQ_RECOMMENDATION:
                returnhandle  = [self PullREQ_RECOMMENDATIONG];
                break;
            case REQ_SHARE_CONTENT:
                returnhandle  = [self PullREQ_SHARE_CONTENT];
                break;
            case REQ_SYNC_SIGNAL_RESOURCE:
                returnhandle = [self PullREQ_SYNC_SIGNAL_RESOURCE];
                break;
            case REQ_SYNC_SIGNAL_GAME:
                break;
            case REQ_FEEDBACK:
                returnhandle  = [self PullREQ_FEEDBACKS];
                break;
            case REQ_CONVERT:
                returnhandle  = [self PullREQ_CONVERTS];
                break;
            case REQ_PERSON_DATA_HEAD_NAME:
                returnhandle  = [self PullREQ_PERSON_DATA_HEAD_NAME];
                break;
            case REQ_PERSON_DATA_ALTER:
                returnhandle  = [self PullREQ_PERSON_DATA_ALTER];
                break;
            case REQ_PERSON_DATA:
                returnhandle  = [self PullREQ_PERSON_DATA];
                break;
            case REQ_GET_CHIPS:
                returnhandle  = [self PullREQ_GET_CHIPS];
                break;
            case REQ_GAME_RECV_OUT:
                returnhandle = [self PullREQ_GAME_RECV_OUT];
                break;
            case REQ_GAME_RECV_SEAT_DOWN:
                returnhandle = [self PullREQ_GAME_RECV_SEAT_DOWN];
                break;
            case REQ_GAME_RECV_CARDS:
                returnhandle = [self PullREQ_GAME_RECV_CARDS];
                break;
            case REQ_OFFLINE:
                returnhandle = [self PullREQ_OFFLINE];
                break;
            case REQ_VERSION:
                returnhandle = [self PullREQ_VERSION];
                break;
            case REQ_GAME_PLAYER_DATA:
                returnhandle = [self PullREQ_GAME_PLAYER_DATA];
                break;
            case REQ_GET_TASK:
                 returnhandle = [self PullREQ_GET_TASK];
                break;
            case REQ_GET_BONUDS:
                returnhandle = [self PullREQ_GET_BONUDS];
                break;
            case REQ_BASIC_INFOR:
                returnhandle = [self PullREQ_BASIC_INFOR];
                break;
            case REQ_GET_ACTIVITY:
                returnhandle = [self PullREQ_GET_ACTIVITY];
                break;
            case REQ_GET_ACTIVITY_HONUS:
                returnhandle = [self PullREQ_GET_ACTIVITY_HOUNS];
                break;
            case REQ_REALTIME_INFOR:
                returnhandle = [self PullREQ_REALTIME_INFOR];
                break;
            case REQ_GET_COUNTDOWN_HONUS:
                returnhandle = [self PullREQ_GET_COUNTDOWN_HONUS];
                break;
            case REQ_GAME_USE_GIFT:
                returnhandle = [self PullREQ_GAME_USE_GIFT];
                break;
            case REQ_SHARE_BONUS:
                returnhandle = [self PullREQ_SHARE_BOUND];
                break;
                //i366 begin
            case REQ_LOGIN_BY_QQ_EMAIL:
                returnhandle = [self PullREQ_LOGIN_BY_QQ_EMAIL];
                break;
            case REQ_GET_BACK_PWD:
                returnhandle = [self PullREQ_GET_BACK_PWD];
                break;
            case REQ_GET_CHANGE_PWD:
                returnhandle = [self PullREQ_GET_CHANGE_PWD];
                break;
            case REQ_GET_CHARGE:
                returnhandle = [self PullREQ_GET_CHARGE];
                break;
            case REQ_READ_CHARGE_RESULT:
                returnhandle = [self PullREQ_READ_CHARGE_RESULT];
                break;
            case REQ_USER_BING_AGAIN:
                returnhandle = [self PullREQ_USER_BING_AGAIN];
                break;
            case REQ_USER_CONNECT_RECORD:
                returnhandle = [self PullREQ_USER_CONNECT_RECORD];
                break;
            case REQ_ORDER_SUCCESS:
                returnhandle = [self PullREQ_ORDER_SUCCESS];
                break;
            case REQ_CHARGE_FOR_IPHONE:
                returnhandle = [self PullREQ_CHARGE_FOR_IPHONE];
                break;
            case YEE_PAY_CHARGE_RESULT:
                returnhandle = [self PullYEE_PAY_CHARGE_RESULT];
                break;
            case REQ_CHARGE_RESULT:
                returnhandle = [self PullREQ_CHARGE_RESULT];
                break;
            case REQ_CHANGE_PWD_BY_EMAIL:
                returnhandle = [self PullREQ_CHANGE_PWD_BY_EMAIL];
                break;
            case REQ_GET_CHARGE_FORDOWNJOY:
                returnhandle = [self PullREQ_GET_CHARGE_FORDOWNJOYE];
                //i366 end
            default:
                break;
        }
    }
    
    //NSLog(@"222222  %p",returnhandle);
    return returnhandle;
}
@end
