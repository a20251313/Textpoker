//
//  BasisZipAndUnzip+itemFirst.m
//  TestZip
//
//  Created by ran on 12-8-17.
//  Copyright (c) 2012年 ran. All rights reserved.
//

#import "BasisZipAndUnzip+loginAndcharge.h"

@implementation BasisZipAndUnzip (itemFirst)

#pragma mark get and push method




-(void)pushItemID:(int)itemID Content:(int)Content
{

    if (itemID < 128)
    {
        [self pushByte:itemID];
        [self pushByte:Content];
    }
     //[self pushInt32:(int32_t)Content];
}
-(void)pushItemIDForBig:(int)itemID Content:(int32_t)Content
{
    [self pushByte:itemID];
    
    //int item = [self getInt16Accordpos:_data_size-2];
    [self pushInt16:sizeof(int32_t)];
    [self pushInt32:Content];
}

-(void)pushItemIDForArray:(int)itemID Content:(int32_t*)Content count:(int)count
{
    [self pushByte:itemID];
    [self pushInt16:count];
    for (int i = 0; i < count; i++)
    {
        [self pushInt32:Content[i]];
    }
}

-(void)pushItemIDForString:(int)itemID Content:(NSString *)Content
{
    [self pushByte:itemID];
    
    int8_t  *arr = [self stringToInt_8:Content];
    int length = uni_strlen((char *)arr);
    [self pushInt16:length];
    [self pushData:arr size:length];
    
}

-(int16_t)getInt16AccordItem:(int)itemID
{
    //_data_size = _data_size+1;
    uint8_t item = [self getItemID];
    if (item != itemID)
    {
        NSLog(@"itemID not equal");
    }
    return [self getInt16];
}
-(int16_t)getInt16AccordItem:(int)itemID  pos:(size_t)pos
{
    
    uint8_t item = [self getItemIDAccordPos:pos++];
    if (item != itemID)
    {
        NSLog(@"itemID not equal");
    }
   // pos = pos+1;
    return [self getInt16Accordpos:pos];
}


-(int8_t)getInt8AccordItem:(int)itemID
{

    int item = [self getItemID];

    if (item != itemID)
    {
        NSLog(@"itemID not equal");
    }
    return [self getInt8];
}

-(int8_t)getInt8AccordItem:(int)itemID pos:(size_t)pos
{
    int item = [self getItemIDAccordPos:pos++];
    if (item != itemID)
    {
        NSLog(@"itemID not equal");
    }
    return [self getInt8Accordpos:pos];
}

-(int32_t *)getArrayAccordItem:(int)itemID count:(int *)count;
{
    int item = [self getItemID];

    if (item != itemID)
    {
        NSLog(@"itemID not equal");
    }
    *count = [self getInt16];
    *count = *count/sizeof(int32_t);
    int32_t  *arr = NULL;
    if (*count <= 0)
    {
        arr =  malloc(sizeof(int32_t)*8);
        while (arr == NULL)
        {
            arr = malloc(sizeof(int32_t)*8);
        }
    }else
    {
        arr =  malloc(sizeof(int32_t)**count);
        while (arr == NULL)
        {
            arr = malloc(sizeof(int32_t)**count);
        }

    }

    if (*count <= 0)
    {
        for (int i = 0; i < 8; i++)
        {
            arr[i] = -1;
        }
    }else if(*count > 0)
    {
        for (int i = 0; i < *count; i++)
        {
            arr[i] = [self getInt32];
        }
    }
   
   
    return arr;
}




