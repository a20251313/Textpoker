//
//  NSString+subStringCount.m
//  Texas-pokes
//
//  Created by ran on 12-8-9.
//
//

#import "NSString+subStringCount.h"

@implementation NSString (subStringCount)

+(NSInteger)countOfsubString:(NSString *)strTemp Mainstring:(NSString *)strMainString
{
    NSInteger   iCount = 0;
    BOOL    bFind = NO;
    do
    {
        NSRange  range = [strMainString rangeOfString:strTemp];
        if (range.location != NSNotFound)
        {
            iCount++;
            strMainString = [strMainString substringFromIndex:range.location+range.length];
            bFind = YES;
        }else
        {
            bFind = NO;
        }
        
    } while (!bFind);
    
    
    
    return iCount;
    
}

@end
