//
//  RJFUserdetail.m
//  Texas-pokes
//
//  Created by ran on 12-10-26.
//
//

#import "RJFUserdetail.h"
#import "RjfDownPicImageView.h"
#import "QuartzCore/QuartzCore.h"
#import "JFItemShowView.h"


#define TOPVIEWTAG   10
#define TOPLEFTBUTTON   11
#define TOPVIEWRIGHTBUTTON  12

#define USERVIEWTAG         1222

#define LFTTTAG         1
#define RIGHTTAG        2


#define DOWNLOADREQUESDID   43
#define UPLOADREQUESTID     42

@implementation RJFUserdetail
@synthesize userID,seatID,delegate,arrayItems,arrayPrices,arrayTags,MaxChip;
- (id)initWithFrame:(CGRect)frame withID:(int32_t)UserID
{
    self = [super initWithFrame:frame];
    if (self)
    {
        userID = UserID;
        self.image = [UIImage imageNamed:@"dzpk_profile_bg.png"];
        self.userInteractionEnabled = YES;
        
        UIImageView  *imageView =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 38)];
        imageView.image = [UIImage imageNamed:@"dzpk_profile_choosebtn_two.png"];
        imageView.tag = TOPVIEWTAG;
        imageView.userInteractionEnabled = YES;
        
        UIButton   *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/2, 38)];
        [btnLeft setBackgroundColor:[UIColor clearColor]];
        [btnLeft setTitle:NSLocalizedString(@"个人信息", nil) forState:UIControlStateNormal];
        [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnLeft addTarget:self
                    action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        btnLeft.tag = TOPLEFTBUTTON;
        [imageView addSubview:btnLeft];
        [btnLeft release];
        
        UIButton   *btnRight = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width/2, 0, frame.size.width/2, 38)];
        [btnRight setBackgroundColor:[UIColor clearColor]];
        [btnRight setTitle:NSLocalizedString(@"统计", nil) forState:UIControlStateNormal];
        [btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnRight addTarget:self
                     action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        btnRight.tag = TOPVIEWRIGHTBUTTON;
        [imageView addSubview:btnRight];
        [btnRight release];
        
        
        [self addSubview:imageView];
        [imageView release];
        
        
        
        
        
        // Initialization code
    }
    return self;
}


-(void)clickButton:(UIButton *)sender
{
    UIImageView  *imageview =(UIImageView *) [self viewWithTag:TOPVIEWTAG];
    
    if (sender.tag == TOPLEFTBUTTON)
    {
        imageview.image = [UIImage imageNamed:@"dzpk_profile_choosebtn_two.png"];
        
        for (UIView *view in [self subviews])
        {
            if ([view respondsToSelector:@selector(setHidden:)])
            {
                if (view.tag > 2000)
                {
                    [view setHidden:YES];
                }else if (view.tag > 1000 && view.tag < 2000)
                {
                    [view setHidden:NO];
                }
                
            }
            
        }
    }else
    {
        imageview.image = [UIImage imageNamed:@"dzpk_profile_choosebtn_one.png"];
        for (UIView *view in [self subviews])
        {
            if ([view respondsToSelector:@selector(setHidden:)])
            {
                if (view.tag > 2000)
                {
                    [view setHidden:NO];
                }else if (view.tag > 1000 && view.tag < 2000)
                {
                    [view setHidden:YES];
                }
                
            }
            
        }
    }
    
    
}


