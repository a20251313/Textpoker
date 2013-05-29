//
//  BasisZipAndUnzip+gameInterface.m
//  TestZip
//
//  Created by ran on 12-8-20.
//  Copyright (c) 2012年 ran. All rights reserved.
//

#import "BasisZipAndUnzip+gameInterface.h"

@implementation BasisZipAndUnzip (gameInterface)



//REQ_GAME_QUICK_SERVER(40)


-(DZPK_SERVER_REQ_GAME_QUICK_SERVER *)PullREQ_GAME_QUICK_SERVER
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_QUICK_SERVER  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_QUICK_SERVER));
    
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_QUICK_SERVER));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_QUICK_SERVER));
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
            case 134:
                arr[i].serverid = [self getInt32AccordItem:134];
                break;
            case 130:
                arr[i].IP = [self getStringAccordItem:130];
                break;
            case 131:
                arr[i].port = [self getInt32AccordItem:131];
                break;
            case 132:
                arr[i].roomPATH = [self getInt32AccordItem:132];
                break;
            case 133:
                arr[i].roomID = [self getInt32AccordItem:133];
                break;
            case 135:
                arr[i].servicecharge = [self getInt32AccordItem:135];
                break;
//            case 136:
//                arr[i].bringGold = [self getInt32AccordItem:136];
                break;
            case 136:
                arr[i].carry_big_Number = [self getInt32AccordItem:136];
                break;
            case 137:
                arr[i].carry_small_Number = [self getInt32AccordItem:137];
                break;
            case 138:
                arr[i].enter_big_Number = [self getInt32AccordItem:138];
                break;
            case 139:
                arr[i].enter_small_Number = [self getInt32AccordItem:139];
                break;
            default:
                break;
        }
        
    }
    
    return arr;
}

//REQ_GAME_QUICK_SERVER(40)


-(void)PushREQ_GAME_QUICKRData:(DZPK_CLIENT_REQ_GAME_QUICK *)arr
{
    [self setItemNumberCountForUpdoad:2];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    /* for (int i = 0; i < 1; i++)
     {
     DZPK_CLIENT_REQ_GAME_QUICK  client = *(arr+i);
     [self pushItemIDForBig:130 Content:client.roomPath];
     [self pushItemIDForBig:131 Content:client.roomID];
     //  [self pushItemIDForString:140 Content:client.QQNumber];
     //  [self pushItemIDForString:141 Content:client.emaliaddr];
     }*/
    
}

-(DZPK_SERVER_REQ_GAME_QUICK *)PullREQ_GAME_QUICK
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_QUICK  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_QUICK));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_QUICK));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_QUICK));
    int i = 0;
    // int count = 0;
    
    
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
                arr[i].gamestatus = [self getInt8AccordItem:61];
                break;
            case 63:
                arr[i].countdown_times = [self getInt8AccordItem:63];
                break;
            case 141:
                arr[i].bigBlind = [self getInt32AccordItem:141];
                break;
            case 142:
                arr[i].smallBlind = [self getInt32AccordItem:142];
                break;
            case 66:
                
                arr[i].bigIndex = [self getInt8AccordItem:66];
                break;
            case 67:
                arr[i].smallIndex = [self getInt8AccordItem:67];
                break;
            case 68:
                arr[i].bankerIndex = [self getInt8AccordItem:68];
                break;
            case 69:
                arr[i].operationID = [self getInt8AccordItem:69];
                break;
            case 70:
                arr[i].mySeatID = [self getInt8AccordItem:70];
                break;
            case 71:
                arr[i].speed = [self getInt8AccordItem:71];
                break;
            case 131:
                arr[i].cards = [self getArrayAccordItem:131 count:(int*)&arr[i].cardsNumber];
                break;
            case 132:
                arr[i].playerIDArray = [self getArrayAccordItem:132 count:(int *)&arr[i].playerIDNumber];
                break;
            case 133:
                
                break;
            case 134:
                arr[i].statusArray = [self getArrayAccordItem:134 count:(int *)&arr[i].statusArrayNumber];
                break;
            case 135:
                arr[i].anteArray = [self getArrayAccordItem:135 count:(int *)&arr[i].anteArrayNumber];
                break;
            case 136:
                arr[i].nick = [self getStringAccordItem:136];
                break;
            case 137:
                arr[i].chipsArray = [self getArrayAccordItem:137 count:(int *)&arr[i].chipsArrayNumber];
                break;
            case 138:
                arr[i].headPicString = [self getStringAccordItem:138];
                break;
            case 139:
                arr[i].firstCardarray = [self getArrayAccordItem:139 count:(int *)&arr[i].firstCardNumber];
                break;
            case 140:
                arr[i].SecondArray = [self getArrayAccordItem:140 count:(int *)&arr[i].secondCardNumber];
                break;
            case 143:
                arr[i].alreadAnte = [self getInt32AccordItem:143];
                break;
                
                
            default:
                break;
        }
        
    }
    
    
    
    return arr;
}

//REQ_GAME_ROOM_LIST_MATCH(42)

