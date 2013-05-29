//
//  RJFShareViewController.m
//  Texas-pokes
//
//  Created by ran on 13-1-21.
//
//

#import "RJFShareViewController.h"
#import "JFSharePanel.h"
#import "PublicDefine.h"


#define SHAREWIDTH          480
#define SHAREHEIGHT         320

@interface RJFShareViewController ()

@end

@implementation RJFShareViewController
@synthesize shareContent,shareImage,shareContentType,shareBounds;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        // Custom initialization
    }
    return self;
}

-(id)initWithContent:(NSString *)strContent WithImage:(UIImage  *)image shareContentType:(int8_t)ishareContentType;
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        self.shareImage = image;
        self.shareContent = strContent;
        self.shareContentType = ishareContentType;
        // Custom initialization
    }
    return self;
}





- (void)viewDidLoad
{
    
    m_arrayDataSource = [[NSMutableArray alloc] init];
    [m_arrayDataSource addObjectsFromArray:[NSArray arrayWithObjects:@"新浪微博",@"腾讯微博", nil]];
    UIImageView   *imageViewTop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SHAREWIDTH, 51)];
    imageViewTop.image = [UIImage imageNamed:@"topline.png"];
    [self.view addSubview:imageViewTop];
    
    UILabel     *label = [[UILabel alloc] initWithFrame:CGRectMake((SHAREWIDTH-200)/2, (51-25)/2, 200, 25)];
    label.text = @"分享";
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    imageViewTop.userInteractionEnabled = YES;
    [imageViewTop addSubview:label];
  
    
    
    UIImageView     *backView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 40, 30)];
    backView.image = [UIImage imageNamed:@"back.png"];
    [imageViewTop addSubview:backView];
    UITapGestureRecognizer   *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(back:)];
    [backView addGestureRecognizer:tapGesture];
    backView.userInteractionEnabled = YES;
    [tapGesture release];
    [imageViewTop addSubview:backView];
    
    
    UIImageView  *WelcomeimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42, SHAREWIDTH, 287)];
    WelcomeimageView.image = [UIImage imageNamed:@"welcome_bg.png"];
    WelcomeimageView.userInteractionEnabled = YES;
    [self.view addSubview:WelcomeimageView];
    
    
    
    UIImageView   *bgLoginImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 48, (SHAREWIDTH-20), 250)];
    bgLoginImageView.image = [UIImage imageNamed:@"bglogin.png"];
    [self.view addSubview:bgLoginImageView];
    bgLoginImageView.userInteractionEnabled = YES; 
    
    
    UITableView   *tableview = [[UITableView alloc] initWithFrame:CGRectMake(4, 4, bgLoginImageView.frame.size.width-8, 245)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    [bgLoginImageView addSubview:tableview];
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [tableview release];
    [bgLoginImageView release];
    [WelcomeimageView release];
    [backView release];
    [label release];
    [imageViewTop release];
    
    
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view.
}


-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *FirstLevel
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"weibocell"];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"weibocell"] autorelease];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
       //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
    
    cell.textLabel.text = [m_arrayDataSource objectAtIndex:row];
    return cell;
    
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = [indexPath row];
    switch (row)
    {
        case 0:
            [self InitSinaAndLogin:nil];
            break;
        case 1:
            [self InitQQAndLogin:nil];
            break;
        case 2:
            break;
        case 3:
            break;  
        default:
            break;
    }
}

-(void)InitSinaAndLogin:(id)Thread
{
    SinaWeibo  *sinaweibo = [SinaWeibo shareInstance:self];

    

    [sinaweibo logIn];
    
}

-(void)InitQQAndLogin:(id)Thread
{
    
    TencentOAuth  *tenect = [TencentOAuth ShareInstance:self];

    if (tenect.isSessionValid  && tenect.openId)
    {
        [self tencentDidLogin:nil];
    }else
    {
       [tenect authorize:[NSArray arrayWithObjects:@"add_topic",@"add_t",@"add_pic_t",@"get_simple_userinfo", nil] inSafari:NO];  
    }
    /* if (m_Tencent == nil)
     {
     m_Tencent = [[TencentOAuth alloc] initWithAppId:QQLoginAPPKEY andDelegate:self];
     }*/
   
    
}

#pragma mark QQLogin delegate
/**
 * Called when the user successfully logged in.
 */
- (void)tencentDidLogin:(NSDictionary *)dicInfo;
{
    JFSharePanel   *jfsharePanel = [[JFSharePanel alloc] initWithShareType:1
                                                                   content:self.shareContent
                                                                     image:self.shareImage shareContentType:self.shareContentType];
    jfsharePanel.shareBounds = self.shareBounds;
    [self.view addSubview:jfsharePanel];
    [jfsharePanel release];
   // TencentOAuth  *tencent = [TencentOAuth ShareInstance:self];
    logMyLogInfo(@"-----------------------login suc ro0tInfo:%@---------------------------",dicInfo);
	// 登录成功
}
/**
 * Called when the user dismissed the dialog without logging in.
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
	if (cancelled)
    {
        logMyLogInfo(@"用户取消登录");
	}
	else {
		logMyLogInfo(@"登录失败");
	}
	
}
/**
 * Called when the notNewWork.
 */
-(void)tencentDidNotNetWork
{
    [self netWorkError:nil];
    logMyLogInfo(@"无网络连接，请设置网络");
}

-(void)netWorkError:(id)Thread
{
    [RJFWarnView addinSelfview:self.view
                      delegate:nil
                       message:NSLocalizedString(@"提示\n\n\n网络连接出现错误，请检查您的网络设置!", nil)
                    buttontype:INSUREBUTTON
                  InsureButton:INSURE
                  CancelButton:nil];
}


#pragma mark   sina delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    
    JFSharePanel   *jfsharePanel = [[JFSharePanel alloc] initWithShareType:2
                                                                   content:self.shareContent
                                                                     image:self.shareImage shareContentType:self.shareContentType];
    jfsharePanel.shareBounds = self.shareBounds;
    [self.view addSubview:jfsharePanel];
    [jfsharePanel release];
    NSLog(@"sinaweibo login in:%@",sinaweibo);
}


-(void)dealloc
{
    if (m_arrayDataSource)
    {
        [m_arrayDataSource removeAllObjects];
        [m_arrayDataSource release];
        m_arrayDataSource = nil;
    }
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{    
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
