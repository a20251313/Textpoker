//
//  WBViewController.m
//  SinaWeiBoSDKDemo
//
//  Created by Wang Buping on 11-12-7.
//  Copyright (c) 2011 Sina. All rights reserved.
//

#import "SinaWeiBoSDKDemoViewController.h"
#import "QQWeiBoViewController.h"
//#import "SharedController.h"
#import "TimeViewOnTop.h"
#import "ROError.h"
#import "UserInfo.h"




#ifndef SINA_LOGIN_APP_INFO
#define SINA_LOGIN_APP_INFO
#pragma mark  - sinaLogin
#define kWBSDKDemoAppKey    @"2828941055"
#define kWBSDKDemoAppSecret @"52e840787e579c8340d65f1b91b7191e"
#define kWBSDKDemoURL       @"http://www.o-popo.com"
#endif


//#import "NetworkFunction.h"

// TODO:
// Define your AppKey & AppSecret here to eliminate the errors


#ifndef kWBSDKDemoAppKey
#error
#endif

#ifndef kWBSDKDemoAppSecret
#error
#endif

#define kWBAlertViewLogOutTag 100
#define kWBAlertViewLogInTag  101

@interface SinaWeiBoSDKDemoViewController (Private)

- (void)dismissTimelineViewController;
- (void)presentTimelineViewController:(BOOL)animated;
- (void)presentTimelineViewControllerWithoutAnimation;

@end

@implementation SinaWeiBoSDKDemoViewController

@synthesize weiBoEngine;
@synthesize timeLineViewController;
@synthesize listData;
@synthesize renren = _renren;


-(IBAction)clickBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


-(void) iwillbackto:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    
    [weiBoEngine setDelegate:nil];
    [weiBoEngine release], weiBoEngine = nil;
    
    [timeLineViewController release], timeLineViewController = nil;
    
    [indicatorView release], indicatorView = nil;
    [listData release];
    [sinaWeiboTableView setDelegate:nil];
    [sinaWeiboTableView setDataSource:nil];
    [sinaWeiboTableView release], sinaWeiboTableView = nil;
    _renren =nil;
    
    if (backButton)
    {
        [backButton release];
        backButton = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}

#pragma mark - View lifecycle
- (void)onLogBackButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WBEngine *engine = [[WBEngine alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
    [engine setRootViewController:self];
    [engine setDelegate:self];
    [engine setRedirectURI:kWBSDKDemoURL];
    [engine setIsUserExclusive:NO];
    self.weiBoEngine = engine;
    [engine release];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"新浪微博",@"腾讯微博",nil];//@"短信", nil];
    self.listData = array;
    [array release];
    
    //    backButton = [[UIButton alloc] init];
    //    backButton.backgroundColor = C
    
    
    [sinaWeiboTableView setBackgroundColor:[UIColor clearColor]];
    //[sinaWeiboTableView setFrame:CGRectMake(0, 64, 320, 170)];
    [sinaWeiboTableView setScrollEnabled:NO];
    
    [self.view addSubview:sinaWeiboTableView];
    
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView setCenter:CGPointMake(160, 240)];
    [self.view addSubview:indicatorView];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AccountLoginElseWhere" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountLoginElseWhere:)
                                                 name:@"AccountLoginElseWhere" object:nil];
    setAllViewautoResize(self.view);
}

- (void)viewDidUnload
{
    [indicatorView release], indicatorView = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//	[super viewWillDisappear:animated];
//}
//
//- (void)viewDidDisappear:(BOOL)animated
//{
//	[super viewDidDisappear:animated];
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}



#pragma mark - User Actions

- (void)onLogInOAuthButtonPressed
{
    
    
    
   // [weiBoEngine logIn];
    
    if ([weiBoEngine isLoggedIn] && ![weiBoEngine isAuthorizeExpired])
    {
        [self performSelector:@selector(presentTimelineViewControllerWithoutAnimation) withObject:nil afterDelay:0.0];
    }else
    {
       [weiBoEngine logIn]; 
    }
}

- (void)onLogInXAuthButtonPressed
{
    WBLogInAlertView *logInView = [[WBLogInAlertView alloc] init];
    [logInView setDelegate:self];
    [logInView show];
    [logInView release];
}

- (void)onLogOutButtonPressed
{
    [weiBoEngine logOut];
}

