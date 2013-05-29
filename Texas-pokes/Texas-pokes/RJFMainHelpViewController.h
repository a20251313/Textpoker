//
//  RJFMainHelpViewController.h
//  Texas-pokes
//
//  Created by ran on 12-11-16.
//
//

#import <UIKit/UIKit.h>

@interface RJFMainHelpViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet   UITableView        *m_tableView;
    IBOutlet   UIButton             *btnBack;
    BOOL                            canSendAdvice;
}

@property(readwrite)BOOL            canSendAdvice;
-(IBAction)clickBack:(id)sender;
@end
