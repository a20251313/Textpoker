//
//  RJFTaskViewController.m
//  Texas-pokes
//
//  Created by ran on 12-11-16.
//
//


#define TASKSTATUS          @"TASKSTATUS"
#define TASKID              @"TASKID"
#define TASKTYPE            @"TASKTYPE"
#define TASKTITLE           @"TASKTITLE"
#define TASKDESCPRITION     @"TASKDESCPRITION"
#define TASKBOUNDS          @"TASKBOUNDS"
#define TASKALLTIMES        @"TASKALLTIMES"
#define TASKPROGRESS        @"TASKPROGRESS"
#import "RJFTaskViewController.h"
#import "PublicDefine.h"
@interface RJFTaskViewController ()

@end

@implementation RJFTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        m_arrayStoreData = [[NSMutableArray alloc] init];
        m_arrUserMess = [[NSMutableArray alloc] init];
        [m_arrUserMess addObjectsFromArray:[[NSUserDefaults standardUserDefaults] valueForKey:MESSAGEUSERINFOINLOCAL]];
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    if (m_arrayStoreData)
    {
        [m_arrayStoreData removeAllObjects];
        [m_arrayStoreData release];
        m_arrayStoreData = nil;
    }
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
    if (m_arrUserMess)
    {
        [m_arrUserMess removeAllObjects];
        [m_arrUserMess release];
        m_arrUserMess = nil;
    }
    [super dealloc];
}
- (void)viewDidLoad
{
    setAllViewautoResize(self.view);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotiFromServer:)
                                                 name:BNRRECEIVEMESSAGEFROMSERVER
                                               object:nil];
    ShowHUD(@"获取任务列表中", self,20);
    [self sendTaskRequest:nil];
    [super viewWillAppear:animated];
    
}

