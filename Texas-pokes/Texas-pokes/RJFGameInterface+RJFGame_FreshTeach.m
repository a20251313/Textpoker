//
//  RJFGameInterface+RJFGame_FreshTeach.m
//  Texas-pokes
//
//  Created by popo on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFGameInterface+RJFGame_FreshTeach.h"
#define TIMEBEAT     10.0f
@implementation RJFGameInterface (RJFGame_FreshTeach)



#ifndef HULU
#define HULU                               NSLocalizedString(@"葫芦" , nil)
#define     LIANGDUI                       NSLocalizedString(@"两对", nil)
#define     HULUWIN                        NSLocalizedString(@"葫芦赢", nil)
#endif


#define     FRESHTEACHDIALOGTAG         2040
#define     PREVIOUSTEPBUTTONTAG        2041
#define     NEXTSTEPBUTTONTAG           2042
#define     CARDARRAYVIEWTAG            2055
#define     FIRSTCARD               @"FIRSTCARD"
#define     SECONDCARD              @"SECONDCARD"
#define     SEATID                  @"SEATID"
#define     MAXPERSONNUMBER             8










#pragma mark   self define method
-(void)setNextAndPreEnable:(BOOL)bEnable
{
    UIButton  *btn = (UIButton *)[self.view viewWithTag:PREVIOUSTEPBUTTONTAG];
    [btn setEnabled:bEnable];
    btn = (UIButton *)[self.view viewWithTag:NEXTSTEPBUTTONTAG];
    [btn setEnabled:bEnable];
    
}



/*
  iLocation  0  left  1 right
 */
-(void)addCardArrayViewInselfview:(BOOL)bAdd location:(int)iLocation
{
    UIImageView   *imageView = (UIImageView *)[self.view viewWithTag:CARDARRAYVIEWTAG];
    if (bAdd)
    {
        if (!imageView)
        {
            if (1)
            {
                imageView    = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH-155, 10, 155, 255)]; 
            }else
                imageView    = [[UIImageView alloc] initWithFrame:CGRectMake(0+10, 10, 155, 255)];
            imageView.tag = CARDARRAYVIEWTAG;
            imageView.image = [UIImage imageNamed:@"cardArray.png"];
            [self.view addSubview:imageView];
            [imageView release];
        }
        
    }else
    {
        if (imageView)
        {
            [imageView removeFromSuperview];
        }
    }
}

-(void)StopArrTimer:(NSDictionary  *)dicInfo
{
    RJFUserImageView  *imageview = [dicInfo valueForKey:@"USERIMAGE"];
    int  Chips = [[dicInfo valueForKey:@"CHIP"] intValue];
    int  index = [[dicInfo valueForKey:@"INDEX"] intValue];
    
    [NSThread sleepForTimeInterval:1.0f];
    [imageview StopTimer:nil];
    [self setNextAndPreEnable:YES];
    imageview.labelNameAndAction.text = [dicInfo valueForKey:@"ACTION"];
    
    
    //12 step
    if ([dicInfo valueForKey:@"FAPAI"] &&[[dicInfo valueForKey:@"FAPAI"] boolValue])
    {
        //[self roateCardAni:@"square1.png" secondCard:@"black4.png" ThirdCard:@"mei13.png"];
        [self roateCardAccordInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"square1.png",@"0",@"black4.png",@"1",@"mei13.png",@"2", nil]];
        [self gatherchips:nil];
    }
    
    
    if ([[dicInfo valueForKey:@"ACTION"] isEqual:GiveUpCard])
    {
        [imageview setAlpha:0.5f];
        
    }
    
    if (Chips != 0 && index > -1 && index < MAXPERSONNUMBER)
    {
        [self BeginBetChips:Chips UserIndex:index];
    }
}


-(void)StartArrowAni:(UIButton *)button
{
    m_iCount = 0;
    for (int i = 0; i < 3; i++)
    {
        m_arrbFlag[i] = NO;
    }
    [self setArrowAni:nil];
}
-(void)setArrowAni:(UIButton *)button
{
    CGFloat  fSing = 2;
    switch (m_iSentenseIndex)
    {
        case 22:
            button = btnRight;
            break;
        case 23:
            button = btnRight;
            break;
        default:
            button = btnMiddle;
            break;
            
    }
    
    BOOL   btnEnable = [button isEnabled];
    //logMyLogInfo(@"Button:%@",button);
    UIImageView   *imageView = (UIImageView *)[self.view viewWithTag:7000];
    UIImageView *imageView2 = (UIImageView *)[self.view viewWithTag:7001];
    if (!btnEnable)
    {
        [imageView removeFromSuperview];
        [imageView2 removeFromSuperview];
        return;
    }
    
    if (!imageView)
    {
        imageView =  [[UIImageView alloc] initWithFrame:CGRectMake(button.frame.origin.x-fSing, button.frame.origin.y-fSing, button.frame.size.width+fSing*2, btnMiddle.frame.size.height+fSing*2)];
        imageView.image = [UIImage imageNamed:@"button_light.png"];
        imageView.tag = 7000;
        [self.view addSubview:imageView];
        [imageView release];
    }
    if(m_iCount%2 == 1)
    {
      
        CGFloat  fAlpha = 0;
        
        if (m_arrbFlag[0])
        {
            fAlpha = 0;
        }else
        {
            fAlpha = 1;
        }
        m_arrbFlag[0] = !m_arrbFlag[0];
        [UIView beginAnimations:@"qq" context:UIGraphicsGetCurrentContext()];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.25f];
        [imageView setAlpha:fAlpha];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(setArrowAni:)];
        [UIView commitAnimations];
        
        // m_bHide = !m_bHide;
    }
    
    
    if(!imageView2)
    {
        imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(button.frame.origin.x+10, button.frame.origin.y-80, 64, 75)];
        imageView2.image = [UIImage imageNamed:@"arrowbelow.png"];
        imageView2.tag = 7001;
        [self.view addSubview:imageView2];
        [imageView2 release];
    }
    if(m_iCount%2 == 0)
    {
        
        CGRect rect = CGRectZero;
        if (m_arrbFlag[1])
        {
            rect = CGRectMake(button.frame.origin.x+10, button.frame.origin.y-100, 64, 75);
        }else
        {
            rect =CGRectMake(button.frame.origin.x+10, button.frame.origin.y-80, 64, 75);
        }
        m_arrbFlag[1] = !m_arrbFlag[1];
        //[imageView setFrame:CGRectMake(btnMiddle.frame.origin.x, btnMiddle.frame.origin.y-100, 64, 75)];
        [UIView beginAnimations:@"12" context:UIGraphicsGetCurrentContext()];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDuration:0.25f];
        [imageView2 setFrame:rect];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(setArrowAni:)];
        [UIView commitAnimations];
        
        //  m_bHide = !m_bHide;
    }
    
    // m_bHide = !m_bHide;
    m_iCount++;
    
}

