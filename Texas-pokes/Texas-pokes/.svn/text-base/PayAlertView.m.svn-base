//
//  PayAlertView.m
//  Texas-pokes
//
//  Created by popo on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PayAlertView.h"
#import "UserInfo.h"
@implementation PayAlertView
@synthesize delegate = delegate;
@synthesize viewBg = imageViewBg;

NSString  * const BNRREMOVEFROMSUPERVIEW = @"*BNRREMOVEFROMSUPERVIEW";



-(void)ClickAdd:(UIButton *)sender
{
    
    UILabel  *label =(UILabel *) [self viewWithTag:14];
    if (label.text && ![label.text isEqualToString:@""]) 
    {
        label.text = [NSString stringWithFormat:@"%d",[label.text intValue]+1];
    }
    NSString  *strNumber = label.text;
   // label = (UILabel *)[self viewWithTag:10];
   // NSString  *strSingGroup = [label text];
    label = (UILabel *)[self viewWithTag:11];
    NSString  *strSingPrice = [label text];


    strSingPrice = [NSString stringWithNeedTranfanstring:strSingPrice returnType:NORMALTYPE];
    label = (UILabel *)[self viewWithTag:12];
    if(m_bIsBeanToCHips)
    {
        
        strSingPrice = [[strSingPrice componentsSeparatedByString:@" "] objectAtIndex:0];
        NSString   *strTemp = [NSString stringWithNeedTranfanstring:[NSNumber numberWithInt:[strSingPrice intValue] * [strNumber intValue]] returnType:COMMOMTYPE];
        [label setText:[NSString stringWithFormat:@"%@ i豆",strTemp]];
    }else 
    {
        strSingPrice = [[strSingPrice componentsSeparatedByString:@" "] lastObject];
         NSString   *strTemp = [NSString stringWithNeedTranfanstring:[NSNumber numberWithInt:[strSingPrice intValue] * [strNumber intValue]] returnType:COMMOMTYPE];
        [label setText:[NSString stringWithFormat:@"%@",strTemp]];
    }

   // NSLog(@"singType:%@",strSingPrice);
    label = (UILabel *)[self viewWithTag:13];
    UserInfo   *Myuser = [UserInfo shareInstance];

    NSString   *strTemp = nil;
    if(m_bIsBeanToCHips)
    {
        strTemp = [NSString stringWithNeedTranfanstring:[NSNumber numberWithInt:Myuser.idou-[strSingPrice intValue] * [strNumber intValue]] returnType:COMMOMTYPE];
       // strSingPrice = [[strSingPrice componentsSeparatedByString:@" "] objectAtIndex:0];
        [label setText:[NSString stringWithFormat:@"%@ i豆",strTemp]];
    }else 
    {
       strTemp = [NSString stringWithNeedTranfanstring:[NSNumber numberWithInt:Myuser.userChips-[strSingPrice intValue] * [strNumber intValue]] returnType:COMMOMTYPE];
        [label setText:[NSString stringWithFormat:@"%@",strTemp]];
    }
    strTemp = [NSString stringWithNeedTranfanstring:strTemp returnType:NORMALTYPE];
    if ([strTemp intValue] < 0) 
    {
     
        [RJFWarnView addinSelfview:[self superview] delegate:nil message:@"提示\n\n账户余额不足，请充值" buttontype:INSUREBUTTON InsureButton:@"确定" CancelButton:nil];
        [self ClickDelete:nil];
    }
    
    
}