-(int8_t *)getArrayofint8AccordItem:(int)itemID count:(int *)count;
{
    int item = [self getItemID];

    if (item != itemID)
    {
        NSLog(@"itemID not equal");
    }
    *count = [self getInt16];
    *count = *count/sizeof(int8_t);
    int8_t  *arr = NULL;
    if (*count <= 0)
    {
        arr =  malloc(sizeof(int8_t)*8);
        while (arr == NULL)
        {
            arr = malloc(sizeof(int8_t)*8);
        }
    }else
    {
        arr =  malloc(sizeof(int8_t)**count);
        while (arr == NULL)
        {
            arr = malloc(sizeof(int8_t)**count);
        }
        
    }
    if (*count <= 0)
    {
        for (int i = 0; i < 8; i++)
        {
            arr[i] = -1;
        }
    }else if(*count > 0)
    {
        for (int i = 0; i < *count; i++)
        {
            arr[i] = [self getInt8];
        }
    }

    return arr;
}


-(int32_t *)getArrayAccordItem:(int)itemID count:(int *)count pos:(size_t)pos
{
    int item = [self getItemIDAccordPos:pos++];
    if (item != itemID)
    {
        NSLog(@"itemID not equal");
    }
    *count = [self getInt16Accordpos:pos];
    pos += 2;
    *count = *count/sizeof(int32_t);
    int32_t  *arr = NULL;
    if (*count <= 0)
    {
        arr =  malloc(sizeof(int32_t)*8);
        while (arr == NULL)
        {
            arr = malloc(sizeof(int32_t)*8);
        }
    }else
    {
        arr =  malloc(sizeof(int32_t)**count);
        while (arr == NULL)
        {
            arr = malloc(sizeof(int32_t)**count);
        }
        
    }
     memset(arr, '\0', sizeof(int32_t)**count);
     NSLog(@"xiexie");
    if (*count <= 0)
    {
        for (int i = 0; i < *count; i++)
        {
            arr[i] = -1;
            pos += 4;
        }
        
    }else
    {
        for (int i = 0; i < *count; i++)
        {
            arr[i] = [self unbyte_to_int32:_data pos:pos];
            pos += 4;
        }
    }

  
    return arr;
}

-(int8_t *)getArrayOfint8AccordItem:(int)itemID count:(int *)count pos:(size_t)pos
{
    int item = [self getItemIDAccordPos:pos++];
    if (item != itemID)
    {
        NSLog(@"itemID not equal");
    }
    *count = [self getInt16Accordpos:pos];
    pos += 2;
    *count = *count/sizeof(int8_t);
    int8_t  *arr = NULL;
    if (*count <= 0)
    {
        arr =  malloc(sizeof(int8_t)*8);
        while (arr == NULL)
        {
            arr = malloc(sizeof(int8_t)*8);
        }
    }else
    {
        arr =  malloc(sizeof(int8_t)**count);
        while (arr == NULL)
        {
            arr = malloc(sizeof(int8_t)**count);
        }
        
    }
    
    if (*count <= 0)
    {
        for (int i = 0; i < *count; i++)
        {
            arr[i] = -1;
            pos++;
        }
        
        
    }else
    {
        for (int i = 0; i < *count; i++)
        {
            arr[i] = [self getInt8Accordpos:pos];
            pos++;
        }
    }
   
    return arr;
}




-(int32_t)getInt32AccordItem:(int)itemID
{
    int16_t item = [self getItemID];
    if (item != itemID)
    {
        NSLog(@"item:%d itemID:%d itemID not equal",item,itemID);
    }
    _data_size +=2;
    return [self getInt32];
}



-(int32_t)getInt32AccordItem:(int)itemID  pos:(size_t)pos
{
    int item = [self getItemIDAccordPos:pos++];
    
    if (item != itemID)
    {
        NSLog(@"itemID not equal");
    }
    pos += 2;
    return [self unbyte_to_int32:_data pos:pos];
}

-(NSString *)getStringAccordItem:(int)itemID 
{
  
    int item = [self getItemID];
    if (item != itemID)
    {
        NSLog(@"itemID not equal");
    }
    int16_t  length = [self getInt16];
    return [self getStringAccordSize:length];
}

