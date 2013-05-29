//
//  RJFGameFlorOrComPeteViewController.m
//  Texas-pokes
//
//  Created by popo on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFGameFlorOrComPeteViewController.h"
#import "UISearchBarForSearch.h"
#import "RJFChargeViewController.h"
#define ROOMID             @"NUMBERID"
#define ROOMNAME           @"ROOMNAME"
#define LITTLECHIP         @"LITTLECHIP"
#define BIGCHIP            @"BIGCHIP"
#define BRINGCHIP          @"BRINGCHIP"
#define PLAYNUMBER         @"PLAYNUMBER"
#define SERVERFEE          @"SERVERFEE"
#define FIRSTGRADE         @"FIRSTGRADE"
#define SECONDGRADE        @"SECONDGRADE"
#define THIRDGRADE         @"THIRDGRADE"
#define ROOMSTATUS         @"ROOMSTATUS"
#define CATEGORY           @"CATEGORY"
#define PORT               @"PORT"
#define SERVERID           @"SERVERID"
#define SERVERIP           @"IP"
#define ROOMPATH           @"ROOMPATH"
#define GAMEISPLAYING           @"进行中"
#define GAMEREADYING            @"准备中"
#define CARRYBIGNUMBER          @"CARRYBIGNUMBER"
#define CARRYSMALLNUMBER        @"CARRYSMALLNUMBER"
#define ENTERSMALLNUMBER        @"ENTERSMALLNUMBER"
#define ENTERBIGNUMBER          @"ENTERBIGNUMBER"
#define GAMETYPEINFO            @"GAMETYPEINFO"
#define BONUFIRSTPRIZE          @"BONUFIRSTPRIZE"
#define BONUSECONDPRIZE         @"BONUSECONDPRIZE"
#define USERADJUSTTYPE          @"USERADJUSTTYPE"

@interface RJFGameFlorOrComPeteViewController ()

@end


extern   NSString               *BNRUPDATUSERINFO;

@implementation RJFGameFlorOrComPeteViewController
@synthesize controlType = m_controlType;

#pragma mark self define method

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 27
 *  @brief
 *          back to last view Control
 *  @param
 *          sender
 *              button
 *	@return
 *          NONE
 *
 */
-(IBAction)ClickBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 27
 *  @brief
 *          sort the m_arrayStoreDataSouce
 *  @param
 *          sender
 *              button
 *	@return
 *          NONE
 *
 */
