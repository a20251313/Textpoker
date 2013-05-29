//
//  RJFMessageViewController.h
//  Texas-pokes
//
//  Created by popo on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"

typedef enum dataSourceType
{
    USERDYM,
    SYSMESSAGE,
    ACTMESSAGE,
}dataSourceTyoe;
@interface RJFMessageViewController : UIViewController
{
    IBOutlet    UITableView         *m_tableView;
    IBOutlet    UIButton            *btnBack;
    IBOutlet    UIButton            *btnUserDym;
    IBOutlet    UIButton            *btnSysMessage;
    IBOutlet    UIButton            *btnActMessage;
    
    
    IBOutlet    UIImageView         *imageViewActMessage;
    IBOutlet    UITextView            *textViewActMessage;;
    dataSourceTyoe                  m_iDataSoureType;
    NSMutableArray                  *m_arrayMessageInfo;    //store date,message [dic ],key:MESSAGEDATE DATE
    NSMutableArray                  *m_arrStoreUserMessage;
    NSMutableArray                  *m_arrStoreSysMessage;
    
}

-(IBAction)clickBack:(UIButton *)sender;
-(IBAction)clickUserDym:(UIButton *)sender;
-(IBAction)clickSysMessage:(UIButton *)sender;
-(IBAction)clickActMessage:(UIButton *)sender;
@end
