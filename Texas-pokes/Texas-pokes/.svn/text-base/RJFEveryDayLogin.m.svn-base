//
//  RJFEveryDayLogin.m
//  Texas-pokes
//
//  Created by ran on 13-1-21.
//
//


#import "RJFEveryDayLogin.h"
#import <QuartzCore/QuartzCore.h>

#import "CABasicAnimation+someAniForProp.h"



#define EVERYWIDTH           480
#define EVERYHEIGHT          320


#define HALOVIEWTAG             1022
#define BIGPREBOXTAG            1024
#define LABELCHIPTAG            1025

@implementation RJFEveryDayLogin
@synthesize day,chipReward;
@synthesize dayImageView;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
        
    {
        
        
        // Initialization code
    }
    return self;
}


-(id)initWithChip:(int32_t)ichipReward day:(NSInteger)iday
{
    CGRect  frame = CGRectMake(0, 0, EVERYWIDTH, EVERYHEIGHT);
    self = [super initWithFrame:frame];
    if (self)
    {
        self.day = iday;
        self.chipReward = ichipReward;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        UIImageView   *imageFrame = [[UIImageView alloc] initWithFrame:CGRectMake((EVERYWIDTH-451)/2, (EVERYHEIGHT-108)/2-10, 451, 108)];
        imageFrame.image = [UIImage imageNamed:@"login_frame.png"];
        [self addSubview:imageFrame];
        
        CGFloat   fwidth = 13;
        CGFloat   fsep = 6;
        for (int i = 0; i < 7; i++)
        {
            UIImageView  *tempView = [[UIImageView alloc] initWithFrame:CGRectMake(fwidth, 40, 41, 41.5)];
            
            if (i+1 == iday)
            {
                // tempView.image = [UIImage imageNamed:@"login_bounds.png"];
                tempView.image = [UIImage imageNamed:@"dzpk_login_gray_preBox.png"];
                dayImageView = tempView;
                
                CABasicAnimation *animationopacity =[CABasicAnimation animationWithKeyPath:@"opacity"];
                
                animationopacity.fromValue=[NSNumber numberWithFloat:1];
                
                
                animationopacity.toValue=[NSNumber numberWithFloat:0];
                
                animationopacity.autoreverses = NO;
                
                animationopacity.duration = 2;
                
                animationopacity.repeatCount = 1;
                
                animationopacity.removedOnCompletion = NO;
                
                animationopacity.delegate = self;
                
                animationopacity.name = @"dayImageView";
                
                
                animationopacity.fillMode = kCAFillModeForwards;
                [dayImageView.layer addAnimation:animationopacity forKey:@"11"];
                
                
                
            }else if (i+1 < iday)
            {
                tempView.image = [UIImage imageNamed:@"dzpk_login_preBox.png"];
            }else if(i+1 > iday)
            {
                tempView.image = [UIImage imageNamed:@"dzpk_login_gray_preBox.png"];
            }
            
            tempView.tag = 2000+i;
            [imageFrame addSubview:tempView];
            if (i+1 == iday)
            {
                tempView.alpha = 1.0f;
            }else
            {
                
                tempView.alpha = 0.4f;
            }
            [tempView release];
            
            UILabel   *labelContent = [[UILabel alloc] initWithFrame:CGRectMake(fwidth-8, 40+41, 60, 21)];
            labelContent.text = [NSString stringWithFormat:NSLocalizedString(@"连续登录%d天", nil),i+1];
            labelContent.backgroundColor = [UIColor clearColor];
            labelContent.textColor = [UIColor whiteColor];
            labelContent.textAlignment = NSTextAlignmentCenter;
            labelContent.font = [UIFont systemFontOfSize:10];
            [imageFrame addSubview:labelContent];
            [labelContent release];
            
            
            fwidth += fsep+41;
            
            if (i == 6)
            {
                break;
            }
            UIImageView  *imageArrowView = [[UIImageView alloc] initWithFrame:CGRectMake(fwidth, 40+15, 11, 11)];
            imageArrowView.image = [UIImage imageNamed:@"login_arrow.png"];
            imageArrowView.tag = 3000+i;
            [imageFrame addSubview:imageArrowView];
            fwidth += fsep+11;
            
            [imageArrowView release];
            [self performSelector:@selector(aniAfterView:)
                       withObject:nil
                       afterDelay:0];
            
            
        }
        
        
    }
    return self;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */



-(void)aniAfterView:(id)Thread
{
    UIImageView   *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-171)/2, (self.frame.size.height-122)/2, 171, 122)];
    imageView.image = [UIImage imageNamed:@"dzpk_login_bigpreBox.png"];
    [self addSubview:imageView];
    CABasicAnimation  *bigpre = [CABasicAnimation aninopacity:3 name:@"bigpreBox"];
    bigpre.delegate = self;
    [imageView.layer addAnimation:bigpre forKey:@"1"];
    [imageView.layer addAnimation:[CABasicAnimation aniWithScale:3 tovalue:1 fromValue:0] forKey:@"w"];
    UIImageView  *haloview = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-265)/2, (self.frame.size.height-265)/2, 265, 265)];
    haloview.center = self.center;
    haloview.image = [UIImage imageNamed:@"dzpk_light_halo.png"];
    [self insertSubview:haloview belowSubview:imageView];
    haloview.tag = HALOVIEWTAG;
    
    CABasicAnimation  *halo = [CABasicAnimation aninopacity:3 name:@"halo"];
    halo.delegate = self;
    [haloview.layer addAnimation:halo forKey:@"qq"];
    [haloview.layer addAnimation:[CABasicAnimation aniWithScale:3 tovalue:1 fromValue:0] forKey:@"1ds"];
    [imageView release];
    [haloview release];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
{
    // NSLog(@"anim:%@ flag:%d name:%@",anim,flag,[anim name]);
    
    if ([anim.name isEqualToString:@"halo"])
    {
        for (UIView  *view in [self subviews])
        {
            if (view.tag == HALOVIEWTAG)
            {
                [view.layer addAnimation:[CABasicAnimation aniRotate:3 name:@"s"] forKey:nil];
            }
        }
        
    }else if([[anim name] isEqualToString:@"bigpreBox"])
    {
        //  anim.name = nil;
        NSString *strChip = [NSString stringWithFormat:@"%d",chipReward];
        int  count = [strChip length]+1;
        CGFloat  fwidth = count*19;
        UIView   *view = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width-fwidth)/2, (self.frame.size.height-30)/2, 19, 30)];
        view.layer.opacity = 0;
        for (int i = 0;i < count;i++)
        {
            UIImageView  *tempView = nil;
            tempView = [[UIImageView alloc] initWithFrame:CGRectMake(19*i, 0, 19, 30)];
            if (i == 0)
            {
                
                tempView.image = [UIImage imageNamed:@"dzpk_login_add.png"];
            }else
            {
                NSString  *strTempString = [strChip substringWithRange:NSMakeRange(i-1, 1)];
                tempView.image = [UIImage imageNamed:[NSString stringWithFormat:@"dzpk_login_%@",strTempString]];
            }
            [view addSubview:tempView];
            [tempView release];
            
        }
        [self addSubview:view];
        
        view.tag = LABELCHIPTAG;
        CAAnimationGroup  *aniGrop = [CAAnimationGroup animation];
        aniGrop.animations = [NSArray  arrayWithObjects:[CABasicAnimation aninopacity:6 name:nil],[CABasicAnimation aniWithTransition:6 tovalue:-70 fromValue:0], nil];
        //  [view.layer addAnimation:[] forKey:nil];
        [view.layer addAnimation:[CABasicAnimation aninopacity:3 name:nil] forKey:@"1"];
        [view.layer addAnimation:[CABasicAnimation aniWithTransition:3 tovalue:-70 fromValue:0] forKey:@"2"];
        [view release];
        
        [self performSelector:@selector(removeFromSuperview)
                   withObject:nil
                   afterDelay:4];
        
    }else if ([[anim name] isEqualToString:@"dayImageView"])
    {
        dayImageView.image = [UIImage imageNamed:@"dzpk_login_littlepreBox.png"];
        [dayImageView.layer addAnimation:[CABasicAnimation aninopacity:3 name:@"qq"] forKey:nil];
    }
    
}




@end
