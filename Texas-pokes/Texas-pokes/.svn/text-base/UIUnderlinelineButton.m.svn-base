//
//  UIUnderlinelineButton.m
//  Texas-pokes
//
//  Created by popo on 12-7-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIUnderlinelineButton.h"

@implementation UIUnderlinelineButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



+ (UIUnderlinelineButton*) underlinedButton
{
    UIUnderlinelineButton * button = [[UIUnderlinelineButton alloc] init];
    [button setEnabled:YES];
    return [button autorelease];
}
- (void) drawRect:(CGRect)rect {
    CGRect textRect = self.titleLabel.frame;
    // need to put the line at top of descenders (negative value)
    CGFloat descender = self.titleLabel.font.descender;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    // set to same colour as text
    CGContextSetStrokeColorWithColor(contextRef, self.titleLabel.textColor.CGColor);
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender);
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender);
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke);
}

@end
