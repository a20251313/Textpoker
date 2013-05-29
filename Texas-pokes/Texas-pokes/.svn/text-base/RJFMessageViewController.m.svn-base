//
//  RJFMessageViewController.m
//  Texas-pokes
//
//  Created by popo on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFMessageViewController.h"
#define SINGLINEWIDTH               21
#define SINGLENEHEIGHT              22
@interface RJFMessageViewController ()

@end

@implementation RJFMessageViewController

-(IBAction)clickBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)clickUserDym:(UIButton *)sender
{
    for (UIView  *view in [self.view subviews])
    {
        if (view.tag == 1001)
        {
            [view removeFromSuperview];
        }
    }
    [imageViewActMessage setHidden:YES];
    [textViewActMessage setHidden:YES];
    m_iDataSoureType = USERDYM;
    
    if (![m_arrStoreUserMessage count])
    {
        
        [self ShowNoMsgInfo:NSLocalizedString(@"没有新的消息", nil)];
        /*[RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:NSLocalizedString(@"提示\n\n\n没有新消息", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];*/
    }
    
    //  [self GetMsgFromServer:nil];
    [m_tableView setHidden:NO];
    [sender setBackgroundImage:[UIImage imageNamed:@"nav_sepline.png"] forState:UIControlStateNormal];
    [btnSysMessage setBackgroundImage:[UIImage imageNamed:@"nav_sepline_null.png"] forState:UIControlStateNormal];
    [btnActMessage setBackgroundImage:[UIImage imageNamed:@"nav_sepline_null.png"] forState:UIControlStateNormal];
    [m_tableView reloadData];
    
    
    
}

-(void)GetMsgFromServer:(id)Net
{
    ShowHUD(NSLocalizedString(@"获取消息中，请稍候！", nil), self,20);
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    BasisZipAndUnzip  *objBasic = [[BasisZipAndUnzip alloc] initWithSize:40];
    
    UserInfo  *objUser = [UserInfo shareInstance];
    
    
    [socket SendCharMessage:[objBasic syncWithRequest:REQ_RECV_GET_MSG
                                               userID:objUser.userIDForDzpk
                                          structArray:NULL] size:[objBasic dataSize]];
    
    [objBasic release];
    
    
    
    
}
-(IBAction)clickSysMessage:(UIButton *)sender
{
    for (UIView  *view in [self.view subviews])
    {
        if (view.tag == 1001)
        {
            [view removeFromSuperview];
        }
    }
    
    if (![m_arrStoreSysMessage count])
    {
        [self ShowNoMsgInfo:NSLocalizedString(@"没有新的系统消息", nil)];
       /* [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:NSLocalizedString(@"提示\n\n\n没有新的系统消息", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];*/
    }
    [imageViewActMessage setHidden:YES];
    [textViewActMessage setHidden:YES];
    m_iDataSoureType = SYSMESSAGE;
    //  [self GetMsgFromServer:nil];
    [m_tableView setHidden:NO];
    [sender setBackgroundImage:[UIImage imageNamed:@"nav_sepline.png"] forState:UIControlStateNormal];
    [btnActMessage setBackgroundImage:[UIImage imageNamed:@"nav_sepline_null.png"] forState:UIControlStateNormal];
    [btnUserDym setBackgroundImage:[UIImage imageNamed:@"nav_sepline_null.png"] forState:UIControlStateNormal];
    [m_tableView reloadData];
}