-(IBAction)ClickFullRoom:(UIButton *)sender
{
    if ([labelShow.text isEqualToString:NSLocalizedString(@"显示", nil)])
    {
        labelShow.text = NSLocalizedString(@"隐藏", nil);
        m_bShowAll = NO;
    }else
    {
        labelShow.text = NSLocalizedString(@"显示", nil);
        m_bShowAll = YES;
    }
    [m_tableView reloadData];
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 27
 *  @brief
 *          sort the m_arrayStoreDataSouce accord speed
 *  @param
 *          sender
 *              button
 *	@return
 *          NONE
 *
 */
-(IBAction)ClickSpeed:(UIButton *)sender
{
    
    switch (m_controlType)
    {
        case GAMEFLOORTYPE:
            
            [m_arrayStoreDataSouce addObjectsFromArray:m_arrayStoreHide];
            [m_arrayStoreHide removeAllObjects];
            
            if ([labelNormal.text isEqualToString:NSLocalizedString(@"快速", nil)])
            {
                
                for (int i = 0; i < [m_arrayStoreDataSouce count]; i++)
                {
                    NSDictionary *dicInfo = [m_arrayStoreDataSouce objectAtIndex:i];
                    if ([[dicInfo valueForKey:ROOMNAME] isEqualToString:NSLocalizedString(@"普通", nil)])
                    {
                        [m_arrayStoreHide addObject:dicInfo];
                        [m_arrayStoreDataSouce removeObjectAtIndex:i];
                        i--;
                    }
                }
                
                labelNormal.text = NSLocalizedString(@"普通", nil);
                
            }else
            {
                for (int i = 0; i < [m_arrayStoreDataSouce count]; i++)
                {
                    NSDictionary *dicInfo = [m_arrayStoreDataSouce objectAtIndex:i];
                    if ([[dicInfo valueForKey:ROOMNAME] isEqualToString:NSLocalizedString(@"快速", nil)])
                    {
                        [m_arrayStoreHide addObject:dicInfo];
                        [m_arrayStoreDataSouce removeObjectAtIndex:i];
                        i--;
                    }
                }
                labelNormal.text = NSLocalizedString(@"快速", nil);
            }
            break;
        case COMPELTETYPE:
            if ([labelNormal.text isEqualToString:NSLocalizedString(@"显示", nil)])
            {
                m_bShowAll = YES;
                if ([m_arrayStoreHide count])
                {
                    [m_arrayStoreDataSouce addObjectsFromArray:m_arrayStoreHide];
                }
                labelNormal.text = NSLocalizedString(@"隐藏", nil);
            }else
            {
                [m_arrayStoreHide removeAllObjects];
                for (int i = 0; i < [m_arrayStoreDataSouce count]; i++)
                {
                    NSDictionary *dicInfo = [m_arrayStoreDataSouce objectAtIndex:i];
                    if ([[dicInfo valueForKey:ROOMSTATUS] isEqualToString:GAMEISPLAYING])
                    {
                        [m_arrayStoreHide addObject:dicInfo];
                        [m_arrayStoreDataSouce removeObjectAtIndex:i];
                        i--;
                    }
                }
                m_bShowAll = NO;
                labelNormal.text = NSLocalizedString(@"显示", nil);
            }
            break;
            
        default:
            break;
    }
    [m_tableView reloadData];
    
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 27
 *  @brief
 *          enter fresh hall
 *  @param
 *          sender
 *              button
 *	@return
 *          NONE
 *
 */
-(IBAction)ClickFresh:(UIButton *)sender
{
    [sender setBackgroundImage:[UIImage imageNamed:@"bottom_button_left_pressed.png"] forState:UIControlStateNormal];
    [btnFirstLevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_mid.png"] forState:UIControlStateNormal];
    [btnMidlevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_mid.png"] forState:UIControlStateNormal];
    [btnHighLevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_right.png"] forState:UIControlStateNormal];
    [self Requestroom:1];
    
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 27
 *  @brief
 *          enter First level
 *  @param
 *          sender
 *              button
 *	@return
 *          NONE
 *
 */
-(IBAction)ClickFirstlevel:(UIButton *)sender
{
    [sender setBackgroundImage:[UIImage imageNamed:@"bottom_button_mid_pressed.png"] forState:UIControlStateNormal];
    [btnFresh setBackgroundImage:[UIImage imageNamed:@"bottom_button_left.png"] forState:UIControlStateNormal];
    [btnMidlevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_mid.png"] forState:UIControlStateNormal];
    [btnHighLevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_right.png"] forState:UIControlStateNormal];
    [self Requestroom:2];
    
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 27
 *  @brief
 *          enter mid level
 *  @param
 *          sender
 *              button
 *	@return
 *          NONE
 *
 */
-(IBAction)ClickMidlevel:(UIButton *)sender
{
    [sender setBackgroundImage:[UIImage imageNamed:@"bottom_button_mid_pressed.png"] forState:UIControlStateNormal];
    [btnFresh setBackgroundImage:[UIImage imageNamed:@"bottom_button_left.png"] forState:UIControlStateNormal];
    [btnFirstLevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_mid.png"] forState:UIControlStateNormal];
    [btnHighLevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_right.png"] forState:UIControlStateNormal];
    [self Requestroom:3];
    
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 27
 *  @brief
 *          enter High level
 *  @param
 *          sender
 *              button
 *	@return
 *          NONE
 *
 */
-(IBAction)ClickHighLevel:(UIButton *)sender
{
    [sender setBackgroundImage:[UIImage imageNamed:@"bottom_button_right_pressed.png"] forState:UIControlStateNormal];
    [btnFresh setBackgroundImage:[UIImage imageNamed:@"bottom_button_left.png"] forState:UIControlStateNormal];
    [btnFirstLevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_mid.png"] forState:UIControlStateNormal];
    [btnMidlevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_mid.png"] forState:UIControlStateNormal];
    [self Requestroom:4];
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 27
 *  @brief
 *          init
 *  @param
 *          nibNameOrNil
 *              nibnmae
 *  @param
 *          nibBundleOrNil
 *              bundle
 *  @param
 *          iType
 *              GameControlType
 *	@return
 *          id(self)
 *
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil controlType:(GameControlType)iType
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        m_controlType = iType;
        m_arrayStoreDataSouce = [[NSMutableArray alloc] init];
        m_arrayStoreHide = [[NSMutableArray alloc] init];
        // Custom initialization
    }
    return self;
}


#pragma mark test method. set datasource info
-(void)AddInfoTodataSourece:(BOOL)bGame
{
    [m_arrayStoreDataSouce removeAllObjects];
}

#pragma mark override method
/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 27
 *  @brief
 *          init
 *  @param
 *          nibNameOrNil
 *              nibnmae
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
        m_arrayStoreDataSouce = [[NSMutableArray alloc] init];
        // Custom initialization
    }
    return self;
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 27
 *  @brief
 *          dealloc
 *	@return
 *          void
 *
 */
-(void)dealloc
{
    if (m_arrayStoreHide)
    {
        [m_arrayStoreHide removeAllObjects];
        [m_arrayStoreHide release];
        m_arrayStoreHide = nil;
    }
    if (m_arrayStoreDataSouce)
    {
        [m_arrayStoreDataSouce removeAllObjects];
        [m_arrayStoreDataSouce release];
        m_arrayStoreDataSouce = nil;
    }
    if (btnBack)
    {
        [btnBack release];
        btnBack = nil;
    }
    
    if (btnFirstLevel)
    {
        [btnFirstLevel release];
        btnFirstLevel = nil;
    }
    if (btnFullRoom)
    {
        [btnFullRoom release];
        btnFullRoom = nil;
    }
    if (btnHighLevel)
    {
        [btnHighLevel release];
        btnHighLevel = nil;
    }
    if (btnMidlevel)
    {
        [btnMidlevel release];
        btnMidlevel = nil;
    }
    if (btnSpeed)
    {
        [btnSpeed release];
        btnSpeed = nil;
    }
    if (labelShow)
    {
        [labelShow release];
        labelShow = nil;
    }
    if (labelNormal)
    {
        [labelNormal release];
        labelNormal = nil;
    }
    if (labelFullRoom)
    {
        [labelFullRoom release];
        labelFullRoom = nil;
    }
    if (labelSpeed)
    {
        [labelSpeed release];
        labelSpeed = nil;
    }
    if (labelTitle)
    {
        [labelTitle release];
        labelTitle = nil;
    }
    if (labelUserName)
    {
        [labelUserName release];
        labelUserName = nil;
    }
    if (labelChips)
    {
        [labelChips release];
        labelChips = nil;
    }
    if (btnChips)
    {
        [btnChips release];
        btnChips = nil;
    }
    if (btnBringChips)
    {
        [btnBringChips release];
        btnBringChips = nil;
    }
    if (btnID)
    {
        [btnID release];
        btnID = nil;
    }
    if (btnPlayNumber)
    {
        [btnPlayNumber release];
        btnPlayNumber = nil;
    }
    if (btnServerFee)
    {
        [btnServerFee release];
        btnServerFee = nil;
    }
    if (imageViewBottom)
    {
        [imageViewBottom release];
        imageViewBottom = nil;
    }
    if (ImageView1)
    {
        [ImageView1 release];
        ImageView1 = nil;
    }
    if (ImageView2)
    {
        [ImageView2 release];
        ImageView2 = nil;
    }
    if (ImageView3)
    {
        [ImageView3 release];
        ImageView3 = nil;
    }
    if (ImageView4)
    {
        [ImageView4 release];
        ImageView4 = nil;
    }
    
    [super dealloc];
    
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 27
 *  @brief
 *          view did load
 *	@return
 *          void
 *
 */
- (void)viewDidLoad
{
    
    
    
    [btnFresh setBackgroundImage:[UIImage imageNamed:@"bottom_button_left_pressed.png"] forState:UIControlStateNormal];
    m_bShowAll = YES;
    if (m_controlType  == COMPELTETYPE)
    {
        [self AddInfoTodataSourece:NO];
        labelNormal.text = NSLocalizedString(@"显示", nil);
        [labelTitle setText:NSLocalizedString(@"比赛大厅", nil)];
        //[labelFullRoom setText:@"进行中"];
        [labelSpeed setText:GAMEISPLAYING];
        [m_tableView setFrame:CGRectMake(m_tableView.frame.origin.x, m_tableView.frame.origin.y, m_tableView.frame.size.width, m_tableView.frame.size.height+45)];
        [btnFresh setHidden:YES];
        [btnFirstLevel setHidden:YES];
        [btnHighLevel setHidden:YES];
        [btnMidlevel setHidden:YES];
        [imageViewBottom setHidden:YES];
        [btnServerFee setHidden:YES];
        
        CGFloat  fWidth = 116;
        [btnID setTitle:NSLocalizedString(@"ID/难度", nil) forState:UIControlStateNormal];
        [btnChips setTitle:NSLocalizedString(@"一/二名奖金", nil) forState:UIControlStateNormal];
        [btnBringChips setTitle:NSLocalizedString(@"状态", nil) forState:UIControlStateNormal];
        [btnPlayNumber setTitle:NSLocalizedString(@"玩家筹码区间", nil) forState:UIControlStateNormal];
        [btnID setFrame:CGRectMake(btnID.frame.origin.x, btnID.frame.origin.y, fWidth, btnID.frame.size.height)];
        [btnChips setFrame:CGRectMake(btnID.frame.origin.x+fWidth, btnChips.frame.origin.y, fWidth, btnChips.frame.size.height)];
        [ImageView1 setFrame:CGRectMake(btnID.frame.origin.x+fWidth, ImageView1.frame.origin.y, ImageView1.frame.size.width, ImageView1.frame.size.height)];
        [btnBringChips setFrame:CGRectMake(btnID.frame.origin.x+fWidth*2, btnBringChips.frame.origin.y, fWidth, btnBringChips.frame.size.height)];
        [ImageView2 setFrame:CGRectMake(btnID.frame.origin.x+fWidth*2, ImageView1.frame.origin.y, ImageView1.frame.size.width, ImageView1.frame.size.height)];
        [btnPlayNumber setFrame:CGRectMake(btnID.frame.origin.x+fWidth*3, btnPlayNumber.frame.origin.y, fWidth, btnPlayNumber.frame.size.height)];
        [ImageView3 setFrame:CGRectMake(btnID.frame.origin.x+fWidth*3, ImageView1.frame.origin.y, ImageView1.frame.size.width, ImageView1.frame.size.height)];
        [ImageView4 setHidden:YES];
        
    }else
    {
        [self AddInfoTodataSourece:YES];
    }
    // [m_tableView setTableHeaderView:[self tanbleHeadView:m_tableView]];
    [m_tableView reloadData];
    if ([m_arrayStoreDataSouce count])
    {
        // [m_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    
    setAllViewautoResize(self.view);
  
    [super viewDidLoad];
    //  m_objShareZip = [BasisZipAndUnzip shareInstance];
    // Do any additional setup after loading the view from its nib.
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 27
 *  @brief
 *          view did unload
 *	@return
 *          void
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
 *          2012 07 27
 *  @brief
 *          shouldAutorotateToInterfaceOrientation
 *  @param
 *          interfaceOrientation
 *                  Orientation
 *	@return
 *          BOOL
 *
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark tableview delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [m_arrayStoreDataSouce count]+1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat  fwidth = 93;
    CGFloat  fSepWidth = 5;
    UITableViewCell  *cell = nil;
    
    if (indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"8"];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"8"] autorelease];
            
            UIImageView  *viewBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 45)];
            viewBg.userInteractionEnabled = YES;
            viewBg.image = [UIImage imageNamed:@"word_mid.png"];
            [cell.contentView addSubview:viewBg];
            [viewBg release];
            [viewBg addSubview:[self tanbleHeadView:tableView]];
            
        }
        
        return cell;
    }
    NSDictionary  *dicInfo = [m_arrayStoreDataSouce objectAtIndex:indexPath.row-1];
    switch (m_controlType)
    {
        case GAMEFLOORTYPE:
            cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
            if (cell == nil)
            {
                
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"1"] autorelease];
                UIImageView  *viewBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 45)];
                viewBg.image = [UIImage imageNamed:@"word_mid.png"];
                [cell.contentView addSubview:viewBg];
                for (int i = 0;i < 3;i++)
                {
                    UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(fSepWidth+fwidth*i, 12, fwidth-fSepWidth*2, 21)];
                    label.tag = 10+i;
                    [label setBackgroundColor:[UIColor clearColor]];
                    [label setTextColor:[UIColor whiteColor]];
                    [label setFont:[UIFont systemFontOfSize:12]];
                    [label setTextAlignment:NSTextAlignmentCenter];
                    [viewBg addSubview:label];
                    [label release];
                }
                
                UIImageView   *imageViewNumberback = [[UIImageView alloc] initWithFrame:CGRectMake(fSepWidth+fwidth*3, 18, fwidth-fSepWidth*2, 10)];
                imageViewNumberback.image = [UIImage imageNamed:@"Number_fill_bg.png"];
                imageViewNumberback.tag = 13;
                [viewBg addSubview:imageViewNumberback];
                [imageViewNumberback release];
                
                UIImageView   *imageViewNumber = [[UIImageView alloc] initWithFrame:CGRectMake(fSepWidth+fwidth*3, 18, fwidth-fSepWidth*2, 10)];
                imageViewNumber.image = [UIImage imageNamed:@"Number_fill1.png"];
                imageViewNumber.tag = 14;
                [viewBg addSubview:imageViewNumber];
                [imageViewNumber release];
                
                
                UILabel  *labelNumber = [[UILabel alloc] initWithFrame:CGRectMake(fSepWidth+fwidth*3, 12, fwidth-fSepWidth*2, 21)];
                labelNumber.tag = 15;
                [labelNumber setBackgroundColor:[UIColor clearColor]];
                [labelNumber setTextColor:[UIColor whiteColor]];
                [labelNumber setTextAlignment:NSTextAlignmentCenter];
                [labelNumber setFont:[UIFont systemFontOfSize:12]];
                [viewBg addSubview:labelNumber];
                [labelNumber release];
                
                
                UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(fSepWidth+fwidth*4, 12, fwidth-fSepWidth*2, 21)];
                label.tag = 16;
                [label setBackgroundColor:[UIColor clearColor]];
                [label setTextColor:[UIColor whiteColor]];
                [label setTextAlignment:NSTextAlignmentCenter];
                [viewBg addSubview:label];
                [label setFont:[UIFont systemFontOfSize:12]];
                [label release];
                [viewBg release];
            }
            //id and name
            if (dicInfo)
            {
                UIView  *view = [cell contentView];
                UILabel   *labelTemp = (UILabel *)[view viewWithTag:10];
                if (labelTemp)
                {
                    [labelTemp setText:[NSString stringWithFormat:@"%@/%@",[dicInfo valueForKey:ROOMID],[dicInfo valueForKey:ROOMNAME]]];
                }
                
                labelTemp = (UILabel *)[view viewWithTag:11];
                if (labelTemp)
                {
                    NSString  *strSmall = [NSString stringWithNeedTranfanstring:[dicInfo valueForKey:LITTLECHIP] returnType:KWLOWCASETYPE];
                    NSString  *strBig = [NSString stringWithNeedTranfanstring:[dicInfo valueForKey:BIGCHIP] returnType:KWLOWCASETYPE];
                    [labelTemp setText:[NSString stringWithFormat:@"%@/%@",strSmall,strBig]];
                }
                
                labelTemp = (UILabel *)[view viewWithTag:12];
                if (labelTemp)
                {
                    NSString  *strSmall = [NSString stringWithNeedTranfanstring:[dicInfo valueForKey:CARRYSMALLNUMBER] returnType:KWLOWCASETYPE];
                    NSString  *strBig = [NSString stringWithNeedTranfanstring:[dicInfo valueForKey:CARRYBIGNUMBER] returnType:KWLOWCASETYPE];
                    
                    [labelTemp setText:[NSString stringWithFormat:@"%@/%@",strSmall,strBig]];
                }
                
                labelTemp = (UILabel *)[view viewWithTag:15];
                if (labelTemp)
                {
                    [labelTemp setText:[NSString stringWithFormat:@"%@/8",[dicInfo valueForKey:PLAYNUMBER]]];
                }
                
                labelTemp = (UILabel *)[view viewWithTag:16];
                if (labelTemp)
                {
                    // [labelTemp setText:[NSString stringWithFormat:@"%@",[dicInfo valueForKey:SERVERFEE]]];
                    NSString  *strSmall = [NSString stringWithNeedTranfanstring:[dicInfo valueForKey:ENTERSMALLNUMBER] returnType:KWLOWCASETYPE];
                    NSString  *strBig = [NSString stringWithNeedTranfanstring:[dicInfo valueForKey:ENTERBIGNUMBER] returnType:KWLOWCASETYPE];
                    if ([strBig intValue] < 0)
                    {
                        strBig = [NSString stringWithFormat:NSLocalizedString(@"%@以上", nil),strSmall];
                    }
                    [labelTemp setText:[NSString stringWithFormat:@"%@~%@",strSmall,strBig]];
                }
                
                UIImageView   *imageViewBg = (UIImageView *)[view viewWithTag:13];
                CGFloat  fwidth = imageViewBg.frame.size.width;
                CGFloat  fLenth = fwidth *([[dicInfo valueForKey:PLAYNUMBER] floatValue]/8.0);
                UIImageView   *imageViewNumber = (UIImageView *)[view viewWithTag:14];
                if (imageViewNumber)
                {
                    [imageViewNumber setFrame:CGRectMake(imageViewNumber.frame.origin.x, imageViewNumber.frame.origin.y, fLenth, imageViewNumber.frame.size.height)];
                }
                
            }
            break;
            
        case COMPELTETYPE:
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"2"];
            if (cell == nil)
            {
                fwidth = 116;
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"2"] autorelease];
                UIImageView  *viewBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 45)];
                viewBg.image = [UIImage imageNamed:@"word_mid.png"];
                [cell.contentView addSubview:viewBg];
                
                
                for (int i = 0;i < 2;i++)
                {
                    UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(fSepWidth+fwidth*i, 12, fwidth-fSepWidth*2, 21)];
                    label.tag = 10+i;
                    [label setBackgroundColor:[UIColor clearColor]];
                    [label setTextColor:[UIColor whiteColor]];
                    [label setFont:[UIFont systemFontOfSize:12]];
                    [label setTextAlignment:NSTextAlignmentCenter];
                    [viewBg addSubview:label];
                    [label release];
                }
                
                
                UIImageView   *imageViewNumberback = [[UIImageView alloc] initWithFrame:CGRectMake(fSepWidth+fwidth*2+40, 18, fwidth-fSepWidth*2-40, 10)];
                imageViewNumberback.image = [UIImage imageNamed:@"Number_fill_bg.png"];
                imageViewNumberback.tag = 13;
                [viewBg addSubview:imageViewNumberback];
                [imageViewNumberback release];
                
                UIImageView   *imageViewNumber = [[UIImageView alloc] initWithFrame:CGRectMake(fSepWidth+fwidth*2+40, 18, fwidth-fSepWidth*2-40, 10)];
                imageViewNumber.image = [UIImage imageNamed:@"Number_fill1.png"];
                imageViewNumber.tag = 14;
                [viewBg addSubview:imageViewNumber];
                [imageViewNumber release];
                
                
                UILabel  *labelNumber = [[UILabel alloc] initWithFrame:CGRectMake(fSepWidth+fwidth*2+40, 12, fwidth-fSepWidth*2-40, 21)];
                labelNumber.tag = 15;
                [labelNumber setBackgroundColor:[UIColor clearColor]];
                [labelNumber setTextColor:[UIColor whiteColor]];
                [labelNumber setTextAlignment:NSTextAlignmentCenter];
                [labelNumber setFont:[UIFont systemFontOfSize:12]];
                [viewBg addSubview:labelNumber];
                [labelNumber release];
                
                UILabel  *labelStatus = [[UILabel alloc] initWithFrame:CGRectMake(fwidth*2, 12, 40, 21)];
                labelStatus.tag = 17;
                [labelStatus setBackgroundColor:[UIColor clearColor]];
                [labelStatus setTextColor:[UIColor whiteColor]];
                [labelStatus setTextAlignment:NSTextAlignmentCenter];
                [labelStatus setFont:[UIFont systemFontOfSize:12]];
                [viewBg addSubview:labelStatus];
                [labelStatus release];
                
                
                UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(fSepWidth+fwidth*3, 12, fwidth-fSepWidth*2, 21)];
                label.tag = 16;
                [label setBackgroundColor:[UIColor clearColor]];
                [label setTextColor:[UIColor whiteColor]];
                [label setTextAlignment:NSTextAlignmentCenter];
                [viewBg addSubview:label];
                [label setFont:[UIFont systemFontOfSize:12]];
                [label release];
                [viewBg release];
                [cell.contentView setAlpha:1];
            }
            //id and name
            if (dicInfo)
            {
                UIView  *view = [cell contentView];
                UILabel   *labelTemp = (UILabel *)[view viewWithTag:10];
                if (labelTemp)
                {
                    
                    NSString *strType = NSLocalizedString(@"入门", nil);
                    if ([[dicInfo valueForKey:GAMETYPEINFO] integerValue] == 2)
                    {
                        strType = NSLocalizedString(@"进阶", nil);
                    }else if ([[dicInfo valueForKey:GAMETYPEINFO] integerValue] == 3)
                    {
                        strType = NSLocalizedString(@"高级", nil);
                    }
                    [labelTemp setText:[NSString stringWithFormat:@"%@/%@",[dicInfo valueForKey:ROOMID],strType]];
                }
                
                labelTemp = (UILabel *)[view viewWithTag:11];
                if (labelTemp)
                {
                    [labelTemp setText:[NSString stringWithFormat:@"%@/%@",[NSString stringWithNeedTranfanNumber:[[dicInfo valueForKey:BONUFIRSTPRIZE] intValue]returnType:KWLOWCASETYPE],[NSString stringWithNeedTranfanNumber:[[dicInfo valueForKey:BONUSECONDPRIZE] intValue] returnType:KWLOWCASETYPE]]];
                }
                
                labelTemp = (UILabel *)[view viewWithTag:17];
                if (labelTemp)
                {
                    [labelTemp setText:[NSString stringWithFormat:@"%@",[dicInfo valueForKey:ROOMSTATUS]]];
                }
                
                labelTemp = (UILabel *)[view viewWithTag:15];
                if (labelTemp)
                {
                    [labelTemp setText:[NSString stringWithFormat:@"%@/8",[dicInfo valueForKey:PLAYNUMBER]]];
                }
                
                //                labelTemp = (UILabel *)[view viewWithTag:16];
                //                if (labelTemp)
                //                {
                //                    int serverFee = [[dicInfo valueForKey:SERVERFEE] intValue];
                //                    [labelTemp setText:[NSString stringWithFormat:@"%@",[NSString stringWithNeedTranfanNumber:serverFee returnType:KWLOWCASETYPE]]];
                //                }
                
                labelTemp = (UILabel *)[view viewWithTag:16];
                if (labelTemp)
                {
                    // [labelTemp setText:[NSString stringWithFormat:@"%@",[dicInfo valueForKey:SERVERFEE]]];
                    NSString  *strSmall = [NSString stringWithNeedTranfanstring:[dicInfo valueForKey:ENTERSMALLNUMBER] returnType:KWLOWCASETYPE];
                    NSString  *strBig = [NSString stringWithNeedTranfanstring:[dicInfo valueForKey:ENTERBIGNUMBER] returnType:KWLOWCASETYPE];
                    if ([strBig intValue] < 0)
                    {
                        strBig = [NSString stringWithFormat:NSLocalizedString(@"%@以上", nil),strSmall];
                    }
                    [labelTemp setText:[NSString stringWithFormat:@"%@~%@",strSmall,strBig]];
                }
                
                UIImageView   *imageViewBg = (UIImageView *)[view viewWithTag:13];
                CGFloat  fwidth = imageViewBg.frame.size.width;
                CGFloat  fLenth = fwidth *([[dicInfo valueForKey:PLAYNUMBER] floatValue]/8.0);
                UIImageView   *imageViewNumber = (UIImageView *)[view viewWithTag:14];
                if (imageViewNumber)
                {
                    if ([[dicInfo valueForKey:ROOMSTATUS] isEqual:GAMEREADYING])
                    {
                        imageViewNumber.image = [UIImage imageNamed:@"Number_fill1.png"];
                        [cell.contentView setAlpha:1];
                    }else
                    {
                        imageViewNumber.image = [UIImage imageNamed:@"Number_fill2.png"];
                        [cell.contentView setAlpha:0.5];
                    }
                    [imageViewNumber setFrame:CGRectMake(imageViewNumber.frame.origin.x, imageViewNumber.frame.origin.y, fLenth, imageViewNumber.frame.size.height)];
                }
                
            }
            break;
        default:
            break;
    }
    
    
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView            // Default is 1 if not implemented
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // logMyLogInfo(@"select indexPath:%@",indexPath);
    
    if (indexPath.row == 0)
    {
        return;
    }
    NSDictionary    *dicInfo = [m_arrayStoreDataSouce objectAtIndex:indexPath.row-1];
    
    if ([dicInfo valueForKey:ROOMSTATUS] && [[dicInfo valueForKey:ROOMSTATUS] boolValue])
    {
        return;
    }
    UserInfo    *objUser = [UserInfo shareInstance];
    int32_t  ibigLimit = 0;
    int32_t  iSmallLimit = 0;
    
    int32_t  ibigBringLimit = 0;
    int32_t  iSmallBringLimit = 0;
    int32_t ineedchip = 0;
    ibigBringLimit = [[dicInfo valueForKey:CARRYBIGNUMBER] intValue];
    iSmallBringLimit = [[dicInfo valueForKey:CARRYSMALLNUMBER] intValue];
    
    NSString     *strWarning = nil;
    //    if (m_controlType == GAMEFLOORTYPE)
    //    {
    
    ibigLimit = [[dicInfo valueForKey:ENTERBIGNUMBER] intValue];
    iSmallLimit = [[dicInfo valueForKey:ENTERSMALLNUMBER] intValue];
    if (ibigLimit <= 0)
    {
        ibigLimit = objUser.userChips+1;
    }
    if (objUser.userChips < iSmallLimit)
    {
        strWarning = @"提示\n\n您的筹码不足以选择当前房间，请充值";
        
    }else if (objUser.userChips > ibigLimit)
    {
        strWarning = @"提示\n\n您的筹码超过当前房间的上限，请选择更高级的房间";
    }
    ineedchip = iSmallLimit;
    //}else
    //{
    if (m_controlType == COMPELTETYPE)
    {
        ineedchip = [[dicInfo valueForKey:SERVERFEE] intValue];
    }
    
    // }
    
    
    
    
    
    if (ineedchip > objUser.userChips)
    {
        strWarning = NSLocalizedString(@"提示\n\n您的筹码不足，不能够进入该房间！", nil);
        [RJFWarnView addinSelfview:self.view
                          delegate:self
                           message:strWarning
                        buttontype:BOTHBUTTON
                      InsureButton:NSLocalizedString(@"充值", nil)
                      CancelButton:CANCEL];
        return;
    }
    
    if (strWarning != nil)
    {
        [RJFWarnView addinSelfview:self.view
                          delegate:nil
                           message:strWarning
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
        return;
        
    }
    
    
    ShowHUD(NSLocalizedString(@"进入房间中...... 请稍候！", nil), self,20);
    NSString  *strIP = [dicInfo valueForKey:SERVERIP];
    
    
    
    int8_t  type = 1;
    
    if (m_controlType == GAMEFLOORTYPE && objUser.autoSitDown)
    {
        type = 0;
    }
    m_roomInfo.roomID = [[dicInfo valueForKey:ROOMID] intValue];
    m_roomInfo.roomPath = [[dicInfo valueForKey:ROOMPATH] intValue];
    m_roomInfo.enterFee = [[dicInfo valueForKey:SERVERFEE] intValue];
    
    if (m_controlType == COMPELTETYPE)
    {
        m_roomInfo.roomType = 5;
    }else
    {
        m_roomInfo.roomType = m_iroomType;
    }
    
    m_roomInfo.roomBigChip = ibigBringLimit;
    m_roomInfo.roomSmallChip = iSmallBringLimit;
    m_roomInfo.roomFirstPrize = [[dicInfo valueForKey:BONUFIRSTPRIZE] intValue];
    m_roomInfo.roomSecondPrize = [[dicInfo valueForKey:BONUSECONDPRIZE] intValue];
    m_roomInfo.selfChooseSeat = type;
    m_roomInfo.HostIP = strIP;
    m_roomInfo.hostport = [[dicInfo valueForKey:PORT] intValue];
    
#if 0
    DZPK_CLIENT_REQ_GAME_ENTER_ROOM roomInfo = {[[dicInfo valueForKey:ROOMPATH] intValue],[[dicInfo valueForKey:ROOMID] intValue],type,1};
    
    //    NSCharacterSet  *charset = [NSCharacterSet characterSetWithCharactersInString:@"1234567890."];
    //    charset = [charset invertedSet];
    //    strIP = [strIP stringByTrimmingCharactersInSet:charset];
    RJFTcpSocket        *mysock = [RJFTcpSocket shareInitWithHost:strIP
                                                             Port:[[dicInfo valueForKey:PORT] intValue]
                                                         Delagate:nil
                                                              tag:GAMESOCKETTAG];
    
    
    
    
    size_t    size = 0;
    BasisZipAndUnzip  *objShare = [[BasisZipAndUnzip alloc] initWithSize:200];
    [mysock SendCharMessage:[objShare syncWithRequest:REQ_GAME_ENTER_ROOM
                                               userID:objUser.userIDForDzpk
                                          structArray:&roomInfo
                                         ]
                       size:[objShare dataSize]];
    [objShare release];
    
#else
    RJFGameInterface  *game = [[RJFGameInterface alloc] initWithNibName:@"RJFGameInterface" bundle:nil roomInfo:&m_roomInfo];
    [self.navigationController pushViewController:game animated:YES];
    [game release];
#endif
    
    
    
    //ran for test debug
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (![self isValidNumber:searchBar.text])
    {
        [RJFWarnView addinSelfview:self.view
                          delegate:Nil
                           message:NSLocalizedString(@"提示\n\n很抱歉，没有找到指定ID的房间", nil)
                        buttontype:INSUREBUTTON
                      InsureButton:INSURE
                      CancelButton:nil];
        return;
    }
    
    int8_t  type = 0;
    if (m_controlType == COMPELTETYPE)
    {
        type = 5;
    }
    DZPK_CLIENT_REQ_GAME_SEARCH_ROOM    serchInfo =  {type,[searchBar.text intValue]};
    RJFTcpSocket    *m_socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    UserInfo   *userObj = [UserInfo shareInstance];
    ShowHUD(NSLocalizedString(@"搜索中，请稍候！", nil), self,15);
    BasisZipAndUnzip  *objBasic = [[BasisZipAndUnzip alloc] initWithSize:100];
    [m_socket SendCharMessage:[objBasic syncWithRequest:REQ_GAME_SEARCH_ROOM
                                                 userID:userObj.userIDForDzpk
                                            structArray:&serchInfo] size:[objBasic dataSize]];
    [searchBar resignFirstResponder];
    [objBasic release];
    
    logMyLogInfo(@"search.text:%@",searchBar.text);
}
// Section header & footer information. Views are preferred over title should you decide to provide both

