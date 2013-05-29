//
//  RJFaudioPlay.m
//  Texas-pokes
//
//  Created by popo on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFaudioPlay.h"
#import "UserInfo.h"
#import "PublicDefine.h"

static  RJFaudioPlay  *shareplayer = nil;
@implementation RJFaudioPlay
+(id)shareInstance
{
    if (!shareplayer)
    {
        shareplayer = [[RJFaudioPlay alloc] init];
    }
    return shareplayer;
    
}



-(id)init
{
    self = [super init];
    if (self) 
    {
       // player = [[AVAudioPlayer alloc] init];
    }
    return self;
}


-(void)PlayMyAudio:(NSString *)strPath
{
    UserInfo  *Myuser = [UserInfo shareInstance];
    float  fVolume = [Myuser music];
    NSURL   *strRelurl = [[[NSBundle mainBundle] resourceURL] URLByAppendingPathComponent:strPath];
    //NSData  *data = [[NSData alloc] initWithContentsOfURL:strRelurl];
    NSError  *error = nil;
    AVAudioPlayer *myplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:strRelurl error:&error];
    if (error) 
    {
       // logMyLogInfo(@"error:%@",[error localizedDescription]);
    }
    [myplayer setVolume:fVolume];
    [myplayer prepareToPlay];
    [myplayer play];
    [myplayer setDelegate:self];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)myplayer successfully:(BOOL)flag
{

    [myplayer release];
    
}

+(void)PlayMyAudio:(NSString *)strPath
{
  //  return;
  
    UserInfo  *Myuser = [UserInfo shareInstance];
    if (!Myuser.IsOnGameInterface)
    {
        return;
    }
    float  fVolume = [Myuser music];
    if (fVolume == 0)
    {
        logMyLogInfo(@"volum is min");
        return;
    }
#if DEBUG
   // return;
#endif
#if TARGET_OS_IPHONE
    if (!shareplayer)
    {
        shareplayer = [RJFaudioPlay shareInstance];
    }
    [shareplayer PlayMyAudio:strPath];
  
#endif
   
}

@end