-(void)ClickDelete:(UIButton *)sender
{
    UILabel  *label =(UILabel *) [self viewWithTag:14];
    if (label.text && ![label.text isEqualToString:@""]) 
    {
        if ([label.text isEqualToString:@"0"])
        {
            return;
        }
        label.text = [NSString stringWithFormat:@"%d",[label.text intValue]-1];
    }
    NSString  *strNumber = label.text;

    label = (UILabel *)[self viewWithTag:11];
    NSString  *strSingPrice = [label text];
    
    
    strSingPrice = [NSString stringWithNeedTranfanstring:strSingPrice returnType:NORMALTYPE];
    label = (UILabel *)[self viewWithTag:12];
    if(m_bIsBeanToCHips)
    {
        
        strSingPrice = [[strSingPrice componentsSeparatedByString:@" "] objectAtIndex:0];
        NSString   *strTemp = [NSString stringWithNeedTranfanstring:[NSNumber numberWithInt:[strSingPrice intValue] * [strNumber intValue]] returnType:COMMOMTYPE];
        [label setText:[NSString stringWithFormat:@"%@ i豆",strTemp]];
    }else 
    {
        strSingPrice = [[strSingPrice componentsSeparatedByString:@" "] lastObject];
        NSString   *strTemp = [NSString stringWithNeedTranfanstring:[NSNumber numberWithInt:[strSingPrice intValue] * [strNumber intValue]] returnType:COMMOMTYPE];
        [label setText:[NSString stringWithFormat:@"%@",strTemp]];
    }
    
  //  NSLog(@"singType:%@",strSingPrice);
    label = (UILabel *)[self viewWithTag:13];
    UserInfo   *Myuser = [UserInfo shareInstance];
    
    if(m_bIsBeanToCHips)
    {
        NSString   *strTemp = [NSString stringWithNeedTranfanstring:[NSNumber numberWithInt:Myuser.idou-[strSingPrice intValue] * [strNumber intValue]] returnType:COMMOMTYPE];
        // strSingPrice = [[strSingPrice componentsSeparatedByString:@" "] objectAtIndex:0];
        [label setText:[NSString stringWithFormat:@"%@ i豆",strTemp]];
    }else 
    {
        NSString   *strTemp = [NSString stringWithNeedTranfanstring:[NSNumber numberWithInt:Myuser.userChips-[strSingPrice intValue] * [strNumber intValue]] returnType:COMMOMTYPE];
        [label setText:[NSString stringWithFormat:@"%@",strTemp]];
    }
}
-(void)ClickInsureExchange:(UIButton *)sender
{
    

    
    UILabel *label = (UILabel *)[self viewWithTag:10];
    NSString  *strSing = label.text;
    if (m_bIsBeanToCHips) 
    {
        strSing = [[strSing componentsSeparatedByString:@" "] lastObject];
    }else 
    {
        strSing = [[strSing componentsSeparatedByString:@" "] objectAtIndex:0];
    }
    strSing = [NSString stringWithNeedTranfanstring:strSing returnType:NORMALTYPE];
    label = (UILabel *)[self viewWithTag:14];
    NSString  *strNumber = label.text;
    
    NSString  *strTotalAddNumber = [NSString stringWithFormat:@"%lld",[strSing longLongValue]*[strNumber longLongValue]];
    label = (UILabel *)[self viewWithTag:13];
    NSString  *strNowNumber = label.text;
    
    
    NSDictionary  *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:strTotalAddNumber,@"TOTALADDNUMBER",strNowNumber,@"NOWNUMBER",[NSNumber numberWithBool:m_bIsBeanToCHips],@"ISBEANTOCHIP",nil];
    
    
    if (delegate && [delegate respondsToSelector:@selector(ClickInsureExchange:)]) 
    {
        [delegate ClickInsureExchange:dicInfo];
    }
    if ([self superview]) 
    {
        [self removeFromSuperview];
    }
    
}
-(void)ClickCancelExchange:(UIButton *)sender
{
    if (delegate && [delegate respondsToSelector:@selector(ClickCancelExchange:)]) 
    {
        [delegate ClickCancelExchange:sender];
    }
    if ([self superview]) 
    {
        [self removeFromSuperview];
    }
     NSLog(@"Cancel");
    
}
-(void)ClickAliPay:(UIButton *)button
{
    if (delegate && [delegate respondsToSelector:@selector(ClickAliPay:)]) 
    {
        [delegate ClickAliPay:button];
    }
    if ([self superview]) 
    {
        [self removeFromSuperview];
    }
    
    
}
-(void)ClickYiPay:(UIButton *)button
{
    if (delegate && [delegate respondsToSelector:@selector(ClickYiPay:)]) 
    {
        [delegate ClickYiPay:button];
    }
    if ([self superview]) 
    {
        [self removeFromSuperview];
    }
    
}
-(void)ClickClose:(UIButton *)button
{
    if (delegate && [delegate respondsToSelector:@selector(ClickClose:)]) 
    {
        [delegate ClickClose:button];
    }
    if ([self superview]) 
    {
        [self removeFromSuperview];
    }
    
}


