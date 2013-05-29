//
//  RJFEditUserinfoViewController.m
//  Texas-pokes
//
//  Created by popo on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFEditUserinfoViewController.h"
#import "RJFUpAndDown.h"
#import "ModelActionSheet.h"
#define HEADFIELDIR   [NSHomeDirectory() stringByAppendingFormat:@"/"]
#define DOWNLOADREQUESDID   43
@interface RJFEditUserinfoViewController ()

@end

@implementation RJFEditUserinfoViewController
@synthesize HeadPicName = m_strPicName;
#pragma mark BNRWarnViewDelegate delegate method

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *          invoke by click the button cancel
 *  @param
 *          sender
 *              button
 *	@return
 *          NONE
 *
 */
-(void)ClickCancel:(id)sender
{
    
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *          invoke by click the button insure
 *  @param
 *          sender
 *              button
 *	@return
 *          NONE
 *
 */
-(void)ClickInsure:(id)sender
{
  [self FinishSave:nil];
}

-(void)FinishSave:(id)Thread
{
    [btnEdit setImage:[UIImage imageNamed:@"userinfo_edit.png"] forState:UIControlStateNormal];
    [textName setBorderStyle:UITextBorderStyleNone];
    [textName setEnabled:NO];
    [textSex setBorderStyle:UITextBorderStyleNone];
    [btnArrowSelect setHidden:YES];
    
    
    [btnSave setEnabled:NO];
    [btnSave setImage:[UIImage imageNamed:@"up1.png"] forState:UIControlStateNormal];
    btnSave.alpha = 0.3f;
    [Myuser.Sex setString:textSex.text];
    [Myuser.userName setString:textName.text];
    
    if (m_bisPick)
    {
        UIImage  *image = userImageView.image;
        NSData   *data = UIImagePNGRepresentation(image);
        NSFileManager  *fileManger = [NSFileManager defaultManager];
        if (![fileManger fileExistsAtPath:USERIMAGEPATH])
        {
            
        }else
        {
            NSError   *error = nil;
            [fileManger removeItemAtPath:USERIMAGEPATH error:&error];
            if (error)
            {
                logMyLogInfo(@"error:%@",[error localizedDescription]);
            }
        }
      
        [data writeToFile:USERIMAGEPATH atomically:NO];
        logMyLogInfo(@"save");
        m_bisPick = NO;
    }
    
}

#pragma mark self define method
/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *          link to the textfield,resingnFirstResponde
 *  @param
 *          sender
 *              button
 *	@return
 *          NONE
 *
 */
-(IBAction)resignKey:(id)sender
{
    UserInfo  *objUser = [UserInfo shareInstance];

    if (![textName.text isEqualToString:objUser.userName])
    {
        [btnSave setEnabled:YES];
        [btnSave setImage:[UIImage imageNamed:@"up2.png"] forState:UIControlStateNormal];
        btnSave.alpha = 0.8f;
        
    }
    [sender resignFirstResponder];
    
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *           back to previous control
 *  @param
 *          sender
 *              button
 *	@return
 *          NONE
 *
 */
-(IBAction)clickBack:(id)sender
{
    UIView  *view = [self.view viewWithTag:1234];
    if (view)
    {
        [view removeFromSuperview];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *           save the dit content. only enable after click button edit
 *  @param
 *          sender
 *              button
 *	@return
 *          NONE
 *
 */
-(IBAction)clickSave:(id)sender
{
    //[RJFWarnView addinSelfview:self.view delegate:self message:@"修改成功!"];
    [textName resignFirstResponder];

    
//    const char *data =(const char *) [textName.text cStringUsingEncoding:NSUTF16BigEndianStringEncoding];
//    int count = uni_strlen((char *)data);
//    logMyLogInfo(@"1111count:%d",count);
//    if (count == 0 || count > 12)
//    {
//        [RJFWarnView addinSelfview:self.view
//                          delegate:nil
//                           message:NSLocalizedString(@"提示\n\n很抱歉，您的用户名不符合规范!\n用户名最长为6个汉字或者\n12位英文字母！\n", nil)
//                        buttontype:INSUREBUTTON
//                      InsureButton:INSURE
//                      CancelButton:nil];
//        return;
//    }
    
    if ([textName.text isEqualToString:@""])
    {
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:NSLocalizedString(@"提示:\n\n\n昵称为空！", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
        return;
    }
    
    ShowHUD(NSLocalizedString(@"更新信息中", nil), self, 25);
    RJFTcpSocket    *m_socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    BasisZipAndUnzip    *shareZip = [[BasisZipAndUnzip alloc] initWithSize:200];
    UserInfo  *objUser = [UserInfo shareInstance];
    int8_t  sex = [textSex.text isEqualToString:NSLocalizedString(@"男", nil)]?0:1;
    
    
    
    if (!m_bisPick)
    {
        self.HeadPicName = objUser.userImagePath;
    }
    DZPK_CLIENT_REQ_PERSON_DATA_ALTER   personInfo = {textName.text,self.HeadPicName,sex};
    
    [m_socket SendCharMessage:[shareZip syncWithRequest:REQ_PERSON_DATA_ALTER
                                                 userID:objUser.userIDForDzpk
                                            structArray:&personInfo
                                           ]
                         size:[shareZip dataSize]];
    [shareZip release];
    
    
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *          click and edit user name and sex
 *  @param
 *          sender
 *              button
 *	@return
 *          NONE
 *
 */
-(IBAction)clickEdit:(id)sender
{
    
    [btnEdit setImage:[UIImage imageNamed:@"userinfo_edit_pressed.png"] forState:UIControlStateNormal];
    [textName setBorderStyle:UITextBorderStyleRoundedRect];
    [textName setEnabled:YES];
    [textName setEnablesReturnKeyAutomatically:YES];
    [textName addTarget:self
                 action:@selector(resignKey:)
       forControlEvents:UIControlEventEditingDidEndOnExit];
    [textSex setBorderStyle:UITextBorderStyleRoundedRect];
    [btnArrowSelect setHidden:NO];
    logMyLogInfo(@"edit");
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *          click and choose sex
 *  @param
 *          sender
 *              button
 *	@return
 *          NONE
 *
 */
-(IBAction)clickArrowSelect:(UIButton *)sender
{
   ModelActionSheet  *actionSheet = [[ModelActionSheet alloc] initWithHeight:SCREENHEIGHT-100 WithSheetTitle:@"性别"];
    [actionSheet setDelegate:self];
    UIPickerView   *pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, SCREENWIDTH,SCREENHEIGHT-150)];
    [pick setDataSource:self];
    [pick setDelegate:self];
    pick.showsSelectionIndicator = YES;
    [actionSheet addSubview:pick];
    [pick release];
    [actionSheet showInView:self.view];
    [m_strSex setString:NSLocalizedString(@"男", nil)];
    
    

    logMyLogInfo(@"arrow");
}

#pragma mark overide method

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 07
 *  @brief
 *          override method dealloc
 *	@return
 *          NONE
 *
 */

-(void)dealloc
{
    if (btnBack)
    {
        [btnBack release];
        btnBack = nil;
    }
    if (btnSave)
    {
        [btnSave release];
        btnSave = nil;
    }
    if (m_tableView)
    {
        [m_tableView release];
        m_tableView = nil;
    }
    if (imageiewedits)
    {
        [imageiewedits release];
        imageiewedits = nil;
    }
    if (userImageView)
    {
        [userImageView release];
        userImageView = nil;
    }
    if (m_strSex)
    {
        [m_strSex release];
        m_strSex = nil;
    }
    [super dealloc];
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *         init
 *  @param
 *          nibNameOrNil
 *              nibName
 *  @param
 *          nibBundleOrNil
 *              bundle
 *	@return
 *          id(self)
 *
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        m_bisPick = NO;
        m_strSex = [[NSMutableString alloc] init];
        // Custom initialization
    }
    return self;
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *          overide method
 *	@return
 *          id(self)
 *
 */
- (void)viewDidLoad
{
    Myuser = [UserInfo shareInstance];
    userImageView.layer.masksToBounds = YES;
    userImageView.layer.cornerRadius = 5;
    
    UIImage  *image = [RJFUpAndDown getLocalImage:[[UserInfo shareInstance] userImagePath]];
     
    if (image != nil)
    {
        userImageView.image = image;
    }else
    {
       // UIImage  *imageDefault = [UIImage imageNamed:@"userDefault.png"];
      //  userImageView.image = imageDefault;
        
        RJFUpAndDown  *upanddown = [RJFUpAndDown shareWithTag:0];
        [upanddown setDelegate:self];
        [upanddown SendDownRequest:[[UserInfo shareInstance] userImagePath] requestID:DOWNLOADREQUESDID];
    }
    
    UIImageView  *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 46, 30)];
    imageview.image = [UIImage imageNamed:@"save.png"];
    imageview.tag = 1000;
    btnSave.alpha = 0.3;
    [btnSave addSubview:imageview];
    [imageview release];
    
    setAllViewautoResize(self.view);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *          overide method
 *	@return
 *          id(self)
 *
 */
- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *          overide method
 *  @param
 *          interfaceOrientation
 *              Orientation
 *	@return
 *          id(self)
 *
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *          overide method. if click the user image. user could pick photo
 *  @param
 *          touches
 *              touch event
 *  @param
 *          event
 *              event
 *	@return
 *          id(self)
 *
 */
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint  point = [[touches anyObject] locationInView:self.view];
    // CGPoint  point2 = [[touches anyObject] locationInView:imageiewedits];
    
    if (CGRectContainsPoint(imageiewedits.frame, point) || CGRectContainsPoint(userImageView.frame, point))
    {
        UserInfo  *objUser = [UserInfo shareInstance];
        [objUser setUserInterface:UIInterfaceOrientationMaskAllButUpsideDown];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController  *pick = [[[UIImagePickerController alloc] init] autorelease];
            pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pick.videoQuality = UIImagePickerControllerQualityTypeHigh;
            pick.allowsEditing = YES;
          //  pick.cameraOverlayView = [[UIView alloc] initWithFrame:userImageView.bounds];
            [pick setDelegate:self];
            [self presentViewController:pick animated:YES completion:^{}];
            
        }
     
        
    }
    
}


#pragma mark tableView headview
/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *          head view of tableview
 *  @param
 *          Thread
 *              now is nil
 *	@return
 *          UIView
 *
 */
-(UIView *)settabViewHeadView:(id)Thread
{
    
    UIView    *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,245,104)];
    UILabel   *labelName = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 70, 31)];
    UILabel   *labelSex = [[UILabel alloc] initWithFrame:CGRectMake(0, 51, 70, 31)];
    btnEdit = [[UIButton alloc] initWithFrame:CGRectMake(205, 15, 30, 30)];
    [btnEdit setImage:[UIImage imageNamed:@"userinfo_edit.png"] forState:UIControlStateNormal];
    btnArrowSelect = [[UIButton alloc] initWithFrame:CGRectMake(168, 55, 20, 30)];
    [btnArrowSelect setImage:[UIImage imageNamed:@"userinfo_arrow.png"] forState:UIControlStateNormal];
    [btnArrowSelect setHidden:YES];
    [btnEdit addTarget:self
                action:@selector(clickEdit:)
      forControlEvents:UIControlEventTouchUpInside];
    [btnSave setEnabled:NO];
    [btnArrowSelect addTarget:self
                       action:@selector(clickArrowSelect:)
             forControlEvents:UIControlEventTouchUpInside];
    [labelSex setBackgroundColor:[UIColor clearColor]];
    [labelName setBackgroundColor:[UIColor clearColor]];
    textName = [[UITextField alloc] initWithFrame:CGRectMake(50, 15, 140, 31)];
    
    NSNotificationCenter  *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self
                  name:UITextFieldTextDidChangeNotification
                object:nil];
    [nc addObserver:self
           selector:@selector(textDidChange:)
               name:UITextFieldTextDidChangeNotification
             object:textName];
    textSex = [[UITextField alloc] initWithFrame:CGRectMake(50, 54, 140, 31)];
    [textSex setEnabled:NO];
    [textName setEnabled:NO];
    UIImageView   *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 103, 243, 2)];
    [imageview setBackgroundColor:[UIColor clearColor]];
    imageview.image = [UIImage imageNamed:@"dot_line.png"];
    
    [view addSubview:labelName];
    [view addSubview:labelSex];
    [view addSubview:textName];
    [view addSubview:textSex];
    [view addSubview:imageview];
    [view addSubview:btnArrowSelect];
    [view addSubview:btnEdit];
    [btnEdit release];
    [btnArrowSelect release];
    
    [labelName release];
    [labelSex release];
    [textSex release];
    [textName release];
    [imageview release];
    [labelName setText:NSLocalizedString(@"昵称：", nil)];
    [labelSex setText:NSLocalizedString(@"性别：", nil)];
    textName.text = Myuser.userName;
    textSex.text = Myuser.Sex;
    [textName setTextColor:[UIColor blueColor]];
    [textSex setTextColor:[UIColor blueColor]];
    return [view autorelease];
    // [m_tableView setTableFooterView:view];
    
}


