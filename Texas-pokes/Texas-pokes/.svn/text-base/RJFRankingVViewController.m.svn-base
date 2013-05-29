//
//  RJFRankingVViewController.m
//  Texas-pokes
//
//  Created by ran on 12-10-27.
//
//

#import "RJFRankingVViewController.h"
#import "PublicDefine.h"
#define COLOUMNUMBER        @"COLOUMNUMBER"
#define TWODATA             @"TWODATA"
#define THREEDATA           @"THREEDATA"
#define FOURDATA            @"FOURDATA"
#define ROWNUMBER           @"ROWNUMBER"

@interface RJFRankingVViewController ()

@end

@implementation RJFRankingVViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        m_arrayStoreAllinfo = [[NSMutableArray alloc] init];
        m_arrayStore = [[NSMutableArray alloc] init];
        m_arrayStoreName = [[NSMutableArray alloc] init];
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self InitLabelShow:nil];
    setAllViewautoResize(self.view);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotiFromServer:)
                                                 name:BNRRECEIVEMESSAGEFROMSERVER
                                               object:nil];
    ShowHUD(NSLocalizedString(@"获取排行榜信息中，请稍等！", nil), self,20);
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    BasisZipAndUnzip  *objZip = [[BasisZipAndUnzip alloc] initWithSize:40];
    
    DZPK_CLIENT_REQ_GAME_RANKING  info = {DZPKLANGUAGE};
    UserInfo  *objUser = [UserInfo shareInstance];
    [socket SendCharMessage:[objZip syncWithRequest:REQ_GAME_RANKING
                                             userID:objUser.userIDForDzpk
                                        structArray:&info]
                       size:[objZip dataSize]];
    [objZip release];
    objZip = nil;
    [super viewWillAppear:animated];
}

-(IBAction)clickLeft:(UIButton *)sender
{
    
  
    
    if (m_nowIndex-1 < 0)
    {
        m_nowIndex = [m_arrayStoreName count]-1;
    }else
    {
        m_nowIndex = (m_nowIndex-1)%[m_arrayStoreName count];
    }
    
    [m_arrayStore removeAllObjects];
    [m_arrayStore addObjectsFromArray:[m_arrayStoreAllinfo objectAtIndex:m_nowIndex]];
    
    laberMiddle.text = [m_arrayStoreName objectAtIndex:m_nowIndex];
    if (m_nowIndex-1< 0)
    {
        
        [btnLL setTitle:[m_arrayStoreName lastObject] forState:UIControlStateNormal];
    }else
    {
        
         [btnLL setTitle:[m_arrayStoreName objectAtIndex:m_nowIndex-1] forState:UIControlStateNormal];
    }
    
    if (m_nowIndex+1 > [m_arrayStoreName count]-1)
    {
       
        [btnRR setTitle:[m_arrayStoreName objectAtIndex:0] forState:UIControlStateNormal];
    }else
    {
       
        [btnRR setTitle:[m_arrayStoreName objectAtIndex:m_nowIndex+1] forState:UIControlStateNormal];
    }
    [m_tableView reloadData];
    
    
}
-(IBAction)clickRight:(UIButton *)sender
{
    m_nowIndex = (m_nowIndex+1)%[m_arrayStoreName count];
    [m_arrayStore removeAllObjects];
    [m_arrayStore addObjectsFromArray:[m_arrayStoreAllinfo objectAtIndex:m_nowIndex]];
    
    laberMiddle.text = [m_arrayStoreName objectAtIndex:m_nowIndex];
    if (m_nowIndex-1< 0)
    {
     
        [btnLL setTitle:[m_arrayStoreName lastObject] forState:UIControlStateNormal];
    }else
    {
  
        [btnLL setTitle:[m_arrayStoreName objectAtIndex:m_nowIndex-1] forState:UIControlStateNormal];
    }
    
    if (m_nowIndex+1 > [m_arrayStoreName count]-1)
    {
        
        [btnRR setTitle:[m_arrayStoreName objectAtIndex:0] forState:UIControlStateNormal];
    }else
    {
        
        [btnRR setTitle:[m_arrayStoreName objectAtIndex:m_nowIndex+1] forState:UIControlStateNormal];
    }
    [m_tableView reloadData];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}