-(DZPK_SERVER_REQ_GAME_ROOM_LIST_MATCH *)PullREQ_GAME_ROOM_LIST_MATCH
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_ROOM_LIST_MATCH  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_ROOM_LIST_MATCH));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_ROOM_LIST_MATCH));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_ROOM_LIST_MATCH));
    int i = 0;
    // int count = 0;
    
    
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
            case 135:
                arr[i].serverport = [self getInt32AccordItem:135];
                break;
            case 136:
                arr[i].serverID = [self getInt32AccordItem:136];
                break;
            case 130:
                arr[i].IP = [self getStringAccordItem:130];
                break;
            case 131:
                arr[i].RoomIDArray = [self getArrayAccordItem:131 count:&arr[i].roomIDNumber];
                break;
            case 132:
                
                arr[i].PlayerOrCountArray = [self getArrayofint8AccordItem:132 count:&arr[i].PlayerOrCountNumber];
                break;
            case 133:
                arr[i].statusArray = [self getArrayofint8AccordItem:133 count:&arr[i].statusNumber];
                break;
            case 134:
                arr[i].entryfeeArray = [self getArrayAccordItem:134 count:&arr[i].entryFeeNumber];
                break;
            case 137:
                arr[i].pathArray = [self getArrayAccordItem:137 count:&arr[i].pathArrayNumber];
                break;
            case 138:
                arr[i].enter_big_array = [self getArrayAccordItem:138 count:&arr[i].enterbigNumber];
                break;
            case 139:
                arr[i].enter_small_array = [self getArrayAccordItem:139 count:&arr[i].entersmallNumber];
                break;
            case 140:
                arr[i].typesArray = [self getArrayofint8AccordItem:140 count:&arr[i].typeNumber];
                break;
            case 141:
                arr[i].firstBounsArray = [self getArrayAccordItem:141 count:&arr[i].firstBounsNumber];
                break;
            case 142:
                arr[i].secondBounsArray = [self getArrayAccordItem:142 count:&arr[i].secondNounsNumber];
                break;
            default:
                break;
        }
        
    }
    
    return arr;
}

//REQ_GAME_ROOM_LIST_NORMAL（43)
-(void)PushREQ_GAME_ROOM_LIST_NORMALData:(DZPK_CLIENT_REQ_GAME_ROOM_LIST_NORMAL *)arr
{
    [self setItemNumberCountForUpdoad:2];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_GAME_ROOM_LIST_NORMAL  client = *(arr+i);
        [self pushItemID:60 Content:client.category];
        [self pushItemIDForBig:130 Content:client.chips];
        //  [self pushItemIDForString:140 Content:client.QQNumber];
        //  [self pushItemIDForString:141 Content:client.emaliaddr];
    }
    
}

-(DZPK_SERVER_REQ_GAME_ROOM_LIST_NORMAL *)PullREQ_GAME_ROOM_LIST_NORMAL
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        NSLog(@"12");
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_ROOM_LIST_NORMAL  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_ROOM_LIST_NORMAL));
    
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_ROOM_LIST_NORMAL));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_ROOM_LIST_NORMAL));
    int i = 0;
    //  NSLog(@"int number:%d",int number);
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            NSLog(@"23");
            break;
        }
        
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].status =  [self getInt8AccordItem:60];
                break;
            case 61:
                arr[i].category = [self getInt8AccordItem:61];
                break;
            case 62:
                arr[i].userAdjustType = [self getInt8AccordItem:62];
                break;
            case 139:
                arr[i].port = [self getInt32AccordItem:139];
                break;
            case 138:
                arr[i].serverID = [self getInt32AccordItem:138];
                break;
            case 130:
                arr[i].IP = [self getStringAccordItem:130];
                break;
            case 131:
                arr[i].RoomidArray  = [self getArrayAccordItem:131 count:&arr[i].roomIDNumber];
                break;
            case 132:
                arr[i].SpeedArray  = [self getArrayofint8AccordItem:132 count:&arr[i].speedNumber];
                break;
            case 133:
                arr[i].smallArray  = [self getArrayAccordItem:133 count:&arr[i].smallNumber];
                break;
            case 134:
                arr[i].bigArray    = [self getArrayAccordItem:134 count:&arr[i].bigNumber];
                break;
            case 135:
                arr[i].serverChargeArray  = [self getArrayAccordItem:135 count:&arr[i].serverChargeNumber];
                break;
//            case 136:
//                arr[i].bringGoldArray  = [self getArrayAccordItem:136 count:&arr[i].bringGoldNumber];
//                break;
            case 137:
                arr[i].playerCountArray  = [self getArrayofint8AccordItem:137 count:&arr[i].PlayerOrCountNumber];
                break;
            case 140:
                arr[i].pathArray = [self getArrayAccordItem:140 count:&arr[i].pathNumber];
                break;
            case 136:
                arr[i].carry_big_array = [self getArrayAccordItem:136 count:&arr[i].carrybigNumber];
                break;
            case 141:
                arr[i].carry_small_array = [self getArrayAccordItem:141 count:&arr[i].carrySmallNumber];
                break;
            case 142:
                arr[i].enter_big_array = [self getArrayAccordItem:142 count:&arr[i].enterBigNumber];
                break;
            case 143:
                arr[i].enter_small_array = [self getArrayAccordItem:143 count:&arr[i].enterSmallNumber];
            default:
                break;
        }
        
        
        
    }
    
    return arr;
}