#pragma mark imagePick delegate method

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *         pick image you like
 *  @param
 *          picker
 *              UIImagePickerController
 *  @param
 *          info
 *              the info about user choice
 *	@return
 *          NONE
 *
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage  *image = [info valueForKey:UIImagePickerControllerEditedImage];
    userImageView.image = image;
    m_bisPick =  YES;
    
    [btnSave setEnabled:YES];
     btnSave.alpha = 0.8f;
    [btnSave setBackgroundImage:[UIImage imageNamed:@"up2.png"] forState:UIControlStateNormal];
    
    //[self.ontroller]
    UserInfo  *objUser = [UserInfo shareInstance];
    [objUser setUserInterface:UIInterfaceOrientationMaskLandscape];
   [self dismissViewControllerAnimated:YES completion:NULL];
    
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *         cancel choose
 *  @param
 *          picker
 *              UIImagePickerController
 *	@return
 *          NONE
 *
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [btnSave setEnabled:NO];
    UserInfo  *objUser = [UserInfo shareInstance];
    [objUser setUserInterface:UIInterfaceOrientationMaskLandscape];
    [self dismissViewControllerAnimated:YES completion:NULL];
}



#pragma tableView delegate method

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 07
 *  @brief
 *         delegate method
 *  @param
 *          tableView
 *              tableView
 *  @param
 *          section
 *              section
 *	@return
 *          number Of Rows in section
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return 10;
}



