//
//  RJFMainAppDelegate.h
//  Texas-pokes
//
//  Created by popo on 12-6-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "PublicDefine.h"

@class RJFMainViewController;

@interface RJFMainAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSTimer         *m_timerResource;
  //  BasisZipAndUnzip  *objBasic;
    UserInfo          *objUser;
}   

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RJFMainViewController *viewController;

@end
