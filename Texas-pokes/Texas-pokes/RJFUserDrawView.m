//
//  RJFUserDrawView.m
//  Texas-pokes
//
//  Created by popo on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFUserDrawView.h"

@implementation RJFUserDrawView
@synthesize lineColor = m_LineColor;
NSString  *BNRSTOPTIMER = @"BNRSTOPTIMER";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.lineColor = [UIColor blueColor];
        m_arrayPoint = [[NSMutableArray alloc] init];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        
        self.backgroundColor = [UIColor clearColor];
        NSNotificationCenter  *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(StopTimer:)
                   name:BNRSTOPTIMER
                 object:nil];
        // Initialization code
    }
    return self;
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 06 29
 *  @brief
 *          invoke by noti BNRSTOPTIMER
 *  @param
 *          note
 *              note
 *	@return
 *          NONE
 *
 */
-(void)StopTimer:(NSNotification *)note
{
   logMyLogInfo(@"begin stop timer:%@",note);
    
    m_bStopTimer = YES;
    if (![m_arrayPoint count])
    {
        [self setNeedsDisplay];
        return;
    }
    
    if (m_timer)
    {
        
        [m_timer invalidate];
        [m_timer release];
        m_timer = nil;
    }
    [m_arrayPoint removeAllObjects];
 
  
  // [m_arrayPoint removeAllObjects];
    [self setNeedsDisplay];
 //   logMyLogInfo(@"end stop timer:%@",note);
}

/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 06 29
 *  @brief
 *          remove PointFromArray and display
 *  @param
 *          Timer
 *              Timer
 *	@return
 *          NONE
 *
 */
-(void)DeletePointFromArray:(id)Timer
{
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    m_leavetimer -= m_sepTime;
    if (m_leavetimer < 5 && !m_bHasPlayAlarm)
    {
        m_bHasPlayAlarm = YES;
        // RJFUserImageView  *userView =(RJFUserImageView*)self.superview;
        //[self.superview PlayAudio:@"alarm_active.mp3"];
        [self.superview performSelector:@selector(PlayAudio:)
                               onThread:[NSThread currentThread]
                             withObject:@"alarm_active.mp3"
                          waitUntilDone:YES];
        // [RJFaudioPlay PlayMyAudio:@"alarm_active.mp3"];
    }
    //NSLog(@"count:%d",[m_arrayPoint count]);
    
    if (m_bStopTimer)
    {
        if (m_timer)
        {
            [m_timer invalidate];   
            [m_timer release];
            m_timer = nil;
        }
        [m_arrayPoint removeAllObjects];
        [self setNeedsDisplay];
        [pool drain];
        return;
    }
    
    if ([m_arrayPoint count])
    {
       
        int iCount = 0;
        CGFloat  fCount = m_iarrayCount*1.0-[m_arrayPoint count]*1.0;
        if (fCount > 0)
        {
            fCount = fCount/([m_arrayPoint count]*1.0);
            if (fCount >= 2.5)
            {
                iCount = 4;
            }else if(fCount >= 1)
            {
                iCount = 2;
            }else if (fCount < 1)
            {
                iCount = 1;
            }
        }else
        {
            iCount = 0;
        }
        // logMyLogInfo(@"count:%f",fCount);
        switch(iCount)
        {
                
            case 4:
               // m_LineColor = [UIColor redColor];
                break;
            case 2:
              //  m_LineColor = [UIColor yellowColor];
                break;
            case 1:
               // m_LineColor = [UIColor greenColor];
                break;
            default:
                break;
        }
        [m_arrayPoint removeObjectAtIndex:0];
     
    }else
    {
        m_bStopTimer = NO;
        if (m_timer)
        {

            [m_timer invalidate];
            [m_timer release];
            m_timer = nil;
            
            
            
            // RJFUserImageView  *userView = (RJFUserImageView*)self.superview;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:BNRSTOPTIMER
                                                                object:self.superview];
            // NSLog(@"superview:%@",self.superview);
        }
       
    }
    [self setNeedsDisplay];
    // logMyLogInfo(@"%d",[m_arrayPoint count]);
    [pool drain];
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 06 29
 *  @brief
 *          start a timer to display rect around view
 *  @param
 *          Timer
 *              Timer
 *	@return
 *          NONE
 *
 */
