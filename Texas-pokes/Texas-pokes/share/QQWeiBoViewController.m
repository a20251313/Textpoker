//
//  QQWeiBoViewController.m
//  SinaWeiBoSDKDemo
//
//  Created by popo on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QQWeiBoViewController.h"
#import "QWeiboSyncApi.h"
#import "QWeiboAsyncApi.h"
#import "NSURL+QAdditions.h"
#import "TimeViewOnTop.h"
#import "MBProgressHUD.h"
#import "PublicDefine.h"


#pragma mark -QQLogin info
#define QQAPPKEY       @"801285001"
#define QQAPPSECRET    @"0182260a08810ebe0ca4ded9079dd910"
#define QQLoginVERIFY_URL   @"http://open.t.qq.com/cgi-bin/authorize?oauth_token="


@implementation QQWeiBoViewController
@synthesize appKey;
@synthesize appSecret;
@synthesize tokenKey;
@synthesize tokenSecret;
@synthesize myverifier;
@synthesize myresponse;
@synthesize responseData;
@synthesize connection;
@synthesize _indicatorView;





-(void)ShareTheContext:(id)Thread
{
    
    if ([m_textView text] && ![m_textView.text isEqualToString:@""]) 
    {
        QWeiboAsyncApi *apiOne = [[[QWeiboAsyncApi alloc] init] autorelease];
        self.connection = [apiOne publishMsgWithConsumerKey:self.appKey 
                                             consumerSecret:self.appSecret 
                                             accessTokenKey:self.tokenKey 
                                          accessTokenSecret:self.tokenSecret 
                                                    content:[m_textView text]
                                                  imageFile:nil 
                                                 resultType:RESULTTYPE_JSON 
                                                   delegate:self];
        
    }
    
    
}
-(void)setTextShare:(NSString *)text
{
    [mWebView setHidden:YES];
    
    UIImageView   *imagView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 40, 40)];
    imagView.image = [UIImage imageNamed:@"QQweiboicon.png"];
    [self.view addSubview:imagView];
    [imagView release];
    UILabel  *labelText = [[UILabel alloc] initWithFrame:CGRectMake(20+40+5, 55, 300, 30)];
    [labelText setTextAlignment:NSTextAlignmentLeft];
    [labelText setBackgroundColor:[UIColor clearColor]];
    [labelText setFont:[UIFont systemFontOfSize:18]];
    [labelText setTextColor:[UIColor lightTextColor]];
    [self.view addSubview:labelText];
    [labelText setText:@"说说在德州扑克里发生的有趣的事！"];
    [labelText release];
    
    m_textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 50+40+10, 480-40, 320-150)];
    [m_textView setBackgroundColor:[UIColor whiteColor]];
    [m_textView setTextColor:[UIColor  blackColor]];
    [m_textView setText:text];
    [self.view addSubview:m_textView];
    [m_textView setFont:[UIFont systemFontOfSize:18]];
    [m_textView release];
    
    UILabel  *label = (UILabel *)[self.view viewWithTag:123];
    [label setText:@"腾讯微博开放平台"];
    UIButton *btnShare = [[UIButton alloc] initWithFrame:CGRectMake(480-80-40, 10, 80, 30)];
    [btnShare setTitle:@"分享" forState:UIControlStateNormal];
    [btnShare setBackgroundImage:[UIImage imageNamed:@"button_green"] forState:UIControlStateNormal];
    [btnShare addTarget:self action:@selector(ShareTheContext:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnShare];
    [btnShare release];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void) iwillbackto:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) dealloc
{
    [appSecret release], appSecret = nil;
    [appKey release], appKey = nil;
    [tokenKey release], tokenKey = nil;
    [tokenSecret release], tokenSecret = nil;
    [mWebView release], mWebView = nil;
    [connection release], connection = nil;
    [myresponse release];
    [myverifier release];
    [self._indicatorView release];
    
    
    [super dealloc];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.appKey = QQAPPKEY;
    self.appSecret = QQAPPSECRET;
    
    QWeiboSyncApi *api = [[[QWeiboSyncApi alloc] init] autorelease];
    NSString *retString = [api getRequestTokenWithConsumerKey:self.appKey consumerSecret:self.appSecret];
    
#ifdef DEBUG_VERSION
    NSLog(@"Get resquestToken:%@", retString);
#endif
    
    NSDictionary *params = [NSURL parseURLQueryString:retString];
    self.tokenKey = [params objectForKey:@"oauth_token"];
    self.tokenSecret = [params objectForKey:@"oauth_token_secret"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", QQLoginVERIFY_URL, self.tokenKey];
    NSURL *requestUrl = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    
    //UIImage *imageofbackground = [UIImage imageNamed:@"bg.png"];
    UIImageView *imagebackground = [[UIImageView alloc] initWithImage:nil];
    [imagebackground setFrame:CGRectMake(0, 0, 480, 320)];
    imagebackground.image = [UIImage imageNamed:@"sharebg.png"];
    [self.view addSubview:imagebackground];
   
    
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(10, 8, 40, 30)];
    [button setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button addTarget:self action:@selector(iwillbackto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    [imagebackground release];
    
    UILabel   *label = [[UILabel alloc] initWithFrame:CGRectMake((480-200)/2,8, 200, 31)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setText:@"分享"];
    [label setTextColor:[UIColor whiteColor]];
    label.tag = 123;
    [self.view addSubview:label];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label release];
    /*CGRect frame = CGRectMake(0, 0, 320, 20);
    TimeViewOnTop *timeView = [[TimeViewOnTop alloc] initWithFrame:frame];
    [self.view addSubview:timeView];
    [timeView release];
    
    UIImage *image = [UIImage imageNamed:@"形状-8-副本.PNG"];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    UIImage *buttonImage = [UIImage imageNamed:@"拨打记录2.png"];
    [imageView setFrame:CGRectMake(0, 20, 320, 44)];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 67, 30)];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    [button setTitle:@" 分享" forState:UIControlStateNormal]; 
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button addTarget:self action:@selector(iwillbackto:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(126, 31, 100, 21)];
    [label setText:@"腾讯微博"];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:imageView];
    [self.view addSubview:label];
    [self.view addSubview:button];*/
    
    //[label release];
   // [button release];
   // [imageView release];
    
    mWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 40.0f, 480.0f, 320.f)];
	mWebView.delegate = self;
	[self.view addSubview:mWebView];
    [mWebView loadRequest:request];
    

}