-(void)receiveNotiFromServer:(NSNotification *)note
{
    @synchronized(self)
    {
        // NSLog(@"33");
        RJFTcpSocket  *m_socket = [note object];
        NSDictionary  *dicInfo = [note userInfo];
        if (dicInfo &&(m_socket.tag == RESOURCESOCKEtTAG) )
        {
            
        }else
        {
            return;
        }
        
        size_t  size = [[dicInfo valueForKey:TCPSOCKETSIZE] intValue];
        BasisZipAndUnzip   *objZip = [[BasisZipAndUnzip alloc] initWithSize:size+5];
        int  requestCode = -1;
       
        NSData  *data = [[note userInfo] valueForKey:TCPSOCKETMESSAGE];
        
        int8_t  *bytes =(int8_t*) [data bytes];
        int  pos = 4;
        if (bytes[0] != 'D')
        {
            pos = 5;
        }
        requestCode = [BasisZipAndUnzip unbyte_to_int16:bytes pos:pos];
        
        logMyLogInfo(@"data:%s",[data bytes]);
        void *handle = NULL;
        
        logMyLogInfo(@"data:%s SIZE:%@",[data bytes],[[note userInfo] valueForKey:@"SIZE"]);
    
        
        
        if (REQ_GAME_RANKING == requestCode)
        {
            handle =[objZip PhaseInfoFromData:bytes
                                       
                               outRequestCode:&requestCode];
            HideHUD(self, YES);
            DZPK_SERVER_REQ_GAME_RANKING  *info = handle;
            if (info->status)
            {
                logMyLogInfo(@"get data fail");
            }else
            {
                if (info->RankingName)
                {
                    [m_arrayStoreName addObjectsFromArray:[info->RankingName componentsSeparatedByString:COMPONETSTRING]];
                }
                
                int   inowCount = 0;
                int   jNowcount  = 0;
                int   knowcount = 0;

                
                if (info->coloumFourData && info->coloumThreeData && info->coloumTwoData)
                {
                    NSArray *arrayTwo = [info->coloumTwoData componentsSeparatedByString:COMPONETSTRING];
                    NSArray *arrayThree = [info->coloumThreeData componentsSeparatedByString:COMPONETSTRING];
                    NSArray *arrayFour = [info->coloumFourData componentsSeparatedByString:COMPONETSTRING];
                    NSMutableArray  *infoArray = [NSMutableArray array];
                    for (int i = 0; i < info->rowarrayNumber; i++)
                    {
                        [infoArray removeAllObjects];
                        for (int jCount = 0; jCount < info->rank_rowArray[i]; jCount++)
                        {
                            if (info->rank_columnArray[i] == 3)
                            {
                                NSDictionary  *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:[arrayTwo objectAtIndex:inowCount],TWODATA,[arrayThree objectAtIndex:jNowcount],THREEDATA,[arrayFour objectAtIndex:knowcount],FOURDATA,@4,COLOUMNUMBER,nil];
                                inowCount++;
                                jNowcount++;
                                knowcount++;
                                [infoArray addObject:dicInfo];
                            }else if (info->rank_columnArray[i] == 2)
                            {
                                NSDictionary  *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:[arrayTwo objectAtIndex:inowCount],TWODATA,[arrayThree objectAtIndex:jNowcount],THREEDATA,@3,COLOUMNUMBER,nil];
                                inowCount++;
                                jNowcount++;
                                [infoArray addObject:dicInfo];
                                
                            } else if (info->rank_columnArray[i] == 1)
                            {
                                NSDictionary  *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:[arrayTwo objectAtIndex:inowCount],TWODATA,@2,COLOUMNUMBER,nil];
                                inowCount++;
                                [infoArray addObject:dicInfo];
                                
                            }
                           // NSLog(@"icount:%d jcount:%d kcount:%d",inowCount,jNowcount,knowcount);
                            
                        }
                        [m_arrayStoreAllinfo addObject:[NSArray arrayWithArray:infoArray]];
                          
                    }
                   
                  //  logMyLogInfo(@"m_arrayStoreAllinfo:%@,count:%d",m_arrayStoreAllinfo,[m_arrayStoreAllinfo count]);
                    
                }
               
                
                
            }
            [self setDataAftergetData];
            
        }
        
        
        
         
        free(handle);
        handle = NULL;
        [objZip release];
        objZip = nil;
    }
}

