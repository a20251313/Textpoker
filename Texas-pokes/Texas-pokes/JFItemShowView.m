//
//  JFItemShowView.m
//  Texas-pokes
//
//  Created by ran on 13-1-22.
//
//


#import "JFItemShowView.h"
#import "PublicDefine.h"

@implementation JFItemShowView
@synthesize labelChip,numberView,seatID,delegate,arrayTags,arrayPrices;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        seatID = -1;
        // Initialization code
    }
    return self;
}

- (id)initWithitems:(NSArray *)items prices:(NSArray *)prices withTags:(NSArray *)iarrayTags withFrame:(CGRect)frame maxValue:(int32_t)chipMax;
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        int32_t   maxChipnumber = 0;
        UIScrollView   *scrowView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 1, frame.size.width, 60)];
        scrowView.showsHorizontalScrollIndicator = NO;
        scrowView.pagingEnabled = NO;
        CGFloat   fwidth = 20;
        CGFloat   fimageViewwidth = 38;
        CGFloat  fsep = 22;
        self.arrayPrices = prices;
        self.arrayTags = iarrayTags;
        
        if ([self.arrayPrices count] &&
            [self.arrayTags count])
        {
            maxChipnumber = [[self.arrayPrices objectAtIndex:0] intValue];
        }
        for (int i = 0; i < [items count]; i++)
        {
            
            BOOL     bAddTap = YES;
            UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(fwidth, 1, fimageViewwidth, fimageViewwidth)];
            imageView.userInteractionEnabled = YES;
            NSString   *strimageName = [items objectAtIndex:i];
            if ([strimageName rangeOfString:@"gray"].location != NSNotFound)
            {
                imageView.image = [UIImage imageNamed:@"dzpk_no_prop.png"];
                bAddTap = NO;
            }else
            {
                imageView.image = [UIImage imageNamed:@"dzpk_yes_prop.png"];
            }
            
            UIImageView  *contentView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, fimageViewwidth-1, fimageViewwidth-1)];
            [imageView addSubview:contentView];
            contentView.userInteractionEnabled = YES;
            contentView.image = [UIImage imageNamed:strimageName];
          
            
            if (bAddTap)
            {
                UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(moveAni:)];
                [contentView addGestureRecognizer:tap];
                if ([iarrayTags count] > i+1)
                {
                    contentView.tag = [[iarrayTags objectAtIndex:i+1] integerValue];
                }
                
                [tap release];
                
            }
        
            
            
            [contentView release];
            [scrowView addSubview:imageView];
            
            CGFloat  fconwidth = [iarrayTags count]*1.0f*(frame.size.width/6)*1.0f;
            
            scrowView.contentSize = CGSizeMake(fconwidth, scrowView.frame.size.height);
            [imageView release];
            
            UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(fwidth-13, fimageViewwidth, 70, 15)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:10];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [NSString stringWithFormat:@"%@",[prices objectAtIndex:i+1]];
            [scrowView addSubview:label];
            [label release];
            
            
            fwidth += fimageViewwidth+fsep;     
        }
        
          [self addSubview:scrowView];
        UISlider   *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, fimageViewwidth+25, 200, 12.5)];
        
        if (chipMax > 0)
        {
            [slider setMinimumValue:1];
            [slider setMaximumValue:chipMax];
        }else
        {
            [slider setMinimumValue:1];
            [slider setMaximumValue:maxChipnumber];
            [slider setEnabled:NO];
            
        }
       
        [slider setValue:1];
      
        UIImage *tagertImage = [UIImage imageNamed:@"dzpk_profile_chip_bg.png"];
        UIImage *maximumTrackImage = [UIImage imageNamed:@"dzpk_profile_chip_line.png"];
        tagertImage = [UIImage imageByScalingAndCroppingForSize:CGSizeMake(tagertImage.size.width, 12.5) sourceImages:tagertImage];
        maximumTrackImage = [UIImage imageByScalingAndCroppingForSize:CGSizeMake(maximumTrackImage.size.width, 12.5) sourceImages:maximumTrackImage];
        [slider setMinimumTrackImage:maximumTrackImage forState:UIControlStateNormal];
        [slider setMaximumTrackImage:tagertImage forState:UIControlStateNormal];
        [slider addTarget:self
                   action:@selector(slideValue:) forControlEvents:UIControlEventValueChanged];
        UIImage  *imageSourse = [UIImage imageNamed:@"dzpk_profile_rollbtn.png"];
        UIImage *image = [UIImage imageByScalingAndCroppingForSize:CGSizeMake(imageSourse.size.width/3*2, imageSourse.size.height/3*2) sourceImages:imageSourse];
          [slider setThumbImage:image forState:UIControlStateNormal];
        
        [self addSubview:slider];
        
        
        
        UIButton            *btnGift = [[UIButton alloc] initWithFrame:CGRectMake(250, fimageViewwidth+20, 95, 35)];
        [btnGift setBackgroundImage:[UIImage imageNamed:@"dzpk_profile_giftchip.png"] forState:UIControlStateNormal];
        [btnGift setTitle:@"赠送" forState:UIControlStateNormal];
        [btnGift setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        
        UIEdgeInsets   edge = {0,30,0,0};
        [btnGift setTitleEdgeInsets:edge];
      
       // [btnGift setTitleEdgeInsets:];
        /*[btnGift addTarget:self
                    action:@selector(giftTofriends:) forControlEvents:UIControlEventTouchUpInside];*/
        
        numberView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btnGift.frame.size.width, btnGift.frame.size.height)];
        numberView.image = [UIImage imageNamed:@"dzpk_profile_giftchipnumber.png"];
        [btnGift addSubview:numberView];
        numberView.userInteractionEnabled = YES;
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(giftTofriends:)];
        [numberView addGestureRecognizer:tap];
        labelChip = [[UILabel alloc] initWithFrame:CGRectMake(9, 7, 40, 21)];
        labelChip.backgroundColor = [UIColor clearColor];
        labelChip.textColor = [UIColor blackColor];
        labelChip.font = [UIFont systemFontOfSize:13];
        labelChip.text = @"1";
        labelChip.textAlignment = NSTextAlignmentLeft;
        [numberView addSubview:labelChip];
       // [labelChip release];
        [tap release];
        //[numberView release];
        [slider release];
        [self addSubview:btnGift];
        [btnGift release];
        [scrowView release];
        
        
        // Initialization code
    }
    return self;
}