-(void)StartTimer:(NSNumber*)timer
{
    logMyLogInfo(@"begin start timer:%@",timer);
    if (m_timer)
    {
        [m_timer invalidate];
        [m_timer release];
        m_timer = nil;
    }
    m_leavetimer = [timer floatValue];
   
    [self AddallPointToArrayPoint:nil];

    
    m_sepTime = [timer floatValue]/(m_iarrayCount*1.0f);
    m_bStopTimer = NO;
    m_bHasPlayAlarm = NO;
    // logMyLogInfo(@"septimer:%f",m_sepTime);
   /* m_timer = [NSTimer scheduledTimerWithTimeInterval:m_sepTime
                                               target:self
                                             selector:@selector(DeletePointFromArray:)
                                             userInfo:nil
                                              repeats:YES];*/
    m_timer = [[NSTimer alloc] initWithFireDate:[NSDate date]
                                       interval:m_sepTime
                                         target:self
                                       selector:@selector(DeletePointFromArray:)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:m_timer forMode:NSDefaultRunLoopMode];
    logMyLogInfo(@"End start timer:%@",timer);
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 08 02
 *  @brief
 *          override method
 *  @param
 *          rect
 *             rect will redraw
 *	@return
 *          NONE
 *
 */
- (void)drawRect:(CGRect)rect
{
    if (![m_arrayPoint count])
    {
        //CGContextStrokePath(context);
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = LINEWIDTH;
        return;
    }
    if (!m_bStopTimer)
    {
        NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
        for (int i = 0; i < [m_arrayPoint count]-1; i++)
        {
            if (i+1 > [m_arrayPoint count])
            {
                break;
            }
            
            CGContextRef  context = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context, LINEWIDTH);
            [m_LineColor set];
            CGPoint  point1 = [[m_arrayPoint objectAtIndex:i] CGPointValue];
            CGPoint point2 = [[m_arrayPoint objectAtIndex:i+1] CGPointValue];
            CGContextMoveToPoint(context,point1.x, point1.y);
            CGContextAddLineToPoint(context, point2.x, point2.y);
            CGContextSetLineCap(context, kCGLineCapRound);
            CGContextSetLineJoin(context, kCGLineJoinRound);
            CGContextStrokePath(context);
            // CGContextDrawPath(context, kCGPathEOFillStroke);
        }
        
        [pool drain];
        
    }else
    {
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = LINEWIDTH;
    }
 
    // [self drawInContext:UIGraphicsGetCurrentContext()];
    // Drawing code
}


-(void)drawInContext:(CGContextRef)theContext
{
    if (![m_arrayPoint count])
    {
        
        return;
    }
    for (int i = 0; i < [m_arrayPoint count]-1; i++)
    {
        if (i+1 > [m_arrayPoint count])
        {
            break;
        }
        
        NSDictionary  *dicInfo = [m_arrayPoint objectAtIndex:i];
        CGPoint  point1 = [[dicInfo valueForKey:@"POINT"] CGPointValue];
        CGPoint point2 = [[[m_arrayPoint objectAtIndex:i+1] valueForKey:@"POINT"] CGPointValue];
        CGMutablePathRef   path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, point1.x, point1.y);
        CGPathAddLineToPoint(path, NULL, point2.x, point2.y);
        
        
        CGContextBeginPath(theContext);
        CGContextAddPath(theContext, path);
        CGContextSetLineWidth(theContext, LINEWIDTH);
        CGContextSetLineCap(theContext, kCGLineCapRound);
        CGContextSetLineJoin(theContext, kCGLineJoinRound);
        CGContextSetStrokeColorWithColor(theContext, [m_LineColor CGColor]);
        CGContextStrokePath(theContext);
        CFRelease(path);
    }
}




