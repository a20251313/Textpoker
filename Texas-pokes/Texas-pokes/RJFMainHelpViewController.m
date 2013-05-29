//
//  RJFMainHelpViewController.m
//  Texas-pokes
//
//  Created by ran on 12-11-16.
//
//

#import "RJFMainHelpViewController.h"
#import "RJFHelpViewController.h"
#import "RJFFAQViewController.h"

@interface RJFMainHelpViewController ()

@end

@implementation RJFMainHelpViewController
@synthesize canSendAdvice;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        canSendAdvice = YES;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [super dealloc];
}
-(IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark tableview delegate method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
    
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
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        UIImageView  *imageBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 448, 50)];
        imageBg.image = [UIImage imageNamed:@"project_line_mid.png"];
        imageBg.userInteractionEnabled = YES;
        imageBg.tag = 2;
        [cell.contentView addSubview:imageBg];
        UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 40)];
        label.tag = 10;
        [label setTextColor:[UIColor blackColor]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:@""];
        [label setFont:[UIFont systemFontOfSize:18]];
        [imageBg addSubview:label];
        [label release];
        
        UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(m_tableView.frame.size.width-30, (50-19)/2, 13, 19)];
        imageView.image = [UIImage imageNamed:@"help_array.png"];
        imageView.userInteractionEnabled = YES;
        [imageBg addSubview:imageView];
        [imageBg release];
        [imageView release];
        //[tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];

    }
    UILabel  *label = (UILabel *)[cell.contentView viewWithTag:10];
     UIImageView  *imageView = (UIImageView *)[cell.contentView viewWithTag:2];
    switch (indexPath.row)
    {
        case 0:
            label.text = NSLocalizedString(@"游戏规则", nil);
            imageView.image = [UIImage imageNamed:@"project_line_top.png"];
            break;
        case 1:
            label.text = NSLocalizedString(@"FAQ", nil);
            imageView.image = [UIImage imageNamed:@"project_line_mid.png"];
            break;
        case 2:
            label.text = NSLocalizedString(@"意见反馈", nil);
            imageView.image = [UIImage imageNamed:@"project_line_mid.png"];
            break;
        case 3:
            label.text = NSLocalizedString(@"关于我们", nil);
            imageView.image = [UIImage imageNamed:@"project_line_bottom.png"];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     id  control = nil;
    switch (indexPath.row)
    {
        case 0:
            control = [[RJFHelpViewController alloc] initWithNibName:@"RJFHelpViewController" bundle:nil withType:GAMERULETYPE];
            break;
        case 1:
            control = [[RJFFAQViewController alloc] initWithNibName:@"RJFFAQViewController" bundle:nil type:FAQPAGETYPE];
            break;
        case 2:
            if (!canSendAdvice)
            {
                [RJFWarnView addinSelfview:self.view
                                  delegate:nil
                                   message:NSLocalizedString(@"提示\n\n\n请先登录！", nil)
                                buttontype:INSUREBUTTON
                              InsureButton:INSURE
                              CancelButton:nil];
                return;
            }
            
            control = [[RJFFAQViewController alloc] initWithNibName:@"RJFFAQViewController" bundle:nil type:ADVICEPAGETYPE];
            break;
        case 3:
            control = [[RJFHelpViewController alloc] initWithNibName:@"RJFHelpViewController" bundle:nil withType:ABOUTUSTYPE];
            break;
            
        default:
            break;
    }
    if (control)
    {
        [self.navigationController pushViewController:control animated:YES];
        [control release];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}




@end
