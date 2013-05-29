//
//  PublicMethod.h
//  Texas-pokes
//
//  Created by ran on 12-10-27.
//
//


#import "QuartzCore/QuartzCore.h"
#import "PublicVarible.h"
#import "PublicClass.h"
#ifndef Texas_pokes_PublicMethod_h
#define Texas_pokes_PublicMethod_h

#define HUDVIEWTAG                  2051

@interface UIImageView (removeAsfade)

@end

@implementation UIImageView (removeAsfade)

-(void)removeFromSuperviewAsAni
{
    [self.layer addAnimation:[CABasicAnimation aniWithTransition:2 tovalue:0-self.frame.size.height fromValue:0] forKey:nil];
    [self performSelector:@selector(removeFromSuperview)
               withObject:nil
               afterDelay:2];
}

@end
//NSString* getLevelName(int32_t userScore);
//int sinaCountWord(NSString*s);
//void ShowHUD(NSString *message,UIViewController *viewControl);
//void  HideHUD(UIViewController *viewControl,bool needremove);
//UIImage *MaxImageAccordCardNumber(int32_t maxCardNumber);
//NSString  *SetCardNumber(NSInteger iNumber);
typedef enum insureMode
{
    DEFAULTNONEMODE,
    GOANDGET,
    STANDUPMODE,
    LEVEANOWVIEWMODE,
    ADDCHIPINGAME,
    SITDOWNINCOMGAMEMODE,
    LOGINOUTMODE,
    CHARGEIDOUMODE,
    ENTERROOMFAILMODE,
}ClickinsureMode;



typedef struct
{
    int32_t roomPath;
    int32_t roomID;
    int32_t enterFee;
    int32_t roomSmallChip;
    int32_t roomBigChip;
    int8_t roomType;
    int32_t roomFirstPrize;
    int32_t roomSecondPrize;
    NSString *HostIP;
    int32_t   hostport;
    int8_t    selfChooseSeat;//0 is self choose 1 is not
}GameroomInfo;






static void setAllViewautoResize(UIView *Myview)
{
    
    
    NSLog(@"before:%@  ",Myview);
  //  Myview.bounds = CGRectMake(0, 0, 480, 320);
  //  Myview.center = CGPointMake(568/2, 160);
  //  Myview.frame = CGRectMake(0, 0, 480, 320);
    NSLog(@"after:%@  ",Myview);
   /* for (UIView  *Tempview in [Myview subviews])
    {
        Tempview.autoresizingMask =  UIViewAutoresizingFlexibleTopMargin  | UIViewAutoresizingFlexibleBottomMargin;
        
        
    }*/
}
static NSString* getLevelName(int32_t userScore)
{
    NSDictionary  *dicInfo =[[NSBundle mainBundle] infoDictionary];
    NSArray  *array = [dicInfo valueForKey:@"levelTable"];
    // int level = -1;
    NSDictionary   *diclevelInfo = nil;
    
    for (int i = [array count]-1; i >= 0; i--)
    {
        diclevelInfo = [array objectAtIndex:i];
        NSString  *strScore = [NSString stringWithNeedTranfanstring:[diclevelInfo valueForKey:@"score"] returnType:NORMALTYPE];
        long score = [strScore longLongValue];
        
        
        if (userScore >= score)
        {
            //logMyLogInfo(@"diclevelInfoL:%@",diclevelInfo);
            //   level = i+1;
            break;
        }
    }
    // [labelLevelPercentage setText:[NSString stringWithFormat:@"%d/%d",level,[array count]]];
    //  [labelLevel setText:[diclevelInfo valueForKey:@"name"]];
    return [diclevelInfo valueForKey:@"name"];
}

#if 0
static int sinaCountWord(NSString*s)
{
    int i,n=[s length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++)
    {
        c=[s characterAtIndex:i];
        if(isblank(c))
        {
            b++;
        }else if(isascii(c))
        {
            a++;
        }else
        {
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b)/2.0);
}
#else
static int sinaCountWord(NSString*s)
{
    int i,n=[s length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++)
    {
        c=[s characterAtIndex:i];
        if(isblank(c))
        {
            b++;
        }else if(isascii(c))
        {
            a++;
            //a++;
        }else
        {
            l++;
        }
       // NSLog(@"char:%c black:%d ascii:%d other:%d",c,b,a,l);
    }
    if(a==0 && l==0) return 0;
    return l+a/2;
    // return l+(int)ceilf((float)(a+b)/2.0);
}
#endif

static void ShowHUD(NSString *message,UIViewController *viewControl ,NSTimeInterval  timeout)
{
    if (![viewControl isKindOfClass:[UIViewController class]])
    {
        return;
    }
    MBProgressHUD       *hud =  (MBProgressHUD*)[viewControl.navigationController.view viewWithTag:HUDVIEWTAG];
    if (!hud)
    {
        hud  = [[MBProgressHUD alloc] initWithView:viewControl.navigationController.view];
        hud.mode = MBProgressHUDModeIndeterminate;
        //hud.graceTime = 1.0f;
        [viewControl.navigationController.view addSubview:hud];
      //  hud.center = CGPointMake(480/2,230);
        [hud release];
    }
    hud.labelText = message;
    [hud show:YES timeout:timeout];
    
}