//typedef struct
//{
//
//    int8_t     status;
//    int8_t     sex;
//    int8_t     msg_count;
//    int8_t     level;
//    NSString   *nick;
//    NSString   *head_pic_name;
//    int8_t    *maxCards;
//    int32_t    max_win;
//    int32_t    chips;
//    int32_t     idou;
//    int32_t     lose_number;
//    int32_t     win_number;
//    int32_t     max_own;
//    int32_t     online_count;
//    int32_t     score;
//    int32_t     match_score;
//
//    int         maxcardNumber;
//}DZPK_SERVER_REQ_PERSON_DATA;
-(void)SetInfoAccorddata:(DZPK_SERVER_REQ_GAME_PLAYER_DATA*)dataInfo
{
    if (dataInfo == NULL)
    {
        logMyLogInfo(@"get user detail fail");
        return;
    }
    UserInfo  *objUser = [UserInfo shareInstance];
    int leftTagBegin = 1000;
    int  rightTagBegin = 2000;
    CGFloat  fwidth = 125;
    CGFloat  fXpoint = 20;
    CGFloat  fHeight = 40;
    CGFloat  fSep = 2;
    CGFloat  flabelHeight = 21;
    CGFloat  flabelWidth = 180;
    
    
    UIImageView             *imageBg = (UIImageView *)[self viewWithTag:leftTagBegin+30];
    if (imageBg == nil)
    {
        imageBg = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint-2, fHeight+4, fwidth+4, fwidth+4)];
        imageBg.image = [UIImage imageNamed:@"userimage_square.png"];
        imageBg.userInteractionEnabled = YES;
        imageBg.tag = leftTagBegin+30;
        imageBg.layer.masksToBounds = YES;
        imageBg.layer.cornerRadius = 10.0;
        imageBg.backgroundColor = [UIColor whiteColor];
        [self addSubview:imageBg];
        [imageBg release];
    }
    RjfDownPicImageView     *userView =(RjfDownPicImageView*) [self viewWithTag:leftTagBegin+1];
    
    if (userView == nil)
    {
        userView = [[RjfDownPicImageView alloc] initWithFrame:CGRectMake(2,2, fwidth, fwidth)];
        userView.image = [UIImage imageNamed:@"userDefault.png"];
        userView.userInteractionEnabled = YES;
        userView.tag = leftTagBegin+1;
        userView.layer.masksToBounds = YES;
        userView.layer.cornerRadius = 5;
        [imageBg addSubview:userView];
        [userView release];
        
    }
    
    UIImage  *image = [RJFUpAndDown getLocalImage:dataInfo->headPicName];
    if (image)
    {
        userView.image = image;
    }else
    {
        [userView StartDownPic:dataInfo->headPicName
                     requestID:UPLOADREQUESTID
                    fileServer:objUser.fileHost
                          port:objUser.filePort];
    }
    
    
    
    
    fXpoint += 10;
    
    UILabel   *labelName = (UILabel *)[self viewWithTag:leftTagBegin+2];
    if (labelName == nil)
    {
        labelName = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint+fwidth, fHeight, flabelWidth, flabelHeight)];
        labelName.tag = leftTagBegin+2;
        [labelName setTextColor:[UIColor whiteColor]];
        [labelName setBackgroundColor:[UIColor clearColor]];
        [self addSubview:labelName];
        [labelName release];
        
    }
    [labelName setText:dataInfo->nick];
    
    
    fHeight += fSep+flabelHeight;
    UILabel   *labelID = (UILabel *)[self viewWithTag:leftTagBegin+3];
    if (labelID == nil)
    {
        labelID = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint+fwidth, fHeight, flabelWidth, flabelHeight)];
        labelID.tag = leftTagBegin+3;
        [labelID setTextColor:[UIColor whiteColor]];
        [labelID setBackgroundColor:[UIColor clearColor]];
        [self addSubview:labelID];
        [labelID release];
        
    }
    [labelID setText:[NSString stringWithFormat:@"ID：   %d",userID]];
    
    
    
    fHeight += fSep+flabelHeight;
    UILabel   *labelSex = (UILabel *)[self viewWithTag:leftTagBegin+4];
    if (labelSex == nil)
    {
        labelSex = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint+fwidth, fHeight, flabelWidth, flabelHeight)];
        labelSex.tag = leftTagBegin+4;
        [labelSex setTextColor:[UIColor whiteColor]];
        [labelSex setBackgroundColor:[UIColor clearColor]];
        [self addSubview:labelSex];
        [labelSex release];
        
    }
    NSString  *strSex = NSLocalizedString(@"男", nil);
    if (dataInfo->sex == 1)
    {
        strSex = NSLocalizedString(@"女", nil);
    }
    [labelSex setText:[NSString stringWithFormat:NSLocalizedString(@"性别： %@", nil),strSex]];
    
    
    
    
    
    fHeight += fSep+flabelHeight;
    CGFloat  ftempWidth = 50;
    UILabel   *labellevel = (UILabel *)[self viewWithTag:leftTagBegin+5];
    if (labellevel == nil)
    {
        labellevel = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint+fwidth, fHeight, ftempWidth+20, flabelHeight)];
        labellevel.tag = leftTagBegin+5;
        [labellevel setTextColor:[UIColor whiteColor]];
        [labellevel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:labellevel];
        [labellevel release];
        
    }
    [labellevel setText:[NSString stringWithFormat:NSLocalizedString(@"等级：", nil)]];
    
    
    UIImageView  *imageViewMedal  = (UIImageView *)[self viewWithTag:leftTagBegin+6];
    
    if (imageViewMedal == nil)
    {
        imageViewMedal = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint+fwidth+10+ftempWidth, fHeight+3, 12, 17)];
        imageViewMedal.backgroundColor = [UIColor clearColor];
        imageViewMedal.tag = leftTagBegin+6;
        [self addSubview:imageViewMedal];
        [imageViewMedal release];
    }
    
    
    if (dataInfo->level <= 1)
    {
        imageViewMedal.image = nil;
    }else if (dataInfo->level < 7)
    {
        imageViewMedal.image = [UIImage imageNamed:@"medal_1.png"];
    }else if (dataInfo->level < 10)
    {
        imageViewMedal.image = [UIImage imageNamed:@"medal_2.png"];
    }else if (dataInfo->level < 14)
    {
        imageViewMedal.image = [UIImage imageNamed:@"medal_3.png"];
    }else if (dataInfo->level < 18)
    {
        imageViewMedal.image = [UIImage imageNamed:@"medal_4.png"];
    }else
    {
        imageViewMedal.image = [UIImage imageNamed:@"medal_5.png"];
    }
    
    
    UILabel   *labellevelName = (UILabel *)[self viewWithTag:leftTagBegin+7];
    if (labellevelName == nil)
    {
        labellevelName = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint+fwidth+10+17+fSep+ftempWidth, fHeight, flabelWidth, flabelHeight)];
        labellevelName.tag = leftTagBegin+7;
        [labellevelName setTextColor:[UIColor whiteColor]];
        [labellevelName setBackgroundColor:[UIColor clearColor]];
        [self addSubview:labellevelName];
        [labellevelName release];
        
    }
    [labellevelName setText:getLevelName(dataInfo->score)];
    
    
    
    
    fHeight += fSep+flabelHeight;
    UILabel   *labelchip= (UILabel *)[self viewWithTag:leftTagBegin+8];
    if (labelchip == nil)
    {
        labelchip = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint+fwidth, fHeight, ftempWidth, flabelHeight)];
        labelchip.tag = leftTagBegin+8;
        [labelchip setTextColor:[UIColor whiteColor]];
        [labelchip setBackgroundColor:[UIColor clearColor]];
        [self addSubview:labelchip];
        [labelchip release];
        
    }
    
    
    [labelchip setText:[NSString stringWithFormat:NSLocalizedString(@"筹码:", nil)]];
    
    UIImageView  *imageViewChip  = (UIImageView *)[self viewWithTag:leftTagBegin+9];
    
    if (imageViewChip == nil)
    {
        imageViewChip = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint+fwidth+fSep*2+ftempWidth, fHeight+4, 15, 15)];
        imageViewChip.backgroundColor = [UIColor clearColor];
        imageViewChip.tag = leftTagBegin+9;
        imageViewChip.image = [UIImage imageNamed:@"small_chips.png"];
        [self addSubview:imageViewChip];
        [imageViewChip release];
    }
    
    UILabel   *labelchipNumber= (UILabel *)[self viewWithTag:leftTagBegin+10];
    if (labelchipNumber == nil)
    {
        labelchipNumber = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint+fwidth+fSep*2+ftempWidth+11, fHeight, flabelWidth, flabelHeight)];
        labelchipNumber.tag = leftTagBegin+10;
        [labelchipNumber setTextColor:[UIColor whiteColor]];
        [labelchipNumber setBackgroundColor:[UIColor clearColor]];
        [self addSubview:labelchipNumber];
        [labelchipNumber release];
        
    }
    [labelchipNumber setText:[NSString stringWithFormat:@"  %d",dataInfo->chips]];
    
    
    fHeight += fSep+flabelHeight;
    UILabel   *labelScore= (UILabel *)[self viewWithTag:leftTagBegin+11];
    if (labelScore == nil)
    {
        labelScore = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint+fwidth, fHeight, flabelWidth, flabelHeight)];
        labelScore.tag = leftTagBegin+11;
        [labelScore setTextColor:[UIColor whiteColor]];
        [labelScore setBackgroundColor:[UIColor clearColor]];
        [self addSubview:labelScore];
        [labelScore release];
        
    }
    [labelScore setText:[NSString stringWithFormat:NSLocalizedString(@"积分：  %d", nil),dataInfo->score]];
    


    JFItemShowView  *itemsView = [[JFItemShowView alloc] initWithitems:self.arrayItems
                                                                prices:self.arrayPrices
                                                              withTags:self.arrayTags
                                                             withFrame:CGRectMake(0, fHeight+flabelHeight, self.frame.size.width, 100)
                                                              maxValue:self.MaxChip];
    itemsView.delegate = self.delegate;
    itemsView.seatID = self.seatID;
    [self addSubview:itemsView];
    [itemsView release];
    
    fHeight = 40;
    flabelWidth = 200;
    //right panel
    UILabel   *labelMatchScore = (UILabel *)[self viewWithTag:rightTagBegin+1];
    if (labelMatchScore == nil)
    {
        labelMatchScore = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, fHeight, flabelWidth, flabelHeight)];
        labelMatchScore.tag = rightTagBegin+1;
        [labelMatchScore setTextColor:[UIColor whiteColor]];
        [labelMatchScore setBackgroundColor:[UIColor clearColor]];
        [labelMatchScore setHidden:YES];
        [self addSubview:labelMatchScore];
        [labelMatchScore release];
        
    }
    [labelMatchScore setText:[NSString stringWithFormat:NSLocalizedString(@"比赛积分： %d", nil),dataInfo->matchscore]];
    
    fHeight += fSep+flabelHeight;
    UILabel   *labelHasPlayed = (UILabel *)[self viewWithTag:rightTagBegin+2];
    if (labelHasPlayed == nil)
    {
        labelHasPlayed = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, fHeight, flabelWidth, flabelHeight)];
        labelHasPlayed.tag = rightTagBegin+2;
        [labelHasPlayed setTextColor:[UIColor whiteColor]];
        [labelHasPlayed setBackgroundColor:[UIColor clearColor]];
        [labelHasPlayed setHidden:YES];
        [self addSubview:labelHasPlayed];
        [labelHasPlayed release];
        
    }
    [labelHasPlayed setText:[NSString stringWithFormat:NSLocalizedString(@"已玩局数： %d", nil),dataInfo->lose_number+dataInfo->win_number]];
    
    
    fHeight += fSep+flabelHeight;
    UILabel   *labelRecord = (UILabel *)[self viewWithTag:rightTagBegin+3];
    if (labelRecord == nil)
    {
        labelRecord = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, fHeight, flabelWidth, flabelHeight)];
        labelRecord.tag = rightTagBegin+3;
        [labelRecord setTextColor:[UIColor whiteColor]];
        [labelRecord setBackgroundColor:[UIColor clearColor]];
        [labelRecord setHidden:YES];
        [self addSubview:labelRecord];
        [labelRecord release];
        
    }
    [labelRecord setText:[NSString stringWithFormat:NSLocalizedString(@"战        绩：%d胜%d败", nil),dataInfo->win_number,dataInfo->lose_number]];
    
    fHeight += fSep+flabelHeight;
    UILabel   *labelWinPer = (UILabel *)[self viewWithTag:rightTagBegin+4];
    if (labelWinPer == nil)
    {
        labelWinPer = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, fHeight, flabelWidth, flabelHeight)];
        labelWinPer.tag = rightTagBegin+4;
        [labelWinPer setTextColor:[UIColor whiteColor]];
        [labelWinPer setBackgroundColor:[UIColor clearColor]];
        [labelWinPer setHidden:YES];
        [self addSubview:labelWinPer];
        [labelWinPer release];
        
    }
    if (dataInfo->lose_number+dataInfo->win_number > 0)
    {
        [labelWinPer setText:[NSString stringWithFormat:NSLocalizedString(@"胜        率：%0.0f%%", nil),dataInfo->win_number*1.0f/(dataInfo->lose_number+dataInfo->win_number)*100.0f]];
    }else
    {
        [labelWinPer setText:[NSString stringWithFormat:NSLocalizedString(@"胜        率：0%%", nil) ]];
    }
    
    fHeight += fSep+flabelHeight;
    ftempWidth = 87;
    UILabel   *labelMaxCard = (UILabel *)[self viewWithTag:rightTagBegin+5];
    if (labelMaxCard == nil)
    {
        labelMaxCard = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, fHeight, ftempWidth, flabelHeight)];
        labelMaxCard.tag = rightTagBegin+5;
        [labelMaxCard setTextColor:[UIColor whiteColor]];
        [labelMaxCard setBackgroundColor:[UIColor clearColor]];
        [labelMaxCard setHidden:YES];
        [self addSubview:labelMaxCard];
        [labelMaxCard release];
        
    }
    [labelMaxCard setText:[NSString stringWithFormat:NSLocalizedString(@"最大手牌：", nil)]];
    
    
    CGFloat fimageWidth = 14;
    CGFloat fimageHeight = 20;
    CGFloat flabelCardWidth = 25;
    CGFloat flabelCardHeight = 17;
    CGFloat fwidthsep = 2;
    UIImageView  *imageViewcard1 = (UIImageView *)[self viewWithTag:rightTagBegin+6];
    if (imageViewcard1 == nil)
    {
        imageViewcard1 = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint+ftempWidth+fwidthsep, fHeight, fimageWidth, fimageHeight)];
        imageViewcard1.backgroundColor = [UIColor clearColor];
        imageViewcard1.userInteractionEnabled = YES;
        imageViewcard1.tag = rightTagBegin+6;
        imageViewcard1.hidden = YES;
        [self addSubview:imageViewcard1];
        [imageViewcard1 release];
    }
    imageViewcard1.image = MaxImageAccordCardNumber(dataInfo->maxCards[0]);
    
    
    UILabel   *labelMaxCard1 = (UILabel *)[self viewWithTag:rightTagBegin+7];
    if (labelMaxCard1 == nil)
    {
        labelMaxCard1 = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint+ftempWidth+fwidthsep*2+fimageWidth, fHeight+3, flabelCardWidth, flabelCardHeight)];
        labelMaxCard1.tag = rightTagBegin+7;
        [labelMaxCard1 setTextColor:[UIColor whiteColor]];
        [labelMaxCard1 setTextAlignment:NSTextAlignmentCenter];
        [labelMaxCard1 setBackgroundColor:[UIColor clearColor]];
        [labelMaxCard1 setHidden:YES];
        [self addSubview:labelMaxCard1];
        [labelMaxCard1 release];
        
    }
    [labelMaxCard1 setText:SetCardNumber(dataInfo->maxCards[0])];
    
    
    UIImageView  *imageViewcard2 = (UIImageView *)[self viewWithTag:rightTagBegin+8];
    if (imageViewcard2 == nil)
    {
        imageViewcard2 = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint+ftempWidth+fwidthsep*3+fimageWidth+flabelCardWidth, fHeight, fimageWidth, fimageHeight)];
        imageViewcard2.backgroundColor = [UIColor clearColor];
        imageViewcard2.userInteractionEnabled = YES;
        
        imageViewcard2.tag = rightTagBegin+8;
        imageViewcard2.hidden = YES;
        [self addSubview:imageViewcard2];
        [imageViewcard2 release];
    }
    imageViewcard2.image = MaxImageAccordCardNumber(dataInfo->maxCards[1]);
    
    
    UILabel   *labelMaxCard2 = (UILabel *)[self viewWithTag:rightTagBegin+9];
    if (labelMaxCard2 == nil)
    {
        labelMaxCard2 = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint+ftempWidth+fwidthsep*4+fimageWidth*2+flabelCardWidth, fHeight+3, flabelCardWidth, flabelCardHeight)];
        labelMaxCard2.tag = rightTagBegin+9;
        [labelMaxCard2 setTextColor:[UIColor whiteColor]];
        [labelMaxCard2 setBackgroundColor:[UIColor clearColor]];
        [labelMaxCard2 setHidden:YES];
        [labelMaxCard2 setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:labelMaxCard2];
        [labelMaxCard2 release];
        
    }
    [labelMaxCard2 setText:SetCardNumber(dataInfo->maxCards[1])];
    
    
    UIImageView  *imageViewcard3 = (UIImageView *)[self viewWithTag:rightTagBegin+10];
    if (imageViewcard3 == nil)
    {
        imageViewcard3 = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint+ftempWidth+fwidthsep*5+fimageWidth*2+flabelCardWidth*2, fHeight, fimageWidth, fimageHeight)];
        imageViewcard3.backgroundColor = [UIColor clearColor];
        imageViewcard3.userInteractionEnabled = YES;
        imageViewcard3.tag = rightTagBegin+10;
        imageViewcard3.hidden = YES;
        [self addSubview:imageViewcard3];
        [imageViewcard3 release];
    }
    imageViewcard3.image = MaxImageAccordCardNumber(dataInfo->maxCards[2]);
    
    
    UILabel   *labelMaxCard3 = (UILabel *)[self viewWithTag:rightTagBegin+11];
    if (labelMaxCard3 == nil)
    {
        labelMaxCard3 = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint+ftempWidth+fwidthsep*6+fimageWidth*3+flabelCardWidth*2, fHeight+3, flabelCardWidth, flabelCardHeight)];
        labelMaxCard3.tag = rightTagBegin+11;
        [labelMaxCard3 setTextColor:[UIColor whiteColor]];
        [labelMaxCard3 setTextAlignment:NSTextAlignmentCenter];
        [labelMaxCard3 setBackgroundColor:[UIColor clearColor]];
        [labelMaxCard3 setHidden:YES];
        [self addSubview:labelMaxCard3];
        [labelMaxCard3 release];
        
    }
    [labelMaxCard3 setText:SetCardNumber(dataInfo->maxCards[2])];
    
    UIImageView  *imageViewcard4 = (UIImageView *)[self viewWithTag:rightTagBegin+12];
    if (imageViewcard4 == nil)
    {
        imageViewcard4 = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint+ftempWidth+fwidthsep*7+fimageWidth*3+flabelCardWidth*3, fHeight, fimageWidth, fimageHeight)];
        imageViewcard4.backgroundColor = [UIColor clearColor];
        imageViewcard4.userInteractionEnabled = YES;
        imageViewcard4.tag = rightTagBegin+12;
        imageViewcard4.hidden = YES;
        [self addSubview:imageViewcard4];
        [imageViewcard4 release];
    }
    imageViewcard4.image = MaxImageAccordCardNumber(dataInfo->maxCards[3]);
    
    
    UILabel   *labelMaxCard4 = (UILabel *)[self viewWithTag:rightTagBegin+13];
    if (labelMaxCard4 == nil)
    {
        labelMaxCard4 = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint+ftempWidth+fwidthsep*8+fimageWidth*4+flabelCardWidth*3, fHeight+3, flabelCardWidth, flabelCardHeight)];
        labelMaxCard4.tag = rightTagBegin+13;
        [labelMaxCard4 setTextColor:[UIColor whiteColor]];
        [labelMaxCard4 setTextAlignment:NSTextAlignmentCenter];
        [labelMaxCard4 setBackgroundColor:[UIColor clearColor]];
        [labelMaxCard4 setHidden:YES];
        [self addSubview:labelMaxCard4];
        [labelMaxCard4 release];
        
    }
    [labelMaxCard4 setText:SetCardNumber(dataInfo->maxCards[3])];
    
    
    UIImageView  *imageViewcard5 = (UIImageView *)[self viewWithTag:rightTagBegin+14];
    if (imageViewcard5 == nil)
    {
        imageViewcard5 = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint+ftempWidth+fwidthsep*8+fimageWidth*4+flabelCardWidth*4, fHeight, fimageWidth, fimageHeight)];
        imageViewcard5.backgroundColor = [UIColor clearColor];
        imageViewcard5.userInteractionEnabled = YES;
        imageViewcard5.tag = rightTagBegin+14;
        imageViewcard5.hidden = YES;
        [self addSubview:imageViewcard5];
        [imageViewcard5 release];
    }
    imageViewcard5.image = MaxImageAccordCardNumber(dataInfo->maxCards[4]);
    
    
    UILabel   *labelMaxCard5 = (UILabel *)[self viewWithTag:rightTagBegin+15];
    if (labelMaxCard5 == nil)
    {
        labelMaxCard5 = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint+ftempWidth+fwidthsep*8+fimageWidth*5+flabelCardWidth*4, fHeight+3, flabelCardWidth, flabelCardHeight)];
        labelMaxCard5.tag = rightTagBegin+15;
        [labelMaxCard5 setTextColor:[UIColor whiteColor]];
        [labelMaxCard5 setBackgroundColor:[UIColor clearColor]];
        [labelMaxCard5 setHidden:YES];
        [labelMaxCard5 setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:labelMaxCard5];
        [labelMaxCard5 release];
        
    }
    [labelMaxCard5 setText:SetCardNumber(dataInfo->maxCards[4])];
    
    fHeight += fSep+flabelHeight;
    UILabel   *labelMaxWin= (UILabel *)[self viewWithTag:rightTagBegin+16];
    if (labelMaxWin == nil)
    {
        labelMaxWin = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint, fHeight, ftempWidth, flabelHeight)];
        labelMaxWin.tag = rightTagBegin+16;
        [labelMaxWin setTextColor:[UIColor whiteColor]];
        [labelMaxWin setBackgroundColor:[UIColor clearColor]];
        [labelMaxWin setHidden:YES];
        [self addSubview:labelMaxWin];
        [labelMaxWin release];
        
    }
    [labelMaxWin setText:NSLocalizedString(@"最多赢取：", nil)];
    
    
    UIImageView  *imageViewChips = (UIImageView *)[self viewWithTag:rightTagBegin+17];
    if (imageViewChips == nil)
    {
        imageViewChips = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint+fwidthsep+ftempWidth, fHeight+4, 15, 15)];
        imageViewChips.backgroundColor = [UIColor clearColor];
        imageViewChips.userInteractionEnabled = YES;
        imageViewChips.tag = rightTagBegin+17;
        imageViewChips.hidden = YES;
        [self addSubview:imageViewChips];
        [imageViewChips release];
    }
    imageViewChips.image = [UIImage imageNamed:@"small_chips.png"];
    
    
    UILabel   *labelMaxWinNumber= (UILabel *)[self viewWithTag:rightTagBegin+18];
    if (labelMaxWinNumber == nil)
    {
        labelMaxWinNumber = [[UILabel alloc] initWithFrame:CGRectMake(fXpoint+fwidthsep*3+ftempWidth+15, fHeight, flabelWidth, flabelHeight)];
        labelMaxWinNumber.tag = rightTagBegin+18;
        [labelMaxWinNumber setTextColor:[UIColor whiteColor]];
        [labelMaxWinNumber setBackgroundColor:[UIColor clearColor]];
        [labelMaxWinNumber setHidden:YES];
        [self addSubview:labelMaxWinNumber];
        [labelMaxWinNumber release];
        
    }
    [labelMaxWinNumber setText:[NSString stringWithFormat:@"%d",dataInfo->max_win]];
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
