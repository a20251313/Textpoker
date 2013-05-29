//
//  RJFFAQViewController.m
//  Texas-pokes
//
//  Created by popo on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFFAQViewController.h"
#define SINGELINEWIDTH              21
#define WORDNUMBER                      25
#define TITLE                       @"MESSAGE"
#define CONTEXT                     @"CONTENT"
#import "UserInfo.h"
#import "RJFWarnView.h"
@interface RJFFAQViewController ()

@end

@implementation RJFFAQViewController

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [self.view endEditing:YES];
    return YES;
}
-(IBAction)clickBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setSomeViewHidden:(BOOL)bHide
{
    [m_tableView setHidden:!bHide];
    [btnSend setHidden:bHide];
    [labelEmail setHidden:bHide];
    [labelPhone setHidden:bHide];
    [labelSepLine setHidden:bHide];
    [labelCustom setHidden:bHide];
    [imageView setHidden:bHide];
    [textViewAdvice setHidden:bHide];
}
-(IBAction)clickAdvice:(UIButton *)sender
{
    
    [sender setBackgroundImage:[UIImage imageNamed:@"nav_sepline.png"] forState:UIControlStateNormal];
    [btnFAQ setBackgroundImage:[UIImage imageNamed:@"nav_sepline_null.png"] forState:UIControlStateNormal];
    
    [self setSomeViewHidden:NO];
    
    
    if([textViewAdvice.text length] < 1)
    {
         [self setSendButtonEnable:NO];
    }
   
    
    
}
-(IBAction)clickFAQ:(UIButton *)sender
{
    [textViewAdvice resignFirstResponder];
    [sender setBackgroundImage:[UIImage imageNamed:@"nav_sepline.png"] forState:UIControlStateNormal];
    [btnAdvice setBackgroundImage:[UIImage imageNamed:@"nav_sepline_null.png"] forState:UIControlStateNormal];
    [self setSomeViewHidden:YES];
    [m_tableView reloadData];
    
}
-(IBAction)clickSend:(UIButton *)sender
{
    

    // [[UIDevice currentDevice] un]
    logMyLogInfo(@"send:%@",textViewAdvice.text);
    
    [textViewAdvice resignFirstResponder];
    [textViewAdvice setTextColor:[UIColor grayColor]];
    
    if ([textViewAdvice.text length] < 1 || [textViewAdvice.text rangeOfString:NSLocalizedString(@"在此输入您的反馈!（仅限140字）", nil)].location != NSNotFound)
    {
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:NSLocalizedString(@"提示\n\n\n噢，出错了！您还没有输入您想说的话了！！", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
       
        return;
    }
    
    [self setSendButtonEnable:NO];
    DZPK_CLIENT_REQ_FEEDBACK    faqInfo = {textViewAdvice.text};
    RJFTcpSocket    *m_socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    BasisZipAndUnzip *objZip = [[BasisZipAndUnzip alloc] initWithSize:1024];
    UserInfo  *objUser = [UserInfo shareInstance];
    if (m_socket)
    {
        [m_socket SendCharMessage:[objZip syncWithRequest:REQ_FEEDBACK
                                                   userID:objUser.userIDForDzpk
                                              structArray:&faqInfo] size:[objZip dataSize]];
    }
    
    textViewAdvice.text = NSLocalizedString(@"在此输入您的反馈!（仅限140字）", nil);
    //[textViewAdvice set]
    [objZip release];
    //[textViewAdvice resignFirstResponder];
}

-(void)dealloc
{
    if (m_arrayStoreFAQs)
    {
        [m_arrayStoreFAQs removeAllObjects];
        [m_arrayStoreFAQs release];
        m_arrayStoreFAQs = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
  /*  if (btnBack)
    {
        [btnBack release];
        btnBack  = nil;
    }
    if (btnAdvice)
    {
        [btnAdvice release];
        btnAdvice  = nil;
    }
    if (btnFAQ)
    {
        [btnFAQ release];
        btnFAQ  = nil;
    }
    if (btnSend)
    {
        [btnSend release];
        btnSend  = nil;
    }
    if (m_tableView)
    {
        [m_tableView release];
        m_tableView  = nil;
    }
    if (labelSepLine)
    {
        [labelSepLine release];
        labelSepLine  = nil;
    }
    if (labelCustom)
    {
        [labelCustom release];
        labelCustom  = nil;
    }
    if (labelPhone)
    {
        [labelPhone release];
        labelPhone  = nil;
    }
    if (labelEmail)
    {
        [labelEmail release];
        labelEmail  = nil;
    }
    if (imageView)
    {
        [imageView release];
        imageView  = nil;
    }
    if (labelFAQTitle)
    {
        [labelFAQTitle release];
        labelFAQTitle = nil;
    }*/
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  type:(FAQCONTROLTYPE)FAQType
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        m_faqControlType = FAQType;
        m_arrayStoreFAQs = [[NSMutableArray alloc] init];
        NSDictionary  *dicInfo = nil;
        for (int i = 0; i < 6;i++)
        {
            switch (i)
            {
                case 0:
                    dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"如何修改昵称？",TITLE,@"昵称代表您向别人展示的名字，如果您使用的是QQ帐号或者新浪微博帐号登录，昵称与头像将使用您QQ或新浪微博的昵称与头像。您也可以自己修改头像和昵称并保存下来。",CONTEXT, nil];
                    break;
                case 1:
                    dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"如何升级？",TITLE,@"游戏内的等级与积分挂钩，您在游戏中每赢得1筹码就可以获得一个积分，每输掉一个筹码将减少1积分。随着积分的变化，您的等级也将变化。积分是可以为负值的。",CONTEXT, nil];
                    break;
                case 2:
                    dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"如何才能进入更高级的游戏场地？",TITLE,@"乐乐德州扑克游戏场地的进场需求与您身上拥有的筹码数量相关，您可以先在低级别的比赛场地赢得足够筹码后再进入高级场地。",CONTEXT, nil];
                    break;
                case 3:
                    dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"如何才能进入我朋友所在的房间？",TITLE,@"您可以通过搜索房间ID功能找到您朋友所在的房间并进入（前提是您需要符合该房间的进入条件）。",CONTEXT, nil];
                    break;
                case 4:
                    dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"如何获得更多的筹码？",TITLE,@"您可以在合适的游戏场地通过智慧赢得足够的筹码，也可以通过充值获得筹码、完成每日任务也能获得很多筹码。",CONTEXT, nil];
                    break;
                case 5:
                    dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"如何联系客服？",TITLE,NSLocalizedString(@"客服", nil),CONTEXT, nil];
                    break;
                    
                default:
                    break;
            }
            [m_arrayStoreFAQs addObject:dicInfo];
        }
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
 

    
    
      setAllViewautoResize(self.view);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)keyboardWillShown:(NSNotification *)aNotification
{
    NSLog(@"note:%@",aNotification);
    
    if ([[[aNotification userInfo] valueForKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue] <= 0)
    {
        return;
    }
    [UIView animateWithDuration:0.3f
                     animations:^
     {
       //  CGRect frame = self.view.frame;
       //  [self.view setFrame:CGRectMake(0, -60, frame.size.width, frame.size.height)];
         
         for (UIView  *view in [self.view subviews])
         {
             if (view.tag == 10)
             {
                 [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-20, view.frame.size.width, view.frame.size.height)];
             }
         }
         
      //   [textViewAdvice setFrame:CGRectMake(textViewAdvice.frame.origin.x, textViewAdvice.frame.origin.y-60, textViewAdvice.frame.size.width, textViewAdvice.frame.size.height)];
     } completion:^(BOOL finish)
     {
         [textViewAdvice becomeFirstResponder];
         
     }];
    
}