-(NSString *)getStringAccordItem:(int)itemID  pos:(size_t)pos
{
    int item = [self getItemIDAccordPos:pos++];
    if (item != itemID)
    {
        NSLog(@"itemID not equal");
    }
  
    int32_t  length = [self getInt16Accordpos:pos];
    
    return  [self getStringAccordSize:length pos:pos+2 outdata:nil];
}




#pragma mark protol imeplment method (login,regiest,getback,pwd charge)

//REQ_LOGIN（1）				
-(void)PushDZPK_CLIENT_REQ_LOGINData:(DZPK_CLIENT_REQ_LOGIN *)arr
{
    

    int icount = 7;
    [self setItemNumberCountForUpdoad:icount];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_LOGIN  client = *(arr+i);
        [self pushItemID:60 Content:client.user_type];
        [self pushItemIDForString:131 Content:client.userUUID];
        [self pushItemIDForString:132 Content:client.macAddress];
        [self pushItemIDForString:133 Content:client.imsi];
        [self pushItemIDForString:134 Content:client.HeighthAndWidth];
        [self pushItemIDForString:135 Content:client.model];
        [self pushItemIDForString:136 Content:client.system_version];
        [self pushItemIDForString:137 Content:client.sessionKey];
    }


}


-(DZPK_SERVER_REQ_LOGIN *)PullREQ_LOGIN
{
   //  NSLog(@"333333333333");
    int32_t   number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_LOGIN  *arr = malloc(sizeof(DZPK_SERVER_REQ_LOGIN));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_LOGIN));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_LOGIN));
    int  i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].status =  [self getInt8AccordItem:60];
                break;
            case 61:
                arr[i].user_type = [self getInt8AccordItem:61];
                break;
            case 62:
                arr[i].isfirstLogin = [self getInt8AccordItem:62];
                break;
            case 134:
                 arr[i].server_number = [self getInt32AccordItem:134];
                break;
            case 133:
                 arr[i].port = [self getInt32AccordItem:133];
                break;
            case 130:
                arr[i].IP = [self getStringAccordItem:130];
                break;
            case 131:
                arr[i].key = [self getStringAccordItem:131];
                break;
            case 132:
                arr[i].user_id = [self getInt32AccordItem:132];
                break;
            default:
                break;
        }
        
    }
   //  NSLog(@"4444444");
    return arr;
}


//REQ_LOGIN_RESOURCES（2）

-(void)PushREQ_LOGIN_RESOURCESInData:(DZPK_CLIENT_REQ_LOGIN_RESOURCES *)arr
{
    [self setItemNumberCountForUpdoad:1];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_LOGIN_RESOURCES  client = *(arr+i);
        [self pushItemIDForString:130 Content:client.key];
    }

}

