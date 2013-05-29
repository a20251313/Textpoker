//
//  BasisZipAndUnzip+Other_userinfo.m
//  TestZip
//
//  Created by ran on 12-8-21.
//  Copyright (c) 2012年 ran. All rights reserved.
//

#import "BasisZipAndUnzip+Other_userinfo.h"

@implementation BasisZipAndUnzip (Other_userinfo)

//REQ_RECV_NEW_MSG（90）;
-(DZPK_SERVER_REQ_RECV_NEW_MSG * )PullREQ_RECV_NEW_MSG
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_RECV_NEW_MSG  *arr = malloc(sizeof(DZPK_SERVER_REQ_RECV_NEW_MSG));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_RECV_NEW_MSG));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_RECV_NEW_MSG));
    for (int i = 0; i < 1; i++)
    {
        arr[i].new_msg_number =  [self getInt8AccordItem:60];
    }
    return arr;
}


//REQ_RECV_GET_MSG（91）

-(DZPK_SERVER_REQ_RECV_GET_MSG * )PullREQ_RECV_GET_MSGG
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_RECV_GET_MSG  *arr = malloc(sizeof(DZPK_SERVER_REQ_RECV_GET_MSG));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_RECV_GET_MSG));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_RECV_GET_MSG));
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
                arr[i].typeArray = [self getArrayofint8AccordItem:130 count:&arr[i].typeNumber];
                break;
            case 131:
                arr[i].content = [self getStringAccordItem:131];
                break;
            case 132:
                arr[i].recv_Time = [self getStringAccordItem:132];
                break;
            case 133:
                arr[i].post_Time = [self getStringAccordItem:133];
                break;
            default:
                break;
        }
        
    }
    return arr;
}


//REQ_GAME_RANKING（92）


-(void)PushREQ_GAME_RANKINGData:(DZPK_CLIENT_REQ_GAME_RANKING*)arr
{
    [self setItemNumberCountForUpdoad:1];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_GAME_RANKING  client = *(arr+i);
        [self pushItemID:60 Content:client.language];
        
    }
    
}
-(DZPK_SERVER_REQ_GAME_RANKING * )PullREQ_GAME_RANKINGG
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_RANKING  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RANKING));
    
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RANKING));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_RANKING));
    
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
            case 131:
                arr[i].RankingName = [self getStringAccordItem:131];
                break;
            case 132:
                arr[i].rank_rowArray = [self getArrayofint8AccordItem:132 count:&arr[i].rowarrayNumber];
                break;
            case 133:
                arr[i].rank_columnArray = [self getArrayofint8AccordItem:133 count:&arr[i].coloumNumber];
                break;
            case 134:
                arr[i].coloumTwoData = [self getStringAccordItem:134];
                break;
            case 135:
                arr[i].coloumThreeData = [self getStringAccordItem:135];
                break;
            case 136:
                arr[i].coloumFourData = [self getStringAccordItem:136];
                break;
                
            default:
                break;
        }
        
    }
    return arr;
}

//REQ_RECOMMENDATION（93)
-(DZPK_SERVER_REQ_RECOMMENDATION * )PullREQ_RECOMMENDATIONG
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_RECOMMENDATION  *arr = malloc(sizeof(DZPK_SERVER_REQ_RECOMMENDATION));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_RECOMMENDATION));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_RECOMMENDATION));
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
                arr[i].title = [self getStringAccordItem:130];
                break;
            case 131:
                arr[i].logo = [self getStringAccordItem:131];
                break;
            case 132:
                arr[i].version = [self getStringAccordItem:132];
                break;
            case 133:
                arr[i].size = [self getStringAccordItem:133];
                break;
            case 134:
                arr[i].url = [self getStringAccordItem:134];
                break;
            case 135:
                arr[i].download_number = [self getArrayAccordItem:135 count:&arr[i].downloadCount];
                break;
            case 136:
                arr[i].idNumber = [self getArrayAccordItem:136 count:&arr[i].idCount];
                break;
            default:
                break;
        }
        
    }
    return arr;
}


//REQ_FEEDBACK（94)
-(void)PushREQ_FEEDBACKData:(DZPK_CLIENT_REQ_FEEDBACK *)arr
{
    [self setItemNumberCountForUpdoad:1];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_FEEDBACK  client = *(arr+i);
        [self pushItemIDForString:130 Content:client.content];
        
    }
    
}