///REQ_GAME_ENTER_ROOM(44)
-(void)PushREQ_GAME_ENTER_ROOMData:(DZPK_CLIENT_REQ_GAME_ENTER_ROOM *)arr
{
    [self setItemNumberCountForUpdoad:4];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_GAME_ENTER_ROOM  client = *(arr+i);
        [self pushItemIDForBig:131 Content:client.roomPath];
        [self pushItemIDForBig:132 Content:client.roomID];
        [self pushItemID:60 Content:client.type];
        [self pushItemID:61 Content:client.reconnect];
        //  [self pushItemID:61 Content:client.iType];
        //  [self pushItemIDForString:140 Content:client.QQNumber];
        //  [self pushItemIDForString:141 Content:client.emaliaddr];
    }
    
}

-(DZPK_SERVER_REQ_GAME_ENTER_ROOM *)PullREQ_GAME_ENTER_ROOM
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_ENTER_ROOM  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_ENTER_ROOM));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_ENTER_ROOM));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_ENTER_ROOM));
    int i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        int16_t  itemID = [self getItemIDAccordPos:_data_size];
     //   NSLog(@"ItemID:%d",itemID);
        switch (itemID)
        {
            case 60:
                arr[i].status =  [self getInt8AccordItem:60];
                break;
            case 61:
                arr[i].gamestatus = [self getInt8AccordItem:61];
                break;
            case 62:
                arr[i].countdown_times = [self getInt8AccordItem:62];
                if (arr[i].countdown_times > 0 && arr[i].countdown_times < 3)
                {
                    NSLog(@"\n\n\nqqqqqqqqCountdownTimes:%d\n\n\n",arr[i].countdown_times);
                }
                break;
            case 140:
                arr[i].bigBlind = [self getInt32AccordItem:140];
                break;
            case 141:
                arr[i].smallBlind = [self getInt32AccordItem:141];
                break;
            case 65:
                arr[i].bigIndex = [self getInt8AccordItem:65];
                break;
            case 66:
                arr[i].smallIndex = [self getInt8AccordItem:66];
                break;
            case 67:
                arr[i].bankerIndex = [self getInt8AccordItem:67];
                break;
            case 68:
                arr[i].operationID = [self getInt8AccordItem:68];
                break;
            case 69:
                arr[i].speed = [self getInt8AccordItem:69];
                break;
            case 70:
                arr[i].mySeatID = [self getInt8AccordItem:70];
                break;
            case 131:
                arr[i].cards = [self getArrayofint8AccordItem:131 count:&arr[i].cardsNumber];
                break;
            case 132:
                arr[i].playerIDArray = [self getArrayAccordItem:132 count:&arr[i].playerIDNumber];
                break;
            case 133:
                arr[i].statusArray = [self getArrayAccordItem:133 count:&arr[i].statusArrayNumber];
                break;
            case 134:
                arr[i].anteArray = [self getArrayAccordItem:134 count:&arr[i].anteArrayNumber];
                break;
            case 135:
                arr[i].nick = [self getStringAccordItem:135];
                break;
            case 136:
                arr[i].chipsArray = [self getArrayAccordItem:136 count:&arr[i].chipsArrayNumber];
                break;
            case 137:
                arr[i].headPicString = [self getStringAccordItem:137];
                break;
            case 138:
                arr[i].firstCardarray = [self getArrayofint8AccordItem:138 count:&arr[i].firstCardNumber];
                break;
            case 139:
                arr[i].SecondArray = [self getArrayofint8AccordItem:139 count:&arr[i].secondCardNumber];
                break;
            case 142:
                arr[i].alreadAnte = [self getInt32AccordItem:142];
                break;
            case 143:
                arr[i].maxAnte = [self getInt32AccordItem:143];
                break;
            default:
                break;
        }
        
    }
    
    
    
    
    for (int j = 0; j < arr[i].playerIDNumber; j++)
    {
        if (arr[i].playerIDArray[j] > -1)
        {
            NSLog(@"!!!!!!!!!!!!!!!!!!!!enter info ID:%d   chip:%d",arr[i].playerIDArray[j],arr[i].chipsArray[j]);
        }
    }
    
    
    
    return arr;
}

///REQ_GAME_SEND_SEAT_ACTION(45)
-(void)PushREQ_GAME_SEND_SEAT_ACTIONData:(DZPK_CLIENT_REQ_GAME_SEND_SEAT_ACTION *)arr
{
    [self setItemNumberCountForUpdoad:4];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_GAME_SEND_SEAT_ACTION  client = *(arr+i);
        [self pushItemID:60 Content:client.action];
        [self pushItemID:61 Content:client.seatID];
        [self pushItemIDForBig:131 Content:client.roomID];
        [self pushItemIDForBig:130 Content:client.roomPath];
    }
    
}