/*
 -(void)AddallPointToArrayPoint:(id)Thread
 {
 [m_arrayPoint removeAllObjects];
 int  fwidth = self.frame.size.width;
 int  fHeight = self.frame.size.height;
 NSDictionary   *dicInfo  = nil;;
 CGFloat  linewidth = LINEWIDTH/2;
 for (int i = fwidth/2; i < fwidth-4-1; i++)
 {
 
 NSValue   *value = [NSValue valueWithCGPoint:CGPointMake(i+linewidth, linewidth)];
 dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:value,@"POINT",@"HU",@"0", nil];
 [m_arrayPoint addObject:dicInfo];
 // CGMutablePathRef  thepath = CGPathCreateMutable();
 // [m_arrayPoint addObject:the];
 
 }
 
 dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSValue valueWithCGPoint:CGPointMake(fwidth-4+linewidth, linewidth)],@"POINT",@"HU",@"1", nil];
 [m_arrayPoint addObject:dicInfo];
 dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"HU",@"0",[NSValue valueWithCGPoint:CGPointMake(fwidth-linewidth, 5+linewidth)],@"POINT", nil];
 [m_arrayPoint addObject:dicInfo];
 
 
 
 for (int i = 4; i < fHeight-4; i++)
 {
 //[m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth, i)]];
 NSValue   *value = [NSValue valueWithCGPoint:CGPointMake(fwidth-linewidth, i+linewidth)];
 NSDictionary   *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:value,@"POINT",@"HU",@"0", nil];
 [m_arrayPoint addObject:dicInfo];
 // logMyLogInfo(@"NSVALUE:%@\n",[NSValue valueWithCGPoint:CGPointMake(fwidth, i)]);
 }
 
 
 dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSValue valueWithCGPoint:CGPointMake(fwidth-linewidth, fHeight-4+linewidth)],@"POINT",@"HU",@"1",nil];
 [m_arrayPoint addObject:dicInfo];
 dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"HU",@"0",[NSValue valueWithCGPoint:CGPointMake(fwidth-linewidth, fHeight-linewidth)],@"POINT", nil];
 [m_arrayPoint addObject:dicInfo];
 
 
 for (int i = fwidth-4; i > 4; i--)
 {
 NSValue   *value = [NSValue valueWithCGPoint:CGPointMake(i+linewidth, fHeight-linewidth)];
 dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:value,@"POINT",@"HU",@"0", nil];
 [m_arrayPoint addObject:dicInfo];
 
 //[m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(i, fHeight)]];
 // logMyLogInfo(@"NSVALUE:%@\n",[NSValue valueWithCGPoint:CGPointMake(i, fHeight)]);
 }
 
 
 dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSValue valueWithCGPoint:CGPointMake(4+linewidth, fHeight-linewidth)],@"POINT",@"HU",@"1",nil];
 [m_arrayPoint addObject:dicInfo];
 dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"HU",@"0",[NSValue valueWithCGPoint:CGPointMake(0+linewidth, fHeight-4+linewidth)],@"POINT", nil];
 [m_arrayPoint addObject:dicInfo];
 for (int i = fHeight-4; i > 4; i--)
 {
 //[m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(0,i)]];
 
 NSValue   *value = [NSValue valueWithCGPoint:CGPointMake(linewidth,i-linewidth)];
 dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:value,@"POINT",@"HU",@"0", nil];
 [m_arrayPoint addObject:dicInfo];
 // logMyLogInfo(@"NSVALUE:%@\n",[NSValue valueWithCGPoint:CGPointMake(0, i)]);
 }
 
 
 
 dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSValue valueWithCGPoint:CGPointMake(0+linewidth, 4-linewidth)],@"POINT",@"HU",@"1",nil];
 [m_arrayPoint addObject:dicInfo];
 dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"HU",@"0",[NSValue valueWithCGPoint:CGPointMake(4-linewidth, 0+linewidth)],@"POINT", nil];
 [m_arrayPoint addObject:dicInfo];
 for (int i = 4; i < fwidth/2; i++)
 {
 
 NSValue   *value = [NSValue valueWithCGPoint:CGPointMake(i+linewidth, linewidth)];
 dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:value,@"POINT",@"HU",@"0", nil];
 [m_arrayPoint addObject:dicInfo];
 //  [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(i, 0)]];
 }
 m_iarrayCount = [m_arrayPoint count];
 }*/


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 06 29
 *  @brief
 *          Add whole point to array
 *  @param
 *          Timer
 *              Timer
 *	@return
 *          NONE
 *
 */
