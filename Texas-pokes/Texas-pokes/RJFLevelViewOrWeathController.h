//
//  RJFLevelViewController.h
//  Texas-pokes
//
//  Created by popo on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"

@interface RJFLevelViewOrWeathController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet       UIButton         *btnBack;
   // IBOutlet       UIScrollView     *m_scrollView;
    
    IBOutlet       UILabel          *labelTextContex;

    NSMutableArray                    *m_arrayStoreRank;
    UITableView                       *m_tableView;
   IBOutlet UIScrollView              *m_scrollView;
}

@property(nonatomic,retain)NSMutableArray   *arrayStoreRank;
-(IBAction)clickBack:(UIButton *)sender;


@end
