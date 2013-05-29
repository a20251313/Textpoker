//
//  NSString+Number.m
//  Texas-pokes
//
//  Created by popo on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+Number.h"

@implementation NSString (Number)

+(NSString *)stringWithNeedTranfanstring:(id)strMyNumber returnType:(ReturnType)returnType;
{
    NSString * strNumber = nil;
    if (![strMyNumber isKindOfClass:[NSString class]])
    {
        strNumber = [strMyNumber description];
        strNumber = [strNumber lowercaseString];
    }else
    {
        strNumber = [strMyNumber lowercaseString];
    }
    
    NSString    *strChar = @"!@#$￥* ,";
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:strChar];
    strNumber = [strNumber stringByTrimmingCharactersInSet:set];
    if ([strNumber rangeOfString:@"k"].location != NSNotFound)
    {
        
        strNumber = [strNumber stringByReplacingOccurrencesOfString:@"k" withString:@""];
        strNumber = [NSString stringWithFormat:@"%d",[strNumber intValue]*1000];
    }
    if ([strNumber rangeOfString:@"w"].location != NSNotFound)
    {
        strNumber = [strNumber stringByReplacingOccurrencesOfString:@"w" withString:@""];
        strNumber = [NSString stringWithFormat:@"%d",[strNumber intValue]*10000];
    }
    
    if ([strNumber rangeOfString:@"m"].location != NSNotFound)
    {
        strNumber = [strNumber stringByReplacingOccurrencesOfString:@"m" withString:@""];
        strNumber = [NSString stringWithFormat:@"%d",[strNumber intValue]*1000000];
    }
    strNumber = [strNumber stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    int  iValue = [strNumber intValue];;
    NSString  *strReturn = nil;
    switch (returnType)
    {
        case COMMOMTYPE:
            
            [NSNumberFormatter setDefaultFormatterBehavior:NSNumberFormatterBehavior10_4];
            NSNumber  *number = [NSNumber numberWithInt:iValue];
            NSNumberFormatter  *format = [[NSNumberFormatter alloc] init];
            [format setNumberStyle:NSNumberFormatterDecimalStyle];
            strReturn = [format stringFromNumber:number];
            [format release];
            break;
        case KWLOWCASETYPE:
            if (iValue/10000 > 0)
            {
                strReturn = [NSString stringWithFormat:@"%dw",iValue/10000];
                if (iValue%10000 > 0)
                {
                    strReturn = [NSString stringWithFormat:@"%0.1fw",iValue*1.0/10000*1.0f];
                }
                
            }else if(iValue/1000 > 0)
            {
                strReturn = [NSString stringWithFormat:@"%dk",iValue/1000];
            }else
            {
                strReturn = [NSString stringWithFormat:@"%d",iValue];
            }
            
            break;
        case KWHIGHCASETYPE:
            if (iValue/10000 > 0)
            {
                strReturn = [NSString stringWithFormat:@"%dW",iValue/10000];
                if (iValue/1000 > 0)
                {
                    strReturn = [NSString stringWithFormat:@"%0.1f",iValue*1.0/10000*1.0f];
                }
            }else if(iValue/1000 > 0)
            {
                strReturn = [NSString stringWithFormat:@"%dK",iValue/1000];
            }else
            {
                strReturn = [NSString stringWithFormat:@"%d",iValue];
            }
            break;
        case NORMALTYPE:
            strReturn = [NSString stringWithFormat:@"%d",iValue];
            break;
        case GAMESHOWTYPE:
            if (iValue >= 1000000)
            {
                strReturn = [NSString stringWithFormat:@"%.0fk",iValue*1.0f/1000.0f*1.0];
            }else
            {
                [NSNumberFormatter setDefaultFormatterBehavior:NSNumberFormatterBehavior10_4];
                NSNumber  *number = [NSNumber numberWithInt:iValue];
                NSNumberFormatter  *format = [[NSNumberFormatter alloc] init];
                [format setNumberStyle:NSNumberFormatterDecimalStyle];
                strReturn = [format stringFromNumber:number];
                [format release];
            }
            break;
            
        default:
            break;
    }
    // NSLog(@"@@@@@@@@@@@@@@before:%@ after:%@",strNumber,strReturn);
    return strReturn;
}

+(NSString *)stringWithNeedTranfanNumber:(NSInteger)iNumber returnType:(ReturnType)returnType;
{
    
    int  iValue = iNumber;
    NSString  *strReturn = nil;
    switch (returnType)
    {
        case COMMOMTYPE:
            if (iValue >= 1000)
            {
                strReturn = [NSString stringWithFormat:@"%dk",iValue/1000];
                break;
            }
            [NSNumberFormatter setDefaultFormatterBehavior:NSNumberFormatterBehavior10_4];
            NSNumber  *number = [NSNumber numberWithInt:iValue];
            NSNumberFormatter  *format = [[NSNumberFormatter alloc] init];
            [format setNumberStyle:NSNumberFormatterDecimalStyle];
            strReturn = [format stringFromNumber:number];
            [format release];
            break;
        case KWLOWCASETYPE:
            if (iValue/10000 > 0)
            {
                strReturn = [NSString stringWithFormat:@"%dw",iValue/10000];
                if (iValue%10000 > 0)
                {
                    strReturn = [NSString stringWithFormat:@"%0.1fw",iValue*1.0/10000*1.0f];
                }
                
            }else if(iValue/1000 > 0)
            {
                strReturn = [NSString stringWithFormat:@"%dk",iValue/1000];
            }else
            {
                strReturn = [NSString stringWithFormat:@"%d",iValue];
            }
            break;
        case KWHIGHCASETYPE:
            if (iValue/10000 > 0)
            {
                strReturn = [NSString stringWithFormat:@"%dW",iValue/10000];
            }else if(iValue/1000 > 0)
            {
                strReturn = [NSString stringWithFormat:@"%dK",iValue/1000];
            }else
            {
                strReturn = [NSString stringWithFormat:@"%d",iValue];
            }
            break;
        case NORMALTYPE:
            strReturn = [NSString stringWithFormat:@"%d",iValue];
            break;
        case GAMESHOWTYPE:
            if (iValue >= 1000000)
            {
                strReturn = [NSString stringWithFormat:@"%.0fk",iValue*1.0f/1000.0f*1.0];
            }else
            {
                [NSNumberFormatter setDefaultFormatterBehavior:NSNumberFormatterBehavior10_4];
                NSNumber  *number = [NSNumber numberWithInt:iValue];
                NSNumberFormatter  *format = [[NSNumberFormatter alloc] init];
                [format setNumberStyle:NSNumberFormatterDecimalStyle];
                strReturn = [format stringFromNumber:number];
                [format release];
            }
            
        default:
            break;
    }
    
    //NSLog(@"！！！！！！！！！！！before:%d after:%@",iNumber,strReturn);
    return strReturn;
}

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
        
    } while (bFind);
    
    
    
    return iCount;
    
}
@end