-(IBAction)ClickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dealloc
{
    if (m_arrayStore)
    {
        [m_arrayStore removeAllObjects];
        [m_arrayStore release];
        m_arrayStore = nil;
    }
    if (m_arrayStoreAllinfo)
    {
        [m_arrayStoreAllinfo removeAllObjects];
        [m_arrayStoreAllinfo release];
        m_arrayStoreAllinfo = nil;

    }
    if (m_arrayStoreName)
    {
        [m_arrayStoreName removeAllObjects];
        [m_arrayStoreName release];
        m_arrayStoreName = nil;
    }
    if(btnBack)
    {
        [btnBack release];
        btnBack = nil;
    }
    if(btnRight)
    {
        [btnRight release];
        btnRight = nil;
    }
    if(btnLeft)
    {
        [btnLeft release];
        btnLeft = nil;
    }
    if (btnLL)
    {
        [btnLL release];
        btnLL = nil;
    }
    if (btnRR)
    {
        [btnRR release];
        btnRR = nil;
    }
    if (laberMiddle)
    {
        [laberMiddle release];
        laberMiddle = nil;
    }

    [super dealloc];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_arrayStore count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"111"];
    if (cell == nil)
    {
        [tableView setBackgroundColor:[UIColor clearColor]];
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"111"] autorelease];
        UIView *view = [cell contentView];
        CGFloat  fXpoint = 5;
        CGFloat  fSep = 0;
        CGFloat  fwidth = 125;
        UIImageView   *imageNumberOne = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint, 5, 22, 27)];
        imageNumberOne.tag = 1;
        [view addSubview:imageNumberOne];
        [imageNumberOne release];
        
        fXpoint += 22+fSep;
        UIImageView   *imageNumberTwo = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint, 5, 22, 27)];
        imageNumberTwo.tag = 2;
        [view addSubview:imageNumberTwo];
        [imageNumberTwo release];
        fSep = 5;
        fXpoint += 22+fSep+30;
        
        UILabel   *labelTwo = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, 5, fwidth, 30)];
        labelTwo.tag = 3;
        [labelTwo setBackgroundColor:[UIColor clearColor]];
        [labelTwo setTextColor:[UIColor blackColor]];
        [view addSubview:labelTwo];
        [labelTwo release];
        
        fXpoint += fSep+fwidth;
        UILabel   *labelThree = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, 5, fwidth, 30)];
        labelThree.tag = 4;
        [labelThree setBackgroundColor:[UIColor clearColor]];
        [labelThree setTextColor:[UIColor blackColor]];
        [view addSubview:labelThree];
        [labelThree release];
        
        fXpoint += fSep+fwidth;
        UILabel   *labelFour= [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, 5, fwidth, 30)];
        labelFour.tag = 5;
        [labelFour setBackgroundColor:[UIColor clearColor]];
        [labelFour setTextColor:[UIColor blackColor]];
        [view addSubview:labelFour];
        [labelFour release];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if (indexPath.row < 9)
    {
        UIImageView  *imageView = (UIImageView *)[cell.contentView viewWithTag:1];
        if (imageView)
        {
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"rank%d.png",indexPath.row+1]];
        }
        
        imageView = (UIImageView *)[cell.contentView viewWithTag:2];
        [imageView setHidden:YES];
    }else
    {
        UIImageView  *imageView = (UIImageView *)[cell.contentView viewWithTag:1];
        if (imageView)
        {
         
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"rank%d.png",(indexPath.row+1)/10]];
            
            
        }
        
        imageView = (UIImageView *)[cell.contentView viewWithTag:2];
        [imageView setHidden:NO];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"rank%d.png",(indexPath.row+1)%10]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    NSDictionary  *dicInfo = [m_arrayStore objectAtIndex:indexPath.row];
    UILabel  *label = (UILabel *)[cell.contentView viewWithTag:3];
    if (label)
    {
        [label setText:[dicInfo valueForKey:TWODATA]];
    }
    
    label = (UILabel *)[cell.contentView viewWithTag:4];
    int coloum = [[dicInfo valueForKey:COLOUMNUMBER] intValue];
    if (label && coloum > 1)
    {
        [label setHidden:NO];
        [label setText:[dicInfo valueForKey:THREEDATA]];
    }else
    {
        [label setHidden:YES];
    }
    
    label = (UILabel *)[cell.contentView viewWithTag:5];
    if (label && coloum > 2)
    {
        [label setHidden:NO];
        [label setText:[dicInfo valueForKey:FOURDATA]];
    }else
    {
        [label setHidden:YES];
    }
    
    return cell;
}

-(void)InitLabelShow:(id)Show
{
    [btnLL setTitle:@"" forState:UIControlStateNormal];
    [btnRR setTitle:@"" forState:UIControlStateNormal];
    [laberMiddle setText:NSLocalizedString(@"排行榜", nil)];
    
}
-(void)setDataAftergetData
{
    [m_arrayStore removeAllObjects];

    if ([m_arrayStoreName count] == 1)
    {
        [laberMiddle setText:[m_arrayStoreName objectAtIndex:0]];
        [m_arrayStore addObjectsFromArray:[m_arrayStoreAllinfo objectAtIndex:0]];
        m_nowIndex = 0;
    }else if ([m_arrayStoreName count] == 2)
    {
        [btnLL setTitle:[m_arrayStoreName objectAtIndex:0] forState:UIControlStateNormal];
        [laberMiddle setText:[m_arrayStoreName objectAtIndex:1]];
         [m_arrayStore addObjectsFromArray:[m_arrayStoreAllinfo objectAtIndex:1]];
        m_nowIndex = 1;
    }else if ([m_arrayStoreName count] > 2)
    {
        [btnLL setTitle:[m_arrayStoreName objectAtIndex:0] forState:UIControlStateNormal];
       // [labelLeft setText:[m_arrayStoreName objectAtIndex:0]];
        [laberMiddle setText:[m_arrayStoreName objectAtIndex:1]];
        
        [btnRR setTitle:[m_arrayStoreName objectAtIndex:2] forState:UIControlStateNormal];
        [m_arrayStore addObjectsFromArray:[m_arrayStoreAllinfo objectAtIndex:1]];
        m_nowIndex = 1;
    }
    [m_tableView reloadData];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
@end
