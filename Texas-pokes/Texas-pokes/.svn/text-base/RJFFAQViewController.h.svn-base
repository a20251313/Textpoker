//
//  RJFFAQViewController.h
//  Texas-pokes
//
//  Created by popo on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"

typedef enum
{
    FAQPAGETYPE,
    ADVICEPAGETYPE,
}FAQCONTROLTYPE;

@interface RJFFAQViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    IBOutlet     UIButton       *btnBack;
    IBOutlet     UITextView     *textViewAdvice;
    IBOutlet     UIButton       *btnAdvice;
    IBOutlet     UIButton       *btnFAQ;
    IBOutlet     UIButton       *btnSend;
    
    IBOutlet     UITableView       *m_tableView;
    UIScrollView                   *scorView;
    
    IBOutlet    UILabel         *labelSepLine;
    IBOutlet    UILabel         *labelCustom;
    IBOutlet    UILabel         *labelPhone;
    IBOutlet    UILabel         *labelEmail;
    IBOutlet    UILabel         *labelFAQTitle;
    IBOutlet    UIImageView     *imageView;
    FAQCONTROLTYPE              m_faqControlType;
    NSMutableArray              *m_arrayStoreFAQs;
}



-(IBAction)clickBack:(UIButton *)sender;
-(IBAction)clickAdvice:(UIButton *)sender;
-(IBAction)clickFAQ:(UIButton *)sender;
-(IBAction)clickSend:(UIButton *)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  type:(FAQCONTROLTYPE)FAQType;
@end