-(DZPK_SERVER_REQ_LOGIN_RESOURCES *)PullREQ_LOGIN_RESOURCES
{
  //  NSLog(@"333333333333");
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    NSLog(@"item:%d value:%d",_data[29],_data[30]);
    DZPK_SERVER_REQ_LOGIN_RESOURCES  *arr = malloc(sizeof(DZPK_SERVER_REQ_LOGIN_RESOURCES));
//    NSLog(@"size:%ld",sizeof(DZPK_SERVER_REQ_LOGIN_RESOURCES));
    while(arr == NULL)
    {
        
        arr = malloc(sizeof(DZPK_SERVER_REQ_LOGIN_RESOURCES));
    }
   memset(arr, '\0', sizeof(DZPK_SERVER_REQ_LOGIN_RESOURCES));
  //  NSLog(@"hehe");
    //int count = 0;
    int  i = 0;
    arr[i].maxcardNumber = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        // NSLog(@"%d int number:%d itemID:%d %p",jCount,int number,[self getItemIDAccordPos:_data_size],number);
        switch ([self getItemIDAccordPos:_data_size])
        {
            
            case 60:
                arr[i].status =  [self getInt8AccordItem:60];
                break;
            case 61:
                arr[i].sex = [self getInt8AccordItem:61];
                break;
            case 63:
                arr[i].level = [self getInt8AccordItem:63];
                break;
            case 64:
                arr[i].task = [self getInt8AccordItem:64];
                break;
            case 62:
                arr[i].msg_count = [self getInt8AccordItem:62];
                break;
            case 130:
                 arr[i].nick = [self getStringAccordItem:130];
                break;
            case 131:
                 arr[i].head_picName = [self getStringAccordItem:131];
                break;
            case 132:
                 arr[i].maxcards = [self getArrayofint8AccordItem:132 count:&arr[i].maxcardNumber];
                break;
            case 133:
               arr[i].maxwin = [self getInt32AccordItem:133];
                break;
            case 134:
                arr[i].gold = [self getInt32AccordItem:134];
                break;
            case 135:
               arr[i].idou = [self getInt32AccordItem:135];
                break;
            case 136:
                arr[i].lose_number = [self getInt32AccordItem:136];
                break;
            case 137:
                arr[i].win_number = [self getInt32AccordItem:137];
                break;
            case 138:
                arr[i].max_own = [self getInt32AccordItem:138];
                break;
            case 139:
                arr[i].online_count = [self getInt32AccordItem:139];
                break;
            case 141:
                arr[i].fileServerIP = [self getStringAccordItem:141];
                break;
            case 140:
                arr[i].fileServerPort = [self getInt32AccordItem:140];
                break;
            case 142:
                arr[i].score = [self getInt32AccordItem:142];
                break;
            case 143:
                arr[i].match_score = [self getInt32AccordItem:143];
                break;
            case 144:
                arr[i].bounds = [self getArrayofint8AccordItem:144 count:&arr[i].boundsNumber];
                break;
               
            default:
                break;
        }
        // NSLog(@"%d int number:%d itemID:%d",jCount,int number,[self getItemIDAccordPos:_data_size]);
    }
     NSLog(@"task:%d",arr[i].task);
    return arr;
}

//REQ_LOGIN_BY_QQ_EMAIL(140)
-(void)PushREQ_LOGIN_BY_QQ_EMAILData:(DZPK_CLIENT_REQ_LOGIN_BY_QQ_EMAIL *)arr
{
    if ([arr->QQNumber isEqualToString:@""])
    {
       [self setItemNumberCountForUpdoad:5];
    }else
    {
        [self setItemNumberCountForUpdoad:6]; 
    }
    
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_LOGIN_BY_QQ_EMAIL  client = *(arr+i);
        [self pushItemID:61 Content:client.login_type];
        if (![client.QQNumber isEqualToString:@""])
        {
           [self pushItemIDForString:140 Content:client.QQNumber]; 
        }
        
        [self pushItemIDForString:141 Content:client.emailaddr];
        [self pushItemIDForString:142 Content:client.pwd];
        [self pushItemIDForString:143 Content:client.imei];
        [self pushItemIDForBig:144 Content:client.versionID];
    }
    
}

-(DZPK_SERVER_REQ_LOGIN_BY_QQ_EMAIL *)PullREQ_LOGIN_BY_QQ_EMAIL
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_LOGIN_BY_QQ_EMAIL  *arr = malloc(sizeof(DZPK_SERVER_REQ_LOGIN_BY_QQ_EMAIL));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_LOGIN_BY_QQ_EMAIL));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_LOGIN_BY_QQ_EMAIL));
    int  i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        NSLog(@"itemID:%d",[self getInt16Accordpos:_data_size]);
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].status =  [self getInt8AccordItem:60];
                break;
            case 160:
                arr[i].userID = [self getInt32AccordItem:160];
                break;
            default:
                break;
        }
        
    }
    return arr;
}


//REQ_GET_BACK_PWD(141)
-(void)PushREQ_GET_BACK_PWDLData:(DZPK_CLIENT_REQ_GET_BACK_PWD *)arr
{
    [self setItemNumberCountForUpdoad:3];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_GET_BACK_PWD  client = *(arr+i);
        [self pushItemID:61 Content:client.iType];
        [self pushItemIDForString:140 Content:client.QQNumber];
        [self pushItemIDForString:141 Content:client.emaliaddr];
    }
    
}

