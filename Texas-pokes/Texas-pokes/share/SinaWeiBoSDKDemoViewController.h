//
//  WBViewController.h
//  SinaWeiBoSDKDemo
//
//  Created by Wang Buping on 11-12-7.
//  Copyright (c) 2011 Sina. All rights reserved.
//

//微博列表界面

#import <UIKit/UIKit.h>
#import "WBEngine.h"
#import "WBSendView.h"
#import "WBLogInAlertView.h"
#import "WBSDKTimelineViewController.h"
#import "Renren.h"


@interface SinaWeiBoSDKDemoViewController : UIViewController <WBEngineDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, WBLogInAlertViewDelegate, RenrenDelegate> {
    WBEngine *weiBoEngine;
    
    WBSDKTimelineViewController *timeLineViewController;
    UIActivityIndicatorView *indicatorView;
    IBOutlet UIButton *backButton;
    
    // NSMutableArray* sharedArray;
    NSArray *listData;
    IBOutlet UITableView *sinaWeiboTableView;
    Renren *_renren;
    
}

@property (retain, nonatomic) Renren *renren;
@property (nonatomic, retain) WBEngine *weiBoEngine;
@property (nonatomic, retain) WBSDKTimelineViewController *timeLineViewController;
//@property (nonatomic, retain) NSArray * sharedArray;
@property (nonatomic, retain) NSArray * listData;

-(IBAction)clickBack:(UIButton *)sender;

@end