-(DZPK_SERVER_REQ_FEEDBACK *)PullREQ_FEEDBACKS
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_FEEDBACK  *arr = malloc(sizeof(DZPK_SERVER_REQ_FEEDBACK));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_FEEDBACK));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_FEEDBACK));
    for (int i = 0; i < 1; i++)
    {
        
        arr[i].status = [self getInt8AccordItem:60];
    }
    return arr;
}

////REQ_SHARE_CONTENT（95)

-(void)PushREQ_SHARE_CONTENTData:(DZPK_CLIENT_REQ_SHARE_CONTENT *)arr
{
    [self setItemNumberCountForUpdoad:1];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_SHARE_CONTENT  client = *(arr+i);
        [self pushItemID:60 Content:client.type];
        
    }
    
}
-(DZPK_SERVER_REQ_SHARE_CONTENT*)PullREQ_SHARE_CONTENT
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_SHARE_CONTENT  *arr = malloc(sizeof(DZPK_SERVER_REQ_SHARE_CONTENT));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_SHARE_CONTENT));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_SHARE_CONTENT));
    
    
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
                arr[i].type =  [self getInt8AccordItem:61];
                break;
            case 130:
                arr[i].content = [self getStringAccordItem:130];
                break;
            case 131:
                arr[i].shareBounds = [self getInt32AccordItem:131];
                break;
            default:
                break;
        }
        
    }
    
    return arr;
}

//REQ_SYNC_SIGNAL_RESOURCE  96
-(DZPK_SERVER_REQ_SYNC_SIGNAL_RESOURCE*)PullREQ_SYNC_SIGNAL_RESOURCE
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_SYNC_SIGNAL_RESOURCE  *arr = malloc(sizeof(DZPK_SERVER_REQ_SYNC_SIGNAL_RESOURCE));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_SYNC_SIGNAL_RESOURCE));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_SYNC_SIGNAL_RESOURCE));
    
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
                arr[i].onlineCount = [self getInt32AccordItem:130];
                break;
            default:
                break;
        }
        
    }
    return arr;
}


//REQ_CONVERT（98）
-(void)PushREQ_CONVERTData:(DZPK_CLIENT_REQ_CONVERT *)arr
{
    [self setItemNumberCountForUpdoad:3];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_CONVERT  client = *(arr+i);
        [self pushItemID:60 Content:client.converType];
        [self pushItemIDForBig:130 Content:client.idou];
        [self pushItemIDForBig:131 Content:client.chips];
        
    }
    
}

//98
-(DZPK_SERVER_REQ_CONVERT *)PullREQ_CONVERTS
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_CONVERT  *arr = malloc(sizeof(DZPK_SERVER_REQ_CONVERT));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_CONVERT));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_CONVERT));
    
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
                arr[i].idou = [self getInt32AccordItem:130];
                break;
            case 131:
                arr[i].chips = [self getInt32AccordItem:131];
                break;
            default:
                break;
        }
        
    }
    
    return arr;
}


//REQ_GET_CHIPS  100
-(DZPK_SERVER_REQ_GET_CHIPS*)PullREQ_GET_CHIPS
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GET_CHIPS  *arr = malloc(sizeof(DZPK_SERVER_REQ_GET_CHIPS));
    
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GET_CHIPS));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GET_CHIPS));
    
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
                arr[i].freeTimes = [self getInt8AccordItem:61];
                break;
            case 130:
                arr[i].chips = [self getInt32AccordItem:130];
                break;
            case 131:
                arr[i].allchips = [self getInt32AccordItem:131];
                break;
            default:
                break;
        }
        
    }
    
    return arr;
}


//REQ_PERSON_DATA_HEAD_NAME 31
-(DZPK_SERVER_REQ_PERSON_DATA_HEAD_NAME *)PullREQ_PERSON_DATA_HEAD_NAME
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_PERSON_DATA_HEAD_NAME  *arr = malloc(sizeof(DZPK_SERVER_REQ_PERSON_DATA_HEAD_NAME));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_PERSON_DATA_HEAD_NAME));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_PERSON_DATA_HEAD_NAME));
    
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
//            case 130:
//                arr[i].port = [self getInt32AccordItem:130];
//                break;
//            case 131:
//                arr[i].IP = [self getStringAccordItem:131];
//                break;
            case 132:
                arr[i].name = [self getStringAccordItem:132];
                break;
            default:
                break;
        }
        
    }
    return arr;
}

