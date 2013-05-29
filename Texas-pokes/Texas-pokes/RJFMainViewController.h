//
//  RJFMainViewController.h
//  Texas-pokes
//
//  Created by popo on 12-6-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJFMainWindow.h"
#import "PublicDefine.h"
#import "RJFHelpViewController.h"
#import "RJFSettingViewController.h"
#import "PublicDefine.h"
@interface RJFMainViewController : UIViewController<TencentSessionDelegate,SinaWeiboDelegate>
{
    UIButton         *buttonQQlogin;
    UIButton         *buttonSinalogin;
    UIButton         *buttonGuest;
    UIButton         *buttonSetting;
    UIButton         *buttonHelp;
    
   
    
    NSMutableString             *m_strURL;

   
    //For QQLogin
    NSMutableArray              *m_permits;
    TencentOAuth                *m_Tencent;
    NSMutableDictionary         *m_UserdicInfo;
    BOOL                         m_bIsFirstLogin;

}

-(IBAction)PopTheCorrecctXib:(UIButton *)sender;
@end