-(DZPK_SERVER_REQ_GAME_SEND_SEAT_ACTION *)PullREQ_GAME_SEND_SEAT_ACTION
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_SEND_SEAT_ACTION  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_SEND_SEAT_ACTION));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_SEND_SEAT_ACTION));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_SEND_SEAT_ACTION));
    int i = 0;
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
                arr[i].action = [self getInt8AccordItem:61];
                break;
            case 130:
                arr[i].tableChip = [self getInt32AccordItem:130];
                break;
            case 131:
                arr[i].leavelChips = [self getInt32AccordItem:131];
                break;
            default:
                break;
        }
        
    }
    
    return arr;
}

///REQ_GAME_SEND_MSG(46)
-(void)PushREQ_GAME_SEND_MSGData:(DZPK_CLIENT_REQ_GAME_SEND_MSG *)arr
{
    [self setItemNumberCountForUpdoad:4];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_GAME_SEND_MSG  client = *(arr+i);
        [self pushItemID:60 Content:client.msgType];
        [self pushItemIDForBig:132 Content:client.roomID];
        [self pushItemIDForBig:131 Content:client.roomPath];
        [self pushItemIDForString:130 Content:client.msgContent];
    }
    
}


//REQ_GAME_SEND_MSG（46）
-(DZPK_SERVER_REQ_GAME_SEND_MSG *)PullREQ_GAME_SEND_MSG
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_SEND_MSG  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_SEND_MSG));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_SEND_MSG));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_SEND_MSG));
    for (int i = 0; i < 1; i++)
    {
        // int count = 0;
        arr[i].status =  [self getInt8AccordItem:60];
        
        
    }
    
    return arr;
}

//REQ_GAME_SEND_ACTION（47）
-(void)PushREQ_GAME_SEND_ACTIONData:(DZPK_CLIENT_REQ_GAME_SEND_ACTION *)arr
{
    [self setItemNumberCountForUpdoad:4];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_GAME_SEND_ACTION  client = *(arr+i);
        [self pushItemID:60 Content:client.action];
        [self pushItemIDForBig:132 Content:client.roomID];
        [self pushItemIDForBig:131 Content:client.roomPath];
        [self pushItemIDForBig:133 Content:client.anteNumber];
        //  [self pushItemID:61 Content:client.iType];
        //  [self pushItemIDForString:140 Content:client.QQNumber];
        //  [self pushItemIDForString:141 Content:client.emaliaddr];
    }
    
}


-(DZPK_SERVER_REQ_GAME_SEND_ACTION *)PullREQ_GAME_SEND_ACTION
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_SEND_ACTION  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_SEND_ACTION));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_SEND_ACTION));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_SEND_ACTION));
    for (int i = 0; i < 1; i++)
    {
        
        arr[i].status =  [self getInt8AccordItem:60];
        
    }
    /*  DZPK_SERVER_REQ_LOGIN_BY_QQ_EMAIL  returnStruct[int number];
     for (int i = 0;i < 1;i++)
     {
     returnStruct[i] = *(arr+i);
     }*/
    return arr;
}


//REQ_GAME_RECV_ACTION（49）


-(DZPK_SERVER_REQ_GAME_RECV_ACTION *)PullREQ_GAME_RECV_ACTION
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_RECV_ACTION  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_ACTION));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_ACTION));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_RECV_ACTION));
    
    
    int i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 131:
                arr[i].playerID =  [self getInt32AccordItem:131];
                break;
            case 61:
                arr[i].seatID = [self getInt8AccordItem:61];
                break;
            case 62:
                arr[i].action = [self getInt8AccordItem:62];
                break;
            case 130:
                arr[i].anteNumber = [self getInt32AccordItem:130];
                break;
            case 64:
                arr[i].operationID = [self getInt8AccordItem:64];
                break;
                
            default:
                break;
        }
        
    }
    return arr;
}


//REQ_GAME_RECV_LEAVE（50）

-(DZPK_SERVER_REQ_GAME_RECV_LEAVE *)PullREQ_GAME_RECV_LEAVE
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_RECV_LEAVE  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_LEAVE));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_LEAVE));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_RECV_LEAVE));
    
    
    int i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].seatID =  [self getInt8AccordItem:60];
                break;
            case 130:
                arr[i].userID = [self getInt32AccordItem:130];
                break;
            default:
                break;
        }
        
    }
    return arr;
}


//REQ_GAME_RECV_SEAT_DOWN（51）


-(DZPK_SERVER_REQ_GAME_RECV_SEAT_DOWN *)PullREQ_GAME_RECV_SEAT_DOWN
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_RECV_SEAT_DOWN  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_SEAT_DOWN));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_SEAT_DOWN));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_RECV_SEAT_DOWN));
    
    int i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 132:
                arr[i].userID = [self getInt32AccordItem:132];
                break;
            case 61:
                arr[i].seatID =  [self getInt8AccordItem:61];
                break;
            case 133:
                arr[i].chips = [self getInt32AccordItem:133];
                break;
            case 130:
                arr[i].headPic = [self getStringAccordItem:130];
                break;
            case 131:
                arr[i].nick = [self getStringAccordItem:131];
                break;
                
            default:
                break;
        }
        
    }
    return arr;
}

