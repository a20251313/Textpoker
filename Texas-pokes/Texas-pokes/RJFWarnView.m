//
//  RJFWarnView.m
//  Texas-pokes
//
//  Created by popo on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFWarnView.h"
#import "PublicDefine.h"

#define WARNINGHEIGHT           236
@implementation RJFWarnView

static  RJFWarnView  *warninig = nil;
@synthesize delegate = m_delegate;
@synthesize mainView;

//warninig = [[RJFWarnView alloc] initWithFrame:CGRectMake(60, 25,330, 215)];
#pragma mark self define method
/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *         generate a share instance
 *	@return
 *          the share instance of class RJFWarinView
 *
 */
+(id)shareInstance
{
    
    if (!warninig)
    {
        warninig = [[RJFWarnView alloc] initWithFrame:CGRectMake((SCREENWIDTH-295)/2, 25,295, 236)];
    }
    
    
    return warninig;
}



/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *          add thw view i super view
 *  @param
 *          uiview
 *             superView
 *  @param
 *          delegate
 *              delegate
 *  @param
 *          strMessage
 *              WarningMessage
 *  @param
 *          iType
 *              button type(BUTTONSHOWTYPE enum)
 *  @param
 *          strInsuretitle
 *              insure button title
 *  @param
 *          strCancelTitle
 *              cancel button title
 *	@return
 *          NONE
 *
 */
-(void)addinSelfview:(UIView *)uiview
            delegate:(id)delegate
             message:(NSString *)strMessage
          buttontype:(BUTTONSHOWTYPE)iType
        InsureButton:(NSString *)strInsuretitle
        CancelButton:(NSString *)strCancelTitle
{
  
    setAllViewEnable(NO, uiview);
    [self setDelegate:delegate];
    if (self.delegate == nil && delegate != nil)
    {
        logMyLogInfo(@"assgin delegate fail,assgin again");
        [self setDelegate:delegate];
    }
    self.mainView = uiview;
    [uiview addSubview:self];
    [uiview endEditing:YES];
    [TextwarningMessage setText:strMessage];
    /* NSMutableAttributedString  *atrString = [[NSMutableAttributedString alloc] initWithString:strMessage];
     
     [atrString setTextColor:[UIColor whiteColor] range:[strMessage rangeOfString:strMessage]];
     if ([strMessage rangeOfString:INSURE].location != NSNotFound)
     {
     [atrString setTextColor:[UIColor orangeColor] range:[strMessage rangeOfString:INSURE]];
     }
     [atrString setFont:[UIFont systemFontOfSize:16]];
     [atrString setTextAlignment:kCTCenterTextAlignment
     lineBreakMode:kCTLineBreakByTruncatingMiddle
     range:[strMessage rangeOfString:strMessage]];
     [LabelwarningMessage setAttributedText:atrString];
     [LabelwarningMessage setNumberOfLines:5];*/
    
    CGFloat   faddhieght = 0;
    if ([strMessage length] > 50 && self.frame.size.height == WARNINGHEIGHT)
    {
        faddhieght = 0;
    }else if(self.frame.size.height > WARNINGHEIGHT)
    {
        faddhieght = -0;
    }
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+faddhieght)];
    [TextwarningMessage setFrame:CGRectMake(TextwarningMessage.frame.origin.x,TextwarningMessage.frame.origin.y,TextwarningMessage.frame.size.width,TextwarningMessage.frame.size.height+faddhieght)];
    
    float count = 2.5;
    
    // CGFloat  fbtnheight = 90+fad
    switch (iType)
    {
            
        case BOTHBUTTON:
            [btnInsure setHidden:NO];
            [btnCancel setHidden:NO];
            
            [btnInsure setFrame:CGRectMake(20,self.frame.size.height-20*count, 90, 31)];
            [btnCancel setFrame:CGRectMake(self.frame.size.width-40-90, self.frame.size.height-20*count, 90, 31)];
            [btnCancel setTitle:strCancelTitle forState:UIControlStateNormal];
            [btnInsure setTitle:strInsuretitle forState:UIControlStateNormal];
            break;
        case CANCELBUTTON:
            [btnCancel setHidden:NO];
            [btnCancel setFrame:CGRectMake(self.frame.size.width/2-45, self.frame.size.height-20*count, 90, 31)];
            [btnCancel setTitle:strCancelTitle forState:UIControlStateNormal];
            
            [btnInsure setHidden:YES];
            break;
        case INSUREBUTTON:
            [btnInsure setHidden:NO];
            [btnInsure setTitle:strInsuretitle forState:UIControlStateNormal];
            [btnInsure setFrame:CGRectMake(self.frame.size.width/2-45, self.frame.size.height-20*count, 90, 31)];
            [btnCancel setHidden:YES];
            break;
            
        default:
            break;
    }
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *         set share delegate nil
 *	@return
 *          NONE
 *
 */
+(void)setnilDelegate
{
    if (warninig)
    {
        warninig.delegate = nil;
    }
}



/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *          add th3 view in super view(class method)
 *  @param
 *          uiview
 *             superView
 *  @param
 *          delegate
 *              delegate
 *  @param
 *          strMessage
 *              WarningMessage
 *  @param
 *          iType
 *              button type(BUTTONSHOWTYPE enum)
 *  @param
 *          strInsuretitle
 *              insure button title
 *  @param
 *          strCancelTitle
 *              cancel button title
 *	@return
 *          NONE
 *
 */
