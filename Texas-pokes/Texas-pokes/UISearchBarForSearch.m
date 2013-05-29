//
//  UISearchBarForSearch.m
//  Texas-pokes
//
//  Created by ran on 12-11-13.
//
//

#import "UISearchBarForSearch.h"

@implementation UISearchBarForSearch

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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

- (void)drawRect:(CGRect)rect
{
      UIImage *image = [UIImage imageNamed:@"word_mid.png"];
      [image drawInRect:rect];
}
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    UIImage *img = [UIImage imageNamed:@"word_mid.png"];
    UIImageView *v = [[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
  //  v.alpha = 0.0;
    [v setImage:img];
    v.bounds = CGRectMake(0, 0, img.size.width+2, img.size.height);
   // NSLog([NSString stringWithFormat:@"%f:%f",img.size.width, img.size.height]);
    NSArray *subs = self.subviews;
    for (int i = 0; i < [subs count]; i++) {
        id subv = [self.subviews objectAtIndex:i];
        if ([subv isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
        {
            CGRect viewRect = [subv frame];
            [v setFrame:viewRect];
            [self insertSubview:v atIndex:i];
        }
    }
    [v setNeedsDisplay];
    [v setNeedsLayout];
}

@end