-(DZPK_SERVER_REQ_GET_BACK_PWD *)PullREQ_GET_BACK_PWD
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GET_BACK_PWD  *arr = malloc(sizeof(DZPK_SERVER_REQ_GET_BACK_PWD));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GET_BACK_PWD));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GET_BACK_PWD));
    for (int i = 0; i < 1; i++)
    {
        // int count = 0;
        arr[i].status =  [self getInt8AccordItem:60];
       // arr[i].userID = [self getInt32AccordItem:160];
        
    }
    return arr;
}



//REQ_GET_CHANGE_PWD(143)
-(void)PushREQ_GET_CHANGE_PWDLData:(DZPK_CLIENT_REQ_GET_CHANGE_PWD *)arr
{
    [self setItemNumberCountForUpdoad:3];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_GET_CHANGE_PWD  client = *(arr+i);
        [self pushItemIDForBig:130 Content:client.userID];
        [self pushItemIDForString:131 Content:client.checkcode];
        [self pushItemIDForString:132 Content:client.pwd];
    }
    
}

-(DZPK_SERVER_REQ_GET_CHANGE_PWD *)PullREQ_GET_CHANGE_PWD
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GET_CHANGE_PWD  *arr = malloc(sizeof(DZPK_SERVER_REQ_GET_CHANGE_PWD));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GET_CHANGE_PWD));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GET_CHANGE_PWD));
    for (int i = 0; i < 1; i++)
    {
        // int count = 0;
        arr[i].status =  [self getInt8AccordItem:60];
        
    }
    return arr;
}





//REQ_GET_CHARGE(144)
-(void)PushREQ_GET_CHARGELData:(DZPK_CLIENT_REQ_GET_CHARGE *)arr
{
    [self setItemNumberCountForUpdoad:2];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_GET_CHARGE  client = *(arr+i);
        [self pushItemIDForBig:130 Content:client.userID];
        [self pushItemIDForBig:131 Content:client.versionID];
    }
    
}

-(DZPK_SERVER_REQ_GET_CHARGE *)PullREQ_GET_CHARGE
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GET_CHARGE  *arr = malloc(sizeof(DZPK_SERVER_REQ_GET_CHARGE));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GET_CHARGE));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GET_CHARGE));
    int  i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].status =  [self getInt8AccordItem:60];
                break;
            case 130:
                arr[i].tradeID = [self getStringAccordItem:130];
                break;
            case 131:
                 arr[i].url = [self getStringAccordItem:131];
                break;
            default:
                break;
        }
        
    }
    return arr;
}

//REQ_READ_CHARGE_RESULT(145)

-(DZPK_SERVER_REQ_READ_CHARGE_RESULT *)PullREQ_READ_CHARGE_RESULT
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_READ_CHARGE_RESULT  *arr = malloc(sizeof(DZPK_SERVER_REQ_READ_CHARGE_RESULT));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_READ_CHARGE_RESULT));
    }
     memset(arr, '\0', sizeof(DZPK_SERVER_REQ_READ_CHARGE_RESULT));
    
    int  i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].status =  [self getInt8AccordItem:60];
                break;
            case 130:
                arr[i].tradeID = [self getStringAccordItem:130];
                break;
            case 131:
                arr[i].iMoney = [self getInt32AccordItem:131];
                break;
            default:
                break;
        }
        
    }
    return arr;
}

//REQ_USER_BING_AGAIN(147)
-(void)PushREQ_USER_BING_AGAINData:(DZPK_CLIENT_REQ_USER_BING_AGAIN *)arr
{
    [self setItemNumberCountForUpdoad:6];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_USER_BING_AGAIN  client = *(arr+i);
        [self pushItemIDForBig:60 Content:client.iType];
        [self pushItemIDForBig:130 Content:client.userID];
        [self pushItemIDForString:131 Content:client.phoneNum];
        [self pushItemIDForString:132 Content:client.QQNumber];
        [self pushItemIDForString:133 Content:client.emailAddr];
        [self pushItemIDForString:134 Content:client.countrySec];
    }
    
}