-(void)AddallPointToArrayPoint:(id)Thread
{
    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
    [m_arrayPoint removeAllObjects];
    int  fwidth = self.frame.size.width;
    int  fHeight = self.frame.size.height;
    CGFloat  faddwidth = LINEWIDTH/2;
    for (int i = fwidth/2; i < fwidth-4; i++)
    {
        [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(i, 0+faddwidth)]];
    }
    
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-4, 1+faddwidth)]];
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-3, 2+faddwidth)]];
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-2, 3+faddwidth)]];
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-1, 4+faddwidth)]];
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-0, 5+faddwidth)]];
    
    
    for (int i = 4; i < fHeight-4; i++)
    {
        [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-faddwidth, i+faddwidth)]];
        // logMyLogInfo(@"NSVALUE:%@\n",[NSValue valueWithCGPoint:CGPointMake(fwidth, i)]);
    }
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-faddwidth, fHeight-4+faddwidth)]];
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-1-faddwidth, fHeight-3+faddwidth)]];
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-2-faddwidth, fHeight-2+faddwidth)]];
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-3-faddwidth, fHeight-1+faddwidth)]];
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-4-faddwidth, fHeight+faddwidth)]];
    for (int i = fwidth-4; i > 4; i--)
    {
        [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(i, fHeight-faddwidth)]];
        // logMyLogInfo(@"NSVALUE:%@\n",[NSValue valueWithCGPoint:CGPointMake(i, fHeight)]);
    }
    
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(4, fHeight-faddwidth)]];
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(3, fHeight-1-faddwidth)]];
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(2, fHeight-2-faddwidth)]];
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(1, fHeight-3-faddwidth)]];
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(0, fHeight-4-faddwidth)]];
    for (int i = fHeight-4; i > 4; i--)
    {
        [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(0+faddwidth,i)]];
        // logMyLogInfo(@"NSVALUE:%@\n",[NSValue valueWithCGPoint:CGPointMake(0, i)]);
    }
    
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(0+faddwidth, 4)]];
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(1+faddwidth, 3)]];
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(2+faddwidth, 2)]];
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(3+faddwidth, 1)]];
    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(4+faddwidth, 0)]];
    for (int i = 4; i < fwidth/2; i++)
    {
        [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(i+faddwidth, 0+faddwidth)]];
    }
    m_iarrayCount = [m_arrayPoint count];
    [pool drain];
}


/*!
 *  @author
 *          jingfu Ran
 *  @since
 *          2012 06 29
 *  @brief
 *          override method dealloc
 *	@return
 *          NONE
 *
 */
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (m_arrayPoint)
    {
        [m_arrayPoint removeAllObjects];
        [m_arrayPoint release];
        m_arrayPoint = nil;
    }
    [super dealloc];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(BOOL)respondsToSelector:(SEL)aSelector
{
    logMyLogInfo(@"userDrawView.........SELECTOR: %@...........\n", NSStringFromSelector(aSelector));
    return [super respondsToSelector:aSelector];
}

@end


