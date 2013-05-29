//
//  RJFRecommandViewController.m
//  Texas-pokes
//
//  Created by ran on 12-10-8.
//
//

#import "PublicDefine.h"
#if MODEFORAPPSTORE
#import "RJFRecommandViewController.h"
#import "RjfDownPicImageView.h"


#define APPSERVERHOST          @"apps.bbitoo.cn"
#define APPSERVERPORT          57800
#define DOWNAPPPICID           47


#ifndef SOFTINFO_ABOUT_APPRECOMMAND
#define SOFTINFO_ABOUT_APPRECOMMAND
#define SOFTARETITLE        @"SOFTARETITLE"
#define SOFTAREVERSION      @"SOFTAREVERSION"
#define SOFTARESIZE         @"SOFTARESIZE"
#define SOFTAREURL          @"SOFTAREURL"
#define SOFTARELOGO         @"SOFTARELOGO"
#define SOFTAREDOWNNUMBER   @"SOFTAREDOWNNUMBER"
#define SOFTAREIDNUMBER     @"SOFTAREIDNUMBER"
#define SOFTAREAPPID        @"APPID"
#define SOFTAREUPDATETIME   @"SOFTAREUPDATETIME"
#define SOFTAREDISPLAYSEQUE  @"DISPLAYSEQUE"
#define SOFTARELANGUAGE     @"SOFTARELANGUAGE"
#define SOFTAREDESPRICTION  @"SOFTAREDESPRICTION"
#endif
//#include "appcenter.h"



@interface RJFRecommandViewController ()

@end

@implementation RJFRecommandViewController
@synthesize fileport = m_ifilePort;
@synthesize fileHost = m_strHost;

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
    
   // m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    setAllViewautoResize(self.view);
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
    if (m_appDownload)
    {
        [m_appDownload release];
        m_appDownload = nil;
    }
    [super dealloc];
}

-(void)viewDidAppear:(BOOL)animated
{

    ShowHUD(NSLocalizedString(@"加载应用程序信息中，请稍候", nil), self,25);
    m_appDownload = [[RJFAppDownload alloc] initWithHost:APPSERVERHOST
                                                    Port:APPSERVERPORT
                                                Delagate:self
                                                     tag:0];
    [super viewDidAppear:animated];
    NSLog(@"appdowninfo:%@",m_appDownload);
}
-(void)viewDidDisappear:(BOOL)animated
{
    [m_appDownload disConnect];
     [super viewDidDisappear:animated];
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)receiveNotiFromServer:(NSNotification *)note
{

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
        [tableView setBackgroundColor:[UIColor clearColor]];
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"q"] autorelease];
         tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        CGFloat   Xpoint = 5;
        CGFloat   XSep = 5;
        RjfDownPicImageView   *imageView  = [[RjfDownPicImageView alloc] initWithFrame:CGRectMake(Xpoint, 5, 50, 50)];
        imageView.tag = 1;
        [cell.contentView addSubview:imageView];
        [imageView release];
        
        Xpoint += 50+XSep;
        
        UIFont  *font = [UIFont systemFontOfSize:14];
        UILabel  *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(Xpoint, 5, 180, 50)];
        [labelTitle setBackgroundColor:[UIColor clearColor]];
        [labelTitle setTextAlignment:NSTextAlignmentLeft];
        [labelTitle setTextColor:[UIColor blackColor]];
        labelTitle.tag = 2;
        [labelTitle setFont:[UIFont systemFontOfSize:18]];
        [cell.contentView addSubview:labelTitle];
        [labelTitle release];
        
        Xpoint += 160+XSep;
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
      //  Xpoint += 90+XSep;
        
//        UILabel  *labelDownload = [[UILabel alloc] initWithFrame:CGRectMake(Xpoint, 3+12.5, 70, 25)];
//        labelDownload.tag = 5;
//        [labelDownload setFont:font];
//        [labelDownload setBackgroundColor:[UIColor clearColor]];
//        [labelDownload setTextColor:[UIColor blackColor]];
//        [cell.contentView addSubview:labelDownload];
//        [labelDownload release];
        
        
        Xpoint += 100+XSep;
        UIButton  *btnDoload = [[UIButton alloc] initWithFrame:CGRectMake(Xpoint, 12.5, 90, 40)];
        btnDoload.tag = 6;
        [btnDoload addTarget:self
                      action:@selector(downApp:)
            forControlEvents:UIControlEventTouchUpInside];
        [btnDoload setTitle:NSLocalizedString(@"下载", nil) forState:UIControlStateNormal];
        [btnDoload setBackgroundImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
        [cell.contentView addSubview:btnDoload];
        [btnDoload release];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    UIView  *view = [cell contentView];
    NSDictionary  *dicInfo = [m_arrStoreDatasource objectAtIndex:indexPath.row];
    
    RjfDownPicImageView  *imageView = (RjfDownPicImageView *)[view viewWithTag:1];
    [imageView StartDownPic:[dicInfo valueForKey:SOFTARELOGO]
                  requestID:DOWNAPPPICID
                 fileServer:self.fileHost
                       port:self.fileport];
   // imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dicInfo valueForKey:SOFTARELOGO]]]];
    
    
    UILabel  *label =(UILabel *)[view viewWithTag:2];
    [label setText:[dicInfo valueForKey:SOFTAREDESPRICTION]];
    label = (UILabel *)[view viewWithTag:3];
    
  
    [label setText:[NSString stringWithFormat:NSLocalizedString(@"大小:%@KB", nil),[dicInfo valueForKey:SOFTARESIZE]]];
    label = (UILabel *)[view viewWithTag:4];
    [label setText:[NSString stringWithFormat:NSLocalizedString(@"版本：%@", nil),[dicInfo valueForKey:SOFTAREVERSION]]];
//    label = (UILabel *)[view viewWithTag:5];
//    label.text = [NSString stringWithFormat:@"下载：%@",[dicInfo valueForKey:SOFTAREDOWNNUMBER]];
    
    
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




-(void)receiveAppInfo:(NSDictionary *)dicInfo
{
    HideHUD(self, YES);
    if (dicInfo == nil)
    {
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:NSLocalizedString(@"提示\n当前没有应用可以推荐", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
        return;
    }
    if ([dicInfo valueForKey:@"FILEHOST"])
    {
        self.fileHost = [dicInfo valueForKey:@"FILEHOST"];
    }
    if ([dicInfo valueForKey:@"FILEPORT"])
    {
        self.fileport = [[dicInfo valueForKey:@"FILEPORT"] intValue];
    }
    [m_arrStoreDatasource removeAllObjects];
    [m_arrStoreDatasource addObjectsFromArray:[dicInfo valueForKey:@"ARRAY"]];
    [m_tableView reloadData];
}
@end
#endif