//REQ_GAME_RECV_CARDS（52）


-(DZPK_SERVER_REQ_GAME_RECV_CARDS *)PullREQ_GAME_RECV_CARDS
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_RECV_CARDS  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_CARDS));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_CARDS));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_RECV_CARDS));
    
    
    int i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].seatID =  [self getInt8AccordItem:60];
                break;
            case 130:
                arr[i].systemIDArray = [self getArrayofint8AccordItem:130 count:&arr[i].systemNumbeer];
                break;
            default:
                break;
        }
        
    }
    
    return arr;
}


//REQ_GAME_RECV_WINNER（53)


-(DZPK_SERVER_REQ_GAME_RECV_WINNER *)PullREQ_GAME_RECV_WINNERS
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_RECV_WINNER  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_WINNER));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_WINNER));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_RECV_WINNER));
    
    
    int i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 130:
                arr[i].seatIDArray = [self getArrayofint8AccordItem:130 count:&arr[i].seatIDNumbeer];
                break;
            case 131:
                arr[i].playerArray = [self getArrayAccordItem:131 count:&arr[i].playerNumbeer];
                break;
            case 132:
                arr[i].chipsArray = [self getArrayAccordItem:132 count:&arr[i].chipsNumbeer];
                break;
            case 133:
                arr[i].cardTypesArray= [self getArrayofint8AccordItem:133 count:&arr[i].cardTypesNumbeer];
                break;
            case 134:
                //    arr[i].isMaxWin = [self getArrayAccordItem:134 count:&arr[i].isMaxWinNumbeer];
                break;
            case 135:
                //  arr[i].isMaxCards = [self getArrayAccordItem:135 count:&arr[i].isMaxCardsNumbeer];
                break;
            case 136:
                arr[i].cardSort = [self getArrayofint8AccordItem:136 count:&arr[i].cardSortNumbeer];
                break;
            case 137:
                arr[i].allPlayerchip = [self getArrayAccordItem:137 count:&arr[i].allPlayerChipNumber];
                break;
            case 138:
                arr[i].allplayerID = [self getArrayAccordItem:138 count:&arr[i].allplayerNumber];
                break;
            case 140:
                arr[i].firstCardArray = [self getArrayofint8AccordItem:140 count:&arr[i].firstCardArrayNumber];
                break;
            case 141:
                arr[i].secondArray = [self getArrayofint8AccordItem:141 count:&arr[i].secondCardArrayNumber];
                break;
            case 142:
                arr[i].isMaxCardArray = [self getArrayofint8AccordItem:142 count:&arr[i].ismaxCardArrayNumber];
                break;
                
            default:
                break;
        }
        
    }
    
    return arr;
}


//REQ_GAME_TIMEOUT_BACK（54）
-(void)PushREQ_GAME_TIMEOUT_BACKData:(DZPK_CLIENT_REQ_GAME_TIMEOUT_BACK *)arr
{
    [self setItemNumberCountForUpdoad:3];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_GAME_TIMEOUT_BACK  client = *(arr+i);
        [self pushItemIDForBig:130 Content:client.player_iD];
        [self pushItemID:60 Content:client.type];
        [self pushItemID:61 Content:client.seatID];
        //[self pushItemID:60 Content:client.action];
        // [self pushItemIDForBig:132 Content:client.roomID];
        // [self pushItemIDForBig:131 Content:client.roomPath];
        // [self pushItemIDForBig:133 Content:client.anteNumber];
        //  [self pushItemID:61 Content:client.iType];
        //  [self pushItemIDForString:140 Content:client.QQNumber];
        //  [self pushItemIDForString:141 Content:client.emaliaddr];
    }
    
}


-(DZPK_SERVER_REQ_GAME_TIMEOUT_BACK *)PullREQ_GAME_TIMEOUT_BACKS
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_TIMEOUT_BACK  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_TIMEOUT_BACK));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_TIMEOUT_BACK));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_TIMEOUT_BACK));
    
    int i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 130:
                arr[i].playerID = [self getInt32AccordItem:130];
                break;
            case 60:
                arr[i].status = [self getInt8AccordItem:60];
                break;
            case 61:
                arr[i].seatID = [self getInt8AccordItem:61];
                break;
            default:
                break;
        }
        
    }
    /*  DZPK_SERVER_REQ_LOGIN_BY_QQ_EMAIL  returnStruct[int number];
     for (int i = 0;i < 1;i++)
     {
     returnStruct[i] = *(arr+i);
     }*/
    return arr;
}


//REQ_GAME_RECV_READYTIME（55)

-(DZPK_SERVER_REQ_GAME_RECV_READYTIME *)PullREQ_GAME_RECV_READYTIME
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_RECV_READYTIME  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_READYTIME));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_READYTIME));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_RECV_READYTIME));
    for (int i = 0; i < 1; i++)
    {
        
        arr[i].readyTime = [self getInt8AccordItem:60];
        
    }
    
    return arr;
}