- (void)keyboardWillHidden:(NSNotification *)aNotification
{
    NSLog(@"note:%@",aNotification);
    [UIView animateWithDuration:0.3f
                     animations:^
     {
        // CGRect frame = self.view.frame;
         //[self.view setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
         
         for (UIView  *view in [self.view subviews])
         {
             if (view.tag == 10)
             {
                 [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+20, view.frame.size.width, view.frame.size.height)];
             }
         }
       ///  [textViewAdvice setFrame:CGRectMake(textViewAdvice.frame.origin.x, textViewAdvice.frame.origin.y-60, textViewAdvice.frame.size.width, textViewAdvice.frame.size.height)];

         
     } completion:^(BOOL finish)
     {
        }];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_arrayStoreFAQs count];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary  *dicInfo = [m_arrayStoreFAQs objectAtIndex:indexPath.row];
    NSString  *strTemp = [dicInfo valueForKey:TITLE];
    CGFloat  fheight = ([strTemp length]/WORDNUMBER+1)*SINGELINEWIDTH+5;
    
    strTemp = [dicInfo valueForKey:CONTEXT];
    fheight+= ([strTemp length]/WORDNUMBER+1)*SINGELINEWIDTH+5;
    if (indexPath.row == 5)
    {
        fheight = 9*SINGELINEWIDTH+5;
    }
    
    return fheight;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"111"];
    if (!cell)
    {
        [tableView setBackgroundColor:[UIColor clearColor]];
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"111"] autorelease];
        UILabel    *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, tableView.frame.size.width-10, 21)];
        [labelTitle setTextColor:[UIColor blackColor]];
        [labelTitle setBackgroundColor:[UIColor clearColor]];
        labelTitle.tag = 11;
        UILabel     *labelContext = [[UILabel alloc] initWithFrame:CGRectMake(5, 21+10, tableView.frame.size.width-10, 21)];
        [labelContext setTextColor:[UIColor blueColor]];
        [labelContext setBackgroundColor:[UIColor clearColor]];
        labelContext.tag = 12;
        [cell.contentView addSubview:labelContext];
        [cell.contentView addSubview:labelTitle];
        [labelTitle release];
        [labelContext release];
         tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary  *dicInfo = [m_arrayStoreFAQs objectAtIndex:indexPath.row];
    if (dicInfo)
    {
        UILabel  *label = (UILabel *)[cell.contentView viewWithTag:11];
        NSString  *strTemp = [dicInfo valueForKey:TITLE];
        label.text = [NSString stringWithFormat:@"Q:%@",strTemp];
        CGFloat  fheight = ([strTemp length]/WORDNUMBER+1)*SINGELINEWIDTH;
        [label setFrame:CGRectMake(5, 5, tableView.frame.size.width-10, fheight)];
        [label setNumberOfLines:[strTemp length]/WORDNUMBER+1];
        label = (UILabel *)[cell.contentView viewWithTag:12];
        strTemp = [dicInfo valueForKey:CONTEXT];
        if (label)
        {
            label.text = [@"A:" stringByAppendingString:strTemp];
            [label setFrame:CGRectMake(5, fheight+5, tableView.frame.size.width-10, ([strTemp length]/WORDNUMBER+1)*SINGELINEWIDTH)];
            [label setNumberOfLines:[strTemp length]/WORDNUMBER+1];
        }
        
            if (indexPath.row == 5)
        {
            label.text = [@"A:" stringByAppendingString:strTemp];
            [label setFrame:CGRectMake(5, fheight+5, tableView.frame.size.width-10, 8*SINGELINEWIDTH)];
            [label setNumberOfLines:8];
            
        }
    }
    
    
    return cell;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    
  //  [textViewAdvice setContentOffset:textView.frame.origin];
    [textView setTextColor:[UIColor blackColor]];
    [textViewAdvice setTextAlignment:NSTextAlignmentLeft];
    if (NSNotFound != [textView.text rangeOfString:NSLocalizedString(@"在此输入您的反馈", nil)].location)
    {
        [textView setText:@""];
        [textViewAdvice setTextColor:[UIColor blackColor]];
    }
    
}