-(void)setLunLineShow:(BOOL)bSHow
{
    
    
    //label first lun;
    NSMutableArray  *array = [[NSMutableArray alloc] init];
    [array addObject:[NSValue valueWithCGRect:CGRectMake(imageViewCardOne.frame.origin.x, imageViewCardOne.frame.origin.y-31, imageViewCardThree.frame.origin.x+imageViewCardThree.frame.size.width-imageViewCardOne.frame.origin.x, 21)]];
    [array addObject:[NSValue valueWithCGRect:CGRectMake(imageViewCardFour.frame.origin.x, imageViewCardFour.frame.origin.y-31,imageViewCardFour.frame.size.width, 21)]];
    [array addObject:[NSValue valueWithCGRect:CGRectMake(imageViewCardFive.frame.origin.x, imageViewCardFive.frame.origin.y-31,imageViewCardFive.frame.size.width, 21)]];
    
    int  tagBegin = 6900;
    
    for (int i = 0; i < 3; i++)
    {
        UILabel   *label =(UILabel *) [self.view viewWithTag:tagBegin+i];
        if (bSHow)
        {
            if (!label)
            {
                label = [[UILabel alloc] initWithFrame:[[array objectAtIndex:i] CGRectValue]];
                [label setFont:[UIFont systemFontOfSize:10]];
                [label setText:NSLocalizedString(@"第一轮", nil)];
                [label setTextColor:[UIColor whiteColor]];
                [label setTextAlignment:NSTextAlignmentCenter];
                label.tag = tagBegin+i;
                [label setBackgroundColor:[UIColor clearColor]];
                [self.view addSubview:label];
                [label release];
            }
            switch (i)
            {
                case 1:
                    [label setText:NSLocalizedString(@"第二轮", nil)];
                    break;
                case 2:
                    [label setText:NSLocalizedString(@"第三轮", nil)];
                    break;
                    
                default:
                    break;
            }
        }else
        {
            if (label)
            {
                [label removeFromSuperview];
            }
        }
        
        
    }
    
    
    [array removeAllObjects];
    [array addObject:[NSValue valueWithCGRect:CGRectMake(imageViewCardOne.frame.origin.x, imageViewCardOne.frame.origin.y-8, imageViewCardThree.frame.origin.x+imageViewCardThree.frame.size.width-imageViewCardOne.frame.origin.x-4, 5)]];
    [array addObject:[NSValue valueWithCGRect:CGRectMake(imageViewCardFour.frame.origin.x, imageViewCardFour.frame.origin.y-8, imageViewCardFour.frame.size.width-4, 5)]];
    [array addObject:[NSValue valueWithCGRect:CGRectMake(imageViewCardFive.frame.origin.x, imageViewCardFive.frame.origin.y-8, imageViewCardFive.frame.size.width-4, 5)]];
    
    
    for (int i = 0; i < 3; i++)
    {
        UIImageView  *imageView = (UIImageView *)[self.view viewWithTag:tagBegin+i+3];
        if (bSHow)
        {
            if (!imageView)
            {
                CGRect   frame = [[array objectAtIndex:i] CGRectValue];
                frame.size.height /=2;
                
                imageView = [[UIImageView alloc] initWithFrame:frame];
                imageView.image = [UIImage imageNamed:@"Sing_Lun.png"];
                [self.view addSubview:imageView];
                imageView.tag = tagBegin+i+3;
                [imageView setBackgroundColor:[UIColor clearColor]];
                [imageView release];
            }
        }else
        {
            if (imageView)
            {
                [imageView removeFromSuperview];
            }
        }
        
    }
    
    [array removeAllObjects];
    [array release];
}



-(void)setUserAllCardShow:(BOOL)bShow
{
    
    UIImageView  *view  = (UIImageView *)[self.view viewWithTag:14];
    if (!bShow)
    {
        [view removeFromSuperview];
        return;
    }
    view =  [[UIImageView alloc] initWithFrame:CGRectMake( SCREENWIDTH-200,SCREENHEIGHT-30-btnMiddle.frame.size.height-45, 190, 50)];
    view.image = [UIImage imageNamed:@"freshBottom.png"];
    view.tag = 14;
    int i = 0;
    CGFloat  fwidth = 25;
    CGFloat  fSep = 4;
    for (i = 0; i < 5; i++)
    {
        
        UIImageView  *viewTemp = [[UIImageView alloc] initWithFrame:CGRectMake(i*fwidth+fSep*(i+1), 7.5, fwidth, 35)];
        UIImage  *image = nil;
        switch (i)
        {
            case 0:
                image = [UIImage imageNamed:@"red1.png"];
                break;
            case 1:
                image = [UIImage imageNamed:@"square1.png"];
                break;
            case 2:
                image = [UIImage imageNamed:@"black1.png"];
                break;
            case 3:
                image = [UIImage imageNamed:@"mei13.png"];
                break;
            case 4:
                image = [UIImage imageNamed:@"red13.png"];
                break;
                
            default:
                break;
        }
        viewTemp.image = image;
        [view addSubview:viewTemp];
        [viewTemp release];
        
    }
    
    UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(i*fwidth+fSep*(i+1), 5, 60, 40)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor blueColor]];
    [label setText:HULU];
    //[label setFont:[UIFont systemFontOfSize:18]];
    [view addSubview:label];
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:10];
    [label release];
    
    
    [self.view addSubview:view];
    [view release];
    
}

-(void)RemoveArrowViewIn345Location
{
    int iTag = 1354;
    for (int i = 3; i < 6; i++)
    {
        
        UIImageView   *ImageView = (UIImageView *)[self.view viewWithTag:iTag+i];
        if (ImageView)
        {
            [ImageView removeFromSuperview];
        }
        
    }
    
}
-(void)AddArrowViewIn345Location:(NSArray*)array
{
    //m_arrbFlag[2] = YES;
    int iTag = 1354;
    if ([array count])
    {
        
        UIImage  *imageSource = [UIImage imageNamed:@"arrowbelow.png"];
        
        for (int i = 3; i < 6; i++)
        {
            
            UIImageView   *ImageView = (UIImageView *)[self.view viewWithTag:iTag+i];
            if (!ImageView)
            {
                NSDictionary  *dicInfo = [array objectAtIndex:i];
                CGRect frame = [[dicInfo valueForKey:@"FRAME"] CGRectValue];
                ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x+5, frame.origin.y-50, 42, 50)];
                ImageView.image = imageSource;
                ImageView.tag = iTag+i;
                UILabel   *label = [[UILabel alloc] initWithFrame:CGRectMake(-20, -31, 80, 31)];
                [label setText:NSLocalizedString(@"点击坐下", nil)];
                [label setTextAlignment:NSTextAlignmentCenter];
                [label setBackgroundColor:[UIColor clearColor]];
                [label setTextColor:[UIColor whiteColor]];
                [ImageView addSubview:label];
                [label release];
                [self.view addSubview:ImageView];
                [ImageView release];
            }
            
            [self AddArrowViewIn345Location:nil];
            
        }
    }else
    {
        
        
        [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        BOOL   bExist = YES;
        for (int i = 3; i < 6; i++)
        {
            UIImageView   *ImageView = (UIImageView *)[self.view viewWithTag:iTag+i];
            if (!ImageView)
            {
                bExist = NO;
                break;
                
            }
            if(m_arrbFlag[2])
            {
                [ImageView setFrame:CGRectMake(ImageView.frame.origin.x, ImageView.frame.origin.y-20, ImageView.frame.size.width, ImageView.frame.size.height)];
            }else
            {
                [ImageView setFrame:CGRectMake(ImageView.frame.origin.x, ImageView.frame.origin.y+20, ImageView.frame.size.width, ImageView.frame.size.height)];
            }
            
        }
        m_arrbFlag[2] = !m_arrbFlag[2];
        if (bExist)
        {
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(AddArrowViewIn345Location:)];
            
        }else
        {
            [UIView setAnimationDelegate:nil];
        }
        [UIView setAnimationDuration:1.2f];
        [UIView commitAnimations];
        
        
    }
}