- (UIView *)tanbleHeadView:(UITableView *)tableView
{
    //UIView   *view = [[UIView alloc] initWithFrame:CGRectMake(-10, 0,tableView.frame.size.width+60, 50)];
    // [view setBackgroundColor:[UIColor clearColor]];
    UISearchBarForSearch  *search = [[UISearchBarForSearch alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width+1, 45)];
    // search.showsCancelButton = YES;
    search.backgroundImage = nil;
    // search.translucent = YES;
    search.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    search.tag = 102;
    // [view addSubview:search];
    [search setDelegate:self];
    
    return [search autorelease];
}

/*- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;                       // called when text ends editing
 - (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)
 - (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0); // called before text changes*/

//REQ_GAME_ROOM_LIST_MATCH

-(void)Requestroom:(int8_t)roomType
{
    
    
    // NSLog(@"11");
    
    m_iroomType = roomType;
    UserInfo  *objUserInfo = [UserInfo shareInstance];
    RJFTcpSocket    *m_socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    DZPK_CLIENT_REQ_GAME_ROOM_LIST_NORMAL   normalRoom = {roomType,objUserInfo.userChips};
    UserInfo   *objUser = [UserInfo shareInstance];
    
    BasisZipAndUnzip  *objShare = [[BasisZipAndUnzip alloc] initWithSize:100];
    switch (m_controlType)
    {
        case GAMEFLOORTYPE:
            ShowHUD(NSLocalizedString(@"加载房间信息中，请稍候！", nil), self,20);
            [m_socket SendCharMessage:[objShare syncWithRequest:REQ_GAME_ROOM_LIST_NORMAL
                                                         userID:objUser.userIDForDzpk
                                                    structArray:&normalRoom]
                                 size:[objShare dataSize]];
            [objShare release];
            
            break;
        case COMPELTETYPE:
            ShowHUD(NSLocalizedString(@"加载房间信息中，请稍候！", nil), self,20);
            [m_socket SendCharMessage:[objShare syncWithRequest:REQ_GAME_ROOM_LIST_MATCH
                                                         userID:objUser.userIDForDzpk
                                                    structArray:NULL]
                                 size:[objShare dataSize]];
            [objShare release];
            
            break;
            
        default:
            break;
    }
    
    //  NSLog(@"22");
    
}
-(void)viewWillAppear:(BOOL)animated
{
    UserInfo   *user = [UserInfo shareInstance];
    [labelUserName setText:user.userName];
    [labelChips setText:[NSString stringWithNeedTranfanstring:[NSNumber numberWithInt:user.userChips] returnType:COMMOMTYPE]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(UpdateeUserChips:)
                                                 name:BNRUPDATUSERINFO
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotiFromServer:)
                                                 name:BNRRECEIVEMESSAGEFROMSERVER
                                               object:nil];
    [self SendUserGetdeatilInfo];
    
  
  

   

    
    
    [self Requestroom:0];
    
    [super viewWillAppear:animated];
}



