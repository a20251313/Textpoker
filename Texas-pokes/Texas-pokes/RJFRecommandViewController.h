//
//  RJFRecommandViewController.h
//  Texas-pokes
//
//  Created by ran on 12-10-8.
//
//
#import "PublicDefine.h"
#if MODEFOR91 == 0
#import <UIKit/UIKit.h>
#import "RJFAppDownload.h"
@interface RJFRecommandViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,BNRDOWNAPPINFO>
{
    IBOutlet       UIButton     *btnBack;
    IBOutlet       UITableView  *m_tableView;
    NSMutableArray              *m_arrStoreDatasource;
    RJFAppDownload              *m_appDownload;
    NSString                    *m_strHost;
    unsigned int                m_ifilePort;
}
@property(copy)NSString         *fileHost;
@property(readwrite) unsigned int           fileport;
-(IBAction)ClickBack:(id)sender;
@end
#endif