- (void)dismissTimelineViewController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)presentTimelineViewController:(BOOL)animated
{
    
    //  ShareToSinaWeiboViewController  *control = [ShareToSinaWeiboViewController sinaWeiBOInstance];
    // [self.navigationController pushViewController:control animated:YES];
    
    WBSDKTimelineViewController *controller = [[WBSDKTimelineViewController alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
    
    self.timeLineViewController = controller;
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"登出" style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(onLogOutButtonPressed)];
    
    
    [controller.navigationItem setLeftBarButtonItem:leftBtn];
    [leftBtn release];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"写微博" style:UIBarButtonItemStylePlain
                                                                target:controller
                                                                action:@selector(onSendButtonPressed)];
    
    
    [controller.navigationItem setRightBarButtonItem:rightBtn];
    [rightBtn release];
    
    [controller.navigationItem setTitle:@"微博"];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [controller release];
   // [self presentModalViewController:navController animated:animated];
    [self presentViewController:navController animated:animated completion:NULL];
    [navController release];
}

- (void)presentTimelineViewControllerWithoutAnimation
{
    [self presentTimelineViewController:NO];
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == kWBAlertViewLogInTag)
    {
        [self presentTimelineViewController:YES];
    }
    else if (alertView.tag == kWBAlertViewLogOutTag)
    {
        [self dismissTimelineViewController];
    }
}

#pragma mark - WBLogInAlertViewDelegate Methods

- (void)logInAlertView:(WBLogInAlertView *)alertView logInWithUserID:(NSString *)userID password:(NSString *)password
{
    [weiBoEngine logInUsingUserID:userID password:password];
    
    [indicatorView startAnimating];
}

#pragma mark - WBEngineDelegate Methods

#pragma mark Authorize

- (void)engineAlreadyLoggedIn:(WBEngine *)engine
{
    [indicatorView stopAnimating];
    if ([engine isUserExclusive])
    {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"请先登出！"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

- (void)engineDidLogIn:(WBEngine *)engine
{
    [indicatorView stopAnimating];
    
    [self presentTimelineViewController:YES];
   /* UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"登录成功！"
													  delegate:self
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
    [alertView setTag:kWBAlertViewLogInTag];
	[alertView show];
	[alertView release];*/
}

- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error
{
    [indicatorView stopAnimating];
#ifdef DEBUG_VERSION
    logMyLogInfo(@"didFailToLogInWithError: %@", error);
#endif
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"登录失败！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)engineDidLogOut:(WBEngine *)engine
{
    
    [self dismissTimelineViewController];
    /*UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"登出成功！"
													  delegate:self
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
    [alertView setTag:kWBAlertViewLogOutTag];
	[alertView show];
	[alertView release];*/
}

- (void)engineNotAuthorized:(WBEngine *)engine
{
    
}

- (void)engineAuthorizeExpired:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"请重新登录！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

#pragma mark -
#pragma mark Table Data Source Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *FirstLevel
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"weibocell"];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"weibocell"] autorelease];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }
    
    UIImage *image  = [UIImage imageNamed:@"rricon.png"];
    UIImage *image1 = [UIImage imageNamed:@"QQweiboicon.png"];
    UIImage *image2 = [UIImage imageNamed:@"sinaicon.png"];
    UIImage *image3 = [UIImage imageNamed:@"smsicon.png"];
    
    
    NSInteger row = [indexPath row];
    switch (row) {
        case 0:
            cell.imageView.image = image2;
            break;
        case 2:
            cell.imageView.image = image;
            break;
        case 1:
            cell.imageView.image = image1;
            break;
        case 3:
            cell.imageView.image = image3;
            break;
        default:
            break;
    }
    
    cell.textLabel.text = [listData objectAtIndex:row];
    return cell;
    
}
-(void) onRenRenButtonPressed
{
    //   [self addChildViewController:[[[PasswordFlowLoginViewController alloc] init] autorelease]];
    
    //      RenRenViewController *controller = [[RenRenViewController alloc] init];
    //      [self.navigationController pushViewController:controller animated:YES];
    ////    [self presentModalViewController:controller animated:YES];
    //    [controller release];
    if(![[Renren sharedRenren] isSessionValid])
    {
        [[Renren sharedRenren] authorizationWithPermisson:nil andDelegate:self];
    }
    else
    {
        [[Renren sharedRenren] logout:self];
        if(![[Renren sharedRenren] isSessionValid])
        {
            [[Renren sharedRenren] authorizationWithPermisson:nil andDelegate:self];
        }
    }
}

