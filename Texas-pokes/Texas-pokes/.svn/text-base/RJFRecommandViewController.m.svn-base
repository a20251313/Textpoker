//
//  RJFRecommandViewController.m
//  Texas-pokes
//
//  Created by ran on 12-10-8.
//
//

#import "RJFRecommandViewController.h"
#include "packethandler.h"


#define SOFTARETITLE        @"SOFTARETITLE"
#define SOFTAREVERSION      @"SOFTAREVERSION"
#define SOFTARESIZE         @"SOFTARESIZE"
#define SOFTAREURL          @"SOFTAREURL"
#define SOFTARELOGO         @"SOFTARELOGO"
#define SOFTAREDOWNNUMBER   @"SOFTAREDOWNNUMBER"
#define SOFTAREIDNUMBER     @"SOFTAREIDNUMBER"
@interface RJFRecommandViewController ()

@end

@implementation RJFRecommandViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        m_arrStoreDatasource = [[NSMutableArray alloc] init];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



-(void)dealloc
{
    if (btnBack)
    {
        [btnBack release];
        btnBack = nil;
    }
    if (m_tableView)
    {
        [m_tableView release];
        m_tableView = nil;
    }
    if (m_arrStoreDatasource)
    {
        [m_arrStoreDatasource removeAllObjects];
        [m_arrStoreDatasource release];
        m_arrStoreDatasource = nil;
    }
    [super dealloc];
}