-(void)ClickCloseSelf:(UIButton *)button
{
    if (delegate && [delegate respondsToSelector:@selector(ClickClose:)]) 
    {
        [delegate ClickClose:button];
    }
    if ([self superview]) 
    {
        [self removeFromSuperview];
    }
    
}
- (id)initWithFrame:(CGRect)frame withIbeans:(NSString *)strIBeans WithMoney:(NSString *)strMonney
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        NSNotificationCenter  *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self 
               selector:@selector(ClickClose:)
                   name:BNRREMOVEFROMSUPERVIEW
                 object:nil];
        
        
        CGFloat    fwidthword = 20;
        imageViewBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imageViewBg.image = [UIImage imageNamed:@"popview.png"];
        imageViewBg.userInteractionEnabled = YES;
        [self addSubview:imageViewBg];
        CGFloat  fbtnWidth = 165;
        CGFloat  fbtnHeight = 62;
        CGFloat    fNowHeight = 80;
        UIButton  *button = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.width-fbtnWidth)/2,fNowHeight, fbtnWidth, fbtnHeight)];
        [button setImage:[UIImage imageNamed:@"Alipay.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(ClickAliPay:) forControlEvents:UIControlEventTouchUpInside];
        [imageViewBg addSubview:button];
        [button release];
        
        
        UIFont  *font = [UIFont systemFontOfSize:18];
        
        UILabel   *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, fwidthword*5, 31)];
        [label1 setText:@"您选择充值"];
        [label1 setBackgroundColor:[UIColor clearColor]];
        [label1 setFont:font];
        [label1 setTextColor:[UIColor whiteColor]];
        [imageViewBg addSubview:label1];
        [label1 setTextAlignment:NSTextAlignmentLeft];
        [label1 release];
        
        
        
        UILabel   *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10+fwidthword*5, 5,fwidthword*3, 31)];
        [label2 setText:strIBeans];
        [label2 setBackgroundColor:[UIColor clearColor]];
        [label2 setFont:font];
        [label2 setTextColor:[UIColor yellowColor]];
        [imageViewBg addSubview:label2];
        [label2 setTextAlignment:NSTextAlignmentLeft];
        [label2 release];
        
        UILabel   *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10+fwidthword*8+5, 5, fwidthword*5, 31)];
        [label3 setText:@",需要支付"];
        [label3 setBackgroundColor:[UIColor clearColor]];
        [label3 setFont:font];
        [label3 setTextColor:[UIColor whiteColor]];
        [imageViewBg addSubview:label3];
        [label3 setTextAlignment:NSTextAlignmentLeft];
        [label3 release];
        
        
        
        UILabel   *label4 = [[UILabel alloc] initWithFrame:CGRectMake(fwidthword*13-5, 5,fwidthword*2+40, 31)];
        [label4 setTextAlignment:NSTextAlignmentLeft];
        [label4 setText:[@"￥" stringByAppendingString:strMonney]];
        [label4 setBackgroundColor:[UIColor clearColor]];
        [label4 setEnabled:YES];
        [label4 setFont:font];
        [label4 setTextColor:[UIColor yellowColor]];
        [imageViewBg addSubview:label4];
        
        
        UILabel   *label5 = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width-fwidthword*7)/2,5+31+5,fwidthword*7, 31)];
        [label5 setText:@"请选择支付方式"];
        [label5 setBackgroundColor:[UIColor clearColor]];
        [label5 setFont:font];
        [label5 setTextColor:[UIColor whiteColor]];
        [imageViewBg addSubview:label5];
        [label5 release];
        
        UIButton  *buttonYiPay = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.width-fbtnWidth)/2,fNowHeight+fbtnHeight+5, fbtnWidth, fbtnHeight)];
        [buttonYiPay setImage:[UIImage imageNamed:@"Yipay.png"] forState:UIControlStateNormal];
        [buttonYiPay addTarget:self action:@selector(ClickYiPay:) forControlEvents:UIControlEventTouchUpInside];
        [imageViewBg addSubview:buttonYiPay];
        [buttonYiPay release];
        
        //UIButton *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-30,5,25, 25)];
        UIButton *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-30,5,25, 25)];

        // UIButton *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(0,120,40, 40)];
        [btnClose setBackgroundImage:[UIImage imageNamed:@"popview_close.png"] forState:UIControlStateNormal];
        [btnClose addTarget:self action:@selector(ClickCloseSelf:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnClose];
        [label4 release];
        [btnClose release];
        
        [imageViewBg release];
        // Initialization code
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame withIbeans:(NSString *)strIBeans WithChips:(NSString *)strChip BeanToCHips:(BOOL)bIsBeanToCHips
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        m_bIsBeanToCHips = bIsBeanToCHips;
        NSNotificationCenter  *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self 
               selector:@selector(ClickClose:)
                   name:BNRREMOVEFROMSUPERVIEW
                 object:nil];
        
        
        //CGFloat    fwidthword = 20;
        CGFloat      fFirstheight = 30;
        CGFloat      fheight = 25;
        CGFloat      fYpoint = 160;
        imageViewBg = [[UIImageView alloc] initWithFrame:frame];
        imageViewBg.image = [UIImage imageNamed:@"popview.png"];
        imageViewBg.userInteractionEnabled = YES;
        [self addSubview:imageViewBg];
        UIFont          *font = [UIFont systemFontOfSize:16];
        
        
        UILabel         *label  = [[UILabel alloc] initWithFrame:CGRectMake(40, fFirstheight, 100, fheight)];
        if (bIsBeanToCHips) 
        {
           [label setText:@"单组筹码："]; 
            
        }else 
        {
            [label setText:@"单组i豆："];
        }
        
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:font];
        [imageViewBg addSubview:label];
        [label release];
        
        UILabel         *label1  = [[UILabel alloc] initWithFrame:CGRectMake(40, fFirstheight+fheight+5, 100, fheight)];
        [label1 setText:@"单价："];
        [label1 setBackgroundColor:[UIColor clearColor]];
        [label1 setTextColor:[UIColor whiteColor]];
        [label1 setFont:font];
        [imageViewBg addSubview:label1];
        [label1 release];
        
        UILabel         *label2  = [[UILabel alloc] initWithFrame:CGRectMake(40, fFirstheight+fheight*2+fheight/2, 100, fheight)];
        [label2  setText:@"数量："];
        [label2  setBackgroundColor:[UIColor clearColor]];
        [label2  setTextColor:[UIColor whiteColor]];
        [label2  setFont:font];
        [imageViewBg addSubview:label2];
        [label2  release];
        
        UILabel         *label3  = [[UILabel alloc] initWithFrame:CGRectMake(40, fFirstheight+fheight*3+fheight/2+5*3, 100, fheight)];
        [label3  setText:@"总价："];
        [label3  setBackgroundColor:[UIColor clearColor]];
        [label3  setTextColor:[UIColor whiteColor]];
        [label3  setFont:font];
        [imageViewBg addSubview:label3];
        [label3  release];
        
        UILabel         *label4  = [[UILabel alloc] initWithFrame:CGRectMake(40, fFirstheight+fheight*4+fheight/2+5*4, 100, fheight)];
        [label4  setText:@"账户剩余："];
        [label4  setBackgroundColor:[UIColor clearColor]];
        [label4  setTextColor:[UIColor whiteColor]];
        [label4  setFont:font];
        [imageViewBg addSubview:label4];
        [label4  release];
        
        
        //right
        UILabel         *labelChips  = [[UILabel alloc] initWithFrame:CGRectMake(fYpoint, fFirstheight, 100, fheight)];
        if (m_bIsBeanToCHips) 
        {
             [labelChips  setText:strChip];
            UIImageView  *imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(fYpoint+10, fFirstheight+5, 15, 15)];
            imageView.image = [UIImage imageNamed:@"small_chips.png"];
            [imageViewBg addSubview:imageView];
            [imageView release];
            
        }else 
        {
             [labelChips  setText:strIBeans];
        }
       
        labelChips.tag  = 10;
        [labelChips  setBackgroundColor:[UIColor clearColor]];
        [labelChips  setTextColor:[UIColor whiteColor]];
        [labelChips  setFont:font];
        [imageViewBg addSubview:labelChips];
        [labelChips setTextAlignment:NSTextAlignmentRight];
        [labelChips  release];
        
        
        
        UILabel         *labeliBeans  = [[UILabel alloc] initWithFrame:CGRectMake(fYpoint, fFirstheight+fheight+5, 100, fheight)];
        if (m_bIsBeanToCHips) 
        {
            [labeliBeans  setText:strIBeans];
        }else 
        {
            UIImageView  *imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(fYpoint+10, fFirstheight+fheight+5+5, 15, 15)];
            imageView.image = [UIImage imageNamed:@"small_chips.png"];
            [imageViewBg addSubview:imageView];
            [imageView release];
            strChip = [NSString stringWithNeedTranfanstring:strChip returnType:COMMOMTYPE];
            [labeliBeans  setText:strChip];
        }
        labeliBeans.tag  = 11;
        [labeliBeans  setBackgroundColor:[UIColor clearColor]];
        [labeliBeans  setTextColor:[UIColor whiteColor]];
        [labeliBeans  setFont:font];
        [imageViewBg addSubview:labeliBeans];
        [labeliBeans setTextAlignment:NSTextAlignmentRight];
        [labeliBeans  release];
        
        
      
        UserInfo  *userInfo = [UserInfo shareInstance];
        NSInteger  iBeans = [[[strIBeans componentsSeparatedByString:@" "] objectAtIndex:0] intValue];
        
        
        UILabel         *labeltotalPrice  = [[UILabel alloc] initWithFrame:CGRectMake(fYpoint, fFirstheight+fheight*3+fheight/2+5*3, 100, fheight)];
        if (bIsBeanToCHips) 
        {
            [labeltotalPrice  setText:[NSString stringWithFormat:@"%d i豆",iBeans]]; 
        }else 
        {
            UIImageView  *imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(fYpoint+10, fFirstheight+fheight*3+fheight/2+5*3+5, 15, 15)];
            imageView.image = [UIImage imageNamed:@"small_chips.png"];
            [imageViewBg addSubview:imageView];
            [imageView release];
            [labeliBeans  setText:strChip];
            [labeltotalPrice setText:[NSString stringWithFormat:@"%@",strChip]];
        }
       
        labeltotalPrice.tag  = 12;
        [labeltotalPrice  setBackgroundColor:[UIColor clearColor]];
        [labeltotalPrice  setTextColor:[UIColor whiteColor]];
        [labeltotalPrice  setFont:font];
        [imageViewBg addSubview:labeltotalPrice];
        [labeltotalPrice setTextAlignment:NSTextAlignmentRight];
        [labeltotalPrice  release];
        
        
        UILabel         *labelleftBeans  = [[UILabel alloc] initWithFrame:CGRectMake(fYpoint, fFirstheight+fheight*4+fheight/2+5*4, 100, fheight)];
        iBeans = userInfo.idou-iBeans;
        if (m_bIsBeanToCHips) 
        {
             [labelleftBeans  setText:[NSString stringWithFormat:@"%d i豆",iBeans]];
        }else 
        {
            strChip = [NSString stringWithNeedTranfanstring:strChip returnType:NORMALTYPE];
            strChip = [NSString stringWithNeedTranfanstring:[NSNumber numberWithInt:userInfo.userChips-[strChip intValue]] returnType:COMMOMTYPE];
            UIImageView  *imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(fYpoint+10,fFirstheight+fheight*4+fheight/2+5*4+5, 15, 15)];
            imageView.image = [UIImage imageNamed:@"small_chips.png"];
            [imageViewBg addSubview:imageView];
            [imageView release];
             [labelleftBeans  setText:[NSString stringWithFormat:@"%@",strChip]];
        }
       
        labelleftBeans.tag  = 13;
        [labelleftBeans  setBackgroundColor:[UIColor clearColor]];
        [labelleftBeans  setTextColor:[UIColor whiteColor]];
        [labelleftBeans  setFont:font];
        [imageViewBg addSubview:labelleftBeans];
        [labelleftBeans setTextAlignment:NSTextAlignmentRight];
        [labelleftBeans  release];
        
        UIButton   *btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(fYpoint, fFirstheight+fheight*2+5, 40, 40)];
        [btnAdd setImage:[UIImage imageNamed:@"charge_add.png"] forState:UIControlStateNormal];
        [btnAdd addTarget:self action:@selector(ClickAdd:) forControlEvents:UIControlEventTouchUpInside];
        [imageViewBg addSubview:btnAdd];
        [btnAdd release];
        
        UIButton   *btnDelete = [[UIButton alloc] initWithFrame:CGRectMake(fYpoint+120, fFirstheight+fheight*2+5, 40, 40)];
        [btnDelete setImage:[UIImage imageNamed:@"charge_delete.png"] forState:UIControlStateNormal];
        [btnDelete addTarget:self action:@selector(ClickDelete:) forControlEvents:UIControlEventTouchUpInside];
        [imageViewBg addSubview:btnDelete];
        [btnDelete release];
        
        UIImageView    *numberView = [[UIImageView alloc] initWithFrame:CGRectMake(fYpoint+60,fFirstheight+fheight*2+10, 50, 25)];
        numberView.image = [UIImage imageNamed:@"charge_number.png"];
        [imageViewBg addSubview:numberView];
        
        
        
        UILabel         *labeliNumber  = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 48, 25)];
        [labeliNumber  setText:@"1"];
        labeliNumber.tag  = 14;
        [labeliNumber  setBackgroundColor:[UIColor clearColor]];
        [labeliNumber  setTextColor:[UIColor redColor]];
        [labeliNumber  setFont:font];
        [labeliNumber setTextAlignment:NSTextAlignmentCenter];
        [numberView addSubview:labeliNumber];
        [labeliNumber  release];
        
        UIButton   *btnInsure = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-35-90,fFirstheight+fheight*5+fheight/2+5*7, 90, 40)];
        [btnInsure setTitle:CANCEL forState:UIControlStateNormal];
        [btnInsure setBackgroundImage:[UIImage imageNamed:@"button_orange.png"] forState:UIControlStateNormal];
        [btnInsure addTarget:self action:@selector(ClickCancelExchange:) forControlEvents:UIControlEventTouchUpInside];
        [imageViewBg addSubview:btnInsure];
        [btnInsure release];
        
        UIButton   *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(35,fFirstheight+fheight*5+fheight/2+5*7, 90, 40)];
        [btnCancel setBackgroundImage:[UIImage imageNamed:@"button_green.png"] forState:UIControlStateNormal];
        [btnCancel setTitle:INSURE forState:UIControlStateNormal];
        [btnCancel addTarget:self action:@selector(ClickInsureExchange:) forControlEvents:UIControlEventTouchUpInside];
        [imageViewBg addSubview:btnCancel];
        [btnCancel release];
        
        
         UIImageView         *imageline  = [[UIImageView alloc] initWithFrame:CGRectMake(3,fFirstheight+fheight*3+fheight/2+5*2,frame.size.width-6, 2)];
        [imageline setImage:[UIImage imageNamed:@"devideline"]];
        [imageViewBg addSubview:imageline];
        [imageline release];
        
        
        [numberView release];
        [imageViewBg release];
        // Initialization code
    }
    return self;
}


-(void)dealloc
{

   // NSNotificationCenter  *nc = [NSNotificationCenter defaultCenter];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
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