/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 07
 *  @brief
 *         delegate method
 *  @param
 *          tableView
 *              tableView
 *  @param
 *          indexPath
 *              indexPath
 *	@return
 *          cell height
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    switch (indexPath.row)
    {
        case 0:
            return 110;
            break;
            
        default:
            break;
    }
    return 40;
}





/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 07
 *  @brief
 *         delegate method
 *  @param
 *          tableView
 *              tableView
 *  @param
 *          indexPath
 *              indexPath
 *	@return
 *          cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  *cell = nil;
    UserInfo        *objUser = [UserInfo shareInstance];
    
    switch (indexPath.row)
    {
        case 0:
            cell  = [tableView dequeueReusableCellWithIdentifier:@"qq"];
            if (!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"qq"] autorelease];
                [cell.contentView addSubview:[self settabViewHeadView:nil]];
            }
            break;
        case 1:
            cell  = [tableView dequeueReusableCellWithIdentifier:@"qq1"];
            if (!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"qq1"] autorelease];
                float  fwidth = 0;
                UILabel  *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 42, 21)];
                [label1 setBackgroundColor:[UIColor clearColor]];
                [label1 setText:NSLocalizedString(@"资产:", nil)];
                fwidth = 42+5;
                UIImageView  *imageviewWeath = [[UIImageView alloc] initWithFrame:CGRectMake(fwidth, 10, 15, 15)];
                fwidth +=15+5;
                imageviewWeath.image = [UIImage imageNamed:@"small_chips.png"];
                UILabel *labelChips = [[UILabel alloc] initWithFrame:CGRectMake(fwidth, 8, 70, 21)];
                [labelChips setBackgroundColor:[UIColor clearColor]];
                fwidth +=5+70;
                UIImageView  *imageviewbeans = [[UIImageView alloc] initWithFrame:CGRectMake(fwidth, 12, 15, 15)];
                imageviewbeans.image = [UIImage imageNamed:@"logo_ibeans.png"];
                fwidth +=15+8;
                UILabel *labeliBeans = [[UILabel alloc] initWithFrame:CGRectMake(fwidth, 8, 70, 21)];
                [labeliBeans setBackgroundColor:[UIColor clearColor]];
                labelChips.text = [NSString stringWithNeedTranfanstring:[NSNumber numberWithInt:Myuser.userChips] returnType:GAMESHOWTYPE];
                labeliBeans.text = [NSString stringWithFormat:@"%0.0f",Myuser.idou];
                UIView  *view = cell.contentView;
                [view addSubview:label1];
                [view addSubview:imageviewWeath];
                [view addSubview:labelChips];
                [view addSubview:labeliBeans];
                [view addSubview:imageviewbeans];
                [labeliBeans release];
                [imageviewbeans release];
                [imageviewWeath release];
                [label1 release];
                [labelChips release];
                //[cell.contentView addSubview:[self settabViewHeadView:nil]];
            }
            break;
        case 2:
            cell  = [tableView dequeueReusableCellWithIdentifier:@"1"];
            if (!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"1"] autorelease];
                UILabel  *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 42, 21)];
                [label2 setBackgroundColor:[UIColor clearColor]];
                [label2 setText:NSLocalizedString(@"等级:", nil)];
                
                UIImageView   *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(42+5, 10, 12, 17)];
                imageview.backgroundColor = [UIColor clearColor];
                
               // objUser.level = 10;
                if (objUser.level <= 1)
                {
                    imageview.image = nil;
                }else if (objUser.level < 7)
                {
                    imageview.image = [UIImage imageNamed:@"medal_1.png"];
                }else if (objUser.level < 10)
                {
                    imageview.image = [UIImage imageNamed:@"medal_2.png"];
                }else if (objUser.level < 14)
                {
                    imageview.image = [UIImage imageNamed:@"medal_3.png"];
                }else if (objUser.level < 18)
                {
                    imageview.image = [UIImage imageNamed:@"medal_4.png"];
                }else
                {
                    imageview.image = [UIImage imageNamed:@"medal_5.png"];
                }
                [cell.contentView addSubview:imageview];
                [imageview release];
                
                
                
                UILabel *labelLevel = [[UILabel alloc] initWithFrame:CGRectMake(42+5+12+5, 8, 70, 21)];
                [labelLevel setBackgroundColor:[UIColor clearColor]];
                [labelLevel setText:getLevelName(objUser.score)];
                
                
                
                UILabel   *labelScore = [[UILabel alloc] initWithFrame:CGRectMake(42+5+80,8,120,21)];
                [labelScore setText:[NSString stringWithFormat:NSLocalizedString(@"积分: %d", nil),objUser.score]];
                [labelScore setBackgroundColor:[UIColor clearColor]];
                [cell.contentView addSubview:labelScore];
                [labelScore release];
                
                [cell.contentView addSubview:labelLevel];
                [cell.contentView addSubview:label2];
                [label2 release];
                [labelLevel release];
            }
            break;
        case 3:
            cell  = [tableView dequeueReusableCellWithIdentifier:@"sdfsdf"];
            if (!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"sdfsdf"] autorelease];
                UILabel   *labelScore = [[UILabel alloc] initWithFrame:CGRectMake(0,8,200,21)];
                [labelScore setText:[NSString stringWithFormat:NSLocalizedString(@"比赛积分: %d",nil),objUser.matchscore]];
                [labelScore setBackgroundColor:[UIColor clearColor]];
                [cell.contentView addSubview:labelScore];
                [labelScore release];
            }
            break;
        case 4:
            cell  = [tableView dequeueReusableCellWithIdentifier:@"2"];
            if (!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"2"] autorelease];
                UILabel  *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 42, 21)];
                [label3 setBackgroundColor:[UIColor clearColor]];
                [label3 setText:NSLocalizedString(@"战绩:", nil)];
                UILabel *labelScore = [[UILabel alloc] initWithFrame:CGRectMake(42+5, 8, 100, 21)];
                [labelScore setBackgroundColor:[UIColor clearColor]];
                labelScore.text = [NSString stringWithFormat:NSLocalizedString(@"%ld胜%ld败", nil),Myuser.winTimes,Myuser.loseTime];
                [cell.contentView addSubview:labelScore];
                [cell.contentView addSubview:label3];
                [label3 release];
                [labelScore release];
            }
            break;
        case 5:
            cell  = [tableView dequeueReusableCellWithIdentifier:@"3"];
            if (!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"3"] autorelease];
                UILabel  *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 42, 21)];
                [label4 setBackgroundColor:[UIColor clearColor]];
                [label4 setText:NSLocalizedString(@"胜率:", nil)];
                UILabel *labelPer = [[UILabel alloc] initWithFrame:CGRectMake(42+5, 8, 100, 21)];
                [labelPer setBackgroundColor:[UIColor clearColor]];
                NSString  *strTemp = nil;
                if (Myuser.winTimes+Myuser.loseTime == 0)
                {
                    strTemp = @"0%";
                }else
                {
                    strTemp =[NSString stringWithFormat:@"%0.0f%%",Myuser.winTimes*1.0f/(Myuser.winTimes*1.0f+Myuser.loseTime*1.0f)*100];
                }
                labelPer.text = strTemp;
                // labelPer.text = [NSString stringWithFormat:@"%d胜%d败",user.winTimes,user.loseTime];
                [cell.contentView addSubview:labelPer];
                [cell.contentView addSubview:label4];
                [label4 release];
                [labelPer release];
            }
            break;
        case 6:
            cell  = [tableView dequeueReusableCellWithIdentifier:@"5"];
            if (!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"5"] autorelease];
                UILabel  *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 75, 21)];
                [label4 setBackgroundColor:[UIColor clearColor]];
                [label4 setText:NSLocalizedString(@"最大手牌:", nil)];
                
                for (int i = 0; i < 5; i++)
                {
                    UIImageView  *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(75+13*i+20*i, 8, 13, 20)];
                    //imageview.image = [UIImage imageNamed:@"max_1.png"];
                    UILabel  *labelCard = [[UILabel alloc] initWithFrame:CGRectMake(87+20*i+13*i+2, 10, 20, 17)];
                    
                    
                    int  iCaredNumber = -1;
                    switch (i)
                    {
                        case 0:
                            iCaredNumber = Myuser.MaxCard1;
                            break;
                        case 1:
                            iCaredNumber = Myuser.MaxCard2;
                            break;
                        case 2:
                            iCaredNumber = Myuser.MaxCard3;
                            break;
                        case 3:
                            iCaredNumber = Myuser.MaxCard4;
                            break;
                        case 4:
                            iCaredNumber = Myuser.MaxCard5;
                            break;
                            
                        default:
                            break;
                    }
                    labelCard.text = SetCardNumber(iCaredNumber);
                    imageview.image =  MaxImageAccordCardNumber(iCaredNumber);
                    [labelCard setBackgroundColor:[UIColor clearColor]];
                    [cell.contentView addSubview:labelCard];
                    [cell.contentView addSubview:imageview];
                    [labelCard release];
                    [imageview release];
                }
                
                
                [cell.contentView addSubview:label4];
                [label4 release];
            }
            break;
        case 7:
            cell  = [tableView dequeueReusableCellWithIdentifier:@"6"];
            if (!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"6"] autorelease];
                UILabel  *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 80, 21)];
                [label4 setBackgroundColor:[UIColor clearColor]];
                [label4 setText:NSLocalizedString(@"已玩局数:", nil)];
                UILabel *labelTimes = [[UILabel alloc] initWithFrame:CGRectMake(80+10, 8, 100, 21)];
                [labelTimes setBackgroundColor:[UIColor clearColor]];
                
                labelTimes.text = [NSString stringWithFormat:@"%ld",Myuser.winTimes+Myuser.loseTime];
                // labelPer.text = [NSString stringWithFormat:@"%d胜%d败",user.winTimes,user.loseTime];
                [cell.contentView addSubview:labelTimes];
                [cell.contentView addSubview:label4];
                [label4 release];
                [labelTimes release];
            }
            break;
        case 8:
            cell  = [tableView dequeueReusableCellWithIdentifier:@"7"];
            if (!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"7"] autorelease];
                UILabel  *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 80, 21)];
                [label4 setBackgroundColor:[UIColor clearColor]];
                [label4 setText:NSLocalizedString(@"最高拥有:", nil)];
                
                
                UIImageView   *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80+5, 10, 15, 15)];
                imageView.image = [UIImage imageNamed:@"small_chips.png"];
                UILabel *labelMaxGain = [[UILabel alloc] initWithFrame:CGRectMake(80+5+20+5, 5, 100, 21)];
                [labelMaxGain setBackgroundColor:[UIColor clearColor]];
                
                labelMaxGain.text = [NSString stringWithFormat:@"%ld",Myuser.maxOwn];
                [cell.contentView addSubview:labelMaxGain];
                [cell.contentView addSubview:label4];
                [cell.contentView addSubview:imageView];
                [imageView release];
                [label4 release];
                [labelMaxGain release];
            }
            break;
        case 9:
            cell  = [tableView dequeueReusableCellWithIdentifier:@"8"];
            if (!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"8"] autorelease];
                UILabel  *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 80, 21)];
                [label4 setBackgroundColor:[UIColor clearColor]];
                [label4 setText:NSLocalizedString(@"最大赢取:", nil)];
                
                
                UIImageView   *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80+5, 10, 15, 15)];
                imageView.image = [UIImage imageNamed:@"small_chips.png"];
                UILabel *labelMaxWins = [[UILabel alloc] initWithFrame:CGRectMake(80+5+20+5, 5, 100, 21)];
                [labelMaxWins setBackgroundColor:[UIColor clearColor]];
                
                labelMaxWins.text = [NSString stringWithFormat:@"%ld",Myuser.MaxWinchips];
                [cell.contentView addSubview:labelMaxWins];
                [cell.contentView addSubview:label4];
                [cell.contentView addSubview:imageView];
                [imageView release];
                [label4 release];
                [labelMaxWins release];
            }
            break;
        default:
            cell  = [tableView dequeueReusableCellWithIdentifier:@"0"];
            if (!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"0"] autorelease];
            }
            
            cell.textLabel.text = @"qqq";
            break;
    }
    
    
    
    return  cell;
}