#pragma mark private methods

-(NSString*) valueForKey:(NSString *)key ofQuery:(NSString*)query
{
	NSArray *pairs = [query componentsSeparatedByString:@"&"];
	for(NSString *aPair in pairs){
		NSArray *keyAndValue = [aPair componentsSeparatedByString:@"="];
		if([keyAndValue count] != 2) continue;
		if([[keyAndValue objectAtIndex:0] isEqualToString:key]){
			return [keyAndValue objectAtIndex:1];
		}
	}
	return nil;
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	
	NSString *query = [[request URL] query];
	NSString *verifier = [self valueForKey:@"oauth_verifier" ofQuery:query]; 
    self.myverifier = verifier;
	
	if (verifier && ![verifier isEqualToString:@""]) 
    {
		
		QWeiboSyncApi *api = [[[QWeiboSyncApi alloc] init] autorelease];
		NSString *retString = [api getAccessTokenWithConsumerKey:self.appKey 
												  consumerSecret:self.appSecret 
												 requestTokenKey:self.tokenKey 
											  requestTokenSecret:self.tokenSecret 
														  verify:verifier];
#ifdef DEBUG_VERSION
		NSLog(@"\nfffffget access token:%@", retString);
#endif
    
        NSDictionary *params = [NSURL parseURLQueryString:retString];
        
        self.tokenKey = [params objectForKey:@"oauth_token"];
        //NSString* antuorcon = [NSString stringWithFormat:[params objectForKey:@"oauth_callback_confirmed"]];
        
#ifdef DEBUG_VERSION
        //NSLog(@"antuorcno==============%@", antuorcon);
#endif
        
       /* if ([antuorcon isEqualToString:nil]) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }*/
    
#ifdef DEBUG_VERSION
        NSLog(@"oauth_token ==== %@", self.myverifier);
#endif
        self.tokenSecret = [params objectForKey:@"oauth_token_secret"];
		
#if MODEFOR91
        [self setTextShare:@"玩扑克赢话费，还有这等好事存在？兄弟们速度来体验。下载地址：http://mobile.91.com/game/iPhone/category/cate_37/1_5.html"];
#else
        [self setTextShare:@"玩扑克赢话费，还有这等好事存在？兄弟们速度来体验。下载地址：http://www.o-popo.com/"];
#endif
        // [self.navigationController popViewControllerAnimated:YES];
       // NSDictionary* connectionreturn = [self.connection 
        
#ifdef DEBUG_VERSION
        NSLog(@"fdafdsf%@", (NSString*)(self.connection));
#endif
        
		return NO;
	}
        
	
	return YES;
}

-(void) webViewDidFinishLoad:(UIWebView *)webView
{
    [self._indicatorView removeFromSuperview];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    MBProgressHUD *indicatorView = [[MBProgressHUD alloc] initWithView:self.view];
//    indicatorView.delegate = self;
    indicatorView.labelText = @"连接腾讯中...";
    self._indicatorView = indicatorView;
    [self.view addSubview:self._indicatorView];
    [self._indicatorView show:YES];
    [indicatorView release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
     return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark -
#pragma mark NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	
    self.responseData = [NSMutableData data];
#ifdef DEBUG_VERSION
	NSLog(@"total = %qi", [response expectedContentLength]);
#endif
    UIAlertView  *av = [[UIAlertView alloc] initWithTitle:@""
                                                  message:@"分享成功"
                                                 delegate:nil 
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil, nil];
    [av show];
    [av release];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
	

	
	self.myresponse = [[[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding] autorelease];

#ifdef DEBUG_VERSION    
    NSLog(@"jfjafljadfdafadfadsfdd;%@", self.myresponse);
#endif
    
	self.connection = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	
	self.myresponse = [NSString stringWithFormat:@"connection error:%@", error];
#ifdef DEBUG_VERSION
	NSLog(@"jfjafljad;%@", self.myresponse);
#endif
	self.connection = nil;
}

@end
