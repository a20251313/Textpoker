//
//  RJFChargeViewController.h
//  Texas-pokes
//
//  Created by popo on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayAlertView.h"
#import "RJFMainAppDelegate.h"
#import "UserInfo.h"
#import "RJFWarnView.h"
#import "PublicDefine.h"
#import "InAppPurchaseManager.h"
//
//测试商品信息封装在Product中,外部商户可以根据自己商品实际情况定义
//
@interface Product : NSObject{
@private
	float     _price;
	NSString *_subject;
	NSString *_body;
	NSString *_orderId;
}

@property (nonatomic, assign) float price;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) NSString *orderId;
@end


typedef enum CHARGECONTROLTYPE
{
    CHARGETYPE,
    EXCHANGETYPE,
    CHAREDETAILTYPE,
}ChargeControlType;

@interface RJFChargeViewController : UIViewController<BNRPayAlertView,BNRWarnViewDelegate>
{
    IBOutlet     UIButton       *btnBack;
    IBOutlet     UIButton       *btnCharge;
    IBOutlet     UIButton       *btnExchange;
    IBOutlet     UIButton       *btnChargeDetail;
    
    IBOutlet     UILabel        *labelChips;
    IBOutlet     UILabel        *labelIBeans;
    IBOutlet     UILabel        *labelRule;
    
    IBOutlet    UITextView      *textViewDeatil;
    
    IBOutlet     UIImageView    *imagviewChips;
    IBOutlet     UIImageView   *imagviewiBeans;
    
    IBOutlet     UITableView    *m_tableView;
    NSMutableArray              *m_arrayStoreDataSource;
    ChargeControlType           m_chargeCtlType;
    NSInteger                   m_index;
    
    
    UserInfo                    *m_objShareUser;
    int8_t                       m_chargeType;
    
    BOOL                         m_bIsChareModel;
}

-(IBAction)clickBack:(UIButton *)sender;
-(IBAction)clickCharge:(UIButton *)sender;
-(IBAction)clickExchange:(UIButton *)sender;
-(IBAction)clickChargeDetail:(UIButton *)sender;
-(void)addExchangeOrChargeInfoToarray:(BOOL)bExchange;
-(void)removeHUDView:(id)thread;

@end