-(void)AddChipToArray:(int32_t)chips Types:(NSInteger)indexNumber
{
    NSDictionary  *dicInfo = [m_arrayStoreData objectAtIndex:indexNumber];
    NSString *strMsg = nil;
    switch ([[dicInfo valueForKey:TASKTYPE] intValue])
    {
            
        case 1:
            strMsg = [NSString stringWithFormat:NSLocalizedString(@"恭喜您，完成每日登录任务，奖励%d筹码", nil),chips];
            break;
        case 2:
            strMsg = [NSString stringWithFormat:NSLocalizedString(@"恭喜您，完成在线时间超过%d分钟任务，奖励%d筹码", nil),[[dicInfo valueForKey:TASKALLTIMES] intValue],chips];
            break;
        case 3:
            strMsg = [NSString stringWithFormat:NSLocalizedString(@"恭喜您，完成游戏局数超过%d局任务，奖励%d筹码", nil),[[dicInfo valueForKey:TASKALLTIMES] intValue],chips];
            break;
        case 4:
            strMsg = [NSString stringWithFormat:NSLocalizedString(@"恭喜您，完成胜利局数超过%d局任务，奖励%d筹码", nil),[[dicInfo valueForKey:TASKALLTIMES] intValue],chips];
            break;
        default:
            break;
    }
    if (strMsg != nil)
    {
        [m_arrUserMess insertObject:[NSDictionary dictionaryWithObjectsAndKeys:strMsg,MESSAGECONTENT,[NSString stringWithFormat:@"%@",[NSDate date]],MESSAGEDATE,@(0),MESSAGETYPE,nil] atIndex:0];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] setObject:m_arrUserMess forKey:MESSAGEUSERINFOINLOCAL];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark tableview delegate method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [m_arrayStoreData count];
    
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  *cell =  [tableView dequeueReusableCellWithIdentifier:@"22"];
    if (!cell)
    {
        CGFloat   fXpoint = 10;
        CGFloat   fsep = 5;
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"22"] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        UIImageView  *imageBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 50)];
        imageBg.image = [UIImage imageNamed:@"project_line_mid.png"];
        imageBg.userInteractionEnabled = YES;
        imageBg.tag = 2;
        [cell.contentView addSubview:imageBg];
        
        
        
        UIImageView  *imageViewTask = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint, 5, 44.5, 40.5)];
        imageViewTask.tag = 3;
        [cell.contentView addSubview:imageViewTask];
        [imageViewTask release];
        
        fXpoint += 44.5+fsep;
        UILabel  *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, 2, 180, 20)];
        labelTitle.tag = 4;
        [labelTitle setTextColor:[UIColor blackColor]];
        [labelTitle setBackgroundColor:[UIColor clearColor]];
        [labelTitle setText:@""];
        [labelTitle setFont:[UIFont systemFontOfSize:14]];
        [imageBg addSubview:labelTitle];
        [labelTitle release];
        
        
        UILabel  *labelDesprition = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, 25, 180, 20)];
        labelDesprition.tag = 5;
        [labelDesprition setTextColor:[UIColor grayColor]];
        [labelDesprition setBackgroundColor:[UIColor clearColor]];
        [labelDesprition setText:@""];
        [labelDesprition setFont:[UIFont systemFontOfSize:16]];
        [imageBg addSubview:labelDesprition];
        [labelDesprition release];
        
        fXpoint += 180+fsep;
        
        UIImageView   *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint, (50-15)/2, 15, 15)];
        imageView.tag = 6;
        imageView.image = [UIImage imageNamed:@"small_chips.png"];
        [imageBg addSubview:imageView];
        [imageView release];
        
        fXpoint += 15+fsep;
        UILabel  *labelChips = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, 10,80, 30)];
        [labelChips setTextColor:[UIColor purpleColor]];
        [labelChips setBackgroundColor:[UIColor clearColor]];
        [labelChips setFont:[UIFont systemFontOfSize:16]];
        labelChips.tag = 7;
        [imageBg addSubview:labelChips];
        [labelChips release];
        
        
        fXpoint += 80+fsep;
        
        UIButton  *btnGetprize = [[UIButton alloc] initWithFrame:CGRectMake(fXpoint, 9, 89, 31)];
        [btnGetprize setBackgroundImage:[UIImage imageNamed:@"get_prize.png"] forState:UIControlStateNormal];
        [btnGetprize setTitle:NSLocalizedString(@"领取奖励", nil) forState:UIControlStateNormal];
        [[btnGetprize titleLabel] setFont:[UIFont systemFontOfSize:14]];
        [btnGetprize addTarget:self
                        action:@selector(GetPrize:) forControlEvents:UIControlEventTouchUpInside];
        [imageBg addSubview:btnGetprize];
        btnGetprize.tag = 8;
        [btnGetprize release];
        
        
        UILabel  *labelProgress = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, 2, 89, 20)];
        [labelProgress setTextColor:[UIColor blueColor]];
        [labelProgress setBackgroundColor:[UIColor clearColor]];
        [labelProgress setTextAlignment:NSTextAlignmentCenter];
        [labelProgress setFont:[UIFont systemFontOfSize:14]];
        labelProgress.tag = 9;
        
        [imageBg addSubview:labelProgress];
        [labelProgress release];
       // fXpoint += 30;
        OHAttributedLabel   *labelNumber = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(fXpoint, 24, 89, 20)];
        [labelNumber setTextColor:[UIColor blueColor]];
        [labelNumber setBackgroundColor:[UIColor clearColor]];
        [labelNumber setTextAlignment:NSTextAlignmentCenter];
        
        labelNumber.tag = 10;
        [imageBg addSubview:labelNumber];
        [labelNumber release];
        [imageBg release];
       
        

        
    }
    
   // logMyLogInfo(@"before indexPath.rqo:%d  m_array count:%d",indexPath.row,[m_arrayStoreData count]);
    NSMutableDictionary  *dicInfo = [m_arrayStoreData objectAtIndex:indexPath.row];
  //  logMyLogInfo(@"after indexPath.rqo:%d",indexPath.row);
    UILabel  *labelTitle = (UILabel *)[cell.contentView viewWithTag:4];
     UILabel  *labelDes = (UILabel *)[cell.contentView viewWithTag:5];
    UIImageView  *imageView = (UIImageView *)[cell.contentView viewWithTag:3];
    int32_t  times = [[dicInfo valueForKey:TASKALLTIMES] intValue];
    int count = 0;
    switch ([[dicInfo valueForKey:TASKTYPE] intValue])
    {
        case 1:
            imageView.image = [UIImage imageNamed:@"login_task.png"];
            labelTitle.text = NSLocalizedString(@"签到有礼金", nil);
            labelDes.text = NSLocalizedString(@"登录就有送", nil);
            break;
        case 2:
           
            if (times >= 30)
            {
                if (times > 99)
                {
                    count = 3;
                }else
                {
                    count = 2;
                }
                
                imageView.image = [UIImage imageNamed:@"online_over30.png"];
                
            }else if (times >= 15)
            {   count = 2;
                imageView.image = [UIImage imageNamed:@"online_over15.png"];
            }else if (times >= 5)
            {
                if (times > 9)
                {
                    count = 2;
                }else
                {
                    count = 1;
                }
                imageView.image = [UIImage imageNamed:@"online_over5.png"];
            }
            
            labelTitle.text = NSLocalizedString(@"在线赚筹码", nil);
            labelDes.text = [NSString stringWithFormat:NSLocalizedString(@"在线%@分钟", nil),[dicInfo valueForKey:TASKALLTIMES]];
            break;
        case 3:
            if (times >= 10)
            {
                if (times > 99)
                {
                    count = 3;
                }else
                {
                    count = 2;
                }
                imageView.image = [UIImage imageNamed:@"beat_over10.png"];
            }else if (times >= 5)
            {
                if (times > 9)
                {
                    count = 2;
                }else
                {
                    count = 1;
                }
                
                imageView.image = [UIImage imageNamed:@"beat_over5.png"];
            }else if (times >= 1)
            {
                count = 1;
                imageView.image = [UIImage imageNamed:@"beat_over1.png"];
            }
            
            labelTitle.text = NSLocalizedString(@"为坚持喝彩", nil);
            labelDes.text = [NSString stringWithFormat:NSLocalizedString(@"游戏%@局", nil),[dicInfo valueForKey:TASKALLTIMES]];
            break;
        case 4:
            if (times >= 10)
            {
                if (times > 99)
                {
                    count = 3;
                }else
                {
                    count = 2;
                }
                imageView.image = [UIImage imageNamed:@"win_over_10.png"];
            }else if (times >= 5)
            {
                if (times > 9)
                {
                    count = 2;
                }else
                {
                    count = 1;
                }
                imageView.image = [UIImage imageNamed:@"win_over_5.png"];
            }else if (times >= 1)
            {
                count = 1;
                imageView.image = [UIImage imageNamed:@"win_over_1.png"];
            }
            
            labelTitle.text = NSLocalizedString(@"为胜利干杯", nil);
            labelDes.text = [NSString stringWithFormat:NSLocalizedString(@"胜利%@局", nil),[dicInfo valueForKey:TASKALLTIMES]];
            break;
            
        default:
            break;
    }
    CGFloat  fwidth = imageView.frame.size.width;
    CGFloat  fheight = imageView.frame.size.height/2+5;
    for (UIView  *view in [imageView subviews])
    {
        if (view.tag == 100)
        {
            [view removeFromSuperview];
        }
    }
    if (count == 1)
    {
        UIImageView *NumberViewOne = [[UIImageView alloc] initWithFrame:CGRectMake((fwidth-7)/2, fheight, 7, 12)];
        NumberViewOne.tag = 100;
        NumberViewOne.image = [UIImage imageNamed:[NSString stringWithFormat:@"task_%d.png",times]];
        [imageView addSubview:NumberViewOne];
        [NumberViewOne release];
    }else if (count == 2)
    {
        UIImageView  *NumberViewOne = [[UIImageView alloc] initWithFrame:CGRectMake((fwidth-14)/2, fheight, 7, 12)];
        NumberViewOne.image = [UIImage imageNamed:[NSString stringWithFormat:@"task_%d.png",times/10]];
        [imageView addSubview:NumberViewOne];
         NumberViewOne.tag = 100;
        [NumberViewOne release];
        UIImageView *NumberViewTwo= [[UIImageView alloc] initWithFrame:CGRectMake((fwidth-14)/2+7, fheight, 7, 12)];
        NumberViewTwo.image = [UIImage imageNamed:[NSString stringWithFormat:@"task_%d.png",times%10]];
        [imageView addSubview:NumberViewTwo];
         NumberViewTwo.tag = 100;
        [NumberViewTwo release];
        
    }else if (count == 3)
    {
        UIImageView *NumberViewOne = [[UIImageView alloc] initWithFrame:CGRectMake((fwidth-21)/2, fheight, 7, 12)];
        NumberViewOne.image = [UIImage imageNamed:[NSString stringWithFormat:@"task_%d.png",times/100]];
        [imageView addSubview:NumberViewOne];
         NumberViewOne.tag = 100;
        [NumberViewOne release];
        UIImageView *NumberViewTwo= [[UIImageView alloc] initWithFrame:CGRectMake((fwidth-21)/2+7, fheight, 7, 12)];
        NumberViewTwo.image = [UIImage imageNamed:[NSString stringWithFormat:@"task_%d.png",times/10%10]];
        [imageView addSubview:NumberViewTwo];
         NumberViewTwo.tag = 100;
        [NumberViewTwo release];
        UIImageView *NumberViewThree= [[UIImageView alloc] initWithFrame:CGRectMake((fwidth-21)/2+14, fheight, 7, 12)];
        NumberViewThree.image = [UIImage imageNamed:[NSString stringWithFormat:@"task_%d.png",times%10]];
        [imageView addSubview:NumberViewThree];
        NumberViewThree.tag = 100;
        [NumberViewThree release];
        
    }
    
    UILabel  *labeltemp = (UILabel *)[cell.contentView viewWithTag:7];
    if (labeltemp && [[dicInfo valueForKey:TASKTYPE] intValue] != 1)
    {
        [labeltemp setText:[NSString stringWithFormat:@"%@",[dicInfo valueForKey:TASKBOUNDS]]];
    }else
    {
        [labeltemp setText:[NSString stringWithFormat:NSLocalizedString(@"随机", nil)]];
    }
    
    UIButton   *btnGetPrize = (UIButton *)[cell.contentView viewWithTag:8];
    labeltemp = (UILabel *)[cell.contentView viewWithTag:9];
    OHAttributedLabel  *labelTempTwo = (OHAttributedLabel *)[cell.contentView viewWithTag:10];
   
    
    switch ([[dicInfo valueForKey:TASKSTATUS] intValue])
    {
        case 0:
            [btnGetPrize setHidden:YES];
            [labeltemp setHidden:NO];
            [labelTempTwo setHidden:NO];
            [labeltemp setText:[NSString stringWithFormat:NSLocalizedString(@"进行中", nil)]];
            //[labelTempTwo setText:[NSString stringWithFormat:@"%@/%@",[dicInfo valueForKey:TASKPROGRESS],[dicInfo valueForKey:TASKALLTIMES]]];
            NSString    *strInfo = [NSString stringWithFormat:@"%@/%@",[dicInfo valueForKey:TASKPROGRESS],[dicInfo valueForKey:TASKALLTIMES]];
            NSMutableAttributedString  *string = [[NSMutableAttributedString alloc] initWithString:strInfo];
            NSRange  range = [strInfo rangeOfString:@"/"];
           // logMyLogInfo(@"range:%@",[NSValue valueWithRange:range]);
            [string setTextColor:[UIColor blueColor]];
            if (range.location != NSNotFound)
            {
              [string setTextColor:[UIColor redColor] range:NSMakeRange(0, range.location)];  
            }
            
          //  [string setTextColor:[UIColor blueColor] range:NSMakeRange(range.location, [string length]-range.length)];
            [string setTextAlignment:CTTextAlignmentFromUITextAlignment(UITextAlignmentCenter) lineBreakMode:CTLineBreakModeFromUILineBreakMode(UILineBreakModeClip)];
            labelTempTwo.attributedText = string;
            [string release];
            break;
        case 1:
            [btnGetPrize setHidden:NO];
            [btnGetPrize setEnabled:YES];
            [btnGetPrize setTitle:NSLocalizedString(@"领取奖励", nil) forState:UIControlStateNormal];
            [btnGetPrize setBackgroundImage:[UIImage imageNamed:@"get_prize.png"] forState:UIControlStateNormal];
            [labeltemp setHidden:YES];
            [labelTempTwo setHidden:YES];
            break;
        case 2:
            [btnGetPrize setHidden:NO];
            [btnGetPrize setEnabled:NO];
            [btnGetPrize setTitle:NSLocalizedString(@"已领取", nil) forState:UIControlStateNormal];
            [btnGetPrize setBackgroundImage:[UIImage imageNamed:@"has_gain.png"] forState:UIControlStateNormal];
            [labeltemp setHidden:YES];
            [labelTempTwo setHidden:YES];
            break;
            
        default:
            break;
    }
    
    
    return cell;
    
}
-(void)GetPrize:(UIButton *)sender
{
    CGPoint point = sender.center;
    point = [m_tableView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [m_tableView indexPathForRowAtPoint:point];
    NSMutableDictionary  *dicInfo = [m_arrayStoreData objectAtIndex:indexpath.row];
    int8_t   idNumber = [[dicInfo valueForKey:TASKID] integerValue];
    DZPK_CLIENT_REQ_GET_BONUDS  boundsInfo = {idNumber};
    
    for (UIView  *view in [self.view subviews])
    {
        view.userInteractionEnabled = NO;
    }
    UIActivityIndicatorView  *ac = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((SCREENWIDTH-20)/2, (SCREENHEIGHT-20)/2, 20, 20)];
    [ac startAnimating];
    ac.tag = 111;
    [self.view addSubview:ac];
    [ac release];
    
    RJFTcpSocket  *resocket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    
    UserInfo  *objUser = [UserInfo shareInstance];
    BasisZipAndUnzip  *basic = [[BasisZipAndUnzip alloc] initWithSize:40];
    [resocket SendCharMessage:[basic syncWithRequest:REQ_GET_BONUDS
                                              userID:objUser.userIDForDzpk
                                         structArray:&boundsInfo]
                         size:[basic dataSize]];
    [basic release];
    basic = nil;
    
}
-(void)ShowPrizeNumber:(int)chipNumber
{
    
    UIImageView  *imageViewPrize = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH-429)/2, (SCREENHEIGHT-57)/2, 429, 57)];
    imageViewPrize.image = [UIImage imageNamed:@"prizes.png"];
    UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (57-30)/2, 429, 30)];
    [label setText:[NSString stringWithFormat:NSLocalizedString(@"恭喜您获得%d筹码", nil),chipNumber]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor blackColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:22]];
    [imageViewPrize addSubview:label];
    [label release];
    
    [self.view addSubview:imageViewPrize];
    [imageViewPrize performSelector:@selector(removeFromSuperview)
                         withObject:nil
                         afterDelay:3.0f];
    [imageViewPrize release];
}
-(IBAction)clickFresh:(id)sender
{
   // [self ShowPrizeNumber:1890];
    [self sendTaskRequest:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView            // Default is 1 if not implemented
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)sendTaskRequest:(id)Thread
{
    RJFTcpSocket  *resocket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    
    UserInfo  *objUser = [UserInfo shareInstance];
    BasisZipAndUnzip  *basic = [[BasisZipAndUnzip alloc] initWithSize:40];
    [resocket SendCharMessage:[basic syncWithRequest:REQ_GET_TASK
                                              userID:objUser.userIDForDzpk
                                         structArray:NULL]
                         size:[basic dataSize]];
    [basic release];
    basic = nil;
}

-(void)receiveNotiFromServer:(NSNotification *)note
{
    
    RJFTcpSocket  *m_socket = [note object];
    NSDictionary  *dicInfo = [note userInfo];
    if (dicInfo &&(m_socket.tag == RESOURCESOCKEtTAG) )
    {
        
    }else
    {
        return;
    }
    
    size_t  size = [[dicInfo valueForKey:TCPSOCKETSIZE] intValue];
    BasisZipAndUnzip   *objShare = [[BasisZipAndUnzip alloc] initWithSize:size+10];
    int  requestCode = -1;
   
    NSData  *data = [[note userInfo] valueForKey:TCPSOCKETMESSAGE];
    
    void *handle = NULL;
    int8_t  *byte =(int8_t*) [data bytes];
    int  pos = 4;
    if (byte[0] != 'D')
    {
        pos = 5;
    }
    requestCode = [BasisZipAndUnzip unbyte_to_int16:byte pos:pos];
    logMyLogInfo(@"data:%s",[data bytes]);
    logMyLogInfo(@"task socket tag:%d request:%d",m_socket.tag,requestCode);
    

    
    if (requestCode == REQ_GET_TASK)
    {
        HideHUD(self, YES);
        handle =[objShare PhaseInfoFromData:(int8_t *)[data bytes]
                                     
                             outRequestCode:&requestCode];
        DZPK_SERVER_REQ_GET_TASK   *taskInfo = (DZPK_SERVER_REQ_GET_TASK*)handle;
       // logMyLogInfo(@"chips:%d freetime:%d",chipInfo->chips,chipInfo->freeTimes);
        if (taskInfo->status)
        {
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"领取奖励失败，请重新登录！", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
           // [self sendTaskRequest:nil];
        }else
        {
            [m_arrayStoreData removeAllObjects];
            NSMutableDictionary   *dicInfo = [NSMutableDictionary dictionary];
//            NSArray  *title = [taskInfo->title componentsSeparatedByString:COMPONETSTRING];
//            NSArray  *arrDes = [taskInfo->descprition componentsSeparatedByString:COMPONETSTRING];
            for (int i = 0;i < taskInfo->taskstatusNumber;i++)
            {
                [dicInfo setObject:@(taskInfo->taskStatus[i]) forKey:TASKSTATUS];
                [dicInfo setObject:@(taskInfo->idArray[i]) forKey:TASKID];
                [dicInfo setObject:@(taskInfo->typeArray[i]) forKey:TASKTYPE];
               // [dicInfo setObject:[title objectAtIndex:i] forKey:TASKTITLE];
               // [dicInfo setObject:[arrDes objectAtIndex:i] forKey:TASKDESCPRITION];
                [dicInfo setObject:@(taskInfo->bounds[i]) forKey:TASKBOUNDS];
                switch (taskInfo->typeArray[i])
                {
                    case 2:
                          [dicInfo setObject:@(taskInfo->doneTimes[0]) forKey:TASKPROGRESS];
                        break;
                    case 3:
                        [dicInfo setObject:@(taskInfo->doneTimes[2]) forKey:TASKPROGRESS];
                        break;
                    case 4:
                        [dicInfo setObject:@(taskInfo->doneTimes[1]) forKey:TASKPROGRESS];
                        break;
                    default:
                        break;
                }
                [dicInfo setObject:@(taskInfo->all_times[i]) forKey:TASKALLTIMES];
                logMyLogInfo(@"task:%i dicInfo:%@\n\n\n",i,dicInfo);
                [m_arrayStoreData addObject:[NSMutableDictionary dictionaryWithDictionary:dicInfo]];
                [dicInfo removeAllObjects];
              
                
            }
             [m_tableView reloadData];
            
        }
        
        
    }else if (requestCode == REQ_GET_BONUDS)
    {
        handle =[objShare PhaseInfoFromData:(int8_t *)[data bytes]
                                     
                             outRequestCode:&requestCode];
        DZPK_SERVER_REQ_GET_BONUDS   *boundsInfo = (DZPK_SERVER_REQ_GET_BONUDS*)handle;
     
        for (UIView  *view in [self.view subviews])
        {
            view.userInteractionEnabled = YES;
        }
        UIActivityIndicatorView  *ac = (UIActivityIndicatorView *)[self.view viewWithTag:111];
        [ac startAnimating];
        [ac removeFromSuperview];

        if (boundsInfo->status)
        {
            logMyLogInfo(@"fail status:%d",boundsInfo->status);
        }else
        {
            for (int i = 0;i < [m_arrayStoreData count];i++)
            {
                NSMutableDictionary  *dicInfo = [m_arrayStoreData objectAtIndex:i];
                if ([[dicInfo valueForKey:TASKID] intValue] == boundsInfo->idNumber)
                {
                    [dicInfo setObject:@(2) forKey:TASKSTATUS];
                   
                    [self ShowPrizeNumber:boundsInfo->chips];
                    [self AddChipToArray:boundsInfo->chips Types:i];
                    break;
                }
            }
            [m_tableView reloadData];
            
        }
    }
    free(handle);
    handle = NULL;
    [objShare release];
    objShare = nil;
    
    
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
@end