-(void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotiFromServer:)
                                                 name:BNRRECEIVEMESSAGEFROMSERVER
                                               object:nil];
    BasisZipAndUnzip   *basiz = [[BasisZipAndUnzip alloc] initWithSize:40];
    UserInfo  *shareUser = [UserInfo shareInstance];
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    size_t  size = 0;
    [socket SendCharMessage:[basiz syncWithRequest:REQ_RECOMMENDATION
                                            userID:shareUser.userID
                                       structArray:NULL
                                      structNumber:1
                                          dataSize:&size]
                       size:[basiz dataSize]];
    
    
    //    DZPK_CLIENT_REQ_RECOMMEND_APP  appinfo = {2,shareUser.userID,10,0,DZPKPRODUCTID};
    //
    //    [socket SendCharMessage:[basiz syncWithRequest:REQ_RECOMMEND_APP
    //                                            userID:shareUser.userID
    //                                       structArray:&appinfo
    //                                      structNumber:1
    //                                          dataSize:&size] size:[basiz dataSize]];
    
    
    [basiz release];
    basiz = nil;
    ShowHUD(@"加载应用程序信息中，请稍候", self);
}
-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)receiveNotiFromServer:(NSNotification *)note
{
    RJFTcpSocket  *m_socket = [note object];
    NSDictionary  *dicInfo = [note userInfo];
    if (dicInfo &&(m_socket.tag == RESOURCESOCKEtTAG))
    {
        
    }else
    {
        return;
    }
    
    size_t  size = [[dicInfo valueForKey:TCPSOCKETSIZE] intValue];
    BasisZipAndUnzip   *objShare = [[BasisZipAndUnzip alloc] initWithSize:size+10];
    int  requestCode = -1;
    int  iItemCount = -1;
    NSData  *data = [[note userInfo] valueForKey:TCPSOCKETMESSAGE];
    logMyLogInfo(@"data:%s",[data bytes]);
    void *handle =[objShare PhaseInfoFromData:(int8_t *)[data bytes]
                                       number:&iItemCount
                               outRequestCode:&requestCode];
    logMyLogInfo(@"requestcode:%d",requestCode);
    
    if (requestCode == REQ_RECOMMENDATION)
    {
        
        DZPK_SERVER_REQ_RECOMMENDATION  *info = (DZPK_SERVER_REQ_RECOMMENDATION*)handle;
        HideHUD(self, YES);
        if (info->status)
        {
            [RJFWarnView addinSelfview:self.navigationController.view
                              delegate:nil
                               message:@"获取应用推荐失败！"
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
            free(handle);
            handle = NULL;
            [objShare release];
            return;
        }
        //        NSString    *title;
        //        NSString    *logo;
        //        NSString    *version;
        //        NSString    *size;
        //        NSString    *url;
        NSArray  *arrayTitle = [info->title componentsSeparatedByString:COMPONETSTRING];
        NSArray  *arrayLogo = [info->logo componentsSeparatedByString:COMPONETSTRING];
        NSArray  *arrayVersion = [info->version componentsSeparatedByString:COMPONETSTRING];
        NSArray  *arraySize = [info->size componentsSeparatedByString:COMPONETSTRING];
        NSArray  *arrayUrl =  [info->url componentsSeparatedByString:COMPONETSTRING];
        for (int i = 0;i < info->idCount;i++)
        {
            NSString *strTitle = [arrayTitle objectAtIndex:i];
            NSString *strLogo = [arrayLogo objectAtIndex:i];
            NSString *strVersion = [arrayVersion objectAtIndex:i];
            NSString *strSize = [arraySize objectAtIndex:i];
            NSString *strUrl = [arrayUrl objectAtIndex:i];
            
            NSDictionary   *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:strTitle,SOFTARETITLE,strLogo,SOFTARELOGO,strVersion,SOFTAREVERSION,strSize,SOFTARESIZE,strUrl,SOFTAREURL,@(info->idNumber[i]),SOFTAREIDNUMBER,@(info->download_number[i]),SOFTAREDOWNNUMBER, nil];
            [m_arrStoreDatasource addObject:dicInfo];
            [m_tableView reloadData];
            
        }
        
        logMyLogInfo(@"status:%d",info->status);
        
    }else if (requestCode == REQ_RECOMMEND_APP)
    {
        DZPK_SERVER_REQ_RECOMMEND_APP  *info = (DZPK_SERVER_REQ_RECOMMEND_APP*)info;
        NSLog(@"status:%d,num:%d",info->status,info->listNum);
    }
    
    
    
    
    
    
    
    
    free(handle);
    handle = NULL;
    [objShare release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_arrStoreDatasource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"q"];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"q"] autorelease];
        CGFloat   Xpoint = 5;
        CGFloat   XSep = 5;
        UIImageView   *imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(Xpoint, 5, 50, 50)];
        imageView.tag = 1;
        [cell.contentView addSubview:imageView];
        [imageView release];
        
        Xpoint += 50+XSep;
        
        UIFont  *font = [UIFont systemFontOfSize:14];
        UILabel  *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(Xpoint, 5, 130, 50)];
        [labelTitle setBackgroundColor:[UIColor clearColor]];
        [labelTitle setTextAlignment:UITextAlignmentLeft];
        [labelTitle setTextColor:[UIColor blackColor]];
        labelTitle.tag = 2;
        [labelTitle setFont:[UIFont systemFontOfSize:18]];
        [cell.contentView addSubview:labelTitle];
        [labelTitle release];
        
        Xpoint += 130+XSep;
        UILabel  *labelSize = [[UILabel alloc] initWithFrame:CGRectMake(Xpoint, 3, 90, 25)];
        [labelSize setFont:font];
        [labelSize setBackgroundColor:[UIColor clearColor]];
        [labelSize setTextColor:[UIColor blackColor]];
        labelSize.tag = 3;
        [cell.contentView addSubview:labelSize];
        [labelSize release];
        
        UILabel  *labelVersion = [[UILabel alloc] initWithFrame:CGRectMake(Xpoint, 3+25+3, 90, 25)];
        [labelVersion setBackgroundColor:[UIColor clearColor]];
        labelVersion.tag = 4;
        [labelVersion setFont:font];
        [cell.contentView addSubview:labelVersion];
        [labelVersion setTextColor:[UIColor blackColor]];
        [labelVersion release];
        Xpoint += 90+XSep;
        
        UILabel  *labelDownload = [[UILabel alloc] initWithFrame:CGRectMake(Xpoint, 3+12.5, 70, 25)];
        labelDownload.tag = 5;
        [labelDownload setFont:font];
        [labelDownload setBackgroundColor:[UIColor clearColor]];
        [labelDownload setTextColor:[UIColor blackColor]];
        [cell.contentView addSubview:labelDownload];
        [labelDownload release];
        
        
        Xpoint += 70+XSep;
        UIButton  *btnDoload = [[UIButton alloc] initWithFrame:CGRectMake(Xpoint, 12.5, 60, 35)];
        btnDoload.tag = 6;
        [btnDoload addTarget:self
                      action:@selector(downApp:)
            forControlEvents:UIControlEventTouchUpInside];
        [btnDoload setTitle:@"下载" forState:UIControlStateNormal];
        [btnDoload setBackgroundImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
        [cell.contentView addSubview:btnDoload];
        [btnDoload release];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    UIView  *view = [cell contentView];
    NSDictionary  *dicInfo = [m_arrStoreDatasource objectAtIndex:indexPath.row];
    
    UIImageView  *imageView = (UIImageView *)[view viewWithTag:1];
    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dicInfo valueForKey:SOFTARELOGO]]]];
    
    
    UILabel  *label =(UILabel *)[view viewWithTag:2];
    [label setText:[dicInfo valueForKey:SOFTARETITLE]];
    label = (UILabel *)[view viewWithTag:3];
    
    [label setText:[NSString stringWithFormat:@"大小:%@MB",[dicInfo valueForKey:SOFTARESIZE]]];
    label = (UILabel *)[view viewWithTag:4];
    [label setText:[NSString stringWithFormat:@"版本：%@",[dicInfo valueForKey:SOFTAREVERSION]]];
    label = (UILabel *)[view viewWithTag:5];
    label.text = [NSString stringWithFormat:@"下载：%@",[dicInfo valueForKey:SOFTAREDOWNNUMBER]];
    
    
    return cell;
}

-(void)downApp:(UIButton*)sender
{
    CGPoint point = sender.center;
    point = [m_tableView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [m_tableView indexPathForRowAtPoint:point];
    NSDictionary  *dicInfo = [m_arrStoreDatasource objectAtIndex:indexpath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dicInfo valueForKey:SOFTAREURL]]];
    
    
}
-(IBAction)ClickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
@end