-(void)textViewDidEndEditing:(UITextView *)textView
{
    [textViewAdvice resignFirstResponder];
}



- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length] > 0)
    {
        [self setSendButtonEnable:YES];
    }else
    {
        [self setSendButtonEnable:NO];
    }
//    if ([textViewAdvice.text rangeOfString:@"\n"].location != NSNotFound)
//    {
//        [self.view endEditing:YES];
//    }
    
    if (sinaCountWord(textView.text) >= 140)
    {
        [textView setText:[textView.text substringWithRange:NSMakeRange(0, [textView.text length]-2)]];
    }
    
}

-(void)setSendButtonEnable:(BOOL)bEnale
{
    [btnSend setEnabled:bEnale];
    if (!bEnale)
    {
        [btnSend setBackgroundImage:[UIImage imageNamed:@"button_gray.png"] forState:UIControlStateNormal];
        [textViewAdvice setTextColor:[UIColor grayColor]];
        if (![textViewAdvice isFirstResponder])
        {
           
            [textViewAdvice setTextAlignment:NSTextAlignmentCenter];
             [textViewAdvice setText:NSLocalizedString(@"在此输入您的反馈!（仅限140字）", nil)];
        }
        
    }else
    {
        [btnSend setBackgroundImage:[UIImage imageNamed:@"button_green.png"] forState:UIControlStateNormal];
        [textViewAdvice setTextAlignment:NSTextAlignmentLeft];
        [textViewAdvice setTextColor:[UIColor blackColor]];
    }
}

