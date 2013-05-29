//
//  RJFSliderView.m
//  Texas-pokes
//
//  Created by popo on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFSliderView.h"

#ifndef SLIDEBARTAR
#define     SLIDEBARTAR                 2044
#define     SLIDERBGVIEWTAG             2045
#endif

@implementation RJFSliderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
        [self setBackgroundColor:[UIColor clearColor]];
        self.tag = SLIDERBGVIEWTAG;
        UIImage  *imageSourse = [UIImage imageNamed:@"addchip.png"];
        UIImage  *imageSoureBg = [UIImage imageNamed:@"addchip_bg.png"];
        self.image = imageSoureBg;//[UIImage imageByScalingAndCroppingForSize:CGSizeMake(imageSoureBg.size.width/2, imageSoureBg.size.height/2) sourceImages:imageSoureBg];
        UISlider      *slider = [[UISlider alloc] initWithFrame:CGRectMake(3,self.frame.size.height/2-10, 220, 10)];
        slider.backgroundColor = [UIColor clearColor];
        [slider setMaximumTrackImage:[UIImage imageNamed:@"add_chip_line.png"] forState:UIControlStateNormal];
        [slider setMinimumTrackImage:[UIImage imageNamed:@"addChip_line_fill.png"] forState:UIControlStateNormal];
        slider.tag = SLIDEBARTAR;
        [self addSubview:slider];
        UIImage *image = [UIImage imageByScalingAndCroppingForSize:CGSizeMake(imageSourse.size.width/3*2, imageSourse.size.height/3*2) sourceImages:imageSourse];
        [slider setThumbImage:image forState:UIControlStateNormal];
        [slider autorelease];
        //[self.view addSubview: viewbg];
        [UIView animateWithDuration:0.3f
                         animations:^{self.transform = CGAffineTransformMakeRotation(M_PI_2+M_PI);}
                         completion:^(BOOL finish)
        {
            [self BeginslideAni];
        }];
       // [self release];

        // Initialization code
    }
    return self;
}

- (id)initNoLandWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
        [self setBackgroundColor:[UIColor clearColor]];
        self.tag = SLIDERBGVIEWTAG;
        UIImage  *imageSourse = [UIImage imageNamed:@"addchip.png"];
        //UIImage  *imageSoureBg = [UIImage imageNamed:@"addchip_bg.png"];
        self.backgroundColor = [UIColor clearColor];
        //self.image = imageSoureBg;//[UIImage imageByScalingAndCroppingForSize:CGSizeMake(imageSoureBg.size.width/2, imageSoureBg.size.height/2) sourceImages:imageSoureBg];
        UISlider      *slider = [[UISlider alloc] initWithFrame:CGRectMake(3,self.frame.size.height/2-10, 220, 10)];
        slider.backgroundColor = [UIColor clearColor];
        [slider setMaximumTrackImage:[UIImage imageNamed:@"add_chip_line.png"] forState:UIControlStateNormal];
        [slider setMinimumTrackImage:[UIImage imageNamed:@"addChip_line_fill.png"] forState:UIControlStateNormal];
        slider.tag = SLIDEBARTAR;
        [self addSubview:slider];
        UIImage *image = [UIImage imageByScalingAndCroppingForSize:CGSizeMake(imageSourse.size.width/3*2, imageSourse.size.height/3*2) sourceImages:imageSourse];
        [slider setThumbImage:image forState:UIControlStateNormal];
        [slider autorelease];
        //[self.view addSubview: viewbg];

        // [self release];
        
        // Initialization code
    }
    return self;
}
-(void)BeginslideAni
{
    UISlider  *slider =(UISlider *) [self viewWithTag:SLIDEBARTAR];
    [UIView beginAnimations:@"11" context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
     [slider setValue:[slider minimumValue]];
    [UIView setAnimationDuration:0.5f];
    [slider setValue:[slider maximumValue]];
    [UIView commitAnimations];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
