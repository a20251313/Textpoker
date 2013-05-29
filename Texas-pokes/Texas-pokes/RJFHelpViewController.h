//
//  RJFHelpViewController.h
//  Texas-pokes
//
//  Created by popo on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
typedef enum
{
    GAMERULETYPE,
    ABOUTUSTYPE,
}Helptype;

@interface RJFHelpViewController : UIViewController
{
    IBOutlet   UIButton    *btnBack;
    IBOutlet   UIButton    *btnGameRule;
    IBOutlet   UIButton    *btnAboutUs;
    IBOutlet   UILabel     *labelpage;
    IBOutlet   UILabel     *labeTitle;
    IBOutlet   UIImageView  *imageViewhelp;
    NSMutableArray          *m_arrayStoreimage;
    CGPoint                 m_beginPoint;
    NSInteger               m_index;
    Helptype                m_helpType;
}
-(IBAction)clickBack:(UIButton*)sender;
-(IBAction)ClickGameRule:(UIButton*)sender;
-(IBAction)ClickAboutUs:(UIButton*)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  withType:(Helptype)helptype;
@end
