//
//  RJFShowWordLabel.m
//  Texas-pokes
//
//  Created by ran on 12-10-19.
//
//

#import "RJFShowWordLabel.h"

@implementation RJFShowWordLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_arrStoreWords = [[NSMutableArray alloc] init];
        // Initialization code
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
-(void)StartShow
{
    NSInteger   icount = 10;
    if ([self.text length]*2 < strlen([self.text UTF8String]))
    {
        icount = 4;
    }
    
    int pos = 0;
    int  iTotalLength = [self.text length];
    
    do
    {
#if DEBUG
        NSLog(@"pos:%d icount:%d",pos,icount);
#endif
        if((pos+icount) < iTotalLength)
        {
            NSString *strMessage = [self.text substringWithRange:NSMakeRange(pos, icount)];
            [m_arrStoreWords addObject:strMessage];
        }else if(pos < iTotalLength && pos+icount >= iTotalLength)
        {
            NSString *strMessage = [self.text substringFromIndex:pos];
            [m_arrStoreWords addObject:strMessage];
            break;
        }
        pos += icount;
        if (pos > iTotalLength)
        {
            break;
        }
        
    }while(1);
   

    m_timer = [[NSTimer alloc] initWithFireDate:[NSDate date]
                                       interval:5
                                         target:self
                                       selector:@selector(SHowMsg:)
                                       userInfo:nil
                                        repeats:YES];
  // [m_timer fire];
    [[NSRunLoop currentRunLoop] addTimer:m_timer forMode:NSDefaultRunLoopMode];
    

    
    
}

-(void)SHowMsg:(id)Timer
{
    if ([m_arrStoreWords count])
    {
        [self setText:[m_arrStoreWords objectAtIndex:0]];
        [m_arrStoreWords removeObjectAtIndex:0];
    }else
    {
       // [m_timer invalidate];
        if (self.superview && self.superview.superview)
        {
              [self.superview removeFromSuperview];
        }
      
    }
    
}
-(void)dealloc
{
    [m_arrStoreWords removeAllObjects];
    [m_arrStoreWords release];
    m_arrStoreWords = nil;
    if (m_timer)
    {
        [m_timer invalidate];
       [m_timer release];
        m_timer = nil;
    }
    [super dealloc];
}
@end
