//
//  RJFRankingVViewController.h
//  Texas-pokes
//
//  Created by ran on 12-10-27.
//
//

#import <UIKit/UIKit.h>

@interface RJFRankingVViewController : UIViewController
{
    IBOutlet    UIButton    *btnLeft;
    IBOutlet    UIButton    *btnRight;
    IBOutlet    UITableView *m_tableView;
    IBOutlet    UIButton     *btnBack;
    IBOutlet    UILabel      *laberMiddle;
    
    
    IBOutlet    UIButton    *btnLL;
    IBOutlet    UIButton    *btnRR;
    
    NSMutableArray  *m_arrayStore;
    NSMutableArray  *m_arrayStoreAllinfo;
    NSMutableArray  *m_arrayStoreName;
    
    int8_t      m_nowIndex;
    int8_t      m_MaxIndex;
    
}
-(IBAction)clickLeft:(UIButton *)sender;
-(IBAction)clickRight:(UIButton *)sender;
-(IBAction)ClickBack:(id)sender;

@end
