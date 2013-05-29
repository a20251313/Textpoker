//
//  BasisZipAndUnzip+PhaseAndLoad.h
//  TestZip
//
//  Created by ran on 12-8-22.
//  Copyright (c) 2012年 ran. All rights reserved.
//

#import "BasisZipAndUnzip+Other_userinfo.h"

@interface BasisZipAndUnzip (PhaseAndLoad)

-(int8_t *)syncWithRequest:(int16_t)requestCode
                    userID:(int32_t)userID
               structArray:(void*)handle;
-(void *)PhaseInfoFromData:(int8_t *)data
            outRequestCode:(int*)outReqiestCode;


@end
