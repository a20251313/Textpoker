//
//  RJFUserDrawView.h
//  Texas-pokes
//
//  Created by popo on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PublicDefine.h"
@class RJFUserImageView;

@interface RJFUserDrawView : UIView
{
   
    NSTimer          *m_timer;
    UIColor          *m_LineColor;
    NSMutableArray   *m_arrayPoint;
    
    NSUInteger        m_iarrayCount;
    BOOL              m_bStopTimer;
    CGFloat           m_leavetimer;
    CGFloat           m_sepTime;
    BOOL              m_bHasPlayAlarm;
}

@property(retain)  UIColor  *lineColor;

-(void)StartTimer:(NSNumber*)timer;
-(void)AddallPointToArrayPoint:(id)Thread;
-(void)StopTimer:(NSNotification *)note;
@end