-(void)PreviouStep:(UIButton *)sender
{
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    UITextView  *textview =(UITextView *) [self.view viewWithTag:FRESHTEACHDIALOGTAG];
    UIButton  *btn = (UIButton *)[self.view viewWithTag:NEXTSTEPBUTTONTAG];
    [btn setEnabled:YES];
    NSString *strTitle = [sender titleForState:UIControlStateNormal];
    if ([strTitle isEqualToString:NSLocalizedString(@"领取奖励", nil)])
    {
        
        m_bmustWait = NO;
        BasisZipAndUnzip  *objBasic = [[BasisZipAndUnzip alloc] initWithSize:50];
        
        DZPK_CLIENT_REQ_GET_BONUDS  boundsInfo = {-2};
        RJFTcpSocket  *socket = [RJFTcpSocket shareWithTag:RESOURCESOCKEtTAG];
        [socket SendCharMessage:[objBasic syncWithRequest:REQ_GET_BONUDS
                                                   userID:m_objShareUser.userIDForDzpk
                                              structArray:&boundsInfo] size:[objBasic dataSize]];
        [objBasic release];
        objBasic = nil;
        [sender setHidden:YES];
       
        return;
    }
    
    
    RJFUserImageView  *userImageViewJoshon = [m_arrayStoreUserView objectAtIndex:m_iJoshIndex];
    RJFUserImageView  *userImageVieBalson = [m_arrayStoreUserView objectAtIndex:m_iBalIndex];
    RJFUserImageView  *userImageVieMyself= [m_arrayStoreUserView objectAtIndex:m_iSelfIndex];
    NSDictionary  *dicInfo = nil;
    switch (m_iSentenseIndex)
    {
        case 25:
            m_lTotalChipIndesk = 4020;
            userImageVieMyself.Gameplayer.bringChip = 0;
            userImageViewJoshon.Gameplayer.bringChip = 0;
            [self gatherchips:nil];
            [self youWinAni:140 icount:15];
            [btn setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
            [userImageViewJoshon setCardShow:@"red4.png" SecondCard:@"black3.png" winerString:nil];
            userImageVieMyself.labelNameAndAction.text = HULUWIN;
            [self setUserAllCardShow:YES];
            break;
        case 24:
            m_lTotalChipIndesk = 4020;
            userImageVieMyself.Gameplayer.bringChip = 0;
            userImageViewJoshon.Gameplayer.bringChip = 0;
            userImageVieMyself.labelNameAndAction.text = HULU;
            userImageVieMyself.labelWeath.text = @"0";
            
            [userImageVieMyself RemoveShowCardAndBackToOringal];
            userImageVieMyself.imageViewCardTwo.image = [UIImage imageNamed:@"red1.png"];
            userImageVieMyself.imageViewCardOne.image = [UIImage imageNamed:@"black2.png"];
            [self setUserAllCardShow:NO];
            [userImageViewJoshon RemoveShowCardAndBackToOringal];
            userImageViewJoshon.imageViewCardOne.image = [UIImage imageNamed:@"card_back_left15.png"];
            userImageViewJoshon.imageViewCardTwo.image = [UIImage imageNamed:@"card_back_right15.png"];
            userImageViewJoshon.labelWeath.text = @"1,840";
            userImageViewJoshon.Gameplayer.bringChip += 1840;
            userImageViewJoshon.Gameplayer.giveChip -= 1840;
            m_lTotalChipIndesk -= 1840;
            
            [labelChips setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]]];
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            
            //[self.view addSubview:[m_arrayStoreChipView lastObject]];
            [userImageViewJoshon StartTimer:@(TIMEBEAT)];
            dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userImageViewJoshon,@"USERIMAGE",[NSNumber numberWithInt:m_iJoshIndex],@"INDEX",[NSNumber numberWithInt:1840],@"CHIP",ALLChipBet,@"ACTION",nil];
            [self setNextAndPreEnable:NO];
            [NSThread detachNewThreadSelector:@selector(StopArrTimer:) toTarget:self withObject:dicInfo];
            break;
        case 23:
            [userImageViewJoshon RemoveShowCardAndBackToOringal];
            userImageViewJoshon.imageViewCardOne.image = [UIImage imageNamed:@"card_back_left15.png"];
            userImageViewJoshon.imageViewCardTwo.image = [UIImage imageNamed:@"card_back_right15.png"];
            userImageViewJoshon.labelWeath.text = @"1,840";
            userImageViewJoshon.Gameplayer.bringChip += 1840;
            userImageViewJoshon.Gameplayer.giveChip -= 1840;
            m_lTotalChipIndesk -= 1840;
            userImageVieMyself.labelNameAndAction.text = HULU;
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            
            
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            userImageVieMyself.labelWeath.text = @"1,940";
            userImageVieMyself.Gameplayer.bringChip += 1940;
            userImageVieMyself.Gameplayer.giveChip -=1940;
            m_lTotalChipIndesk -= 1940;
            [labelChips setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]]];
            [m_arrayStoreChipView removeLastObject];
            [btnRight setTitle:AddChip forState:UIControlStateNormal];
            btnRight.enabled = YES;
            [btnMiddle setTitle:FollowChip forState:UIControlStateNormal];
            [self setNextAndPreEnable:NO];
            [self StartArrowAni:btnMiddle];
            break;
        case 22:
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            userImageVieMyself.labelWeath.text = @"1,940";
            userImageVieMyself.Gameplayer.bringChip += 1940;
            userImageVieMyself.Gameplayer.giveChip -=1940;
            m_lTotalChipIndesk -= 1940;
            [labelChips setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]]];
            
            
            
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            userImageViewJoshon.labelWeath.text = @"1,840";
            userImageViewJoshon.Gameplayer.bringChip += 100;
            userImageViewJoshon.Gameplayer.giveChip -= 100;
            m_lTotalChipIndesk -= 100;
            [labelChips setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]]];
            
            imageViewCardTwo.alpha = 1.0f;
            userImageVieMyself.imageViewCardTwo.alpha = 1.0f;
            [userImageViewJoshon StartTimer:@(TIMEBEAT)];
            dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userImageViewJoshon,@"USERIMAGE",[NSNumber numberWithInt:m_iJoshIndex],@"INDEX",[NSNumber numberWithInt:100],@"CHIP",AddChip,@"ACTION",nil];
            [self setNextAndPreEnable:NO];
            [NSThread detachNewThreadSelector:@selector(StopArrTimer:) toTarget:self withObject:dicInfo];
            break;
        case 21:
            
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            userImageViewJoshon.labelWeath.text = @"1,840";
            userImageViewJoshon.Gameplayer.bringChip += 100;
            userImageViewJoshon.Gameplayer.giveChip -= 100;
            m_lTotalChipIndesk -= 100;
            [labelChips setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]]];
            
            imageViewCardFive.image = nil;
            
            [self gatherchips:nil];
            [self CleanAfterEverybetchip:nil];
            userImageVieMyself.Gameplayer.giveChip = 40;
            userImageViewJoshon.Gameplayer.giveChip = 40;
            //[self Rocard:imageViewCardFive Card:@"black1.png" index:4];
            [self roateCardAccordInfo:[NSDictionary dictionaryWithObject:@"black1.png" forKey:@"4"]];
            userImageVieMyself.labelNameAndAction.text = HULU;
            imageViewCardTwo.alpha = 0.5f;
            userImageVieMyself.imageViewCardTwo.alpha = 0.5f;
            break;
        case 20:
            
            imageViewCardFive.image = nil;
            
            //[[m_arrayStoreChipView lastObject] removeFromSuperview];
            //[m_arrayStoreChipView removeLastObject];
            
            
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            
            userImageVieMyself.labelWeath.text = @"1,940";
            userImageVieMyself.Gameplayer.bringChip += 100;
            userImageVieMyself.Gameplayer.giveChip -= 40;
            imageViewCardFive.image = nil;
            m_lTotalChipIndesk -= 40;
            [labelChips setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]]];
            
            [self setLMREnable:NO Hide:NO];
            btnMiddle.enabled = YES;
            [btnMiddle setTitle:FollowChip forState:UIControlStateNormal];
            [self setNextAndPreEnable:NO];
            [self StartArrowAni:btnMiddle];
            break;
        case 19:
            
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            userImageVieMyself.labelWeath.text = @"1,940";
            userImageVieMyself.Gameplayer.bringChip += 40;
            userImageVieMyself.Gameplayer.giveChip -= 40;
            imageViewCardFive.image = nil;
            m_lTotalChipIndesk -= 40;
            [labelChips setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]]];
            
            userImageVieBalson.labelNameAndAction.text = KeepCard;
            
            
            [userImageVieBalson StartTimer:@(TIMEBEAT)];
            dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userImageVieBalson,@"USERIMAGE",[NSNumber numberWithInt:m_iBalIndex],@"INDEX",[NSNumber numberWithInt:0],@"CHIP",GiveUpCard,@"ACTION",nil];
            [self setNextAndPreEnable:NO];
            [NSThread detachNewThreadSelector:@selector(StopArrTimer:) toTarget:self withObject:dicInfo];
            
            break;
        case 18:
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            userImageViewJoshon.labelWeath.text = @"1,800";
            userImageViewJoshon.Gameplayer.bringChip += 40;
            userImageViewJoshon.Gameplayer.giveChip -= 40;
            m_lTotalChipIndesk -= 40;
            [labelChips setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]]];
            
            //[self CleanAfterEverybetchip:nil];
            imageViewCardTwo.alpha = 1.0f;
            userImageVieMyself.imageViewCardTwo.alpha = 1.0f;
            [userImageViewJoshon StartTimer:@(TIMEBEAT)];
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userImageViewJoshon,@"USERIMAGE",[NSNumber numberWithInt:m_iJoshIndex],@"INDEX",[NSNumber numberWithInt:40],@"CHIP",AddChip,@"ACTION",nil];
            [self setNextAndPreEnable:NO];
            [NSThread detachNewThreadSelector:@selector(StopArrTimer:) toTarget:self withObject:dicInfo];
            
            
            
            break;
        case 17:
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            userImageViewJoshon.labelWeath.text = @"1,800";
            userImageViewJoshon.Gameplayer.bringChip += 40;
            userImageViewJoshon.Gameplayer.giveChip -= 40;
            m_lTotalChipIndesk -= 40;
            [labelChips setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]]];
            
            imageViewCardFour.image = nil;
            
            //[self Rocard:imageViewCardFour Card:@"red13.png" index:3];
            [self roateCardAccordInfo:[NSDictionary dictionaryWithObject:@"red13" forKey:@"3"]];
            userImageVieMyself.labelNameAndAction.text = LIANGDUI;
            
            break;
        case 16:
            imageViewCardFour.image = nil;
            userImageVieBalson.labelNameAndAction.text = KeepCard;
            userImageVieMyself.labelNameAndAction.text = FollowChip;
            
            [self setLMREnable:NO Hide:NO];
            btnMiddle.enabled = YES;
            [btnMiddle setTitle:KeepCard forState:UIControlStateNormal];
            [self setNextAndPreEnable:NO];
            [self StartArrowAni:btnMiddle];
            
            break;
        case 15:
            userImageVieBalson.labelNameAndAction.text = KeepCard;
            
            [userImageVieBalson StartTimer:@(TIMEBEAT)];
            dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userImageVieBalson,@"USERIMAGE",[NSNumber numberWithInt:m_iBalIndex],@"INDEX",[NSNumber numberWithInt:0],@"CHIP",KeepCard,@"ACTION",nil];
            [self setNextAndPreEnable:NO];
            [NSThread detachNewThreadSelector:@selector(StopArrTimer:) toTarget:self withObject:dicInfo];
            //*********Joshon选择了跟注10。
            //  *********Balson选择了看牌，这一轮就结束了，筹码集中到奖池。依次翻出三张公共牌。
            //  *********这一轮开始，依次，Joshon选择了看牌。
            //   *********Balson也选择了看牌。
            
            break;
        case 14:
            /* userImageVieBalson.labelNameAndAction.text = BigChip;
             userImageViewJoshon.labelNameAndAction.text = FollowChip;
             imageViewCardOne.image =nil;
             imageViewCardTwo.image = nil;
             imageViewCardThree.image = nil;
             for (int i = [m_arrayStoreUserView count]-1;i > [m_arrayStoreUserView count]-3;i--)
             {
             [self.view addSubview:[m_arrayStoreUserView objectAtIndex:i]];
             }
             
             [userImageViewJoshon StartTimer:nil];
             dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userImageViewJoshon,@"USERIMAGE",[NSNumber numberWithInt:m_iJoshIndex],@"INDEX",[NSNumber numberWithInt:0],@"CHIP",KeepCard,@"ACTION",@"1",@"FAPAI",nil];
             [self setNextAndPreEnable:NO];
             [NSThread detachNewThreadSelector:@selector(StopArrTimer:) toTarget:self withObject:dicInfo];*/
            userImageVieBalson.labelNameAndAction.text = BigChip;
            userImageVieMyself.labelNameAndAction.text = FollowChip;
            
            [userImageViewJoshon StartTimer:@(TIMEBEAT)];
            dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userImageViewJoshon,@"USERIMAGE",[NSNumber numberWithInt:m_iJoshIndex],@"INDEX",[NSNumber numberWithInt:0],@"CHIP",KeepCard,@"ACTION",nil];
            [self setNextAndPreEnable:NO];
            [NSThread detachNewThreadSelector:@selector(StopArrTimer:) toTarget:self withObject:dicInfo];
            break;
        case 13:
            userImageViewJoshon.labelNameAndAction.text = FollowChip;
            userImageVieBalson.labelNameAndAction.text = BigChip;
            userImageVieMyself.labelNameAndAction.text = FollowChip;
            imageViewCardOne.image =nil;
            imageViewCardTwo.image = nil;
            imageViewCardThree.image = nil;
            
            [userImageVieBalson StartTimer:@(TIMEBEAT)];
            dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userImageVieBalson,@"USERIMAGE",[NSNumber numberWithInt:m_iBalIndex],@"INDEX",[NSNumber numberWithInt:0],@"CHIP",KeepCard,@"ACTION",@"1",@"FAPAI",nil];
            [self setNextAndPreEnable:NO];
            [NSThread detachNewThreadSelector:@selector(StopArrTimer:) toTarget:self withObject:dicInfo];
            userImageViewJoshon.Gameplayer.giveChip = 20;
            userImageVieMyself.Gameplayer.giveChip = 20;
            userImageVieBalson.Gameplayer.giveChip = 20;
            userImageViewJoshon.Gameplayer.bringChip += 20;
            m_lTotalChipIndesk = 60;
            break;
        case 12:
            [btnMiddle setTitle:FollowChip forState:UIControlStateNormal];
            userImageViewJoshon.labelNameAndAction.text = LittleChip;
            
            userImageViewJoshon.labelWeath.text = @"1,990";
            userImageViewJoshon.Gameplayer.giveChip -= 10;
            userImageViewJoshon.Gameplayer.bringChip += 10;
            m_lTotalChipIndesk -= 10;
            [labelChips setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]]];
            
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            [userImageViewJoshon StartTimer:@(TIMEBEAT)];
            dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userImageViewJoshon,@"USERIMAGE",[NSNumber numberWithInt:m_iJoshIndex],@"INDEX",[NSNumber numberWithInt:10],@"CHIP",FollowChip,@"ACTION",nil];
            [self setNextAndPreEnable:NO];
            [NSThread detachNewThreadSelector:@selector(StopArrTimer:) toTarget:self withObject:dicInfo];
            
            break;
        case 11:
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            userImageViewJoshon.labelNameAndAction.text = LittleChip;
            userImageViewJoshon.labelWeath.text = @"1,990";
            userImageViewJoshon.Gameplayer.giveChip -= 10;
            userImageViewJoshon.Gameplayer.bringChip += 10;
            m_lTotalChipIndesk -= 10;
            [labelChips setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]]];
            
            
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            userImageVieMyself.labelNameAndAction.text = userImageVieMyself.Gameplayer.UserName;
            userImageVieMyself.labelWeath.text = @"2,000";
            userImageVieMyself.Gameplayer.giveChip -= 20;
            userImageVieMyself.Gameplayer.bringChip += 20;
            m_lTotalChipIndesk -= 20;
            [labelChips setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]]];
            
            [self setLMREnable:NO Hide:NO];
            btnMiddle.enabled = YES;
            [self setNextAndPreEnable:NO];
            [self StartArrowAni:btnMiddle];
            
            
            break;
        case 10:
            
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            userImageVieMyself.labelNameAndAction.text = userImageVieMyself.Gameplayer.UserName;
            userImageVieMyself.labelWeath.text = @"2,000";
            userImageVieMyself.Gameplayer.giveChip -= 20;
            userImageVieMyself.Gameplayer.bringChip += 20;
            m_lTotalChipIndesk -= 20;
            [labelChips setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]]];
            
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            userImageVieBalson.labelNameAndAction.text = userImageVieMyself.Gameplayer.UserName;
            userImageVieBalson.labelWeath.text = @"2,000";
            userImageVieBalson.Gameplayer.giveChip -= 20;
            userImageVieBalson.Gameplayer.bringChip += 20;
            m_lTotalChipIndesk -= 20;
            [labelChips setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]]];
            
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            userImageViewJoshon.labelNameAndAction.text = userImageVieMyself.Gameplayer.UserName;
            userImageViewJoshon.labelWeath.text = @"2,000";
            userImageViewJoshon.Gameplayer.giveChip -= 10;
            userImageViewJoshon.Gameplayer.bringChip += 10;
            m_lTotalChipIndesk -= 10;
            [labelChips setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]]];
            userImageVieMyself.imageViewCardTwo.image = nil;
            userImageVieMyself.imageViewCardOne.image = nil;
            userImageViewJoshon.imageViewCardTwo.image = nil;
            userImageViewJoshon.imageViewCardOne.image = nil;
            userImageVieBalson.imageViewCardTwo.image = nil;
            userImageVieBalson.imageViewCardOne.image = nil;
            userImageVieBalson.labelNameAndAction.text = userImageVieBalson.Gameplayer.UserName;
            userImageViewJoshon.labelNameAndAction.text = userImageViewJoshon.Gameplayer.UserName;
            
            [self setHostLogo:[m_arrayStoreUserView objectAtIndex:m_iSelfIndex] bhide:NO];
            
            [self BeginFapai:m_iJoshIndex FirstCard:@"red1.png" SecondCard:@"black2.png"];
            [self BeginBetChips:10 UserIndex:m_iJoshIndex];
            [self BeginBetChips:20 UserIndex:m_iBalIndex];
            [userImageVieBalson.labelNameAndAction setText:LittleChip];
            [userImageViewJoshon.labelNameAndAction setText:BigChip];
            
            break;
        case 9:
            
            imageViewCardOne.image =nil;
            imageViewCardTwo.image = nil;
            imageViewCardThree.image = nil;
            
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            userImageVieBalson.labelNameAndAction.text = userImageVieMyself.Gameplayer.UserName;
            userImageVieBalson.labelWeath.text = @"2,000";
            userImageVieBalson.Gameplayer.giveChip -= 20;
            userImageVieBalson.Gameplayer.bringChip += 20;
            m_lTotalChipIndesk -= 20;
            [labelChips setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]]];
            
            [[m_arrayStoreChipView lastObject] removeFromSuperview];
            [m_arrayStoreChipView removeLastObject];
            userImageViewJoshon.labelNameAndAction.text = userImageVieMyself.Gameplayer.UserName;
            userImageViewJoshon.labelWeath.text = @"2,000";
            userImageViewJoshon.Gameplayer.giveChip -= 10;
            userImageViewJoshon.Gameplayer.bringChip += 10;
            m_lTotalChipIndesk -= 10;
            [labelChips setText:[DORLLARSYMBOL stringByAppendingString:[NSString stringWithNeedTranfanNumber:m_lTotalChipIndesk returnType:GAMESHOWTYPE]]];
            
            userImageVieBalson.labelNameAndAction.text = userImageVieBalson.Gameplayer.UserName;
            userImageViewJoshon.labelNameAndAction.text = userImageViewJoshon.Gameplayer.UserName;
            userImageVieMyself.imageViewCardTwo.image = nil;
            userImageVieMyself.imageViewCardOne.image = nil;
            userImageViewJoshon.imageViewCardTwo.image = nil;
            userImageViewJoshon.imageViewCardOne.image = nil;
            userImageVieBalson.imageViewCardTwo.image = nil;
            userImageVieBalson.imageViewCardOne.image = nil;
            
            [self setLunLineShow:NO];
            [self setNextAndPreEnable:NO];
            [self StartCountDown:3];
            break;
        case 8:
            
            
            userImageViewJoshon.imageViewCardOne.image = [UIImage imageNamed:@"card_back_left15.png"];
            userImageViewJoshon.imageViewCardTwo.image = [UIImage imageNamed:@"card_back_right15.png"];
            userImageVieBalson.imageViewCardOne.image = [UIImage imageNamed:@"card_back_left15.png"];
            userImageVieBalson.imageViewCardTwo.image = [UIImage imageNamed:@"card_back_right15.png"];
            userImageVieMyself.imageViewCardOne.image = [UIImage imageNamed:@"red8.png"];
            userImageVieMyself.imageViewCardTwo.image = [UIImage imageNamed:@"mei10.png"];
            imageViewCardFour.image = [UIImage imageNamed:@"red10.png"];
            imageViewCardOne.image = [UIImage imageNamed:@"black8.png"];
            imageViewCardTwo.image = [UIImage imageNamed:@"square8.png"];
            imageViewCardThree.image = [UIImage imageNamed:@"mei2.png"];
            imageViewCardFive.image = [UIImage imageNamed:@"red5.png"];
            
            
            
            labelChips.text = @"";
            imageViewCardOne.hidden = NO;
            imageViewCardTwo.hidden = NO;
            imageViewCardThree.hidden = NO;
            imageViewCardFour.hidden = NO;
            imageViewCardFive.hidden = NO;
            [imageViewCardFive setAlpha:0.5f];
            [imageViewCardThree setAlpha:0.5f];
            [userImageVieMyself.labelNameAndAction setText:userImageVieMyself.Gameplayer.UserName];
            [userImageVieMyself.labelWeath setText:[NSString stringWithNeedTranfanstring:@"2000" returnType:COMMOMTYPE]];
            [userImageVieBalson.labelNameAndAction setText:userImageVieBalson.Gameplayer.UserName];
            [userImageViewJoshon.labelNameAndAction setText:userImageViewJoshon.Gameplayer.UserName];
            [imageViewCardFive setFrame:CGRectMake(imageViewCardFive.frame.origin.x, imageViewCardFive.frame.origin.y+8, imageViewCardFive.frame.size.width, imageViewCardFive.frame.size.height)];
            [imageViewCardThree setFrame:CGRectMake(imageViewCardThree.frame.origin.x, imageViewCardThree.frame.origin.y+8, imageViewCardThree.frame.size.width, imageViewCardThree.frame.size.height)];
            [self setLunLineShow:YES];
            break;
        case 7:
            break;
        case 6:
            
            break;
        case 5:
            [self addCardArrayViewInselfview:YES location:1];
            break;
        case 4:
             [self addCardArrayViewInselfview:NO location:1];
            [imageViewCardFive setAlpha:1.0f];
            [imageViewCardThree setAlpha:1.0f];
            [imageViewCardFive setFrame:CGRectMake(imageViewCardFive.frame.origin.x, imageViewCardFive.frame.origin.y-8, imageViewCardFive.frame.size.width, imageViewCardFive.frame.size.height)];
            [imageViewCardThree setFrame:CGRectMake(imageViewCardThree.frame.origin.x, imageViewCardThree.frame.origin.y-8, imageViewCardThree.frame.size.width, imageViewCardThree.frame.size.height)];
            break;
        case 3:
            userImageVieMyself.imageViewCardTwo.image = nil;
            userImageVieMyself.imageViewCardOne.image = nil;
            userImageViewJoshon.imageViewCardTwo.image = nil;
            userImageViewJoshon.imageViewCardOne.image = nil;
            userImageVieBalson.imageViewCardTwo.image = nil;
            userImageVieBalson.imageViewCardOne.image = nil;
            imageViewCardOne.image = nil;
            imageViewCardTwo.image = nil;
            imageViewCardThree.image = nil;
            imageViewCardFour.image = nil;
            imageViewCardFive.image = nil;
            userImageVieBalson.labelNameAndAction.text = userImageVieBalson.Gameplayer.UserName;
            userImageViewJoshon.labelNameAndAction.text = userImageViewJoshon.Gameplayer.UserName;
            [self addCardArrayViewInselfview:NO location:1];
            [self setLunLineShow:NO];
            [self setHostLogo:[m_arrayStoreUserView objectAtIndex:m_iSelfIndex] bhide:YES];
            [self setHostLogo:[m_arrayStoreUserView objectAtIndex:m_iSelfIndex] bhide:NO];
            
            
            
            [self BeginFapai:m_iJoshIndex FirstCard:@"red8.png" SecondCard:@"mei10.png"];
            [self setLMREnable:NO Hide:NO];
            [[m_arrayStoreUserView objectAtIndex:m_iSelfIndex] setAlpha:1.0f];
            [[m_arrayStoreUserView objectAtIndex:m_iBalIndex] setAlpha:1.0f];
            [[m_arrayStoreUserView objectAtIndex:m_iJoshIndex] setAlpha:1.0f];
            [userImageViewJoshon.labelNameAndAction setText:LittleChip];
            [userImageVieBalson.labelNameAndAction setText:BigChip];
            break;
        case 2:
            [self setHostLogo:[m_arrayStoreUserView objectAtIndex:m_iSelfIndex] bhide:YES];
            userImageVieMyself.imageViewCardTwo.image = nil;
            userImageVieMyself.imageViewCardOne.image = nil;
            userImageViewJoshon.imageViewCardTwo.image = nil;
            userImageViewJoshon.imageViewCardOne.image = nil;
            userImageVieBalson.imageViewCardTwo.image = nil;
            userImageVieBalson.imageViewCardOne.image = nil;
            imageViewCardOne.image = nil;
            imageViewCardTwo.image = nil;
            imageViewCardThree.image = nil;
            imageViewCardFour.image = nil;
            imageViewCardFive.image = nil;
            userImageVieBalson.labelNameAndAction.text = userImageVieBalson.Gameplayer.UserName;
            userImageViewJoshon.labelNameAndAction.text = userImageViewJoshon.Gameplayer.UserName;
            break;
        case 1:
            userImageVieMyself.userInteractionEnabled = YES;
            [self SetSeatForFresh:nil];
            m_objShareUser.userHasSitDown = NO;
            [self setNextAndPreEnable:NO];
            
            break;
        case 0:
            userImageVieMyself.userInteractionEnabled = YES;
            [self SetSeatForFresh:nil];
            m_objShareUser.userHasSitDown = NO;
            [self setNextAndPreEnable:NO];
            break;
        default:
            break;
    }
    
    
    
    m_iSentenseIndex--;
    if (m_iSentenseIndex < 0)
    {
        m_iSentenseIndex = 0;
    }
    logMyLogInfo(@"PreviouStep:%d",m_iSentenseIndex);
    if (m_iSentenseIndex)
    {
        
    }else
    {
        UIButton  *btn = (UIButton *)[self.view viewWithTag:PREVIOUSTEPBUTTONTAG];
        [btn setEnabled:NO];
        
    }
    [textview setText:[m_arrStoreSentences objectAtIndex:m_iSentenseIndex]];
    [pool drain];
    
}