static void  HideHUD(UIViewController *viewControl,bool needremove)
{
    if (![viewControl isKindOfClass:[UIViewController class]])
    {
        return;
    }
    for (UIView  *view in [viewControl.navigationController.view subviews])
    {
        if ([view isKindOfClass:[MBProgressHUD class]])
        {
            
            if (needremove)
            {
                [view removeFromSuperview];
            }else
            {
                [view setHidden:YES];
            }
            //  break;
        }
    }
    
}

static void ShowHUDInview(UIView  *view)
{
    if ([view isKindOfClass:[UIViewController class]])
    {
        return;
    }
    MBProgressHUD       *hud =  (MBProgressHUD*)[view viewWithTag:HUDVIEWTAG];
    if (!hud)
    {
        hud  = [[MBProgressHUD alloc] initWithView:view];
        hud.layer.masksToBounds = YES;
        hud.layer.cornerRadius = 10;
        hud.mode = MBProgressHUDModeIndeterminate;
        //hud.graceTime = 1.0f;
        [view addSubview:hud];
        [hud release];
    }
  //  hud.labelText = message;
    [hud show:YES];
    
}
static void  HideHUDinView(UIView *view)
{
    if ([view isKindOfClass:[UIViewController class]])
    {
        return;
    }
    for (UIView  *viewtemp in [view subviews])
    {
        if ([viewtemp isKindOfClass:[MBProgressHUD class]])
        {
            
            if (viewtemp)
            {
                [viewtemp removeFromSuperview];
            }else
            {
                [viewtemp setHidden:YES];
            }
            //  break;
        }
    }
    
}

static UIImage *MaxImageAccordCardNumber(int32_t maxCardNumber)
{
    if (maxCardNumber < 0)
    {
        return nil;
    }
    NSString  *strName = [NSString stringWithFormat:@"max_%d.png",maxCardNumber/13+1];
    
    return [UIImage imageNamed:strName];
}

static NSString  *SetCardNumber(NSInteger iNumber)
{
    
    if (iNumber < 0)
    {
        return @"";
    }
    switch (iNumber%13)
    {
        case 9:
            return @"J";
            break;
        case 10:
            return @"Q";
            break;
        case 11:
            return @"K";
            break;
        case 12:
            return @"A";
            break;
            
        default:
            return [NSString stringWithFormat:@"%d",iNumber%13+2];
            break;
    }
    
}

static void setAllButtonEnable(BOOL bEnable,UIView * MainView)
                         
{
    for (UIView  *view in [MainView subviews])
    {
        if ([view isKindOfClass:[UIButton class]])
        {
             view.userInteractionEnabled = bEnable;
        }
       
    }
}
static void setAllViewEnable(BOOL bEnable,UIView * MainView)

{
    for (UIView  *view in [MainView subviews])
    {
        view.userInteractionEnabled = bEnable;
        if ([view isKindOfClass:[RJFWarnView class]])
        {
            view.userInteractionEnabled = YES;
        }
    }
}




static void ShowMsgInTopView(NSString *strMsg,NSTimeInterval time,UIViewController *viewcontroller)
{
    
    
    
    UIImageView  *bgimageView = (UIImageView *)[viewcontroller.navigationController.view viewWithTag:1023567];
    if (bgimageView)
    {
        [bgimageView removeFromSuperview];
    }
    bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 39)];
    bgimageView.image = [UIImage imageNamed:@"show_msg_bg.png"];
    bgimageView.tag = 12;
    bgimageView.tag = 1023567;
    [viewcontroller.navigationController.view addSubview:bgimageView];
    
    
   
    // [basicAnimation release];
    
    
    
    UILabel         *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 460, 20)];
    label.text = strMsg;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    label.backgroundColor = [UIColor clearColor];
    
    int count = sinaCountWord(strMsg);
    NSLog(@"count:%d",count);
    if (count > 25)
    {
        int value = count/25+1;

        label.numberOfLines = value;
        
        bgimageView.frame = CGRectMake(bgimageView.frame.origin.x, bgimageView.frame.origin.y, bgimageView.frame.size.width, bgimageView.frame.size.height+14*value);
        label.frame = CGRectMake(10, 3, 460, value*20);
        
    }
    [bgimageView addSubview:label];
    [label release];
    

    [bgimageView.layer addAnimation:[CABasicAnimation aniWithTransition:2 tovalue:0 fromValue:0-bgimageView.frame.size.height] forKey:@"qq"];
    
    
    [bgimageView performSelector:@selector(removeFromSuperviewAsAni)
                      withObject:nil
                      afterDelay:time];
    [bgimageView release];
}

#endif
