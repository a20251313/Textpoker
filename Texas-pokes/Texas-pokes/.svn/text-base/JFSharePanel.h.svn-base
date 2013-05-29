//
//  JFSharePanel.h
//  Texas-pokes
//
//  Created by ran on 13-1-21.
//
//

#import <UIKit/UIKit.h>

@interface JFSharePanel : UIView<UITextViewDelegate>
{
    
    NSInteger       m_iShareType;
    NSString        *m_strShareContent;
    UIImage         *m_shareImage;
    BOOL            m_bIsSendImage;
    
}

@property(readwrite)int8_t  shareType,shareContentType;
@property(readwrite)int32_t shareBounds;
@property(readwrite)BOOL        iSSendImage;
@property(copy)NSString        *shareContent;
@property(readwrite,retain)UIImage  *shareImage;


// ishareContentType  1  normal share; 2  freshTeach    3 maxwin  ; 4 level up
-(id)initWithShareType:(NSInteger)type
               content:(NSString *)strContent
                 image:(UIImage*)image
      shareContentType:(int8_t)ishareContentType;
@end
