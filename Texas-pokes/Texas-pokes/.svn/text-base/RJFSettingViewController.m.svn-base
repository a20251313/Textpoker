//
//  RJFSettingViewController.m
//  Texas-pokes
//
//  Created by popo on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFSettingViewController.h"
#ifndef USERINFO
#define USERINFO            @"USERINFO"
#define kautoSitDown      @"autoSitDown"
#define kclearCache      @"clearCache"
#define kcheckVersion      @"checkVersion"
#define kvolume      @"volume"
#define kmusic     @"music"
#endif

@interface RJFSettingViewController ()

@end

@implementation RJFSettingViewController

-(IBAction)clickBack:(id)sender
{
    
    UserInfo  *user = [UserInfo shareInstance];
    // logMyLogInfo(@"%@,%@,%@,%@,%@",swithAutoSitdown,swithClearCache,swithNewversion,sliderMusic,sliderVolume);
   // logMyLogInfo(@"%d,%d,%d,%f,%f",user.autoSitDown,user.clearCache,user.checkVersion,user.music,user.volume);
    user.autoSitDown = swithAutoSitdown.isOn;
    user.checkVersion = swithNewversion.isOn;
    user.music = sliderMusic.value;
    
     NSDictionary *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@(user.autoSitDown),kautoSitDown,@(user.checkVersion),kcheckVersion,@(user.clearCache),kclearCache,@(user.volume),kvolume,@(user.music),kmusic,nil];
    [[NSUserDefaults standardUserDefaults] setObject:dicInfo forKey:USERINFO];
    [[NSUserDefaults standardUserDefaults] synchronize];
   // logMyLogInfo(@"%d,%d,%d,%f,%f",user.autoSitDown,user.clearCache,user.checkVersion,user.music,user.volume);
    [self.navigationController popViewControllerAnimated:YES];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{

    if (swithAutoSitdown) 
    {
        [swithAutoSitdown release];
        swithAutoSitdown = nil;
    }
    if (swithNewversion) 
    {
        [swithNewversion release];
        swithNewversion = nil;
    }
    if (sliderMusic) 
    {
        [sliderMusic release];
        sliderMusic = nil;
    }
    [super dealloc];
}
- (void)viewDidLoad
{
    
    UserInfo  *user = [UserInfo shareInstance];
    [swithAutoSitdown setOn:user.autoSitDown];
    [swithNewversion setOn:user.checkVersion];
    [sliderMusic setValue:user.music];
   // logMyLogInfo(@"%d,%d,%d,%f,%f\n\n",user.autoSitDown,user.clearCache,user.checkVersion,user.music,user.volume);
    //logMyLogInfo(@"%d,%d,%d,%f,%f",swithAutoSitdown.is,swithClearCache,swithNewversion,sliderMusic,sliderVolume);
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

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(IBAction)clickMin:(id)sender
{
    UserInfo  *objUser = [UserInfo shareInstance];
    [sliderMusic setValue:0];
    objUser.music = 0;
}
-(IBAction)clickMax:(id)sender
{
    UserInfo  *objUser = [UserInfo shareInstance];
    [sliderMusic setValue:1];
    objUser.music = 1;
}

@end