/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 07
 *  @brief
 *         delegate method
 *  @param
 *          tableView
 *              tableView
 *	@return
 *          number Of Sections In tableView
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}// Default is 1 if not implemented


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 07
 *  @brief
 *         delegate method. select the cell
 *  @param
 *          indexPath
 *              indexPath
 *	@return
 *          NONE
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:m_tableView])
    {
        return;
    }

}


-(void)receiveNotiFromServer:(NSNotification*)note
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
    BasisZipAndUnzip   *objShare = [[BasisZipAndUnzip alloc] initWithSize:size+5];
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
    if (requestCode == REQ_PERSON_DATA_ALTER)
    {
        handle =[objShare PhaseInfoFromData:bytes
                                     
                             outRequestCode:&requestCode];
        DZPK_SERVER_REQ_PERSON_DATA_ALTER   *serinfo = (DZPK_SERVER_REQ_PERSON_DATA_ALTER*)handle;
        if (serinfo->status == 0)
        {
            
            
            UIImage  *image = userImageView.image;
            // image = [UIImage imageNamed:@"max_1.png"];
            CGSize size = CGSizeMake(userImageView.frame.size.width/3*2, userImageView.frame.size.height/3*2);
            image = [UIImage imageByScalingAndCroppingForSize:size sourceImages:image];
            NSData   *data = UIImagePNGRepresentation(image);
            UserInfo  *objUser = [UserInfo shareInstance];
            [objUser.userName setString:textName.text];
            [objUser.Sex setString:textSex.text];
            //data = [@"1234" dataUsingEncoding:NSUTF8StringEncoding];
            //   NSFileManager  *fileManger = [NSFileManager defaultManager];
            
            
            
            NSLog(@"length:%d",[data length]);
            if ([data length] > 30*1024)
            {
                HideHUD(self, YES);
                [RJFWarnView addinSelfview:self.view
                                  delegate:nil
                                   message:NSLocalizedString(@"提示\n\n资料更新成功，但图片过大，不能上传\n请重新选择图片!", nil)
                                buttontype:INSUREBUTTON
                              InsureButton:INSURE
                              CancelButton:nil];
                free(handle);
                handle = NULL;
                [objShare release];
                objShare = nil;
                return;
                
            }
            
            if (m_bisPick)
            {
                RJFUpAndDown  *filesocket = [RJFUpAndDown shareWithTag:0];
                [filesocket setDelegate:nil];
                [filesocket setDelegate:self];
                [filesocket uploadfile:self.HeadPicName filedata:data];
            }else
            {
                HideHUD(self, YES);
                [btnSave setEnabled:YES];
                btnSave.alpha = 0.3f;
                [btnSave setBackgroundImage:[UIImage imageNamed:@"up1.png"] forState:UIControlStateNormal];
                [RJFWarnView addinSelfview:self.view
                                  delegate:self
                                   message:NSLocalizedString(@"提示\n\n\n修改成功!", nil)
                                buttontype:INSUREBUTTON
                              InsureButton:INSURE
                              CancelButton:nil];
               
            }
        
            
            
        }else if (serinfo->status == 1)
        {
            HideHUD(self, YES);
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n资料上传服务器失败!", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
        }else if (serinfo->status == 2)
        {
            HideHUD(self, YES);
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n很抱歉，您的用户名不符合规范!\n用户名最长为6个汉字或者\n12位英文字母！\n", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
        }
    }else if(requestCode == REQ_PERSON_DATA_HEAD_NAME)
    {
        handle =[objShare PhaseInfoFromData:bytes
                                     
                             outRequestCode:&requestCode];
        DZPK_SERVER_REQ_PERSON_DATA_HEAD_NAME  *info = (DZPK_SERVER_REQ_PERSON_DATA_HEAD_NAME*)handle;
        if (info->status)
        {
            logMyLogInfo(@"fail head pic name");
        }else
        {
            self.HeadPicName = info->name;
        }
        
    }
    free(handle);
    handle  = NULL;
    [objShare release];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    m_bModifyPic = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotiFromServer:)
                                                 name:BNRRECEIVEMESSAGEFROMSERVER
                                               object:nil];
    
    BasisZipAndUnzip  *basic = [[BasisZipAndUnzip alloc] initWithSize:40];
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    
    
    [socket SendCharMessage:[basic syncWithRequest:REQ_PERSON_DATA_HEAD_NAME
                                            userID:Myuser.userIDForDzpk
                                       structArray:NULL] size:[basic dataSize]];
    
    [basic release];
    
    
    
    [super viewWillAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
    
}

