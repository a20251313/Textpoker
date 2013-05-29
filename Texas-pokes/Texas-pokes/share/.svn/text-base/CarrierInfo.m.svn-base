//
//  CarrierInfo.m
//  I366_V1_4
//
//  Created by  on 12-4-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CarrierInfo.h"

@implementation CarrierInfo

- (NSString *)carrierName
{
    CTTelephonyNetworkInfo *tni = [[CTTelephonyNetworkInfo alloc] init];
    
    NSString *crtCarrierName = tni.subscriberCellularProvider.carrierName;
    
    [tni release];
    
    return crtCarrierName;
}

- (NSString *)carrierCountryName
{
    CTTelephonyNetworkInfo *tni = [[CTTelephonyNetworkInfo alloc] init];
    
    NSString *crtCarrierName = tni.subscriberCellularProvider.isoCountryCode;
    
    [tni release];
    
    return crtCarrierName;
}

@end
