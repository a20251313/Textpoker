//
//  BasisZipAndUnzip+itemFirst.h
//  TestZip
//
//  Created by ran on 12-8-17.
//  Copyright (c) 2012年 ran. All rights reserved.
//

#import "BasisZipAndUnzip.h"

@interface BasisZipAndUnzip (itemFirst)


-(void)pushItemID:(int)itemID Content:(int)Content;
-(void)pushItemIDForBig:(int)itemID Content:(int32_t)Content;
-(void)pushItemIDForString:(int)itemID Content:(NSString *)Content;
-(void)pushItemIDForArray:(int)itemID Content:(int32_t*)Content count:(int)count;

-(int16_t)getInt16AccordItem:(int)itemID;
-(int16_t)getInt16AccordItem:(int)itemID  pos:(size_t)pos;
-(int32_t)getInt32AccordItem:(int)itemID;
-(int32_t)getInt32AccordItem:(int)itemID  pos:(size_t)pos;
-(NSString *)getStringAccordItem:(int)itemID;
-(NSString *)getStringAccordItem:(int)itemID  pos:(size_t)pos;
-(int8_t)getInt8AccordItem:(int)itemID;
-(int8_t)getInt8AccordItem:(int)itemID pos:(size_t)pos;
-(int32_t *)getArrayAccordItem:(int)itemID count:(int *)count;
-(int32_t *)getArrayAccordItem:(int)itemID count:(int *)count pos:(size_t)pos;
-(int8_t *)getArrayofint8AccordItem:(int)itemID count:(int *)count;;
-(int8_t *)getArrayOfint8AccordItem:(int)itemID count:(int *)count pos:(size_t)pos;




//
-(void)PushDZPK_CLIENT_REQ_LOGINData:(DZPK_CLIENT_REQ_LOGIN *)arr;
//-(int)PullDZPK_SERVER_REQ_LOGIN_InData:(DZPK_SERVER_REQ_LOGIN *)arr;
-(DZPK_SERVER_REQ_LOGIN *)PullREQ_LOGIN;




-(void)PushREQ_LOGIN_RESOURCESInData:(DZPK_CLIENT_REQ_LOGIN_RESOURCES *)arr;
-(DZPK_SERVER_REQ_LOGIN_RESOURCES *)PullREQ_LOGIN_RESOURCES;
-(void)PushREQ_LOGIN_BY_QQ_EMAILData:(DZPK_CLIENT_REQ_LOGIN_BY_QQ_EMAIL *)arr;
-(DZPK_SERVER_REQ_LOGIN_BY_QQ_EMAIL *)PullREQ_LOGIN_BY_QQ_EMAIL;
-(void)PushREQ_GET_BACK_PWDLData:(DZPK_CLIENT_REQ_GET_BACK_PWD *)arr;
-(DZPK_SERVER_REQ_GET_BACK_PWD *)PullREQ_GET_BACK_PWD;
-(void)PushREQ_GET_CHANGE_PWDLData:(DZPK_CLIENT_REQ_GET_CHANGE_PWD *)arr;
-(DZPK_SERVER_REQ_GET_CHANGE_PWD *)PullREQ_GET_CHANGE_PWD;
-(void)PushREQ_GET_CHARGELData:(DZPK_CLIENT_REQ_GET_CHARGE *)arr;
-(DZPK_SERVER_REQ_GET_CHARGE *)PullREQ_GET_CHARGE;
-(DZPK_SERVER_REQ_READ_CHARGE_RESULT *)PullREQ_READ_CHARGE_RESULT;
-(void)PushREQ_USER_BING_AGAINData:(DZPK_CLIENT_REQ_USER_BING_AGAIN *)arr;
-(DZPK_SERVER_REQ_USER_BING_AGAIN *)PullREQ_USER_BING_AGAIN;
-(void)PushREQ_USER_CONNECT_RECORDData:(DZPK_CLIENT_REQ_USER_CONNECT_RECORD *)arr;
-(DZPK_SERVER_REQ_USER_CONNECT_RECORD *)PullREQ_USER_CONNECT_RECORD;
-(void)PushREQ_ORDER_SUCCESSData:(DZPK_CLIENT_REQ_ORDER_SUCCESS *)arr;
-(DZPK_SERVER_REQ_ORDER_SUCCESS *)PullREQ_ORDER_SUCCESS;
-(void)PushREQ_CHARGE_FOR_IPHONEData:(DZPK_CLIENT_REQ_CHARGE_FOR_IPHONE *)arr;
-(DZPK_SERVER_REQ_CHARGE_FOR_IPHONE *)PullREQ_CHARGE_FOR_IPHONE;
-(void)PushYEE_PAY_CHARGE_RESULTEData:(DZPK_CLIENT_YEE_PAY_CHARGE_RESULT *)arr;
-(DZPK_SERVER_YEE_PAY_CHARGE_RESULT *)PullYEE_PAY_CHARGE_RESULT;
-(void)PushREQ_CHARGE_RESULTData:(DZPK_CLIENT_REQ_CHARGE_RESULT *)arr;
-(DZPK_SERVER_REQ_CHARGE_RESULT *)PullREQ_CHARGE_RESULT;
-(DZPK_SERVER_REQ_CHANGE_PWD_BY_EMAIL *)PullREQ_CHANGE_PWD_BY_EMAIL;
-(void)PushREQ_CHANGE_PWD_BY_EMAILData:(DZPK_CLIENT_REQ_CHANGE_PWD_BY_EMAIL *)arr;
-(DZPK_SERVER_REQ_VERSION *)PullREQ_VERSION;


//REQ_GET_CHARGE_FORDOWNJOY  (210)
-(DZPK_SERVER_REQ_GET_CHARGE_FORDOWNJOY *)PullREQ_GET_CHARGE_FORDOWNJOYE;
-(void)PushREQ_GET_CHARGE_FORDOWNJOYData:(DZPK_CLIENT_REQ_GET_CHARGE_FORDOWNJOY *)arr;
-(DZPK_SERVER_REQ_BASIC_INFOR *)PullREQ_BASIC_INFOR;

@end