-(void)NextStep:(UIButton *)sender
{
    
    NSString *strTitle = [sender titleForState:UIControlStateNormal];
    if ([strTitle isEqualToString:NSLocalizedString(@"离开教学", nil)])
    {
        [self clickBack:btnBack];
        return;
    }
          
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    UITextView  *textview =(UITextView *) [self.view viewWithTag:FRESHTEACHDIALOGTAG];
    if (m_iSentenseIndex > [m_arrStoreSentences count]-1)
    {
        m_iSentenseIndex--;
        return;
    }
    m_iSentenseIndex++;
    if (m_iSentenseIndex <= [m_arrStoreSentences count]-1)
    {
        UIButton  *btn = (UIButton *)[self.view viewWithTag:PREVIOUSTEPBUTTONTAG];
        [btn setEnabled:YES];
        [textview setText:[m_arrStoreSentences objectAtIndex:m_iSentenseIndex]];
        
    }else
    {
        UIButton  *btn = (UIButton *)[self.view viewWithTag: NEXTSTEPBUTTONTAG];
        [btn setEnabled:NO];
    }
    RJFUserImageView  *userImageViewJoshon = [m_arrayStoreUserView objectAtIndex:m_iJoshIndex];
    RJFUserImageView  *userImageVieBalson = [m_arrayStoreUserView objectAtIndex:m_iBalIndex];
    RJFUserImageView  *userImageVieMyself= [m_arrayStoreUserView objectAtIndex:m_iSelfIndex];
    NSDictionary  *dicInfo = nil;
    
    switch (m_iSentenseIndex)
    {
        case 0:
            break;
        case 1:
            break;
        case 2:
            [self setHostLogo:[m_arrayStoreUserView objectAtIndex:m_iSelfIndex] bhide:NO];
            [self BeginFapai:m_iJoshIndex FirstCard:@"red8.png" SecondCard:@"mei10.png"];
            [self setLMREnable:NO Hide:NO];
            [[m_arrayStoreUserView objectAtIndex:m_iSelfIndex] setAlpha:1.0f];
            [[m_arrayStoreUserView objectAtIndex:m_iBalIndex] setAlpha:1.0f];
            [[m_arrayStoreUserView objectAtIndex:m_iJoshIndex] setAlpha:1.0f];
            [userImageViewJoshon.labelNameAndAction setText:LittleChip];
            [userImageVieBalson.labelNameAndAction setText:BigChip];
            break;
        case 3:
            
            [self setLMREnable:NO Hide:YES];
            [self setLunLineShow:YES];
            
            [self roateCardAccordInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"black8.png",@"0",@"square8.png",@"1",@"mei2.png",@"2",@"red10.png",@"3",@"red5",@"4", nil]];
            [imageViewCardFive setHidden:NO];
            [imageViewCardFour setHidden:NO];
            userImageVieMyself.labelNameAndAction.text = HULU;
            break;
        case 4:
             [self addCardArrayViewInselfview:YES location:1];
            [imageViewCardFive setAlpha:0.5f];
            [imageViewCardThree setAlpha:0.5f];
            [imageViewCardFive setFrame:CGRectMake(imageViewCardFive.frame.origin.x, imageViewCardFive.frame.origin.y+8, imageViewCardFive.frame.size.width, imageViewCardFive.frame.size.height)];
            [imageViewCardThree setFrame:CGRectMake(imageViewCardThree.frame.origin.x, imageViewCardThree.frame.origin.y+8, imageViewCardThree.frame.size.width, imageViewCardThree.frame.size.height)];
            break;
        case 5:
           [self addCardArrayViewInselfview:NO location:1];
            break;
        case 6:
            
            break;
        case 7:
            break;
        case 8:
            userImageVieMyself.imageViewCardOne.image = nil;
            userImageVieMyself.imageViewCardTwo.image = nil;
            userImageVieBalson.imageViewCardOne.image = nil;
            userImageVieBalson.imageViewCardTwo.image = nil;
            userImageViewJoshon.imageViewCardOne.image = nil;
            userImageViewJoshon.imageViewCardTwo.image = nil;
            imageViewCardOne.hidden = YES;
            imageViewCardTwo.hidden = YES;
            imageViewCardThree.hidden = YES;
            imageViewCardFour.hidden = YES;
            imageViewCardFive.hidden = YES;
            [imageViewCardFive setAlpha:1.0f];
            [imageViewCardThree setAlpha:1.0f];
            [userImageVieMyself.labelNameAndAction setText:userImageVieMyself.Gameplayer.UserName];
            [userImageVieMyself.labelWeath setText:[NSString stringWithNeedTranfanstring:@"2000" returnType:COMMOMTYPE]];
            [userImageVieBalson.labelNameAndAction setText:userImageVieBalson.Gameplayer.UserName];
            [userImageViewJoshon.labelNameAndAction setText:userImageViewJoshon.Gameplayer.UserName];
            [imageViewCardFive setFrame:CGRectMake(imageViewCardFive.frame.origin.x, imageViewCardFive.frame.origin.y-8, imageViewCardFive.frame.size.width, imageViewCardFive.frame.size.height)];
            [imageViewCardThree setFrame:CGRectMake(imageViewCardThree.frame.origin.x, imageViewCardThree.frame.origin.y-8, imageViewCardThree.frame.size.width, imageViewCardThree.frame.size.height)];
            [self setLunLineShow:NO];
            [self setNextAndPreEnable:NO];
            [self StartCountDown:3];
            break;
        case 9:
            [self setHostLogo:[m_arrayStoreUserView objectAtIndex:m_iSelfIndex] bhide:NO];
            [self BeginFapai:m_iJoshIndex FirstCard:@"red1.png" SecondCard:@"black2.png"];
            [self BeginBetChips:10 UserIndex:m_iJoshIndex];
            [self BeginBetChips:20 UserIndex:m_iBalIndex];
            [userImageViewJoshon.labelNameAndAction setText:LittleChip];
            [userImageVieBalson.labelNameAndAction setText:BigChip];
            break;
            
        case 10:
            [self setLMREnable:NO Hide:NO];
            btnMiddle.enabled = YES;
            [self setNextAndPreEnable:NO];
            [self StartArrowAni:btnMiddle];
            break;
        case 11:
            [userImageViewJoshon StartTimer:@(TIMEBEAT)];
            
            dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userImageViewJoshon,@"USERIMAGE",[NSNumber numberWithInt:m_iJoshIndex],@"INDEX",[NSNumber numberWithInt:10],@"CHIP",FollowChip,@"ACTION",nil];
            [self setNextAndPreEnable:NO];
            [NSThread detachNewThreadSelector:@selector(StopArrTimer:) toTarget:self withObject:dicInfo];
            break;
        case 12:
            [userImageVieBalson StartTimer:@(TIMEBEAT)];
            dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userImageVieBalson,@"USERIMAGE",[NSNumber numberWithInt:m_iBalIndex],@"INDEX",[NSNumber numberWithInt:0],@"CHIP",KeepCard,@"ACTION",@"1",@"FAPAI",nil];
            [self setNextAndPreEnable:NO];
            [NSThread detachNewThreadSelector:@selector(StopArrTimer:) toTarget:self withObject:dicInfo];
            break;
        case 13:
            [userImageViewJoshon StartTimer:@(TIMEBEAT)];
            dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userImageViewJoshon,@"USERIMAGE",[NSNumber numberWithInt:m_iJoshIndex],@"INDEX",[NSNumber numberWithInt:0],@"CHIP",KeepCard,@"ACTION",nil];
            [self setNextAndPreEnable:NO];
            [NSThread detachNewThreadSelector:@selector(StopArrTimer:) toTarget:self withObject:dicInfo];
            break;
        case 14:
            [userImageVieBalson StartTimer:@(TIMEBEAT)];
            dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userImageVieBalson,@"USERIMAGE",[NSNumber numberWithInt:m_iBalIndex],@"INDEX",[NSNumber numberWithInt:0],@"CHIP",KeepCard,@"ACTION",nil];
            [self setNextAndPreEnable:NO];
            [NSThread detachNewThreadSelector:@selector(StopArrTimer:) toTarget:self withObject:dicInfo];
            break;
        case 15:
            [self setLMREnable:NO Hide:NO];
            btnMiddle.enabled = YES;
            [btnMiddle setTitle:KeepCard forState:UIControlStateNormal];
            [self setNextAndPreEnable:NO];
            [self StartArrowAni:btnMiddle];
            break;
        case 16:
            //[self Rocard:imageViewCardFour Card:@"red13.png" index:3];
            [self roateCardAccordInfo:[NSDictionary dictionaryWithObject:@"red13.png" forKey:@"3"]];
            userImageVieMyself.labelNameAndAction.text = LIANGDUI;
            break;
        case 17:
            [self CleanAfterEverybetchip:nil];
            [userImageViewJoshon StartTimer:@(TIMEBEAT)];
            dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userImageViewJoshon,@"USERIMAGE",[NSNumber numberWithInt:m_iJoshIndex],@"INDEX",[NSNumber numberWithInt:40],@"CHIP",AddChip,@"ACTION",nil];
            [self setNextAndPreEnable:NO];
            [NSThread detachNewThreadSelector:@selector(StopArrTimer:) toTarget:self withObject:dicInfo];
            break;
        case 18:
            [userImageVieBalson StartTimer:@(TIMEBEAT)];
            dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userImageVieBalson,@"USERIMAGE",[NSNumber numberWithInt:m_iBalIndex],@"INDEX",[NSNumber numberWithInt:0],@"CHIP",GiveUpCard,@"ACTION",nil];
            [self setNextAndPreEnable:NO];
            [NSThread detachNewThreadSelector:@selector(StopArrTimer:) toTarget:self withObject:dicInfo];
            break;
        case 19:
            [self setLMREnable:NO Hide:NO];
            btnMiddle.enabled = YES;
            [btnMiddle setTitle:FollowChip forState:UIControlStateNormal];
            [self setNextAndPreEnable:NO];
            [self StartArrowAni:btnMiddle];
            break;
        case 20:
            [self gatherchips:nil];
            [self CleanAfterEverybetchip:nil];
            [self roateCardAccordInfo:[NSDictionary dictionaryWithObject:@"black1.png" forKey:@"4"]];
            userImageVieMyself.labelNameAndAction.text = HULU;
            imageViewCardTwo.alpha = 0.5f;
            userImageVieMyself.imageViewCardTwo.alpha = 0.5f;
            break;
        case 21:
            imageViewCardTwo.alpha = 1.0f;
            userImageVieMyself.imageViewCardTwo.alpha = 1.0f;
            [userImageViewJoshon StartTimer:@(TIMEBEAT)];
            dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userImageViewJoshon,@"USERIMAGE",[NSNumber numberWithInt:m_iJoshIndex],@"INDEX",[NSNumber numberWithInt:100],@"CHIP",AddChip,@"ACTION",nil];
            [self setNextAndPreEnable:NO];
            [NSThread detachNewThreadSelector:@selector(StopArrTimer:) toTarget:self withObject:dicInfo];
            break;
        case 22:
            [btnRight setTitle:AddChip forState:UIControlStateNormal];
            btnRight.enabled = YES;
            [btnMiddle setTitle:FollowChip forState:UIControlStateNormal];
            [self setNextAndPreEnable:NO];
            [self StartArrowAni:btnMiddle];
            break;
        case 23:
            [userImageViewJoshon StartTimer:@(TIMEBEAT)];
            dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userImageViewJoshon,@"USERIMAGE",[NSNumber numberWithInt:m_iJoshIndex],@"INDEX",[NSNumber numberWithInt:1840],@"CHIP",ALLChipBet,@"ACTION",nil];
            [self setNextAndPreEnable:NO];
            [NSThread detachNewThreadSelector:@selector(StopArrTimer:) toTarget:self withObject:dicInfo];
            break;
        case 24:
            m_lTotalChipIndesk = 4020;
            
            [self gatherchips:nil];
            [userImageVieMyself MoveTheCardToMid];
            [userImageViewJoshon setCardShow:@"red4.png" SecondCard:@"black3.png" winerString:nil];
            userImageVieMyself.labelNameAndAction.text = HULUWIN;
            [self setUserAllCardShow:YES];
            [self youWinAni:140 icount:15];
            [userImageVieMyself labelWeath].text = @"4,020";
            [labelChips setText:@""];
            break;
        case 25:
            [userImageVieMyself RemoveShowCardAndBackToOringal];
            [userImageViewJoshon RemoveShowCardAndBackToOringal];
            [self setUserAllCardShow:NO];
            [sender setTitle:NSLocalizedString(@"离开教学", nil) forState:UIControlStateNormal];
            
            UIButton  *btn = (UIButton *)[self.view viewWithTag:PREVIOUSTEPBUTTONTAG];
            if (m_objShareUser.hasFreshBounds)
            {
                [btn setEnabled:YES];
                [btn setTitle:NSLocalizedString(@"领取奖励", nil) forState:UIControlStateNormal];
                
            }else
            {
                [btn setHidden:YES];
            }
            break;
        case 26:
            [sender setTitle:NSLocalizedString(@"开始游戏", nil) forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    logMyLogInfo(@"NextStep: %d",m_iSentenseIndex);
    [pool drain];
    
}