-(DZPK_SERVER_REQ_USER_BING_AGAIN *)PullREQ_USER_BING_AGAIN
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_USER_BING_AGAIN  *arr = malloc(sizeof(DZPK_SERVER_REQ_USER_BING_AGAIN));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_USER_BING_AGAIN));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_USER_BING_AGAIN));
    
    int  i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].status =  [self getInt8AccordItem:60];
                break;
            case 61:
                arr[i].iType = [self getInt8AccordItem:61];
                break;
            default:
                break;
        }
        
    }
    return arr;
}

//REQ_USER_CONNECT_RECORD(148)
-(void)PushREQ_USER_CONNECT_RECORDData:(DZPK_CLIENT_REQ_USER_CONNECT_RECORD *)arr
{
    [self setItemNumberCountForUpdoad:2];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_USER_CONNECT_RECORD  client = *(arr+i);
      
        [self pushItemIDForString:130 Content:client.imei];
        [self pushItemIDForBig:131 Content:client.versionID];
    }
    
}

-(DZPK_SERVER_REQ_USER_CONNECT_RECORD *)PullREQ_USER_CONNECT_RECORD
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_USER_CONNECT_RECORD  *arr = malloc(sizeof(DZPK_SERVER_REQ_USER_CONNECT_RECORD));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_USER_CONNECT_RECORD));
    }
     memset(arr, '\0', sizeof(DZPK_SERVER_REQ_USER_CONNECT_RECORD));
    for (int i = 0; i < 1; i++)
    {
        // int count = 0;
        arr[i].status =  [self getInt8AccordItem:60];
        
    }

    return arr;
}


//
//REQ_ORDER_SUCCESS(153)
-(void)PushREQ_ORDER_SUCCESSData:(DZPK_CLIENT_REQ_ORDER_SUCCESS *)arr
{
    [self setItemNumberCountForUpdoad:1];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_ORDER_SUCCESS  client = *(arr+i);
        
      //  [self pushItemIDForString:130 Content:client.imei];
        [self pushItemIDForBig:130 Content:client.userID];
    }
    
}

-(DZPK_SERVER_REQ_ORDER_SUCCESS *)PullREQ_ORDER_SUCCESS
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_ORDER_SUCCESS  *arr = malloc(sizeof(DZPK_SERVER_REQ_ORDER_SUCCESS));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_ORDER_SUCCESS));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_ORDER_SUCCESS));
    int  i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].status =  [self getInt8AccordItem:60];
                break;
            case 130:
                arr[i].iMoney = [self getInt32AccordItem:130];
                break;
            case 131:
                arr[i].level = [self getInt32AccordItem:131];
                break;
            case 132:
                 arr[i].wealth = [self getInt32AccordItem:132];
                break;
            default:
                break;
        }
        
    }
    return arr;
}


//REQ_CHARGE_FOR_IPHONE(154)
-(void)PushREQ_CHARGE_FOR_IPHONEData:(DZPK_CLIENT_REQ_CHARGE_FOR_IPHONE *)arr
{
    [self setItemNumberCountForUpdoad:5];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_CHARGE_FOR_IPHONE  client = *(arr+i);
        
        //  [self pushItemIDForString:130 Content:client.imei];
        [self pushItemIDForString:130 Content:client.orderID];
        [self pushItemIDForString:131 Content:client.tradeID];
        [self pushItemIDForString:132 Content:client.product_ID];
        [self pushItemIDForBig:133 Content:client.versionID];
        [self pushItemIDForString:134 Content:client.receipt];
    }
    
}

