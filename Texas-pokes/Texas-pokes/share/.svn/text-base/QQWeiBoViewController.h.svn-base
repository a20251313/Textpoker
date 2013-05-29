//
//  QQWeiBoViewController.h
//  SinaWeiBoSDKDemo
//
//  Created by popo on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

//QQ微博（暂时不用）

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface QQWeiBoViewController : UIViewController<UIWebViewDelegate>
{
    NSString *appKey;
    NSString *appSecret;
    NSString *tokenKey;
    NSString *tokenSecret;
    NSString *myverifier;
    NSString *myresponse;
    UIWebView *mWebView;
    NSURLConnection *connection;
    
    NSMutableData *responseData;
    MBProgressHUD *_indicatorView;
    UITextView    *m_textView;
}


@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *appSecret;
@property (nonatomic, copy) NSString *tokenKey;
@property (nonatomic, copy) NSString *tokenSecret;
@property (nonatomic, copy) NSString *myverifier;
@property (nonatomic, copy) NSString *myresponse;
@property (nonatomic, retain) NSURLConnection	*connection;
@property (nonatomic, retain) NSMutableData		*responseData;
@property (nonatomic, retain) MBProgressHUD *_indicatorView;

@end