-(void)receiveNotiFormServer:(NSNotification *)note
{
    RJFTcpSocket  *m_socket = [note object];
    NSDictionary  *dicInfo = [note userInfo];
    if (dicInfo &&(m_socket.tag == 1  || m_socket.tag == 0) )
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

    
    if (requestCode != REQ_FEEDBACK)
    {
        [objShare release];
        objShare = nil;
        return;
    }
    
    handle =[objShare PhaseInfoFromData:(int8_t *)[data bytes]
                                 
                         outRequestCode:&requestCode];
    DZPK_SERVER_REQ_FEEDBACK  *serverStatus = (DZPK_SERVER_REQ_FEEDBACK*)handle;
    if (serverStatus->status == 0)
    {
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:NSLocalizedString(@"提示\n\n恭喜您！反馈成功！", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
    }else
    {
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:NSLocalizedString(@"提示\n\n输入已达上限！", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
    }
    free(handle);
    handle = NULL;
    [objShare release];
    objShare = nil;
    
}
-(void)viewWillAppear:(BOOL)animated
{
  
    scorView = [[UIScrollView alloc] initWithFrame:CGRectMake(11, 52, 458, 800)];
   //[scorView setBackgroundColor:[UIColor clearColor]];
    [scorView setScrollEnabled:YES];
    [scorView setPagingEnabled:NO];
    [scorView setShowsVerticalScrollIndicator:YES];
    [scorView setShowsHorizontalScrollIndicator:YES];
    scorView.tag = 10;
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 458, 253)];
    backView.tag = 110;
    backView.image = [UIImage imageNamed:@"bglogin.png"];
  //  backView.userInteractionEnabled =YES
    [scorView addSubview:backView];
    [backView release];
    backView.userInteractionEnabled = YES;
    
    UIImageView  *textBg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 20, 395, 71)];
    textBg.image = [UIImage imageNamed:@"advice.png"];
    textBg.tag = 10;
    textBg.userInteractionEnabled = YES;
    [scorView addSubview:textBg];
    [textBg release];
    
    textViewAdvice = [[UITextView alloc] initWithFrame:CGRectMake(35, 24, 384, 60)];
    [scorView addSubview:textViewAdvice];
    textViewAdvice.tag = 10;
    textViewAdvice.editable = YES;
    [textViewAdvice release];
    
    
    
    btnSend = [[UIButton alloc] initWithFrame:CGRectMake(340, 96, 80, 31)];
    [btnSend setTitle:@"发送" forState:UIControlStateNormal];
    [btnSend addTarget:self
                action:@selector(clickSend:)
      forControlEvents:UIControlEventTouchUpInside];
    [scorView addSubview:btnSend];
    [btnSend release];
    
    UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 142, 384, 1)];
    [label setBackgroundColor:[UIColor lightGrayColor]];
    [scorView addSubview:label];
    label.userInteractionEnabled =YES;
    [label release];
    
    UITextView  *textKefu = [[UITextView alloc] initWithFrame:CGRectMake(25, 152, 384, 100)];
    [textKefu setBackgroundColor:[UIColor clearColor]];
    [textKefu setEditable:NO];
  //  [textKefu setScrollEnabled:NO];
    [scorView addSubview:textKefu];
    textKefu.userInteractionEnabled = YES;
    [textKefu setFont:[UIFont systemFontOfSize:14]];
    [textKefu setTag:10];
    [textKefu setText:NSLocalizedString(@"客服", nil)];
    [textKefu release];
    [textKefu setScrollEnabled:YES];
   // textKefu.userInteractionEnabled = YES;
    
     [scorView setContentSize:CGSizeMake(458, 800)];
    [self.view addSubview:scorView];
    [scorView release];
    
    
    
    
    [textViewAdvice setDelegate:self];
    [btnAdvice setBackgroundImage:[UIImage imageNamed:@"nav_sepline.png"] forState:UIControlStateNormal];
    [btnSend setBackgroundImage:[UIImage imageNamed:@"button_green.png"] forState:UIControlStateNormal];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
  
    [self setDoneButton:textViewAdvice];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotiFormServer:)
                                                 name:BNRRECEIVEMESSAGEFROMSERVER
                                               object:nil];
    
    [self setSendButtonEnable:NO];
    textViewAdvice.autoresizingMask = UIViewAutoresizingNone;
    if (m_faqControlType == FAQPAGETYPE)
    {
        [self clickFAQ:btnFAQ];
        [labelFAQTitle setText:NSLocalizedString(@"FAQ", nil)];
        m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(2, 2, 454, 243)];
        [m_tableView setDelegate:self];
        [m_tableView setDataSource:self];
        [m_tableView setHidden:NO];
    
        textKefu.hidden =YES;
        [btnSend setHidden:YES];
        textBg.hidden = YES;
        [label setHidden:YES];
        textViewAdvice.hidden = YES;
       // [scorView setHidden:YES];
        [scorView addSubview:m_tableView];
        [m_tableView reloadData];
        [m_tableView release];
        
    }else
    {
        [self clickAdvice:btnAdvice];
        [labelFAQTitle setText:NSLocalizedString(@"意见反馈", nil)];
    }
    
    
    
    
     [super viewWillAppear:animated];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint  point = [[touches anyObject] locationInView:self.view];
    
    if (!CGRectContainsPoint(textViewAdvice.frame, point))
    {
        [self.view endEditing:YES];
    }
}

-(void)setDoneButton:(UITextView *)tvTextView
{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    //[topView setBarStyle:UIBarStyleBlack];
    [topView setBackgroundColor:[UIColor clearColor]];
    
    //UIBarButtonItem * helloButton = [[UIBarButtonItem alloc]initWithTitle:@"Hello" style:UIBarButtonItemStyleBordered target:self action:nil];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"完成", nil) style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    
    [doneButton release];
    
     [btnSpace release];
    
   // [helloButton release];
    
    [topView setItems:buttonsArray];
    
    [tvTextView setInputAccessoryView:topView];
    [topView release];
    
}


-(IBAction)dismissKeyBoard

{
    
   // [tvTextView resignFirstResponder];
    [self.view endEditing:YES];
    
}
@end