-(DZPK_SERVER_REQ_CHARGE_FOR_IPHONE *)PullREQ_CHARGE_FOR_IPHONE
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_CHARGE_FOR_IPHONE  *arr = malloc(sizeof(DZPK_SERVER_REQ_CHARGE_FOR_IPHONE));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_CHARGE_FOR_IPHONE));
    }
     memset(arr, '\0', sizeof(DZPK_SERVER_REQ_CHARGE_FOR_IPHONE));
    int  i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].status =  [self getInt8AccordItem:60];
                break;
            case 130:
               arr[i].orderID = [self getStringAccordItem:130];
                break;
            case 131:
                 arr[i].iMoney = [self getInt32AccordItem:131];
                break;
            default:
                break;
        }
        
    }
    return arr;
}




//REQ_GET_CHARGE_FORDOWNJOY  (210)
-(DZPK_SERVER_REQ_GET_CHARGE_FORDOWNJOY *)PullREQ_GET_CHARGE_FORDOWNJOYE
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GET_CHARGE_FORDOWNJOY  *arr = malloc(sizeof(DZPK_SERVER_REQ_GET_CHARGE_FORDOWNJOY));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GET_CHARGE_FORDOWNJOY));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GET_CHARGE_FORDOWNJOY));
    int  i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].status =  [self getInt8AccordItem:60];
                break;
            case 130:
                arr[i].strNargForDownjoy = [self getStringAccordItem:130];
                break;
            default:
                break;
        }
        
    }
    return arr;
}


-(void)PushREQ_GET_CHARGE_FORDOWNJOYData:(DZPK_CLIENT_REQ_GET_CHARGE_FORDOWNJOY *)arr
{
    [self setItemNumberCountForUpdoad:4];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_GET_CHARGE_FORDOWNJOY  client = *(arr+i);
        
        [self pushItemIDForBig:130 Content:client.dzpkuserID];
        [self pushItemIDForBig:131 Content:client.vesionID];
        [self pushItemIDForBig:132 Content:client.idou];
        [self pushItemIDForString:133 Content:client.DownJoyuid];
    }
    
}

//YEE_PAY_CHARGE_RESULT(158)
-(void)PushYEE_PAY_CHARGE_RESULTEData:(DZPK_CLIENT_YEE_PAY_CHARGE_RESULT *)arr
{
    [self setItemNumberCountForUpdoad:7];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_YEE_PAY_CHARGE_RESULT  client = *(arr+i);
        
        [self pushItemIDForString:130 Content:client.cardtype];
        [self pushItemIDForString:131 Content:client.cardnum];
        [self pushItemIDForString:132 Content:client.cardpwd];
        [self pushItemIDForString:133 Content:client.cardMoney];
        [self pushItemIDForString:134 Content:client.product_name];
        [self pushItemIDForString:135 Content:client.chargemoney];
        [self pushItemIDForString:136 Content:client.orderid];
    }
    
}

-(DZPK_SERVER_YEE_PAY_CHARGE_RESULT *)PullYEE_PAY_CHARGE_RESULT
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_YEE_PAY_CHARGE_RESULT  *arr = malloc(sizeof(DZPK_SERVER_YEE_PAY_CHARGE_RESULT));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_YEE_PAY_CHARGE_RESULT));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_YEE_PAY_CHARGE_RESULT));
    
    int  i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].status =  [self getInt8AccordItem:60];
                break;
            case 130:
                arr[i].reason = [self getStringAccordItem:130];
                break;
            case 131:
                arr[i].iMoney = [self getInt32AccordItem:131];
                break;
            case 132:
                arr[i].liftMoney = [self getStringAccordItem:132];
                break;
            default:
                break;
        }
        
    }
    return arr;
}