//REQ_PERSON_DATA_ALTER(30)
-(void)PushREQ_PERSON_DATA_ALTERData:(DZPK_CLIENT_REQ_PERSON_DATA_ALTER *)arr
{
    [self setItemNumberCountForUpdoad:3];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_PERSON_DATA_ALTER  client = *(arr+i);
        [self pushItemIDForString:130 Content:client.nick];
        [self pushItemIDForString:131 Content:client.head_pic_name];
        [self pushItemID:60 Content:client.sex];
        
    }
    
}


-(DZPK_SERVER_REQ_PERSON_DATA_ALTER *)PullREQ_PERSON_DATA_ALTER
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_PERSON_DATA_ALTER  *arr = malloc(sizeof(DZPK_SERVER_REQ_PERSON_DATA_ALTER));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_PERSON_DATA_ALTER));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_PERSON_DATA_ALTER));
    int i = 0;
    
    arr[i].status = [self getInt8AccordItem:60];
    
    return arr;
}

////REQ_PERSON_DATA(32)
-(DZPK_SERVER_REQ_PERSON_DATA *)PullREQ_PERSON_DATA
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_PERSON_DATA  *arr = malloc(sizeof(DZPK_SERVER_REQ_PERSON_DATA));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_PERSON_DATA));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_PERSON_DATA));
    int  i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        uint8_t  itemID = [self getItemIDAccordPos:_data_size];
      //    NSLog(@"itemid:%d",itemID);
        switch (itemID)
        {
            case 60:
                arr[i].status =  [self getInt8AccordItem:60];
                break;
            case 61:
                arr[i].sex = [self getInt8AccordItem:61];
                break;
            case 62:
                arr[i].msg_count = [self getInt8AccordItem:62];
                break;
            case 63:
                arr[i].level = [self getInt8AccordItem:63];
                break;
            case 64:
                arr[i].task = [self getInt8AccordItem:64];
                break;
            case 130:
                arr[i].nick = [self getStringAccordItem:130];
                break;
            case 131:
                arr[i].head_pic_name = [self getStringAccordItem:131];
                break;
            case 132:
                arr[i].maxCards = [self getArrayofint8AccordItem:132 count:&arr[i].maxcardNumber];
                break;
            case 133:
                arr[i].max_win = [self getInt32AccordItem:133];
                break;
            case 134:
                arr[i].chips = [self getInt32AccordItem:134];
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
            case 140:
                arr[i].score = [self getInt32AccordItem:140];
                break;
            case 141:
                arr[i].match_score = [self getInt32AccordItem:141];
                break;
            default:
                break;
        }
        
    }
    return arr;
}

//DZPK_SERVER_REQ_OFFLINE 99
-(DZPK_SERVER_REQ_OFFLINE *)PullREQ_OFFLINE
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_OFFLINE  *arr = malloc(sizeof(DZPK_SERVER_REQ_OFFLINE));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_OFFLINE));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_OFFLINE));
    
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

//REQ_GET_TASK  101
-(DZPK_SERVER_REQ_GET_TASK *)PullREQ_GET_TASK
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    
    DZPK_SERVER_REQ_GET_TASK  *arr = malloc(sizeof(DZPK_SERVER_REQ_GET_TASK));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GET_TASK));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GET_TASK));
    
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
            case 131:
                arr[i].idArray =  [self getArrayofint8AccordItem:131 count:&arr[i].idArrayNumber];
                break;
            case 133:
                arr[i].typeArray =  [self getArrayofint8AccordItem:133 count:&arr[i].typeArrayNumber];
                break;