//REQ_GAME_RECV_START_INFOR（56）
-(DZPK_SERVER_REQ_GAME_RECV_START_INFOR *)PullREQ_GAME_RECV_START_INFORE
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_RECV_START_INFOR  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_START_INFOR));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_START_INFOR));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_RECV_START_INFOR));
    int i = 0;
    arr[i].firstNumber = 0;
    arr[i].secondNumber =0;
    for (int jCount = 0; jCount < number+10; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].bankerID = [self getInt8AccordItem:60];
                break;
            case 61:
                arr[i].bigSeatID = [self getInt8AccordItem:61];
                break;
            case 62:
                arr[i].smallSeatID = [self getInt8AccordItem:62];
                break;
            case 63:
                arr[i].operationID = [self getInt8AccordItem:63];
                break;
            case 130:
                arr[i].firstCardArray = [self getArrayofint8AccordItem:130 count:&arr[i].firstNumber];
                break;
            case 131:
                arr[i].SecondCardArray = [self getArrayofint8AccordItem:131 count:&arr[i].secondNumber];
                break;
            case 132:
                arr[i].smallChip = [self getInt32AccordItem:132];
                break;
            case 133:
                arr[i].bigChip = [self getInt32AccordItem:133];
                break;
            case 134:
                arr[i].chipsArray = [self getArrayAccordItem:134 count:&arr[i].chipsArrayNumber];
                break;
            case 135:
                arr[i].timesArray = [self getArrayAccordItem:135 count:&arr[i].timesArrayNumber];
                break;
            case 136:
                arr[i].taskBounds = [self getArrayAccordItem:136 count:&arr[i].taskBoundsArrayNumber];
                break;
                
            default:
                break;
        }
        
    }
    
    return arr;
}


//REQ_GAME_ADD_CHIPS（57)

-(void)PushREQ_GAME_ADD_CHIPSData:(DZPK_CLIENT_REQ_GAME_ADD_CHIPS *)arr
{
    [self setItemNumberCountForUpdoad:2];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_GAME_ADD_CHIPS  client = *(arr+i);
        [self pushItemID:60 Content:client.seatID];
        [self pushItemIDForBig:130 Content:client.anteNumber];
    }
    
}


-(DZPK_SERVER_REQ_GAME_ADD_CHIPS *)PullREQ_GAME_ADD_CHIPSE
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_ADD_CHIPS  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_ADD_CHIPS));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_ADD_CHIPS));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_ADD_CHIPS));
    
    int i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 61:
                arr[i].status = [self getInt8AccordItem:61];
                break;
            case 62:
                arr[i].seatID = [self getInt8AccordItem:62];
                break;
            case 131:
                arr[i].playerID = [self getInt32AccordItem:131];
                break;
            case 130:
                arr[i].Chips = [self getInt32AccordItem:130];
                break;
            default:
                break;
        }
        
    }
    return arr;
}

//REQ_GAME_RECV_MSG（58）
-(DZPK_SERVER_REQ_GAME_RECV_MSG *)PullREQ_GAME_RECV_MSG
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_RECV_MSG  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_MSG));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_MSG));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_RECV_MSG));
    
    int i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].seatID = [self getInt8AccordItem:60];
                break;
            case 61:
                arr[i].playerID = [self getInt8AccordItem:61];
                break;
            case 131:
                arr[i].nick = [self getStringAccordItem:131];
                break;
            case 63:
                arr[i].msgType = [self getInt8AccordItem:63];
                break;
            case 130:
                arr[i].msgContent = [self getStringAccordItem:130];
                break;
                
            default:
                break;
        }
        
    }
    return arr;
}

