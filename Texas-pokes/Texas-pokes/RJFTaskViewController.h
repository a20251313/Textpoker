//
//  RJFTaskViewController.h
//  Texas-pokes
//
//  Created by ran on 12-11-16.
//
//

#import <UIKit/UIKit.h>

@interface RJFTaskViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet    UIButton            *btnBack;
    IBOutlet    UITableView         *m_tableView;
    NSMutableArray                  *m_arrayStoreData;
    
    NSMutableArray                  *m_arrUserMess;
}
-(IBAction)clickBack:(id)sender;
-(IBAction)clickFresh:(id)sender;
@end
