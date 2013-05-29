//
//  RJFLevelViewController.m
//  Texas-pokes
//
//  Created by popo on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFLevelViewOrWeathController.h"
#import "UserInfo.h"
@interface RJFLevelViewOrWeathController ()

@end
#define USERNAME        @"USERNAME"
#define USERLEVEL       @"USERLEVEL"
#define USERTITLE       @"USERTITLE"
#define USERWEATH        @"USERWEATH"


@implementation RJFLevelViewOrWeathController
@synthesize arrayStoreRank = m_arrayStoreRank;
#pragma mark self define method
/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *         back to preveily viewcontrol
 *  @param
 *          picker
 *              UIImagePickerController
 *	@return
 *          NONE
 *
 */
-(IBAction)clickBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
 *              nibnmae
 *  @param
 *          nibBundleOrNil
 *              bundle
 *  @param
 *          controlType
 *              the control type
 *	@return
 *          id(self)
 *
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [m_tableView setHidden:NO];
    [m_tableView setBackgroundColor:[UIColor clearColor]];
    if (self)
    {
            
       
        
        
        // Custom initialization
    }
    return self;
}

#pragma mark overide method
/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *         dealloc
 *	@return
 *          NONE
 *
 */
-(void)dealloc
{
    if (m_arrayStoreRank)
    {
        [m_arrayStoreRank removeAllObjects];
        [m_arrayStoreRank release];
        m_arrayStoreRank = nil;
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
    if (labelTextContex)
    {
        [labelTextContex release];
        labelTextContex = nil;
    }
    [super dealloc];
}
/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 07 26
 *  @brief
 *         viewdidload
 *	@return
 *          NONE
 *
 */
- (void)viewDidLoad
{
    [m_tableView setDelegate:self];
    [m_tableView setDataSource:self];
    [m_tableView setHidden:NO];

    [labelTextContex setText:NSLocalizedString(@"等级规则", nil)];
   // [m_tableView setTableHeaderView:[self headerView]];
    [m_tableView reloadData];
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
 *         view did unload
 *	@return
 *          NONE
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
 *         shouldAutorotateToInterfaceOrientation
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


#pragma mark tableview delegate method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [m_arrayStoreRank count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  *cell =  [tableView dequeueReusableCellWithIdentifier:@"22"];
        if (!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"22"] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            CGFloat  fXpoint = 0;
            CGFloat  fSep = 5;
            CGFloat  fheight = 30;
            CGFloat  fwidth = 140;
            for (int i = 0; i < 3; i++)
            {
                UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint+fSep*i+fwidth*i, 5, fwidth, fheight)];
                label.tag = i+1;
                [label setBackgroundColor:[UIColor clearColor]];
                [label setTextColor:[UIColor blackColor]];
                [label setTextAlignment:NSTextAlignmentCenter];
                [label setFont:[UIFont systemFontOfSize:16]];
                [cell.contentView addSubview:label];
                
                [label release];
            }
            cell.backgroundColor = [UIColor clearColor];
            [tableView setBackgroundColor:[UIColor clearColor]];
            UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 2+9, 12.5, 17.5)];
            imageView.tag = 10;
            [cell.contentView addSubview:imageView];
            [imageView release];
        }
        NSDictionary  *dicInfo = [m_arrayStoreRank objectAtIndex:indexPath.row];
        
        UIColor *textColor = [UIColor blackColor];
        /*if (indexPath.row  >= 17)
        {
            textColor = [UIColor purpleColor];
        }else if (indexPath.row >= 13)
        {
            textColor = [UIColor orangeColor];
        }else if (indexPath.row >= 9)
        {
            textColor = [UIColor brownColor];
        }else if (indexPath.row >= 6)
        {
            textColor = [UIColor greenColor];
        }else if (indexPath.row >= 2)
        {
            textColor = [UIColor blueColor];
        }else if (indexPath.row >= 0)
        {
            textColor = [UIColor blackColor];
        }*/
        
        UIImageView  *imageView = (UIImageView *)[cell.contentView viewWithTag:10];
        UILabel  *label = (UILabel*)[cell.contentView viewWithTag:1];
        if (indexPath.row  == 0)
        {
            [label setText:NSLocalizedString(@"兵", nil)];
             [imageView setHidden:YES];
        }else if (indexPath.row == 2)
        {
             [label setText:NSLocalizedString(@"士", nil)];
             imageView.image = [UIImage imageNamed:@"medal_1.png"];
             [imageView setHidden:NO];
        }else if (indexPath.row == 6)
        {
             [label setText:NSLocalizedString(@"尉", nil)];
             imageView.image = [UIImage imageNamed:@"medal_2.png"];
            [imageView setHidden:NO];
        }else if (indexPath.row == 9)
        {
            [label setText:NSLocalizedString(@"校", nil)];
             imageView.image = [UIImage imageNamed:@"medal_3.png"];
            [imageView setHidden:NO];
            
        }else if (indexPath.row == 13)
        {
            [label setText:NSLocalizedString(@"将", nil)];
             imageView.image = [UIImage imageNamed:@"medal_4.png"];
            [imageView setHidden:NO];
        }else if (indexPath.row == 17)
        {
            [label setText:NSLocalizedString(@"帅", nil)];
             imageView.image = [UIImage imageNamed:@"medal_5.png"];
            [imageView setHidden:NO];
        }else
        {  [imageView setHidden:YES];
            [label setText:@""];
        }
        
        [label setTextColor:textColor];
        label = (UILabel *)[cell.contentView viewWithTag:2];
        NSString  *strName = [NSString stringWithFormat:@"%@",[dicInfo valueForKey:@"name"]];
        [label setText:strName];
        [label setTextColor:textColor];
        
        
        label = (UILabel*)[cell.contentView viewWithTag:3];
        [label setText:[NSString stringWithFormat:@"%@~%@",[dicInfo valueForKey:@"score"],[dicInfo valueForKey:@"nextLevelScore"]]];
        [label setTextColor:textColor];

  
       
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView            // Default is 1 if not implemented
{
    return 1;
}