-(void)SetSeatForFresh:(id)Thread
{
    NSMutableArray  *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < MAXPERSONNUMBER; i++)
    {
        GamePlayer  *Player = nil;
        NSDictionary  *dicInfo = nil;
        switch (i) {
            case 0:
            case 6:
            case 7:
                dicInfo = [NSDictionary dictionaryWithObject:@"0" forKey:@"HasPlayer"];
                break;
            case 1:
                Player = [[GamePlayer alloc] init];
                Player.UserName = @"Joshon";
                Player.userChip = 2000;
                Player.bringChip = 2000;
                Player.UserId = 12345;
                Player.seatID = 100;
                Player.UserImagePath = @"joshon.png";
                dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:Player,@"PLAYER",@"1",@"HasPlayer",nil];
                break;
            case 2:
                Player = [[GamePlayer alloc] init];
                Player.UserName = @"Kitty";
                Player.userChip = 2000;
                Player.bringChip = 2000;
                Player.UserId = 12345;
                Player.seatID = 102;
                Player.UserImagePath = @"user2.png";
                dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:Player,@"PLAYER",@"1",@"HasPlayer",nil];
                break;
            case 3:
            case 4:
            case 5:
                dicInfo = [NSDictionary dictionaryWithObject:@"0" forKey:@"HasPlayer"];
                break;
            default:
                break;
        }
        [array addObject:dicInfo];
        [Player release];
        
    }
    
    
    [self addUserImagview:array];
    [array release];
    [[m_arrayStoreUserView objectAtIndex:m_iSelfIndex] setAlpha:0.5f];
    [[m_arrayStoreUserView objectAtIndex:m_iJoshIndex] setAlpha:0.5f];
    RJFUserImageView  *userView = [m_arrayStoreUserView objectAtIndex:m_iJoshIndex];
    userView.userInteractionEnabled = NO;
    userView = [m_arrayStoreUserView objectAtIndex:m_iJoshIndex];
    userView.userInteractionEnabled = NO;
    [[m_arrayStoreUserView objectAtIndex:m_iBalIndex] setAlpha:0.5f];
    
    [[m_arrayStoreUserView objectAtIndex:6] setHidden:YES];
    [[m_arrayStoreUserView objectAtIndex:7] setHidden:YES];
    [[m_arrayStoreUserView objectAtIndex:0] setHidden:YES];
    [self AddArrowViewIn345Location:m_arrayStoreUserRectInfo];
}



@end
