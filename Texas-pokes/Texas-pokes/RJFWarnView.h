//
//  RJFWarnView.h
//  Texas-pokes
//
//  Created by popo on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"


@protocol BNRWarnViewDelegate;

typedef enum BUTTONSHOW
{
    BOTHBUTTON,
    CANCELBUTTON,
    INSUREBUTTON
}BUTTONSHOWTYPE;
@interface RJFWarnView : UIView
{
    UIImageView   *imageViewbg;
    UIButton      *btnCancel;
    UIButton      *btnInsure;
    UITextView    *TextwarningMessage;
    id <BNRWarnViewDelegate> m_delegate;
    UIView        *mainView;

}
+(id)shareInstance;
@property(nonatomic,assign)id<BNRWarnViewDelegate> delegate;
@property(assign)UIView  *mainView;
+(void)addinSelfview:(UIView *)uiview delegate:(id)delegate message:(NSString *)strMessage buttontype:(BUTTONSHOWTYPE)iType InsureButton:(NSString *)strInsuretitle CancelButton:(NSString *)strCancelTitle;
+(void)setnilDelegate;
@end

@protocol BNRWarnViewDelegate <NSObject>
@optional
-(void)ClickCancel:(id)sender;
-(void)ClickInsure:(id)sender;

@end
