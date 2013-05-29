//
//  RJFHelpViewController.m
//  Texas-pokes
//
//  Created by popo on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFHelpViewController.h"
#import "PublicDefine.h"


@implementation RJFHelpViewController

-(void)dealloc
{
    if (m_arrayStoreimage) 
    {
        [m_arrayStoreimage removeAllObjects];
        [m_arrayStoreimage release];
        m_arrayStoreimage = nil;
    }
    if (btnBack) 
    {
       [btnBack release];
        btnBack = nil;
    }
    if (btnGameRule) 
    {
        [btnGameRule release];
        btnGameRule = nil;
    }
    if (btnAboutUs) 
    {
        [btnAboutUs release];
        btnAboutUs = nil;
    }
    if (labelpage) 
    {
        [labelpage release];
        labelpage = nil;
    }
    if (imageViewhelp) 
    {
        [imageViewhelp release];
        imageViewhelp = nil;
    }
    if (labeTitle)
    {
        [labeTitle release];
        labeTitle = nil;
    }

    [super dealloc];
}
-(IBAction)clickBack:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)ClickGameRule:(UIButton*)sender
{
    for (UIView *view in [imageViewhelp subviews]) 
    {
        [view removeFromSuperview];
    }
    [labelpage setHidden:NO];
    imageViewhelp.image = [m_arrayStoreimage objectAtIndex:m_index];
    //[btnGameRule setBackgroundImage:[UIImage imageNamed:@"nav_sepline.png"] forState:UIControlStateNormal];
   // [btnAboutUs setBackgroundImage:[UIImage imageNamed:@"nav_sepline_null.png"] forState:UIControlStateNormal];
    
    for (UIView *view in [imageViewhelp subviews])
    {
        if (view.tag == 10)
        {
            [view setHidden:YES];
        }
    }
}
-(IBAction)ClickAboutUs:(UIButton*)sender
{
    [labelpage setHidden:YES];
    imageViewhelp.image = nil;
    
    int i = 0;
    for (UIView *view in [imageViewhelp subviews])
    {
        if (view.tag == 10)
        {
            view.hidden = NO;
            i++;
        }
    }
    
    if (i >= 2)
    {
        return;
    }
    UIImageView  *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aboutus_icon.png"]];
    [imageView setFrame:CGRectMake(180, 10, 114, 114)];
    [imageViewhelp addSubview:imageView];
    imageView.tag = 10;
    [imageView release];
    CGFloat    fsep = 5;
    CGFloat  height = 10 +114+fsep;
    
    UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(10, height, 480-20, 40)];
    [label setText:@"重庆品沃网络科技有限公司出品"];
    [label setFont:[UIFont systemFontOfSize:20]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
        
    label.tag = 10;
    [imageViewhelp addSubview:label];
    [label release];
    
    height += 40+fsep;
   UILabel *labelVersion = [[UILabel alloc] initWithFrame:CGRectMake(10, height, 480-20, 30)];
    [labelVersion setText:@"版本：乐乐德州扑克1.0"];
    [labelVersion setFont:[UIFont systemFontOfSize:16]];
    [labelVersion setBackgroundColor:[UIColor clearColor]];
    [labelVersion setTextColor:[UIColor whiteColor]];
    [labelVersion setTextAlignment:NSTextAlignmentCenter];
    
    labelVersion.tag = 10;
    [imageViewhelp addSubview:labelVersion];
    [labelVersion release];
    
    height+=30;
    UILabel *labelcopyrigh1 = [[UILabel alloc] initWithFrame:CGRectMake(10, height, 480-20, 30)];
    [labelcopyrigh1 setText:@"copyright© 2012"];
    [labelcopyrigh1 setFont:[UIFont systemFontOfSize:16]];
    [labelcopyrigh1 setBackgroundColor:[UIColor clearColor]];
    [labelcopyrigh1 setTextColor:[UIColor whiteColor]];
    [labelcopyrigh1 setTextAlignment:NSTextAlignmentCenter];
    
    labelcopyrigh1.tag = 10;
    [imageViewhelp addSubview:labelcopyrigh1];
    [labelcopyrigh1 release];
    
    height+=30;
    UILabel *labelAllright = [[UILabel alloc] initWithFrame:CGRectMake(10, height, 480-20, 30)];
    [labelAllright setText:@"All Rights Reserved"];
    [labelAllright setFont:[UIFont systemFontOfSize:16]];
    [labelAllright setBackgroundColor:[UIColor clearColor]];
    [labelAllright setTextColor:[UIColor whiteColor]];
    [labelAllright setTextAlignment:NSTextAlignmentCenter];
    
    labelAllright.tag = 10;
    [imageViewhelp addSubview:labelAllright];
    [labelAllright release];

    
    
    
   // [btnAboutUs setBackgroundImage:[UIImage imageNamed:@"nav_sepline.png"] forState:UIControlStateNormal];
   // [btnGameRule setBackgroundImage:[UIImage imageNamed:@"nav_sepline_null.png"] forState:UIControlStateNormal];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  withType:(Helptype)helptype
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        m_helpType = helptype;
        m_index = 0;
        m_arrayStoreimage = [[NSMutableArray alloc] init];
        for (int i = 0; i < 6; i++) 
        {
            [m_arrayStoreimage addObject:[UIImage imageNamed:[NSString stringWithFormat:@"help%d.png",i+1]]];
        }
        [labelpage setText:[NSString  stringWithFormat:@"1/%d",[m_arrayStoreimage count]]];
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
  //  [btnGameRule setBackgroundImage:[UIImage imageNamed:@"nav_sepline.png"] forState:UIControlStateNormal];
    if (m_helpType == ABOUTUSTYPE)
    {
        [self ClickAboutUs:btnAboutUs];
        [labeTitle setText:NSLocalizedString(@"关于我们", nil)];
    }else
    {
        [self ClickGameRule:btnGameRule];
        [labeTitle setText:NSLocalizedString(@"游戏规则", nil)];
    }
      setAllViewautoResize(self.view);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    m_beginPoint = [[touches anyObject] locationInView:self.view];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (labelpage.hidden)
    {
        return;
    }
    CGPoint  endpoint = [[touches anyObject] locationInView:self.view];
    if (endpoint.x - m_beginPoint.x > 5 && (ABS(endpoint.y-m_beginPoint.y) < 80))
    {
        
        m_index--;
        if (m_index < 0)
        {
            m_index = 0;
            return;
        }
        
            CATransition *animation = [CATransition animation];
            animation.delegate = self;
            animation.duration = 0.7f;
            animation.type = kCATransitionReveal;
            animation.subtype = kCATransitionFromLeft;
             imageViewhelp.image = [m_arrayStoreimage objectAtIndex:m_index];
            [imageViewhelp.layer addAnimation:animation forKey:@"a"];

    
    }else if (endpoint.x - m_beginPoint.x < -5 && (ABS(endpoint.y-m_beginPoint.y) < 80))
    {
       
      
        m_index++;
        if (m_index >= [m_arrayStoreimage count])
        {
            m_index = [m_arrayStoreimage count]-1;
            return;
        }

             CATransition *animation = [CATransition animation];
             animation.delegate = self;
             animation.duration = 0.7f;
             animation.subtype = kCATransitionFromRight;
             animation.type = kCATransitionReveal;
             [imageViewhelp.layer addAnimation:animation forKey:@"a"];
             imageViewhelp.image = [m_arrayStoreimage objectAtIndex:m_index];
   
    }
    [labelpage setText:[NSString  stringWithFormat:@"%d/%d",m_index+1,[m_arrayStoreimage count]]];
   // logMyLogInfo(@"end point:%@ beginPoint:%@",[NSValue valueWithCGPoint:endpoint],[NSValue valueWithCGPoint:m_beginPoint]);

    
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


@end
