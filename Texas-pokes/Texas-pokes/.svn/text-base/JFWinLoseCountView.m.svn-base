//
//  JFWinLoseCountView.m
//  Texas-pokes
//
//  Created by ran on 13-1-30.
//
//

#import "JFWinLoseCountView.h"
#import "NSString+Number.h"
@implementation JFWinLoseCountView
@synthesize beforechip,nowchip,propChip;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}


-(id)initWithBeforeChip:(int32_t)ibeforechip nowchip:(int32_t)inowchip propChip:(int32_t)ipropChip
{
    CGRect  frame = [[UIScreen mainScreen] applicationFrame];
    self = [super initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.width)];
    if (self)
    {
        self.beforechip = ibeforechip;
        self.nowchip = inowchip;
        self.propChip = ipropChip;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        
        UIImageView  *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 295, 235)];
        bgView.image = [UIImage imageNamed:@"dzpk_losewin_frame.png"];
        bgView.center = self.center;
        [self addSubview:bgView];
        
        
        UIImageView  *imageViewbeauty = [[UIImageView alloc] initWithFrame:CGRectMake(0, 235-176, 131, 176)];
        imageViewbeauty.image = [UIImage imageNamed:@"dzpk_losewin_beauty.png"];
        [bgView addSubview:imageViewbeauty];
        [imageViewbeauty release];
        
        UILabel  *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, bgView.frame.size.width, 40)];
        labelTitle.text = NSLocalizedString(@"本轮输赢提示", nil);
        labelTitle.textAlignment = NSTextAlignmentCenter;
        labelTitle.textColor = [UIColor whiteColor];
        labelTitle.backgroundColor = [UIColor clearColor];
        labelTitle.font = [UIFont systemFontOfSize:24];
        [bgView addSubview:labelTitle];
        [labelTitle release];
        
        CGFloat   fheight = 235-150;
        CGFloat   fxpoint = bgView.frame.size.width/2-15;
        CGFloat   fsep = 4;
        UILabel   *labelBeforeChip = [[UILabel alloc] initWithFrame:CGRectMake(fxpoint, fheight, bgView.frame.size.width-fxpoint, 24)];
        
        
        labelBeforeChip.text = [NSString stringWithFormat:NSLocalizedString(@"之前筹码:%@", nil),[NSString stringWithNeedTranfanNumber:self.beforechip returnType:GAMESHOWTYPE]];
        labelBeforeChip.textColor = [UIColor whiteColor];
        labelBeforeChip.backgroundColor = [UIColor clearColor];
        labelBeforeChip.font = [UIFont systemFontOfSize:18];
        [bgView addSubview:labelBeforeChip];
        [labelBeforeChip release];
        
        fheight += 24+fsep;
        
        UILabel   *labelnowchip = [[UILabel alloc] initWithFrame:CGRectMake(fxpoint, fheight, bgView.frame.size.width-fxpoint, 24)];
        labelnowchip.text = [NSString stringWithFormat:NSLocalizedString(@"现在筹码:%@", nil),[NSString stringWithNeedTranfanNumber:self.nowchip returnType:GAMESHOWTYPE]];
        labelnowchip.textColor = [UIColor whiteColor];
        labelnowchip.backgroundColor = [UIColor clearColor];
        labelnowchip.font = [UIFont systemFontOfSize:18];
        [bgView addSubview:labelnowchip];
        [labelnowchip release];
        
        fheight += 24+fsep;
        
        
        UILabel   *labelpropchip = [[UILabel alloc] initWithFrame:CGRectMake(fxpoint, fheight, bgView.frame.size.width-fxpoint, 24)];
        labelpropchip.text = [NSString stringWithFormat:NSLocalizedString(@"购买道具:%@", nil),[NSString stringWithNeedTranfanNumber:self.propChip returnType:GAMESHOWTYPE]];
        labelpropchip.textColor = [UIColor whiteColor];
        labelpropchip.backgroundColor = [UIColor clearColor];
        labelpropchip.font = [UIFont systemFontOfSize:18];
        [bgView addSubview:labelpropchip];
        [labelpropchip release];
        fheight += 24+fsep;
        
        UILabel   *labelwinlosechip = [[UILabel alloc] initWithFrame:CGRectMake(fxpoint, fheight, fxpoint, 24)];
        
        if (self.beforechip-self.nowchip < 0)
        {
            labelwinlosechip.text = [NSString stringWithFormat:NSLocalizedString(@" 获得:+%@",nil), [NSString stringWithNeedTranfanNumber:self.nowchip-self.beforechip returnType:GAMESHOWTYPE]];
        }else
        {
            labelwinlosechip.text = [NSString stringWithFormat:NSLocalizedString(@" 减少:-%@",nil), [NSString stringWithNeedTranfanNumber:self.beforechip-self.nowchip returnType:GAMESHOWTYPE]];
           // labelwinlosechip.text = [NSString stringWithFormat:NSLocalizedString(@" 减少:-%d", nil),self.nowchip-self.beforechip];
        }
       
        labelwinlosechip.textColor = [UIColor redColor];
        labelwinlosechip.backgroundColor = [UIColor clearColor];
        labelwinlosechip.font = [UIFont systemFontOfSize:18];
        [bgView addSubview:labelwinlosechip];
        [labelwinlosechip release];
        
       // fheight += 24+fsep;
        
        
        
        [bgView release];
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

@end