-(void)UploadSucOrFail:(BOOL)bSuc
{
    HideHUD(self, YES);
    if (bSuc)
    {
        [RJFWarnView addinSelfview:self.view
                          delegate:self
                           message:NSLocalizedString(@"提示\n\n\n修改成功!", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
        UserInfo  *shareUser = [UserInfo shareInstance];
        
        [shareUser.userImagePath setString:self.HeadPicName];
        [btnSave setEnabled:YES];
        btnSave.alpha = 0.3f;
        [btnSave setBackgroundImage:[UIImage imageNamed:@"up1.png"] forState:UIControlStateNormal];
    }else
    {
        [RJFWarnView addinSelfview:self.view
                          delegate:self
                           message:NSLocalizedString(@"提示\n\n图像上传失败!", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
        
    }
    NSLog(@"upload suc:%d",bSuc);
}


-(void)DownLoadSuOrFail:(UIImage *)image ISSuc:(BOOL)bSUc
{
    if (image)
    {
      userImageView.image = image;  
    }
    
}
-(void)textDidChange:(NSNotification*)note
{
    UserInfo  *objUser = [UserInfo shareInstance];
    if (![textName.text isEqualToString: objUser.userName])
    {
        [btnSave setEnabled:YES];
        btnSave.alpha = 0.8f;
        [btnSave setBackgroundImage:[UIImage imageNamed:@"up2.png"] forState:UIControlStateNormal];
    }
}

-(void)setDoneButton:(id)control
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
    
    [control setInputAccessoryView:topView];
    [topView release];
    
}


#pragma mark pick
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row == 0)
    {
        return NSLocalizedString(@"男", nil);
    }else
    {
        return NSLocalizedString(@"女", nil);
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

{
    return 40;
}

-(void)DoneOrCancle:(BOOL)BiSClickDone
{
    if (BiSClickDone)
    {
        UserInfo  *objUser = [UserInfo shareInstance];
        [textSex setText:m_strSex];
        if (![textSex.text isEqualToString:objUser.Sex])
        {
            [btnSave setEnabled:YES];
            btnSave.alpha = 0.8f;
            [btnSave setBackgroundImage:[UIImage imageNamed:@"up2.png"] forState:UIControlStateNormal];
            // [btnSave setImage:[UIImage imageNamed:@"save_pressed.png"] forState:UIControlStateNormal];
            
        }
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row == 0)
    {
        [m_strSex setString:NSLocalizedString(@"男", nil)];
    }else if (row == 1)
    {
        [m_strSex setString:NSLocalizedString(@"女", nil)];
    }
}

@end