//            case 130:
//                arr[i].title =  [self getStringAccordItem:130];
//                break;
//            case 131:
//                arr[i].descprition =  [self getStringAccordItem:131];
//                break;   
            case 136:
                arr[i].bounds =  [self getArrayAccordItem:136 count:&arr[i].bounsNumber];
                break;
            case 134:
                arr[i].all_times =  [self getArrayAccordItem:134 count:&arr[i].allTimesNumber];
                break;
            case 135:
                arr[i].doneTimes =  [self getArrayAccordItem:135 count:&arr[i].doneTimesNumber];
                break;
            case 132:
                arr[i].taskStatus =  [self getArrayofint8AccordItem:132 count:&arr[i].taskstatusNumber];
                break;
            default:
                break;
        }
        
    }
    return arr;
}


//REQ_GET_BONUDS（102）
-(void)PushREQ_GET_BONUDSData:(DZPK_CLIENT_REQ_GET_BONUDS*)arr
{
    [self setItemNumberCountForUpdoad:1];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_GET_BONUDS  client = *(arr+i);
        [self pushItemIDForBig:130 Content:client.idNumber];
        
    }
    
}

-(DZPK_SERVER_REQ_GET_BONUDS *)PullREQ_GET_BONUDS
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GET_BONUDS  *arr = malloc(sizeof(DZPK_SERVER_REQ_GET_BONUDS));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GET_BONUDS));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GET_BONUDS));
    
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
                arr[i].idNumber =  [self getInt8AccordItem:61];
                break;
            case 131:
                arr[i].chips =  [self getInt32AccordItem:131];
                break;   
            default:
                break;
        }
        
    }
    return arr;
}

//REQ_GET_ACTIVITY  103
-(DZPK_SERVER_REQ_GET_ACTIVITY*)PullREQ_GET_ACTIVITY
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GET_ACTIVITY  *arr = malloc(sizeof(DZPK_SERVER_REQ_GET_ACTIVITY));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GET_ACTIVITY));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GET_ACTIVITY));
    
    
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
                arr[i].flag =  [self getInt8AccordItem:61];
                break;
            case 62:
                arr[i].doneFlag = [self getInt8AccordItem:62];
                break;
            case 130:
                arr[i].descprition = [self getStringAccordItem:130];
                break;
            case 131:
                arr[i].picUrl = [self getStringAccordItem:131];
                break;
            default:
                break;
        }
        
    }
    
    return arr;
}

//REQ_GET_ACTIVITY_HONUS  104
-(DZPK_SERVER_REQ_GET_ACTIVITY_HONUS*)PullREQ_GET_ACTIVITY_HOUNS
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GET_ACTIVITY_HONUS  *arr = malloc(sizeof(DZPK_SERVER_REQ_GET_ACTIVITY_HONUS));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GET_ACTIVITY_HONUS));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GET_ACTIVITY_HONUS));
    
    
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
                arr[i].descprition = [self getStringAccordItem:130];
                break;
            default:
                break;
        }
        
    }
    
    return arr;
}

//REQ_REALTIME_INFOR   105
-(DZPK_SERVER_REQ_REALTIME_INFOR*)PullREQ_REALTIME_INFOR
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_REALTIME_INFOR  *arr = malloc(sizeof(DZPK_SERVER_REQ_REALTIME_INFOR));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_REALTIME_INFOR));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_REALTIME_INFOR));
    
    
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
                arr[i].descprition = [self getStringAccordItem:130];
                break;
            default:
                break;
        }
        
    }
    
    return arr;
}


//REQ_SHARE_BOUND   106

-(void)PushREQ_SHARE_BOUNDData:(DZPK_CLIENT_REQ_SHARE_BONUS*)arr
{
    [self setItemNumberCountForUpdoad:1];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_SHARE_BONUS  client = *(arr+i);
        [self pushItemID:60 Content:client.type];
        
    }
    
}

-(DZPK_SERVER_REQ_SHARE_BONUS*)PullREQ_SHARE_BOUND
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_SHARE_BONUS  *arr = malloc(sizeof(DZPK_SERVER_REQ_SHARE_BONUS));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_SHARE_BONUS));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_SHARE_BONUS));
    
    
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
                arr[i].type =  [self getInt8AccordItem:61];
                break;
            case 131:
                arr[i].all_chips =  [self getInt32AccordItem:131];
                break;
            case 130:
                arr[i].bounds = [self getInt32AccordItem:130];
                break;
            default:
                break;
        }
        
    }
    
    return arr;
}




@end