//REQ_GAME_CONNECT_AGAIN（59)
-(DZPK_SERVER_REQ_GAME_CONNECT_AGAIN *)PullREQ_GAME_CONNECT_AGAIN
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_CONNECT_AGAIN  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_CONNECT_AGAIN));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_CONNECT_AGAIN));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_CONNECT_AGAIN));
    
    int i = 0;
    arr[i].cardsNumber = 0;
    arr[i].playerIDNumber = 0;
    arr[i].statusArrayNumber = 0;
    arr[i].anteArrayNumber = 0;
    arr[i].chipsArrayNumber = 0;
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
                arr[i].gamestatus = [self getInt8AccordItem:61];
                break;
            case 62:
                arr[i].countdown_times = [self getInt8AccordItem:62];
                break;
            case 140:
                arr[i].bigBlind = [self getInt32AccordItem:140];
                break;
            case 141:
                arr[i].smallBlind = [self getInt32AccordItem:141];
                break;
            case 65:
                arr[i].bigIndex = [self getInt8AccordItem:65];
                break;
            case 66:
                arr[i].smallIndex = [self getInt8AccordItem:66];
                break;
            case 67:
                arr[i].bankerIndex = [self getInt8AccordItem:67];
                break;
            case 68:
                arr[i].operationID = [self getInt8AccordItem:68];
                break;
            case 69:
                arr[i].speed = [self getInt8AccordItem:69];
                break;
            case 131:
                arr[i].cards = [self getArrayAccordItem:131 count:(int*)&arr[i].cardsNumber];
                break;
            case 132:
                arr[i].playerIDArray = [self getArrayAccordItem:132 count:(int *)&arr[i].playerIDNumber];
                break;
            case 133:
                arr[i].statusArray = [self getArrayAccordItem:133 count:(int *)&arr[i].statusArrayNumber];
                break;
            case 134:
                arr[i].anteArray = [self getArrayAccordItem:134 count:(int *)&arr[i].anteArrayNumber];
                break;
            case 135:
                arr[i].nick = [self getStringAccordItem:135];
                break;
            case 136:
                arr[i].chipsArray = [self getArrayAccordItem:136 count:(int *)&arr[i].chipsArrayNumber];
                break;
            case 137:
                arr[i].headPicString = [self getStringAccordItem:137];
                break;
            case 138:
                arr[i].firstCardarray = [self getArrayAccordItem:138 count:(int *)&arr[i].firstCardNumber];
                break;
            case 139:
                arr[i].SecondArray = [self getArrayAccordItem:139 count:(int *)&arr[i].secondCardNumber];
                break;
            case 142:
                arr[i].alreadAnte = [self getInt32AccordItem:142];
                break;
                
            default:
                break;
        }
        
    }
    return arr;
}


//REQ_GAME_ADD_CHIPS（57)

-(void)PushREQ_GAME_SEARCH_ROOMData:(DZPK_CLIENT_REQ_GAME_SEARCH_ROOM *)arr
{
    [self setItemNumberCountForUpdoad:2];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_GAME_SEARCH_ROOM  client = *(arr+i);
        [self pushItemID:60 Content:client.roomType];
        [self pushItemIDForBig:130 Content:client.roomID];
    }
    
}


-(DZPK_SERVER_REQ_GAME_SEARCH_ROOM *)PullREQ_GAME_SEARCH_ROOM
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_SEARCH_ROOM  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_SEARCH_ROOM));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_SEARCH_ROOM));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_SEARCH_ROOM));
    
    int i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].status = [self getInt8AccordItem:60];
                break;
            case 130:
                arr[i].serverID = [self getInt32AccordItem:130];
                break;
            case 131:
                arr[i].IP = [self getStringAccordItem:131];
                break;
            case 132:
                arr[i].port = [self getInt32AccordItem:132];
                break;
            case 133:
                arr[i].roomPath = [self getInt32AccordItem:133];
                break;
            case 134:
                arr[i].roomID = [self getInt32AccordItem:134];
                break;
            case 61:
                arr[i].type = [self getInt8AccordItem:61];
                break;
            case 135:
                arr[i].bigBlind = [self getInt32AccordItem:135];
                break;
            case 136:
                arr[i].smallBlind = [self getInt32AccordItem:136];
                break;
            case 137:
                arr[i].serverCharge = [self getInt32AccordItem:137];
                break;
//            case 138:
//                arr[i].bringGold = [self getInt32AccordItem:138];
//                break;
                
                
            case 63:
                arr[i].playerCount = [self getInt8AccordItem:63];
                break;
            case 64:
                arr[i].roomstatus = [self getInt8AccordItem:64];
                break;
            case 62:
                arr[i].speed = [self getInt8AccordItem:62];
                break;
            case 138:
                arr[i].carry_big_chip = [self getInt32AccordItem:138];
                break;
            case 139:
                arr[i].carry_small_chip = [self getInt32AccordItem:139];
                break;
            case 140:
                arr[i].enter_big_chip = [self getInt32AccordItem:140];
                break;
            case 141:
                arr[i].enter_small_chip = [self getInt32AccordItem:142];
                break;
            case 65:
                arr[i].matchTypes = [self getInt8AccordItem:65];
                break;
                
                
            default:
                break;
        }
        
    }
    return arr;
}

//REQ_GAME_RECV_OUT(61)
-(void)PushREQ_GAME_RECV_OUTData:(DZPK_CLIENT_REQ_GAME_RECV_OUT *)arr
{
    [self setItemNumberCountForUpdoad:1];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_GAME_RECV_OUT  client = *(arr+i);
        [self pushItemID:60 Content:client.type];
        
    }
    
}


-(DZPK_SERVER_REQ_GAME_RECV_OUT *)PullREQ_GAME_RECV_OUT
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_RECV_OUT  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_OUT));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_RECV_OUT));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_RECV_OUT));
    int i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 132:
                arr[i].rankingArray = [self getArrayofint8AccordItem:132 count:&arr[i].rangArrayNumber];
                break;
            case 133:
                arr[i].indexArray = [self getArrayofint8AccordItem:133 count:&arr[i].indexArrayNumber];
                break;
            case 130:
                arr[i].userIDArray = [self getArrayAccordItem:130 count:&arr[i].userIDArrayNumber];
                break;
            case 131:
                arr[i].goldArray = [self getArrayAccordItem:131 count:&arr[i].goldArrayNumber];
                break;
            case 60:
                arr[i].type = [self getInt8AccordItem:60];
                break;
                
            default:
                break;
        }
        
    }
    return arr;
}