+(void)addinSelfview:(UIView *)uiview
            delegate:(id)delegate
             message:(NSString *)strMessage
          buttontype:(BUTTONSHOWTYPE)iType
        InsureButton:(NSString *)strInsuretitle
        CancelButton:(NSString *)strCancelTitle
{
    if (!warninig)
    {
        warninig = [RJFWarnView shareInstance];
    }
    
 
    
       
    
    
    [warninig addinSelfview:uiview
                   delegate:delegate
                    message:strMessage
                 buttontype:iType
               InsureButton:strInsuretitle
               CancelButton:strCancelTitle];
    
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *          if delegate != nil,call delegate method
 *  @param
 *          sender
 *            insure button
 *	@return
 *          NONE
 *
 */
-(void)clickInsure:(UIButton *)sender
{
     setAllViewEnable(YES, self.mainView);
    //[self SetAllSubViewsButtonEnable:[[[UIApplication sharedApplication] windows] objectAtIndex:0] bEnable:YES];
    [self removeFromSuperview];
    if (m_delegate)
    {
        if ([m_delegate respondsToSelector:@selector(ClickInsure:)])
        {
            [m_delegate ClickInsure:sender];
        }
    }
    
    logMyLogInfo(@"insure");
    
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *          if delegate != nil,call delegate method
 *  @param
 *          sender
 *            cancel button
 *	@return
 *          NONE
 *
 */
-(void)clickCancel:(UIButton *)sender
{
    setAllViewEnable(YES, self.mainView);
  //  [self SetAllSubViewsButtonEnable:[[[UIApplication sharedApplication] windows] objectAtIndex:0] bEnable:YES];
    [self removeFromSuperview];
    if (m_delegate)
    {
        if ([m_delegate respondsToSelector:@selector(ClickCancel:)])
        {
            [m_delegate ClickCancel:sender];
        }
    }
    logMyLogInfo(@"cancel");
}


#pragma mark override method
/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *          init method(override)
 *  @param
 *          frame
 *            frame
 *	@return
 *          id(self)
 *
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        imageViewbg = [[UIImageView alloc] initWithFrame:self.bounds];
        imageViewbg.userInteractionEnabled = YES;
        imageViewbg.image = [UIImage imageNamed:@"popview.png"];
        TextwarningMessage  = [[UITextView alloc] initWithFrame:CGRectMake(10,20, frame.size.width-20, frame.size.height-20*3.5)];
        TextwarningMessage.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
        [TextwarningMessage setBackgroundColor:[UIColor clearColor]];
        [TextwarningMessage setTextColor:[UIColor whiteColor]];
        [TextwarningMessage setText:@"are you ok?"];
        [TextwarningMessage setTextAlignment:NSTextAlignmentCenter];
        [TextwarningMessage setFont:[UIFont systemFontOfSize:16]];
        [TextwarningMessage setTextAlignment:NSTextAlignmentCenter];
        [TextwarningMessage setEditable:NO];
        TextwarningMessage.userInteractionEnabled = NO;
        
        
        
        
        btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(20, frame.size.height-20*3, 90, 31)];
        btnInsure = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-40-90, frame.size.height-20*3, 90, 31)];
        [btnCancel setBackgroundImage:[UIImage imageNamed:@"button_orange.png"] forState:UIControlStateNormal];
        [btnInsure setBackgroundImage:[UIImage imageNamed:@"button_green.png"] forState:UIControlStateNormal];
        [btnInsure setTitle:INSURE forState:UIControlStateNormal];
        [btnCancel setTitle:CANCEL forState:UIControlStateNormal];
        [btnCancel addTarget:self
                      action:@selector(clickCancel:)
            forControlEvents:UIControlEventTouchUpInside];
        [btnInsure addTarget:self
                      action:@selector(clickInsure:)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:imageViewbg];
        [imageViewbg addSubview:TextwarningMessage];
        [imageViewbg addSubview:btnInsure];
        [imageViewbg addSubview:btnCancel];
        [btnCancel release];
        [btnInsure release];
        [imageViewbg release];
        [TextwarningMessage release];
        // Initialization code
    }
    return self;
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *          dealloc method(override)
 *	@return
 *          id(self)
 *
 */
-(void)dealloc
{
    if (btnCancel)
    {
        [btnCancel release];
        btnCancel = nil;
    }
    if (btnInsure)
    {
        [btnInsure release];
        btnInsure = nil;
    }
    if (TextwarningMessage)
    {
        [TextwarningMessage release];
        TextwarningMessage = nil;
    }
    if (imageViewbg)
    {
        [imageViewbg release];
        imageViewbg = nil;
        //[imageViewbg addSubview:<#(UIView *)#>];
    }
    [super dealloc];
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *         override
 *  @param
 *          touches
 *            touches
 *  @param
 *          event
 *              event
 *	@return
 *          id(self)
 *
 */
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    CGPoint  point = [[touches anyObject] locationInView:[self superview]];
//    if (point.x > 0
//        && point.x < self.frame.size.width
//        && point.y > 0 && point.y < self.frame.size.height)
//    {
//
//    }else
//    {
//        [self removeFromSuperview];
//    }
//}
-(void)SetAllSubViewsButtonEnable:(UIView *)view bEnable:(BOOL)bIsenale
{
    for (UIView  *viewTemp in [view subviews])
    {
        if (![viewTemp isKindOfClass:[UIButton class]])
        {
            continue;
        }
        //logMyLogInfo(@"1............viewtemp:%@",viewTemp);
        /*if ([viewTemp isKindOfClass:[UIButton class]] || [viewTemp isKindOfClass:[UIImageView class]])
        {
            viewTemp.userInteractionEnabled = bIsenale;
        }*/
        viewTemp.userInteractionEnabled = bIsenale;
        if ([[viewTemp subviews] count])
        {
            [self SetAllSubViewsButtonEnable:viewTemp bEnable:bIsenale];
        }
        
    }
}
@end
