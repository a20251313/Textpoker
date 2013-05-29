//
//  PayAlertView.h
//  Texas-pokes
//
//  Created by popo on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJFWarnView.h"
#import "PublicDefine.h"

@protocol BNRPayAlertView <NSObject>
@optional
-(void)ClickAliPay:(UIButton *)sender;
-(void)ClickYiPay:(UIButton *)sender;
-(void)ClickClose:(UIButton *)sender;
-(void)ClickInsureExchange:(id)userInfo;
-(void)ClickCancelExchange:(id)Userinfo;
@end

@interface PayAlertView : UIView
{
    BOOL           m_bIsBeanToCHips;
    UIImageView    *imageViewBg;
    id<BNRPayAlertView> delegate;
}
- (id)initWithFrame:(CGRect)frame withIbeans:(NSString *)strIBeans WithMoney:(NSString *)strMonney;
- (id)initWithFrame:(CGRect)frame withIbeans:(NSString *)strIBeans WithChips:(NSString *)strChip BeanToCHips:(BOOL)bIsBeanToCHips;
@property(nonatomic,retain)UIImageView   *viewBg;
@property(assign)id<BNRPayAlertView>      delegate;
@end
