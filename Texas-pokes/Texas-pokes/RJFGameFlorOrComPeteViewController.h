//
//  RJFGameFlorOrComPeteViewController.h
//  Texas-pokes
//
//  Created by popo on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJFGameInterface.h"
#import "UserInfo.h"
#import "PublicDefine.h"

typedef enum GAMECONTROLTYPE
{
    GAMEFLOORTYPE,
    COMPELTETYPE
}GameControlType;

@interface RJFGameFlorOrComPeteViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
     IBOutlet   UIButton   *btnBack;
     IBOutlet   UIButton   *btnFullRoom;
     IBOutlet   UIButton   *btnSpeed;
     IBOutlet   UIButton   *btnFresh;
     IBOutlet   UIButton   *btnFirstLevel;
     IBOutlet   UIButton   *btnMidlevel;
     IBOutlet   UIButton   *btnHighLevel;
    
    
    IBOutlet   UIButton   *btnID;
    IBOutlet   UIButton   *btnChips;
    IBOutlet   UIButton   *btnBringChips;
    IBOutlet   UIButton   *btnPlayNumber;
    IBOutlet   UIButton   *btnServerFee;
    
     IBOutlet   UILabel    *labelFullRoom;
     IBOutlet   UILabel    *labelShow;
     IBOutlet   UILabel    *labelSpeed;
     IBOutlet   UILabel    *labelNormal;
    
     IBOutlet   UIImageView    *ImageView1;
     IBOutlet   UIImageView    *ImageView4;
     IBOutlet   UIImageView    *ImageView3;
     IBOutlet   UIImageView    *ImageView2;

    
    
    
     IBOutlet   UILabel             *labelTitle;
    
     IBOutlet   UILabel             *labelUserName;
     IBOutlet   UILabel             *labelChips;
    
     IBOutlet   UIImageView         *imageViewBottom;
     IBOutlet   UITableView         *m_tableView;
     int8_t                         m_iroomType;
     NSMutableArray                 *m_arrayStoreDataSouce;
     NSMutableArray                 *m_arrayStoreHide;
     GameControlType                m_controlType;
     GameroomInfo                    m_roomInfo;
     BOOL                            m_bShowAll;
    //BOOL                             m_bAppearFirst;
    
     

}
@property(nonatomic,readwrite) GameControlType  controlType;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil controlType:(GameControlType)iType;
-(IBAction)ClickBack:(UIButton *)sender;
-(IBAction)ClickFullRoom:(UIButton *)sender;
-(IBAction)ClickSpeed:(UIButton *)sender;
-(IBAction)ClickFresh:(UIButton *)sender;
-(IBAction)ClickFirstlevel:(UIButton *)sender;
-(IBAction)ClickMidlevel:(UIButton *)sender;
-(IBAction)ClickHighLevel:(UIButton *)sender;
- (UIView *)tanbleHeadView:(UITableView *)tableView;
-(void)ClickInsure:(id)sender;

@end