-(void)moveAni:(UITapGestureRecognizer *)tap
{
    if (delegate && [delegate respondsToSelector:@selector(AddAnimationWithSeatID:tag:withChip:)])
    {
        int   tag = tap.view.tag;
        int32_t   chips = [[self.arrayPrices objectAtIndex:tag] intValue];
       /* for (int i = 0;i < [self.arrayTags count];i++)
        {
            NSNumber   *number = [self.arrayTags objectAtIndex:i];
            if (tag == [number intValue])
            {
               
                break;
            }
        }*/
        [delegate AddAnimationWithSeatID:self.seatID tag:tag withChip:chips];
    }

    logMyLogInfo(@"moveAni:%@ view:%@ tag:%d",tap,tap.view,tap.view.tag);
}


-(void)giftTofriends:(UIButton *)sender
{
    if (delegate && [delegate respondsToSelector:@selector(GiftChipTofriend:chip:)])
    {
        [delegate GiftChipTofriend:self.seatID chip:[labelChip.text intValue]];
    }
    logMyLogInfo(@"giftTofriends:%@",sender);
}
-(void)slideValue:(UISlider *)slider
{
    labelChip.text = [NSString stringWithFormat:@"%.0f",[slider value]];
    NSLog(@"slideValue:%f",[slider value]);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)dealloc
{
    if (numberView)
    {
        [numberView release];
        numberView = nil;
    }
    if (labelChip)
    {
        [labelChip release];
        labelChip = nil;
    }
    [super dealloc];
}

@end
