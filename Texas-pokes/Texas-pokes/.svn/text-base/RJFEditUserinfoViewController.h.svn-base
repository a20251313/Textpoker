//
//  RJFEditUserinfoViewController.h
//  Texas-pokes
//
//  Created by popo on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "PublicDefine.h"
#import "RJFWarnView.h"
#import <QuartzCore/QuartzCore.h>
#import "ModelActionSheet.h"


@interface RJFEditUserinfoViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,BNRWarnViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,BNRUSERCHOOSEINACTIONSHEET>
{
    IBOutlet    UIButton        *btnBack;
    IBOutlet    UIButton        *btnSave;
    IBOutlet    UITableView     *m_tableView;
    IBOutlet    UIImageView     *imageiewedits;
    IBOutlet    UIImageView     *userImageView;
    
    UserInfo            *Myuser;
    
    UIButton            *btnEdit;
    UIButton            *btnArrowSelect;
    
    UITextField         *textName;
    UITextField         *textSex;
    
    NSString            *m_strPicName;
    NSMutableString     *m_strSex;

    BOOL            m_bisPick;
    BOOL            m_bModifyPic;
}
@property(copy)NSString     *HeadPicName;
-(IBAction)clickBack:(id)sender;
-(IBAction)clickSave:(id)sender;
-(IBAction)clickEdit:(id)sender;
-(IBAction)clickArrowSelect:(id)sender;
-(IBAction)resignKey:(id)sender;


@end