-(IBAction)clickActMessage:(UIButton *)sender
{
    for (UIView  *view in [self.view subviews])
    {
        if (view.tag == 1001)
        {
            [view removeFromSuperview];
        }
    }
    m_iDataSoureType = ACTMESSAGE;
    [imageViewActMessage setHidden:NO];
    [textViewActMessage setHidden:NO];
    //  [self GetMsgFromServer:nil];
    // imageViewActMessage.image = [UIImage imageNamed:@""];
    
    [textViewActMessage setText:NSLocalizedString(@"暂时没有活动消息，敬请关注！", nil)];
    
    [m_tableView setHidden:YES];
    [sender setBackgroundImage:[UIImage imageNamed:@"nav_sepline.png"] forState:UIControlStateNormal];
    [btnUserDym setBackgroundImage:[UIImage imageNamed:@"nav_sepline_null.png"] forState:UIControlStateNormal];
    [btnSysMessage setBackgroundImage:[UIImage imageNamed:@"nav_sepline_null.png"] forState:UIControlStateNormal];
    [m_tableView reloadData];
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        m_arrayMessageInfo = [[NSMutableArray alloc] init];
        m_arrStoreSysMessage = [[NSMutableArray alloc] init];
        m_arrStoreUserMessage = [[NSMutableArray alloc] init];
        
        [m_arrStoreUserMessage addObjectsFromArray:[[NSUserDefaults standardUserDefaults] valueForKey:MESSAGEUSERINFOINLOCAL]];
        [m_arrStoreSysMessage addObjectsFromArray:[[NSUserDefaults standardUserDefaults] valueForKey:MESSAGESYSLOCAL]];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    m_iDataSoureType = USERDYM;
    [btnUserDym setBackgroundImage:[UIImage imageNamed:@"nav_sepline.png"] forState:UIControlStateNormal];
    
    /* [btnUserDym setBackgroundImage:[UIImage imageNamed:@"nav_sepline.png"] forState:UIControlStateNormal];
     for (int i = 0; i < 20; i++)
     {
     NSString  *strDate = [NSString stringWithFormat:@"6月%d日",i];
     NSString  *strMessage = [NSString stringWithFormat:@"I ma a sfdsjfs %d",i*5];
     NSDictionary  *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:strDate,MESSAGEDATE,strMessage,MESSAGECONTENT,nil];
     [m_arrayMessageInfo addObject:dicInfo];
     }//degug */
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
-(void)dealloc
{
    if (m_arrayMessageInfo)
    {
        [m_arrayMessageInfo removeAllObjects];
        [m_arrayMessageInfo release];
        m_arrayMessageInfo = nil;
    }
    if (m_arrStoreUserMessage)
    {
        [m_arrStoreUserMessage removeAllObjects];
        [m_arrStoreUserMessage release];
         m_arrStoreUserMessage = nil;
    }
    if (m_arrStoreSysMessage)
    {
        [m_arrStoreSysMessage removeAllObjects];
        [m_arrStoreSysMessage release];
        m_arrStoreSysMessage = nil;
    }
    if (btnBack)
    {
        [btnBack release];
        btnBack = nil;
    }
    if (btnActMessage)
    {
        [btnActMessage release];
        btnActMessage = nil;
    }
    if (btnSysMessage)
    {
        [btnSysMessage release];
        btnSysMessage = nil;
    }
    if (btnUserDym)
    {
        [btnUserDym release];
        btnUserDym = nil;
    }
    if (m_tableView)
    {
        [m_tableView release];
        m_tableView = nil;
    }
    if (textViewActMessage)
    {
        [textViewActMessage release];
        textViewActMessage = nil;
    }
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (m_iDataSoureType == ACTMESSAGE)
    {
        return 0;
    }
    if (m_iDataSoureType == USERDYM)
    {
        return [m_arrStoreUserMessage count];
    }else if(m_iDataSoureType == SYSMESSAGE)
    {
        return [m_arrStoreSysMessage count];
    }
    return [m_arrayMessageInfo count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  *cell = nil;
    NSDictionary  *dicInfo = nil;
    if (m_iDataSoureType == USERDYM)
    {
        dicInfo = [m_arrStoreUserMessage objectAtIndex:indexPath.row];
    }else if (m_iDataSoureType == SYSMESSAGE)
    {
        dicInfo = [m_arrStoreSysMessage objectAtIndex:indexPath.row];
    }
    switch (m_iDataSoureType)
    {
        case USERDYM:
        case SYSMESSAGE:
            cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
            if (!cell)
            {
                [tableView setBackgroundColor:[UIColor clearColor]];
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"1"] autorelease];
                UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(3, 12, 15, 15)];
                imageview.tag = 11;
                [cell.contentView addSubview:imageview];
                [imageview release];
                UILabel  *labelDate = [[UILabel alloc] initWithFrame:CGRectMake(8+15+5, 10, 75, 21)];
                [labelDate setFont:[UIFont systemFontOfSize:14]];
                [labelDate setBackgroundColor:[UIColor clearColor]];
                labelDate.tag = 12;
                [cell.contentView addSubview:labelDate];
                [labelDate release];
                UILabel  *labelContent = [[UILabel alloc] initWithFrame:CGRectMake(8+15+5+75+5, 8, 340, 21)];
                [labelContent setFont:[UIFont systemFontOfSize:15]];
                [labelContent setBackgroundColor:[UIColor clearColor]];
                labelContent.tag = 13;
                [cell.contentView addSubview:labelContent];
                [labelContent release];
                
               
                
            }
             tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            if (dicInfo)
            {
                UIImageView  *imageView = (UIImageView *)[cell.contentView viewWithTag:11];
                if (imageView)
                {
                    if (m_iDataSoureType == USERDYM)
                    {
                        imageView.image = [UIImage imageNamed:@"logo_message.png"];
                    }else
                    {
                        imageView.image = [UIImage imageNamed:@"logo_message.png"];
                        
                    }
                }
                UILabel  *labeltemp  = (UILabel *)[cell.contentView viewWithTag:12];
                if (labeltemp)
                {
                    NSString    *strDate = [[[dicInfo valueForKey:MESSAGEDATE] componentsSeparatedByString:@" "] objectAtIndex:0];
                    [labeltemp setText:strDate];
                
                }
                labeltemp  = (UILabel *)[cell.contentView viewWithTag:13];
                if (labeltemp)
                {
                    if (m_iDataSoureType == USERDYM)
                    {
                        [labeltemp setTextColor:[UIColor orangeColor]];
                    }else
                    {
                        [labeltemp setTextColor:[UIColor blueColor]];
                    }

                    
                  
                    NSString  *strContent = [dicInfo valueForKey:MESSAGECONTENT];
                    [labeltemp setText:strContent];
                    int count = sinaCountWord(strContent)/SINGLINEWIDTH;
                    if (sinaCountWord(strContent)%SINGLINEWIDTH > 0 || count == 0)
                    {
                        count++;
                    }
                    [labeltemp setNumberOfLines:count];
        
                    [labeltemp setFrame:CGRectMake(labeltemp.frame.origin.x, labeltemp.frame.origin.y, labeltemp.frame.size.width, SINGLENEHEIGHT*count)];
                   // [labeltemp setTextAlignment:NSTextAlignmentJustified];
                   
                    
                    
                }
            }
            cell.selectionStyle = UITableViewCellEditingStyleNone;
            break;
        case ACTMESSAGE:
            break;
        default:
            break;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView            // Default is 1 if not implemented
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary  *dicInfo = nil;
    
    if (m_iDataSoureType == USERDYM)
    {
        dicInfo = [m_arrStoreUserMessage objectAtIndex:indexPath.row];
    }else if(m_iDataSoureType == SYSMESSAGE)
    {
        dicInfo = [m_arrStoreSysMessage objectAtIndex:indexPath.row];
    }
    NSString   *strContent = [dicInfo valueForKey:MESSAGECONTENT];
    int count = sinaCountWord(strContent)/SINGLINEWIDTH;
    if (sinaCountWord(strContent)%SINGLINEWIDTH > 0 || count == 0)
    {
        count++;
    }
    

    NSLog(@"content:%@ length:%d count:%d",strContent,sinaCountWord(strContent),count);
    if (count > 1)
    {
        return 40+(count-1)*SINGLINEWIDTH;
    }
    
    
     
    return 40;
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
    if (requestCode != REQ_RECV_GET_MSG)
    {
        return;
    }
    HideHUD(self, YES);
    BasisZipAndUnzip   *objShare = [[BasisZipAndUnzip alloc] initWithSize:size+10];
    handle = [objShare PhaseInfoFromData:bytes
                         
                 outRequestCode:&requestCode];
    DZPK_SERVER_REQ_RECV_GET_MSG    *msgInfo = (DZPK_SERVER_REQ_RECV_GET_MSG*)handle;
    if (msgInfo->status == 0)
    {
        
        UserInfo   *objUser = [UserInfo shareInstance];
        objUser.msgCount = 0;
        NSArray     *arrPostTime = [msgInfo->post_Time componentsSeparatedByString:COMPONETSTRING];
        NSArray     *arrMsgCon = [msgInfo->content componentsSeparatedByString:COMPONETSTRING];
        for (int i = 0; i < [arrMsgCon count]; i++)
        {
            NSNumber    *NumMessagetype = @(-1);
            NSString    *strTime = [arrPostTime objectAtIndex:i];
            strTime = [strTime stringByReplacingOccurrencesOfString:@".0" withString:@""];
            if (msgInfo->typeArray[i] == 0)
            {
                // NumMessagetype = @0;
             
                [m_arrStoreUserMessage insertObject:[NSDictionary dictionaryWithObjectsAndKeys:NumMessagetype,MESSAGETYPE,[arrMsgCon objectAtIndex:i],MESSAGECONTENT,strTime,MESSAGEDATE,nil] atIndex:0];
                
            }else if (msgInfo->typeArray[i] == 1)
            {
                NumMessagetype = @1;
               // [m_arrStoreSysMessage addObject:[NSDictionary dictionaryWithObjectsAndKeys:NumMessagetype,MESSAGETYPE,[arrMsgCon objectAtIndex:i],MESSAGECONTENT,strTime,MESSAGEDATE,nil]];
                [m_arrStoreSysMessage insertObject:[NSDictionary dictionaryWithObjectsAndKeys:NumMessagetype,MESSAGETYPE,[arrMsgCon objectAtIndex:i],MESSAGECONTENT,strTime,MESSAGEDATE,nil] atIndex:0];
            }else if (msgInfo->typeArray[i] == 2)
            {
                NumMessagetype = @2;
                [m_arrayMessageInfo addObject:[NSDictionary dictionaryWithObjectsAndKeys:NumMessagetype,MESSAGETYPE,[arrMsgCon objectAtIndex:i],MESSAGECONTENT,strTime,MESSAGEDATE,nil]];
            }
           
        }
        
    
        
    }else
    {
        
        
    }

  
    if ([m_arrStoreUserMessage count] < 1)
    {
        [self ShowNoMsgInfo:NSLocalizedString(@"没有新的个人动态消息", nil)];
    }
    if ([m_arrStoreUserMessage count] <= 50)
    {
        
    }else
    {
        while ([m_arrStoreUserMessage count] > 50)
        {
            [m_arrStoreUserMessage removeLastObject];
        }
    }
    if ([m_arrStoreSysMessage count] <= 50)
    {
        
    }else
    {
        while ([m_arrStoreSysMessage count] > 50)
        {
            [m_arrStoreSysMessage removeLastObject];
        }
        
    }
    
    for (NSDictionary  *dicInfo in m_arrStoreUserMessage)
    {
        if (![dicInfo isKindOfClass:[NSDictionary class]])
        {
            [m_arrStoreUserMessage removeObject:dicInfo];
        }
    }
    UserInfo  *objUser = [UserInfo shareInstance];
    
    if (objUser.msgCount > 0 && [m_arrStoreSysMessage count])
    {
        [self clickSysMessage:btnSysMessage];
    }
     [m_tableView reloadData];
    

    free(handle);
    handle = NULL;
    [objShare release];
    objShare = nil;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotiFromServer:)
                                                 name:BNRRECEIVEMESSAGEFROMSERVER
                                               object:nil];
    
    [self GetMsgFromServer:nil];
    [super viewWillAppear:animated];
    // [self clickUserDym:btnUserDym];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] setObject:m_arrStoreSysMessage forKey:MESSAGESYSLOCAL];
    [[NSUserDefaults standardUserDefaults] setObject:m_arrStoreUserMessage forKey:MESSAGEUSERINFOINLOCAL];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
    
    
}

-(void)ShowNoMsgInfo:(NSString *)strInfo
{
    for (UIView  *view in [self.view subviews])
    {
        if (view.tag == 1001)
        {
            [view removeFromSuperview];
        }
    }
    UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT/2-30, SCREENWIDTH, 30)];
    [label setBackgroundColor:[UIColor clearColor]];
    label.tag = 1001;
    [label setText:strInfo];
    [label setFont:[UIFont systemFontOfSize:20]];
    [label setTextColor:[UIColor grayColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label];
    /*[label performSelector:@selector(removeFromSuperview)
                withObject:nil
                afterDelay:3];*/
    [label release];
}


@end