//
//  RJFUserDrawView.m
//  Texas-pokes
//
//  Created by popo on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//
//#import "RJFUserDrawView.h"
//
//@implementation RJFUserDrawView
//NSString  *BNRSTOPTIMER = @"BNRSTOPTIMER";
//
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self)
//    {
//        m_LineColor = [UIColor greenColor];
//        m_arrayPoint = [[NSMutableArray alloc] init];
//        self.layer.masksToBounds = YES;
//        self.layer.cornerRadius = 3;
//        self.backgroundColor = [UIColor clearColor];
//        NSNotificationCenter  *nc = [NSNotificationCenter defaultCenter];
//        [nc addObserver:self
//               selector:@selector(StopTimer:)
//                   name:BNRSTOPTIMER
//                 object:nil];
//        // Initialization code
//    }
//    return self;
//}
//
//
///*!
// *  @author
// *          jingfu Ran
// *  @since
// *          2012 06 29
// *  @brief
// *          invoke by noti BNRSTOPTIMER
// *  @param
// *          note
// *              note
// *	@return
// *          NONE
// *
// */
//-(void)StopTimer:(NSNotification *)note
//{
//
//    m_bStopTimer = YES;
//    // [m_arrayPoint removeAllObjects];
//    //[self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0.1f];
//
//
//}
//
///*!
// *  @author
// *          jingfu Ran
// *  @since
// *          2012 06 29
// *  @brief
// *          remove PointFromArray and display
// *  @param
// *          Timer
// *              Timer
// *	@return
// *          NONE
// *
// */
//-(void)DeletePointFromArray:(id)Timer
//{
//    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
//    if ([m_arrayPoint count])
//    {
//        if (m_bStopTimer)
//        {
//            [m_arrayPoint removeAllObjects];
//            if (m_timer)
//            {
//                if ([m_timer isValid])
//                {
//                    [m_timer invalidate];
//                }
//                m_timer = nil;
//            }
//            [self setNeedsDisplay];
//            [pool drain];
//            return;
//        }
//        int iCount = 0;
//        CGFloat  fCount = m_iarrayCount*1.0-[m_arrayPoint count]*1.0;
//        if (fCount > 0)
//        {
//            fCount = fCount/([m_arrayPoint count]*1.0);
//            if (fCount >= 2.5)
//            {
//                iCount = 4;
//            }else if(fCount >= 1)
//            {
//                iCount = 2;
//            }else if (fCount < 1)
//            {
//                iCount = 1;
//            }
//        }else
//        {
//            iCount = 0;
//        }
//        // logMyLogInfo(@"count:%f",fCount);
//        switch(iCount)
//        {
//
//            case 4:
//                m_LineColor = [UIColor redColor];
//                break;
//            case 2:
//                m_LineColor = [UIColor yellowColor];
//                break;
//            case 1:
//                m_LineColor = [UIColor greenColor];
//                break;
//            default:
//                break;
//        }
//        [m_arrayPoint removeObjectAtIndex:0];
//        [self setNeedsDisplay];
//    }else
//    {
//        m_bStopTimer = NO;
//        if (m_timer)
//        {
//            if ([m_timer isValid])
//            {
//                [m_timer invalidate];
//            }
//            m_timer = nil;
//        }
//        [self setNeedsDisplay];
//    }
//    // logMyLogInfo(@"%d",[m_arrayPoint count]);
//    [pool drain];
//}
//
//
///*!
// *  @author
// *          jingfu Ran
// *  @since
// *          2012 06 29
// *  @brief
// *          start a timer to display rect around view
// *  @param
// *          Timer
// *              Timer
// *	@return
// *          NONE
// *
// */
//-(void)StartTimer:(NSTimeInterval)timer
//{
//    if (m_timer)
//    {
//        [m_timer invalidate];
//        m_timer = nil;
//    }
//    m_bStopTimer = NO;
//    [self AddallPointToArrayPoint:nil];
//    m_LineColor = [UIColor greenColor];
//    m_timer = [NSTimer scheduledTimerWithTimeInterval:timer/(m_iarrayCount*1.0f)
//                                               target:self
//                                             selector:@selector(DeletePointFromArray:)
//                                             userInfo:nil
//                                              repeats:YES];
//    [m_timer fire];
//}
//
//
///*!
// *  @author
// *          jingfu Ran
// *  @since
// *          2012 08 02
// *  @brief
// *          override method
// *  @param
// *          rect
// *             rect will redraw
// *	@return
// *          NONE
// *
// */
//- (void)drawRect:(CGRect)rect
//{
//    /*if (![m_arrayPoint count])
//    {
//        //CGContextStrokePath(context);
//        return;
//    }
//    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
//    for (int i = 0; i < [m_arrayPoint count]-1; i++)
//    {
//        if (i+1 > [m_arrayPoint count])
//        {
//            break;
//        }
//        CGContextRef  context = UIGraphicsGetCurrentContext();
//        CGContextSetLineWidth(context, LINEWIDTH);
//        [m_LineColor set];
//        CGPoint  point1 = [[m_arrayPoint objectAtIndex:i] CGPointValue];
//        CGPoint point2 = [[m_arrayPoint objectAtIndex:i+1] CGPointValue];
//        CGContextMoveToPoint(context,point1.x, point1.y);
//        //CGContextAddLineToPoint(context, point2.x, point2.y);
//        CGContextAddCurveToPoint(context, point1.x,point1.y,(point2.x+point1.x)/2,(point2.y+point1.y)/2,point2.y, point2.y);
//
//
//        CGContextSetLineCap(context, kCGLineCapRound);
//        //CGContextSetLineJoin(context, kCGLineJoinRound);
//        CGContextStrokePath(context);
//    }
//
//    [pool drain];*/
//
//    /*CGContextRef  context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, LINEWIDTH);
//    [m_LineColor set];
//   // CGPoint  point1 = CGPointMake(0, 0);
//    //CGPoint point2 = CGPointMake(2, 2);
//   // CGContextMoveToPoint(context,point1.x, point1.y);
//    //CGContextAddLineToPoint(context, point2.x, point2.y);
//    //CGContextAddCurveToPoint(context, point1.x,point1.y,(point2.x+point1.x)/2,(point2.y+point1.y)/2,point2.y, point2.y);
//    CGContextAddArcToPoint(context, 0, 0, 2, 2, 1);
//
//    CGContextSetLineCap(context, kCGLineCapRound);
//    CGContextSetLineJoin(context, kCGLineJoinRound);
//    CGContextStrokePath(context);*/
//     //[self drawInContext:UIGraphicsGetCurrentContext()];
//    [self drawInContextAccordlength:UIGraphicsGetCurrentContext()];
//    // Drawing code
//}
//
//
//
//-(void)drawInContextAccordlength:(CGContextRef)theContext
//{
//
//
//
//    CGRect   frame = self.bounds;
//    CGFloat   fwidth = frame.size.width-LINEWIDTH*2;
//    CGFloat   fheight = frame.size.height-LINEWIDTH*2;
//    CGFloat   fsep = 4;
//
//    CGContextRef  context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, LINEWIDTH);
//    [m_LineColor set];
//
//
//
//   // CGContextMoveToPoint(theContext, fsep, fsep);
//  //  CGContextAddLineToPoint(theContext, fwidth+fsep, fsep);
//
//    CGContextStrokePath(context);
//
//   // CGContextAddArc(theContext, fwidth-fsep, fsep/2,2, 0, M_PI_2, 0);
//    CGContextSetLineCap(context, kCGLineCapRound);
//    CGContextSetLineJoin(context, kCGLineJoinRound);
//    //CGContextAddRect(theContext, CGRectMake(LINEWIDTH,LINEWIDTH, self.frame.size.width-LINEWIDTH*2, self.frame.size.height-LINEWIDTH*2));
//    CGContextAddEllipseInRect(theContext,CGRectMake(0,-10, fwidth, fheight+20));
//    CGContextStrokePath(context);
//
//
//   /* CGPoint  point1 = CGPointMake(0, 2);
//    CGPoint point2 =    CGPointMake(fwidth, 0);
//    CGMutablePathRef   path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, point1.x, point1.y);
//    CGPathAddLineToPoint(path, NULL, point2.x, point2.y);
//    CGPathAddLineToPoint(path, NULL, point2.x, point2.y);
//     CGContextAddArcToPoint(theContext, 0, 2, 10, 0, 5);
//    CGContextBeginPath(theContext);
//    CGContextAddPath(theContext, path);
//
//    CGContextSetLineWidth(theContext, LINEWIDTH);
//    CGContextSetLineCap(theContext, kCGLineCapRound);
//    CGContextSetLineJoin(theContext, kCGLineJoinRound);
//    CGContextSetStrokeColorWithColor(theContext, [m_LineColor CGColor]);
//    CGContextStrokePath(theContext);
//    CFRelease(path);*/
//
//}
//
//-(void)drawInContext:(CGContextRef)theContext
//{
//    if (![m_arrayPoint count])
//    {
//
//        return;
//    }
//    for (int i = 0; i < [m_arrayPoint count]-1; i++)
//    {
//        if (i+1 > [m_arrayPoint count])
//        {
//            break;
//        }
//
//        NSDictionary  *dicInfo = [m_arrayPoint objectAtIndex:i+1];
//        CGPoint  point1 = [[dicInfo valueForKey:@"POINT"] CGPointValue];
//        CGPoint point2 = [[[m_arrayPoint objectAtIndex:i+1] valueForKey:@"POINT"] CGPointValue];
//        CGMutablePathRef   path = CGPathCreateMutable();
//        CGPathMoveToPoint(path, NULL, point1.x, point1.y);
//        CGPathAddLineToPoint(path, NULL, point2.x, point2.y);
//         if (![[dicInfo valueForKey:@"HU"] boolValue])
//         {
//
//         CGPathAddLineToPoint(path, NULL, point2.x, point2.y);
//
//         }else
//         {
//         //CGPathAddArc(path, NULL, (point1.x+point2.x)/2, (point1.y+point2.y)/2, 2, -M_PI_4, M_PI+4, YES);
//         //CGPathAddCurveToPoint(path, NULL, point1.x, point1.y, (point1.x+point2.x)/2, (point1.y+point2.y)/2, point2.x, point2.y);
//         //CGContextAddArcToPoint(theContext, point1.x, point1.y, point2.x, point2.y, 5);
//         //CGContextAddQuadCurveToPoint(theContext, point1.x, point1.y,point2.x, point2.y);
//
//         }
//
//        CGContextBeginPath(theContext);
//        CGContextAddPath(theContext, path);
//        CGContextSetLineWidth(theContext, LINEWIDTH);
//        CGContextSetLineCap(theContext, kCGLineCapRound);
//        CGContextSetLineJoin(theContext, kCGLineJoinRound);
//        CGContextSetStrokeColorWithColor(theContext, [m_LineColor CGColor]);
//        CGContextStrokePath(theContext);
//        CFRelease(path);
//    }
//}
//
//
//
//
//
// -(void)AddallPointToArrayPoint:(id)Thread
// {
// [m_arrayPoint removeAllObjects];
// int  fwidth = self.frame.size.width;
// int  fHeight = self.frame.size.height;
// NSDictionary   *dicInfo  = nil;;
// CGFloat  linewidth = LINEWIDTH/2;
// for (int i = fwidth/2; i < fwidth-4-1; i++)
// {
//
// NSValue   *value = [NSValue valueWithCGPoint:CGPointMake(i+linewidth, linewidth)];
// dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:value,@"POINT",@"HU",@"0", nil];
// [m_arrayPoint addObject:dicInfo];
// // CGMutablePathRef  thepath = CGPathCreateMutable();
// // [m_arrayPoint addObject:the];
//
// }
//
// dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSValue valueWithCGPoint:CGPointMake(fwidth-4+linewidth, linewidth)],@"POINT",@"HU",@"1", nil];
// [m_arrayPoint addObject:dicInfo];
// dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"HU",@"1",[NSValue valueWithCGPoint:CGPointMake(fwidth-linewidth, 5+linewidth)],@"POINT", nil];
// [m_arrayPoint addObject:dicInfo];
//
//
//
// for (int i = 4; i < fHeight-4; i++)
// {
// //[m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth, i)]];
// NSValue   *value = [NSValue valueWithCGPoint:CGPointMake(fwidth-linewidth, i+linewidth)];
// NSDictionary   *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:value,@"POINT",@"HU",@"0", nil];
// [m_arrayPoint addObject:dicInfo];
// // logMyLogInfo(@"NSVALUE:%@\n",[NSValue valueWithCGPoint:CGPointMake(fwidth, i)]);
// }
//
//
// dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSValue valueWithCGPoint:CGPointMake(fwidth-linewidth, fHeight-4+linewidth)],@"POINT",@"HU",@"1",nil];
// [m_arrayPoint addObject:dicInfo];
// dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"HU",@"1",[NSValue valueWithCGPoint:CGPointMake(fwidth-linewidth, fHeight-linewidth)],@"POINT", nil];
// [m_arrayPoint addObject:dicInfo];
//
//
// for (int i = fwidth-4; i > 4; i--)
// {
// NSValue   *value = [NSValue valueWithCGPoint:CGPointMake(i+linewidth, fHeight-linewidth)];
// dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:value,@"POINT",@"HU",@"0", nil];
// [m_arrayPoint addObject:dicInfo];
//
// //[m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(i, fHeight)]];
// // logMyLogInfo(@"NSVALUE:%@\n",[NSValue valueWithCGPoint:CGPointMake(i, fHeight)]);
// }
//
//
// dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSValue valueWithCGPoint:CGPointMake(4+linewidth, fHeight-linewidth)],@"POINT",@"HU",@"1",nil];
// [m_arrayPoint addObject:dicInfo];
// dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"HU",@"1",[NSValue valueWithCGPoint:CGPointMake(0+linewidth, fHeight-4+linewidth)],@"POINT", nil];
// [m_arrayPoint addObject:dicInfo];
// for (int i = fHeight-4; i > 4; i--)
// {
// //[m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(0,i)]];
//
// NSValue   *value = [NSValue valueWithCGPoint:CGPointMake(linewidth,i-linewidth)];
// dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:value,@"POINT",@"HU",@"0", nil];
// [m_arrayPoint addObject:dicInfo];
// // logMyLogInfo(@"NSVALUE:%@\n",[NSValue valueWithCGPoint:CGPointMake(0, i)]);
// }
//
//
//
// dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSValue valueWithCGPoint:CGPointMake(0+linewidth, 4-linewidth)],@"POINT",@"HU",@"1",nil];
// [m_arrayPoint addObject:dicInfo];
// dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"HU",@"1",[NSValue valueWithCGPoint:CGPointMake(4-linewidth, 0+linewidth)],@"POINT", nil];
// [m_arrayPoint addObject:dicInfo];
// for (int i = 4; i < fwidth/2; i++)
// {
//
// NSValue   *value = [NSValue valueWithCGPoint:CGPointMake(i+linewidth, linewidth)];
// dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:value,@"POINT",@"HU",@"0", nil];
// [m_arrayPoint addObject:dicInfo];
// //  [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(i, 0)]];
// }
// m_iarrayCount = [m_arrayPoint count];
// }
//
//
///*!
// *  @author
// *          jingfu Ran
// *  @since
// *          2012 06 29
// *  @brief
// *          Add whole point to array
// *  @param
// *          Timer
// *              Timer
// *	@return
// *          NONE
// *
// *
//-(void)AddallPointToArrayPoint:(id)Thread
//{
//    NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc] init];
//    [m_arrayPoint removeAllObjects];
//    int  fwidth = self.frame.size.width;
//    int  fHeight = self.frame.size.height;
//    CGFloat  faddwidth = LINEWIDTH/2;
//    for (int i = fwidth/2; i < fwidth-4; i++)
//    {
//        [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(i, 0+faddwidth)]];
//    }
//
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-4, 1+faddwidth)]];
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-3, 2+faddwidth)]];
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-2, 3+faddwidth)]];
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-1, 4+faddwidth)]];
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-0, 5+faddwidth)]];
//
//
//    for (int i = 4; i < fHeight-4; i++)
//    {
//        [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-faddwidth, i+faddwidth)]];
//        // logMyLogInfo(@"NSVALUE:%@\n",[NSValue valueWithCGPoint:CGPointMake(fwidth, i)]);
//    }
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-faddwidth, fHeight-4+faddwidth)]];
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-1-faddwidth, fHeight-3+faddwidth)]];
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-2-faddwidth, fHeight-2+faddwidth)]];
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-3-faddwidth, fHeight-1+faddwidth)]];
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(fwidth-4-faddwidth, fHeight+faddwidth)]];
//    for (int i = fwidth-4; i > 4; i--)
//    {
//        [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(i, fHeight-faddwidth)]];
//        // logMyLogInfo(@"NSVALUE:%@\n",[NSValue valueWithCGPoint:CGPointMake(i, fHeight)]);
//    }
//
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(4, fHeight-faddwidth)]];
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(3, fHeight-1-faddwidth)]];
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(2, fHeight-2-faddwidth)]];
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(1, fHeight-3-faddwidth)]];
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(0, fHeight-4-faddwidth)]];
//    for (int i = fHeight-4; i > 4; i--)
//    {
//        [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(0+faddwidth,i)]];
//        // logMyLogInfo(@"NSVALUE:%@\n",[NSValue valueWithCGPoint:CGPointMake(0, i)]);
//    }
//
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(0+faddwidth, 4)]];
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(1+faddwidth, 3)]];
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(2+faddwidth, 2)]];
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(3+faddwidth, 1)]];
//    [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(4+faddwidth, 0)]];
//    for (int i = 4; i < fwidth/2; i++)
//    {
//        [m_arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(i+faddwidth, 0+faddwidth)]];
//    }
//    m_iarrayCount = [m_arrayPoint count];
//    [pool drain];
//}*/
//
//
///*!
// *  @author
// *          jingfu Ran
// *  @since
// *          2012 06 29
// *  @brief
// *          override method dealloc
// *	@return
// *          NONE
// *
// */
//-(void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    if (m_arrayPoint)
//    {
//        [m_arrayPoint removeAllObjects];
//        [m_arrayPoint release];
//        m_arrayPoint = nil;
//    }
//    [super dealloc];
//}
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//
//@end
//