-(void)viewWillAppear:(BOOL)animated
{
    CGFloat  fwidth = m_scrollView.frame.size.width;
    CGFloat  fsep = 5;
    CGFloat  fhight = 5;;
    [m_scrollView setScrollEnabled:YES];
    [m_scrollView setShowsVerticalScrollIndicator:YES];
    UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, fwidth, 25)];
    [label setText:NSLocalizedString(@"1.积分说明", nil)];
    [label setTextColor:[UIColor blueColor]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont systemFontOfSize:20]];
    [m_scrollView addSubview:label];
    [label release];
    
    fhight += 25;
    
    UITextView   *Textview = [[UITextView alloc] initWithFrame:CGRectMake(0, fhight, fwidth, 135)];
    [Textview setTextAlignment:NSTextAlignmentLeft];
    [Textview setText:NSLocalizedString(@"积分说明", nil)];
    [Textview setBackgroundColor:[UIColor clearColor]];
    [Textview setEditable:NO];
    [Textview setFont:[UIFont systemFontOfSize:16]];
    [Textview setTextColor:[UIColor blackColor]];
    [Textview setScrollEnabled:NO];
    [m_scrollView addSubview:Textview];
    [Textview release];
    
    fhight += 135+fsep;
    
    UILabel  *labelRule = [[UILabel alloc] initWithFrame:CGRectMake(0, fhight, fwidth, 25)];
    [labelRule setText:NSLocalizedString(@"2.等级对应表", nil)];
    [labelRule setTextColor:[UIColor blueColor]];
    [labelRule setTextAlignment:NSTextAlignmentLeft];
    [labelRule setBackgroundColor:[UIColor clearColor]];
    [labelRule setFont:[UIFont systemFontOfSize:20]];
    [m_scrollView addSubview:labelRule];
    [labelRule release];
    fhight += fsep+25;
    [m_tableView setScrollEnabled:NO];
    [m_tableView setBackgroundColor:[UIColor clearColor]];
    [m_tableView setShowsVerticalScrollIndicator:NO];
    m_tableView.userInteractionEnabled = YES;
    m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, fhight, fwidth, 840)];
    [m_tableView setDelegate:self];
    [m_tableView setDataSource:self];
    UIImageView  *viewBg = [[UIImageView alloc] initWithImage:nil];
    viewBg.backgroundColor = [UIColor clearColor];
    [m_tableView setBackgroundView:viewBg];
    [viewBg release];
    [m_scrollView addSubview:m_tableView];
    
    [m_scrollView setContentSize:CGSizeMake(fwidth, fhight+840)];
    
    [m_scrollView setPagingEnabled:NO];
    
    [labelTextContex setText:NSLocalizedString(@"等级规则", nil)];
    NSDictionary  *dicInfo = [[NSBundle mainBundle] infoDictionary];
    m_arrayStoreRank = [[NSMutableArray alloc] init];
    NSArray  *array = [dicInfo valueForKey:@"levelTable"];
    [m_arrayStoreRank addObjectsFromArray:array];
    [m_tableView reloadData];
    [super viewWillAppear:animated];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(UIView *)headerView
{

    UIView  *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 480, 40)] autorelease];
    
    CGFloat  fXpoint = 0;
    CGFloat  fSep = 5;
    CGFloat  fheight = 30;
    CGFloat  fwidth = 140;
    for (int i = 0; i < 3; i++)
    {
        UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint+fSep*i+fwidth*i, 5, fwidth, fheight)];
        label.tag = i+1;
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor blackColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:18]];
        
        [view addSubview:label];
        switch (i)
        {
            case 0:
                label.text = NSLocalizedString(@"等级", nil);
                break;
            case 1:
                label.text = NSLocalizedString(@"名称", nil);
                break;
            case 2:
                label.text = NSLocalizedString(@"积分区间", nil);
                break;
                
            default:
                break;
        }
        [label release];
        
        
    }
    
    UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 39, 480, 1)];
    [view addSubview:label];
    [label setBackgroundColor:[UIColor lightGrayColor]];
    [label release];
    return view;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section

{
    return [self headerView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 40;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 40;
    
}
@end