-(void)UpdateeUserChips:(NSNotification*)note
{
     UserInfo   *user = [UserInfo shareInstance];
     [labelChips setText:[NSString stringWithNeedTranfanstring:[NSNumber numberWithInt:user.userChips] returnType:COMMOMTYPE]];
    logMyLogInfo(@"userBow  chips:%ld",user.userChips);
}

-(void)viewDidAppear:(BOOL)animated
{
    
    
    //[self.view endEditing:YES];
    [super viewDidAppear:animated];
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
        if (dicInfo &&(m_socket.tag == RESOURCESOCKEtTAG || m_socket.tag == GAMESOCKETTAG) )
        {
            
        }else
        {
            return;
        }
        
        size_t  size = [[dicInfo valueForKey:TCPSOCKETSIZE] intValue];
        BasisZipAndUnzip   *objZip = [[BasisZipAndUnzip alloc] initWithSize:size+5];
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
        
        logMyLogInfo(@"data:%s SIZE:%@  requestCode:%d",[data bytes],[[note userInfo] valueForKey:@"SIZE"],requestCode);
        
        
        
        
        
        switch (m_controlType)
        {
            case GAMEFLOORTYPE:
                handle =[objZip PhaseInfoFromData:byte      
                                   outRequestCode:&requestCode];
                [self dealNotiForGAMEFLOORTYPE:requestCode  info:handle];
                break;
            case COMPELTETYPE:
                handle =[objZip PhaseInfoFromData:byte
                                   outRequestCode:&requestCode];
                [self dealNotiForCOMPELTETYPE:requestCode  info:handle];
                break;
            default:
                break;
        }
        
        //  NSLog(@"55");
        free(handle);
        handle = NULL;
        [objZip release];
        
    }
}