//REQ_GAME_PLAYER_DATA(62)
-(void)PushREQ_GAME_PLAYER_DATAData:(DZPK_CLIENT_REQ_GAME_PLAYER_DATA *)arr
{
    [self setItemNumberCountForUpdoad:2];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_GAME_PLAYER_DATA  client = *(arr+i);
        [self pushItemID:60 Content:client.seatID];
        [self pushItemIDForBig:130 Content:client.userid];
        
    }
    
}


-(DZPK_SERVER_REQ_GAME_PLAYER_DATA *)PullREQ_GAME_PLAYER_DATA
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_PLAYER_DATA  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_PLAYER_DATA));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_PLAYER_DATA));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_PLAYER_DATA));
    int i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 132:
                arr[i].maxCards = [self getArrayofint8AccordItem:132 count:&arr[i].cardArrayNumber];
                break;
            case 130:
                arr[i].userID = [self getInt32AccordItem:130];
                break;
            case 131:
                arr[i].nick = [self getStringAccordItem:131];
                break;
            case 133:
                arr[i].max_win = [self getInt32AccordItem:133];
                break;
            case 134:
                arr[i].chips = [self getInt32AccordItem:134];
                break;
            case 135:
                arr[i].win_number = [self getInt32AccordItem:135];
                break;
            case 136:
                arr[i].lose_number = [self getInt32AccordItem:136];
                break;
            case 137:
                arr[i].score = [self getInt32AccordItem:137];
                break;
            case 138:
                arr[i].matchscore = [self getInt32AccordItem:138];
                break;
            case 139:
                arr[i].headPicName = [self getStringAccordItem:139];
                break;
          
            case 60:
                arr[i].status = [self getInt8AccordItem:60];
                break;
            case 61:
                arr[i].sex = [self getInt8AccordItem:61];
                break;
            case 62:
                arr[i].level = [self getInt8AccordItem:62];
                break;
            case 63:
                arr[i].seatID = [self getInt8AccordItem:63];
                break;
                
            default:
                break;
        }
        
    }
    return arr;
}



//REQ_GET_COUNTDOWN_HONUS   63
-(DZPK_SERVER_REQ_GET_COUNTDOWN_HONUS*)PullREQ_GET_COUNTDOWN_HONUS
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GET_COUNTDOWN_HONUS  *arr = malloc(sizeof(DZPK_SERVER_REQ_GET_COUNTDOWN_HONUS));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GET_COUNTDOWN_HONUS));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GET_COUNTDOWN_HONUS));
    
    
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
                arr[i].bounds = [self getInt32AccordItem:130];
                break;
            case 131:
                arr[i].times = [self getInt32AccordItem:131];
                break;
            case 132:
                arr[i].bounds_next = [self getInt32AccordItem:132];
                break;
            default:
                break;
        }
        
    }
    
    return arr;
}


//REQ_GAME_USE_GIFT   64
-(void)PushREQ_GAME_USE_GIFTData:(DZPK_CLIENT_REQ_GAME_USE_GIFT *)arr
{
    [self setItemNumberCountForUpdoad:4];
    [self setPos:CLIENT_UPLOAD_HEADERSIZE+1];
    for (int i = 0; i < 1; i++)
    {
        DZPK_CLIENT_REQ_GAME_USE_GIFT  client = *(arr+i);
        [self pushItemID:60 Content:client.fromseat];
        [self pushItemID:61 Content:client.toseat];
        [self pushItemID:62 Content:client.giftID];
        [self pushItemIDForBig:130 Content:client.chips];
        
    }
    
}

-(DZPK_SERVER_REQ_GAME_USE_GIFT *)PullREQ_GAME_USE_GIFT
{
    int number = [self getItemNumberForDownLoad];
    if (number <= 0)
    {
        return  NULL;
    }
    DZPK_SERVER_REQ_GAME_USE_GIFT  *arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_USE_GIFT));
    while (arr == NULL)
    {
        arr = malloc(sizeof(DZPK_SERVER_REQ_GAME_USE_GIFT));
    }
    memset(arr, '\0', sizeof(DZPK_SERVER_REQ_GAME_USE_GIFT));
    int i = 0;
    for (int jCount = 0; jCount < number; jCount++)
    {
        if (_data_size > m_realSize)
        {
            break;
        }
        switch ([self getItemIDAccordPos:_data_size])
        {
            case 60:
                arr[i].status = [self getInt8AccordItem:60];
                break;
            case 61:
                arr[i].fromseat = [self getInt8AccordItem:61];
                break;
            case 62:
                arr[i].toseat = [self getInt8AccordItem:62];
                break;
            case 63:
                arr[i].giftID = [self getInt8AccordItem:63];
                break;
            case 130:
                arr[i].userchips = [self getInt32AccordItem:130];
                break;
            default:
                break;
        }
        
    }
    return arr;
}


@end