//REQ_CHARGE_RESULT(171)
-(void)PushREQ_CHARGE_RESULTData:(DZPK_CLIENT_REQ_CHARGE_RESULT *)arr
{
    [self setItemNumberCountForUpdoad:7];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_CHARGE_RESULT  client = *(arr+i);
        [self pushItemIDForBig:130 Content:client.userID];
        [self pushItemIDForBig:131 Content:client.channelID];
        [self pushItemIDForBig:132 Content:client.idou];
        [self pushItemIDForBig:133 Content:client.imoney];
        [self pushItemIDForString:134 Content:client.productID];
        [self pushItemIDForString:135 Content:client.orderID];
        [self pushItemIDForString:136 Content:client.customID];
    }
    
}

-(DZPK_SERVER_REQ_CHARGE_RESULT *)PullREQ_CHARGE_RESULT
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_CHARGE_RESULT  *arr = malloc(sizeof(DZPK_SERVER_REQ_CHARGE_RESULT));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_CHARGE_RESULT));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_CHARGE_RESULT));
    int  i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].status =  [self getInt8AccordItem:60];
                break;
            case 130:
                arr[i].moneySum = [self getInt32AccordItem:130];
                break;
            default:
                break;
        }
        
    }
    return arr;
}

//REQ_CHANGE_PWD_BY_EMAIL  377
-(void)PushREQ_CHANGE_PWD_BY_EMAILData:(DZPK_CLIENT_REQ_CHANGE_PWD_BY_EMAIL *)arr
{
    [self setItemNumberCountForUpdoad:7];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_CHANGE_PWD_BY_EMAIL  client = *(arr+i);
        [self pushItemID:60 Content:client.iType];
        [self pushItemIDForString:130 Content:client.strBaseEmailAdd];
        [self pushItemIDForString:131 Content:client.strPwd];
    }
    
}
-(DZPK_SERVER_REQ_CHANGE_PWD_BY_EMAIL *)PullREQ_CHANGE_PWD_BY_EMAIL
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_CHANGE_PWD_BY_EMAIL  *arr = malloc(sizeof(DZPK_SERVER_REQ_CHANGE_PWD_BY_EMAIL));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_CHANGE_PWD_BY_EMAIL));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_CHANGE_PWD_BY_EMAIL));
    int  i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].status =  [self getInt8AccordItem:60];
                break;

            default:
                break;
        }
        
    }
    return arr;
}

-(DZPK_SERVER_REQ_VERSION *)PullREQ_VERSION
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_VERSION  *arr = malloc(sizeof(DZPK_SERVER_REQ_VERSION));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_VERSION));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_VERSION));
    int  i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].status =  [self getInt8AccordItem:60];
                break;
            case 61:
                arr[i].versionCode =  [self getInt8AccordItem:61];
                break;
            case 130:
                arr[i].versionName =  [self getStringAccordItem:130];
                break;
            case 131:
                arr[i].updateContent =  [self getStringAccordItem:131];
                break;
            case 132:
                arr[i].versionSize =  [self getStringAccordItem:132];
                break;
            case 133:
                arr[i].url =  [self getStringAccordItem:133];
                break;
            default:
                break;
        }
        
    }
    return arr;
}


//REQ_BASIC_INFOR 4
-(DZPK_SERVER_REQ_BASIC_INFOR *)PullREQ_BASIC_INFOR
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_BASIC_INFOR  *arr = malloc(sizeof(DZPK_SERVER_REQ_BASIC_INFOR));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_BASIC_INFOR));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_BASIC_INFOR));
    int  i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].status =  [self getInt8AccordItem:60];
                break;
            case 61:
                arr[i].dayindex =  [self getInt8AccordItem:61];
                break;
            case 130:
                arr[i].loginBoundsArray =  [self getArrayAccordItem:130 count:&arr[i].loginbounds_number];
                break;
            case 131:
                arr[i].propArray   =  [self getArrayofint8AccordItem:131 count:&arr[i].propArraynumber];
                break;
            case 132:
                arr[i].propprice_array =  [self getArrayAccordItem:132 count:&arr[i].propPriceNumber];
                break;
            default:
                break;
        }
        
    }
    return arr;
}

@end