-(void)setLevelButtonstatue:(int8_t)roomType
{
   
    
    switch (roomType)
    {
        case 1:
            [btnFresh setBackgroundImage:[UIImage imageNamed:@"bottom_button_left_pressed.png"] forState:UIControlStateNormal];
            [btnFirstLevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_mid.png"] forState:UIControlStateNormal];
            [btnMidlevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_mid.png"] forState:UIControlStateNormal];
            [btnHighLevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_right.png"] forState:UIControlStateNormal];
            break;
        case 2:
            [btnFresh setBackgroundImage:[UIImage imageNamed:@"bottom_button_left.png"] forState:UIControlStateNormal];
            [btnFirstLevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_mid_pressed.png"] forState:UIControlStateNormal];
            [btnMidlevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_mid.png"] forState:UIControlStateNormal];
            [btnHighLevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_right.png"] forState:UIControlStateNormal];
            break;
        case 3:
            [btnFresh setBackgroundImage:[UIImage imageNamed:@"bottom_button_left.png"] forState:UIControlStateNormal];
            [btnFirstLevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_mid"] forState:UIControlStateNormal];
            [btnMidlevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_mid_pressed.png"] forState:UIControlStateNormal];
            [btnHighLevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_right.png"] forState:UIControlStateNormal];
            break;
        case 4:
            [btnFresh setBackgroundImage:[UIImage imageNamed:@"bottom_button_left.png"] forState:UIControlStateNormal];
            [btnFirstLevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_mid.png"] forState:UIControlStateNormal];
            [btnMidlevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_mid.png"] forState:UIControlStateNormal];
            [btnHighLevel setBackgroundImage:[UIImage imageNamed:@"bottom_button_right_pressed.png"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }

}
-(void)dealNotiForGAMEFLOORTYPE:(int)requestCode  info:(void*)handle
{
    
    
   
    
    
    if (requestCode == REQ_GAME_ROOM_LIST_NORMAL)
    {
        
        DZPK_SERVER_REQ_GAME_ROOM_LIST_NORMAL   *info = (DZPK_SERVER_REQ_GAME_ROOM_LIST_NORMAL*)handle;
        HideHUD(self, YES);
        // NSLog(@"66");
        
        if (info->status == 0 && info->category != 0)
        {
            [m_arrayStoreDataSouce removeAllObjects];
            if (info->SpeedArray == NULL || info->RoomidArray == NULL
                || info->smallArray == NULL || info->bigArray == NULL
                || info->playerCountArray == NULL
                || info->pathArray == NULL)
            {
                [self Requestroom:m_iroomType];
                return;
                
            }
            [self setLevelButtonstatue:info->category];
            
            logMyLogInfo(@"-------------------receive ROOM_LIST_NORMA -------------------");
            logMyLogInfo(@"status:%d category:%d IP:%@ port:%d serverID:%d",info->status,info->category,info->IP,info->port,info->serverID);
            
            for (int i = 0; i < info->bigNumber ; i++)
            {
                logMyLogInfo(@"Number:%d  roomID:%d samllChip:%d bigChip:%d playerCpunt:%d serverCharge:%d path:%d enter_big:%d enter_small:%d carry_big_%d carry_small:%d userAdjustType:%d",i,info->RoomidArray[i],info->smallArray[i],info->bigArray[i],info->playerCountArray[i],info->serverChargeArray[i],info->pathArray[i],info->enter_big_array[i],info->enter_small_array[i],info->carry_big_array[i],info->carry_small_array[i],info->userAdjustType);
            }
            
            logMyLogInfo(@"-------------------end receive ROOM_LIST_NORMA-----------------");
            
            
            for (int i = 0; i < info->smallNumber; i++)
            {
                //  NSLog(@"00:%i",i);
                
                NSString    *roomName = info->SpeedArray[i] == 1?NSLocalizedString(@"普通", nil):NSLocalizedString(@"快速",nil);
                // NSLog(@"roomSpeed:%d",info->SpeedArray[i]);
                NSDictionary  *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@(info->category),CATEGORY,@(info->port),PORT,@(info->serverID),SERVERID,info->IP,SERVERIP,@(info->RoomidArray[i]),ROOMID,roomName,ROOMNAME,@(info->smallArray[i]),LITTLECHIP,@(info->bigArray[i]),BIGCHIP,@(info->playerCountArray[i]),PLAYNUMBER,@(info->serverChargeArray[i]),SERVERFEE,@(info->pathArray[i]),ROOMPATH,@(info->enter_big_array[i]),ENTERBIGNUMBER,@(info->enter_small_array[i]),ENTERSMALLNUMBER,@(info->carry_big_array[i]),CARRYBIGNUMBER,@(info->carry_small_array[i]),CARRYSMALLNUMBER,@(info->userAdjustType),USERADJUSTTYPE,nil];
                
                [m_arrayStoreDataSouce addObject:dicInfo];
                
            }
            
            
            NSArray *sortedArray = [m_arrayStoreDataSouce sortedArrayUsingComparator: ^(id obj1, id obj2)
                                    {
                                        if ([[obj1 valueForKey:PLAYNUMBER] intValue] < [[obj2 valueForKey:PLAYNUMBER] intValue])
                                        {
                                            return (NSComparisonResult)NSOrderedDescending;
                                        }else if([[obj1 valueForKey:PLAYNUMBER] intValue] > [[obj2 valueForKey:PLAYNUMBER] intValue])
                                        {
                                            return (NSComparisonResult)NSOrderedAscending;
                                        }
                                        return (NSComparisonResult)NSOrderedSame;
                                    }];
            [m_arrayStoreDataSouce removeAllObjects];
            [m_arrayStoreDataSouce addObjectsFromArray:sortedArray];
            [m_tableView reloadData];
            if ([m_arrayStoreDataSouce count])
            {
                //[m_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
            
            free(info->bigArray);
            free(info->bringGoldArray);
            free(info->carry_big_array);
            free(info->carry_small_array);
            free(info->enter_big_array);
            free(info->enter_small_array);
            free(info->pathArray);
            free(info->playerCountArray);
            free(info->RoomidArray);
            free(info->serverChargeArray);
            free(info->smallArray);
            free(info->SpeedArray);
            info->bigArray = NULL;
            info->bringGoldArray = NULL;
            info->carry_big_array = NULL;
            info->carry_small_array = NULL;
            info->enter_big_array = NULL;
            info->enter_small_array = NULL;
            info->pathArray = NULL;
            info->playerCountArray = NULL;
            info->RoomidArray = NULL;
            info->serverChargeArray = NULL;
            info->smallArray = NULL;
            info->SpeedArray = NULL;
            
            
        }else
        {
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n获取房间列表失败！", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
            
        }
        // NSLog(@"77");
    }else if(requestCode == REQ_GAME_SEARCH_ROOM)
    {
        
        HideHUD(self, YES);
        
        DZPK_SERVER_REQ_GAME_SEARCH_ROOM        *info = (DZPK_SERVER_REQ_GAME_SEARCH_ROOM*)handle;
        if (info->status == 0)
        {
            logMyLogInfo(@"-------------------receive _SEARCH_ROOM -------------------");
            logMyLogInfo(@"status:%d bigBlind:%d carry_big:%d carry_small:%d enter_big:%d enter_small:%d IP:%@,matchtypes:%d playerCount:%d port:%d roomID:%d,roomPath:%d roomStatus:%d,serverCharge:%d,serverID:%d,smallBlind:%d,speed:%d status:%d type:%d",info->status,info->bigBlind,info->carry_big_chip,info->carry_small_chip,info->enter_big_chip,info->enter_small_chip,info->IP,info->matchTypes,info->playerCount,info->port,info->roomID,info->roomPath,info->roomstatus,info->serverCharge,info->serverID,info->smallBlind,info->speed,info->status,info->type);
            
            logMyLogInfo(@"-------------------end receive _SEARCH_ROOM----------------");
            [m_arrayStoreDataSouce removeAllObjects];
            
            NSString    *roomName = info->speed == 0?NSLocalizedString(@"普通", nil):NSLocalizedString(@"快速",nil);
            NSDictionary   *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@(info->type),CATEGORY,@(info->port),PORT,@(info->serverID),SERVERID,info->IP,SERVERIP,@(info->roomID),ROOMID,roomName,ROOMNAME,@(info->smallBlind),LITTLECHIP,@(info->bigBlind),BIGCHIP,@(info->playerCount),PLAYNUMBER,@(info->serverCharge),SERVERFEE,@(info->roomPath),ROOMPATH,@(info->carry_big_chip),CARRYBIGNUMBER,@(info->carry_small_chip),CARRYSMALLNUMBER,@(info->enter_big_chip),ENTERBIGNUMBER,@(info->enter_small_chip),ENTERSMALLNUMBER,nil];
            [m_arrayStoreDataSouce addObject:dicInfo];
            [m_tableView reloadData];
            if ([m_arrayStoreDataSouce count])
            {
                // [m_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
            
            
        }else if(info->status == 1)
        {
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n很抱歉，没有找到指定ID的房间", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
        }
        logMyLogInfo(@"[self.view subviews]:%@",[m_tableView subviews]);
        
        
    }
}

-(void)dealNotiForCOMPELTETYPE:(int)requestCode info:(void*)handle
{
    
    
    if (requestCode == REQ_GAME_ROOM_LIST_MATCH)
    {
        HideHUD(self, YES);
        DZPK_SERVER_REQ_GAME_ROOM_LIST_MATCH   *info = (DZPK_SERVER_REQ_GAME_ROOM_LIST_MATCH*)handle;
        
        if (info->status == 0)
        {
            [m_arrayStoreDataSouce removeAllObjects];
            
            logMyLogInfo(@"-------------------receive ROOM_LIST_MATCH -------------------");
            logMyLogInfo(@"status:%d typeNumber:%d IP:%@ port:%d serverID:%d",info->status,info->typeNumber,info->IP,info->serverport,info->serverID);
            
            for (int i = 0; i < info->pathArrayNumber ; i++)
            {
                logMyLogInfo(@"Number:%d  enterBig:%d enter_small:%d enterfee:%d firstBounds:%d path:%d playCount:%d roomID:%d second_bounds:%d status:%d,types:%d ",i,info->enter_big_array[i],info->enter_small_array[i],info->entryfeeArray[i],info->firstBounsArray[i],info->pathArray[i],info->PlayerOrCountArray[i],info->RoomIDArray[i],info->secondBounsArray[i],info->statusArray[i],info->typesArray[i]);
            }
            
            logMyLogInfo(@"-------------------end receive ROOM_LIST_MATCH-----------------");
            
            for (int i = 0; i < info->PlayerOrCountNumber; i++)
            {
                NSString    *roomStatus= info->statusArray[i] == 0?NSLocalizedString(@"准备中", nil):NSLocalizedString(@"进行中",nil);
                NSDictionary   *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@(info->serverport),PORT,@(info->serverID),SERVERID,info->IP,SERVERIP,@(info->RoomIDArray[i]),ROOMID,@(info->PlayerOrCountArray[i]),PLAYNUMBER,@(info->entryfeeArray[i]),SERVERFEE,@(info->pathArray[i]),ROOMPATH,roomStatus,ROOMSTATUS,@(info->enter_big_array[i]),ENTERBIGNUMBER,@(info->enter_small_array[i]),ENTERSMALLNUMBER,@(info->typesArray[i]),GAMETYPEINFO,@(info->firstBounsArray[i]),BONUFIRSTPRIZE,@(info->secondBounsArray[i]),BONUSECONDPRIZE,nil];
                [m_arrayStoreDataSouce addObject:dicInfo];
                
                
            }
            
            NSArray *sortedArray = [m_arrayStoreDataSouce sortedArrayUsingComparator: ^(id obj1, id obj2)
                                    {
                                        if ([[obj1 valueForKey:PLAYNUMBER] intValue] < [[obj2 valueForKey:PLAYNUMBER] intValue])
                                        {
                                            return (NSComparisonResult)NSOrderedDescending;
                                        }else if([[obj1 valueForKey:PLAYNUMBER] intValue] > [[obj2 valueForKey:PLAYNUMBER] intValue])
                                        {
                                            return (NSComparisonResult)NSOrderedAscending;
                                        }
                                        return (NSComparisonResult)NSOrderedSame;
                                    }];
            [m_arrayStoreDataSouce removeAllObjects];
            [m_arrayStoreDataSouce addObjectsFromArray:sortedArray];
            [m_tableView reloadData];
            
            if ([m_arrayStoreDataSouce count])
            {
                // [m_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
            
            free(info->enter_big_array);
            free(info->enter_small_array);
            free(info->entryfeeArray);
            free(info->firstBounsArray);
            free(info->pathArray);
            free(info->PlayerOrCountArray);
            free(info->secondBounsArray);
            free(info->statusArray);
            free(info->typesArray);
            info->enter_big_array = NULL;
            info->enter_small_array = NULL;
            info->entryfeeArray = NULL;
            info->firstBounsArray = NULL;
            info->secondBounsArray = NULL;
            info->statusArray = NULL;
            info->typesArray = NULL;
            
        }else if(info->status == 1)
        {
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n获取房间列表失败！", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
            
        }
        
    }else if(requestCode == REQ_GAME_SEARCH_ROOM)
    {
        
        HideHUD(self, YES);
        DZPK_SERVER_REQ_GAME_SEARCH_ROOM        *info = (DZPK_SERVER_REQ_GAME_SEARCH_ROOM*)handle;
        if (info->status == 0)
        {
            logMyLogInfo(@"-------------------receive _SEARCH_ROOM -------------------");
            logMyLogInfo(@"status:%d bigBlind:%d carry_big:%d carry_small:%d enter_big:%d enter_small:%d IP:%@,matchtypes:%d playerCount:%d port:%d roomID:%d,roomPath:%d roomStatus:%d,serverCharge:%d,serverID:%d,smallBlind:%d,speed:%d status:%d type:%d",info->status,info->bigBlind,info->carry_big_chip,info->carry_small_chip,info->enter_big_chip,info->enter_small_chip,info->IP,info->matchTypes,info->playerCount,info->port,info->roomID,info->roomPath,info->roomstatus,info->serverCharge,info->serverID,info->smallBlind,info->speed,info->status,info->type);
            
            logMyLogInfo(@"-------------------end receive _SEARCH_ROOM-----------------");
            
            [m_arrayStoreDataSouce removeAllObjects];
            
            NSString    *roomStatus = info->status == 0?NSLocalizedString(@"准备中", nil):NSLocalizedString(@"游戏进行中",nil);
            NSDictionary   *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@(info->port),PORT,@(info->serverID),SERVERID,info->IP,SERVERIP,@(info->roomID),ROOMID,@(info->playerCount),PLAYNUMBER,@(info->serverCharge),SERVERFEE,@(info->roomPath),ROOMPATH,roomStatus,ROOMSTATUS,@(info->carry_big_chip),BONUFIRSTPRIZE,@(info->carry_small_chip),BONUSECONDPRIZE,@(info->enter_big_chip),ENTERBIGNUMBER,@(info->enter_small_chip),ENTERSMALLNUMBER,@(info->matchTypes),GAMETYPEINFO,nil];
            [m_arrayStoreDataSouce addObject:dicInfo];
            [m_tableView reloadData];
            if ([m_arrayStoreDataSouce count])
            {
                //[m_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
            
            
        }else if(info->status == 1)
        {
            [RJFWarnView addinSelfview:self.view
                              delegate:nil
                               message:NSLocalizedString(@"提示\n\n很抱歉，没有找到指定ID的房间", nil)
                            buttontype:INSUREBUTTON
                          InsureButton:INSURE
                          CancelButton:nil];
        }
        
    }
    
}

-(BOOL)isValidNumber:(NSString *)strNumber
{
    
    NSString *NumberRegex = @"[0-9]+";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", NumberRegex];
    
    return [emailTest evaluateWithObject:strNumber];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)ClickInsure:(id)sender;
{
    
    RJFChargeViewController  *chargeView = [[RJFChargeViewController alloc] initWithNibName:@"RJFChargeViewController" bundle:nil];
    [self.navigationController pushViewController:chargeView animated:YES];
    [chargeView release];
    
}

-(void)SendUserGetdeatilInfo
{
    
 
    RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
    BasisZipAndUnzip  *basic = [[BasisZipAndUnzip alloc] initWithSize:50];
    logMyLogInfo(@"to get userinfo from server time:%@ socket connect:%d",[NSDate date],socket.connectSuc);
    [socket SendCharMessage:[basic syncWithRequest:REQ_PERSON_DATA
                                            userID:[[UserInfo shareInstance] userIDForDzpk]
                                       structArray:NULL] size:[basic dataSize]];
    
    
    
    
    [basic release];
    basic = nil;
    
}
@end