-(void) onQQButtonPressed
{
    QQWeiBoViewController* controller = [[QQWeiBoViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}
-(void) onMailButtonPressed
{
//    SharedController* controller = [[SharedController alloc] init];
//    [self.navigationController pushViewController:controller animated:YES];
//    [controller release];
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // ShareToSinaWeiboViewController  *control;
    NSInteger row = [indexPath row];
    switch (row) {
        case 0:
            [self onLogInOAuthButtonPressed];
           // [self onLogInXAuthButtonPressed];
             // control = [ShareToSinaWeiboViewController sinaWeiBOInstance];
            // /[self.navigationController pushViewController:control animated:YES];
            break;
        case 1:
             [self onQQButtonPressed];
           // [self onRenRenButtonPressed];
            break;
        case 2:
           
            break;
        case 3:
            [self onMailButtonPressed];
            break;
            
        default:
            break;
    }
}

-(void)renrenDidLogin:(Renren *)renren
{
    //	StatusPostViewController *viewController = [[StatusPostViewController alloc] initWithNibName:nil bundle:[NSBundle mainBundle]];
    //	viewController.renren = self.renren;
    //   // [self.navigationController pushViewController:viewController animated:YES];
    ////    [self presentModalViewController:viewController animated:YES];
    //	[viewController release];
    NSString *mymessage = [NSString stringWithFormat:@"玩扑克赢话费，还有这等好事存在？兄弟们速度来体验。下载地址：http://www.o-popo.com/"];//user_id];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 @"http://www.o-popo.com",@"url",
                                 @"德州扑克",@"name",
                                 @"访问我们",@"action_name",
                                 @"http://www.o-popo.com",@"action_link",
                                 @"来自德州扑克",@"description",
                                 @"德州扑克",@"caption",
                                 @"http://hdn.xnimg.cn/photos/hdn421/20090923/1935/head_1Wmz_19242g019116.jpg",@"image",
                                 mymessage, @"message",
                                 nil];
    [[Renren sharedRenren] dialogInNavigation:@"feed" andParams:params andDelegate:self];
}

- (void)renren:(Renren *)renren loginFailWithError:(ROError*)error;
{
	NSString *title = [NSString stringWithFormat:@"Error code:%d", [error code]];
	//NSString *description = [NSString stringWithFormat:@"%@", [error.userInfo objectForKey:@"error_msg"]];
	UIAlertView *alertView =[[[UIAlertView alloc] initWithTitle:title message:@"aa" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] autorelease];
	[alertView show];
}

#pragma mark -

-(void)showAlert:(NSString*)message{
	UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"分享成功"
                                                   message:message delegate:nil
                                         cancelButtonTitle:@"确定" otherButtonTitles:nil];
	[alert show];
    [alert release];
}

#pragma mark - RenrenDelegate methods

- (void)renren:(Renren *)renren requestDidReturnResponse:(ROResponse*)response{
	NSDictionary* params = (NSDictionary *)response.rootObject;
    if (params!=nil) {
        //  NSString *msg=nil;
        //        NSMutableString *result = [[NSMutableString alloc] initWithString:@"分享成功"];
        //        for (id key in params)
        //		{
        //			//msg = [NSString stringWithFormat:@"key: %@ value: %@    ",key,[params objectForKey:key]];
        //		    [result appendString:@"分享成功"];
        //		}
		[self showAlert:@""];
        //      [self.navigationController  popViewControllerAnimated:YES];
        //        [result release];
	}
    ///////////////////////////////////////////////////////////////////////////////
    //    UITableView *myTableView = [self.view.subviews objectAtIndex:0];
    //    [myTableView deselectRowAtIndexPath:[myTableView indexPathForSelectedRow] animated:YES];
    [[Renren sharedRenren] logout:self];
    
}

- (void)renren:(Renren *)renren requestFailWithError:(ROError*)error{
	//Demo Test
    NSString* errorCode = [NSString stringWithFormat:@"Error:%d",error.code];
    NSString* errorMsg = [error localizedDescription];
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:errorCode message:errorMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)accountLoginElseWhere:(NSNotification *)notification
{
    [self dismissTimelineViewController];
}


@end
