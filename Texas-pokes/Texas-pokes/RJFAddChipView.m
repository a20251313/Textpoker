//
//  RJFAddChipView.m
//  Texas-pokes
//
//  Created by ran on 12-10-30.
//
//

#import "RJFAddChipView.h"
#import "RJFSliderView.h"

#ifndef SLIDEBARTAR
#define     SLIDEBARTAR                 2044
#define     SLIDERBGVIEWTAG             2045
#endif


@implementation RJFAddChipView
@synthesize delegate;
//   USERCHIP ------------   NSNumber
//   MAXCHIP  ------------   NSNUmber
//   MINCHIP  ------------   NSNUmber

- (id)initWithFrame:(CGRect)frame withInfo:(NSDictionary *)dicInfo
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        //320 200
        RJFSliderView  *slideview = [[RJFSliderView alloc] initNoLandWithFrame:CGRectMake(50, 30, 250, 100)];
        [self addSubview:slideview];
        self.image = [UIImage imageNamed:@"popview.png"];
        [slideview release];
        self.userInteractionEnabled = YES;
        
        
        UILabel  *labelUserChip = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 320, 20)];
        [labelUserChip setText:[NSString stringWithFormat:NSLocalizedString(@"用户拥有筹码:%@", nil),[dicInfo valueForKey:@"USERCHIP"]]];
        [labelUserChip setBackgroundColor:[UIColor clearColor]];
        [labelUserChip setTextColor:[UIColor whiteColor]];
        [labelUserChip setFont:[UIFont systemFontOfSize:16]];
        [labelUserChip setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:labelUserChip];
        [labelUserChip release];
        
        
        
        int  maxValue = [[dicInfo valueForKey:@"MAXCHIP"] intValue];
        int  minvalue = [[dicInfo valueForKey:@"MINCHIP"] intValue];
        UISlider  *slide = (UISlider *)[self viewWithTag:SLIDEBARTAR];
        if (slide)
        {
            [slide addTarget:self
                      action:@selector(sliderValueChange:)
            forControlEvents:UIControlEventValueChanged];
            [slide setMaximumValue:maxValue];
            [slide setMinimumValue:minvalue];
            [slide setValue:(minvalue+maxValue)/2];
        }
        
        UILabel  *labelCurrentValue = [[UILabel alloc] initWithFrame:CGRectMake(0, 95, 320, 20)];
        int  currentvalue = ([[dicInfo valueForKey:@"MAXCHIP"] intValue]+[[dicInfo valueForKey:@"MINCHIP"] intValue])/2;
        [labelCurrentValue setText:[NSString stringWithFormat:@"%d",currentvalue]];
        [labelCurrentValue setBackgroundColor:[UIColor clearColor]];
        [labelCurrentValue setTextColor:[UIColor whiteColor]];
        [labelCurrentValue setTextAlignment:NSTextAlignmentCenter];
        [labelCurrentValue setFont:[UIFont systemFontOfSize:14]];
        labelCurrentValue.tag = 12;
        [self addSubview:labelCurrentValue];
        [labelCurrentValue release];
        
        
        UILabel  *labelMin = [[UILabel alloc] initWithFrame:CGRectMake(5, 125, 160, 20)];
        [labelMin setText:[NSString stringWithFormat:NSLocalizedString(@"最小添加:%@", nil),[dicInfo valueForKey:@"MINCHIP"]]];
        [labelMin setBackgroundColor:[UIColor clearColor]];
        [labelMin setTextColor:[UIColor whiteColor]];
        [labelMin setTextAlignment:NSTextAlignmentCenter];
        [labelMin setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:labelMin];
        [labelMin release];
        
        
        UILabel  *labelMAX = [[UILabel alloc] initWithFrame:CGRectMake(165, 125, 160, 20)];
        [labelMAX setText:[NSString stringWithFormat:NSLocalizedString(@"最大添加:%@", nil),[dicInfo valueForKey:@"MAXCHIP"]]];
        [labelMAX setBackgroundColor:[UIColor clearColor]];
        [labelMAX setTextColor:[UIColor whiteColor]];
        [labelMAX setTextAlignment:NSTextAlignmentCenter];
        [labelMAX setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:labelMAX];
        [labelMAX release];
        
        
        // button_green
        UIButton    *btnInsure = [[UIButton alloc] initWithFrame:CGRectMake(30, 155, 90, 30)];
        [btnInsure setBackgroundImage:[UIImage imageNamed:@"button_green.png"] forState:UIControlStateNormal];
        [btnInsure setTitle:INSURE forState:UIControlStateNormal];
        [btnInsure addTarget:self
                      action:@selector(ClickInsure:)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnInsure];
        [btnInsure release];
        
        UIButton    *btnCancle= [[UIButton alloc] initWithFrame:CGRectMake(180, 155, 90, 30)];
        [btnCancle setBackgroundImage:[UIImage imageNamed:@"button_orange.png"] forState:UIControlStateNormal];
        [btnCancle setTitle:CANCEL forState:UIControlStateNormal];
        [btnCancle addTarget:self
                      action:@selector(ClickCancel:)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnCancle];
        [btnCancle release];
        
        // Initialization code
    }
    return self;
}


-(void)ClickInsure:(id)sender
{
    
    UISlider  *slide = (UISlider *)[self viewWithTag:SLIDEBARTAR];
    int chips = [slide value];
    
    if (delegate && [delegate respondsToSelector:@selector(getAddChipInfo:)])
    {
        [delegate getAddChipInfo:[NSDictionary dictionaryWithObjectsAndKeys:@(chips),@"CHIP",nil]];
    }
    [self removeFromSuperview];
    
    NSLog(@"insure:");
    
    
}
-(void)ClickCancel:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(getAddChipInfo:)])
    {
        [delegate getAddChipInfo:nil];
    }
    [self removeFromSuperview];
    NSLog(@"cancel:");
}

-(void)sliderValueChange:(UISlider *)slider
{
    UILabel  *label =(UILabel *) [self viewWithTag:12];
    [label setText:[NSString stringWithFormat:@"%0.0f",[slider value]]];
    
}
///[[RJFSliderView alloc] initWithFrame:CGRectMake(310, 109, 250, 100)]

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
