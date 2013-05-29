//
//  RJFGameInterface+RJFGame_FreshTeach.h
//  Texas-pokes
//
//  Created by popo on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJFGameInterface.h"
#import "PublicDefine.h"

@interface RJFGameInterface (RJFGame_FreshTeach)

-(void)setNextAndPreEnable:(BOOL)bEnable;
-(void)RemoveArrowViewIn345Location;
-(void)SetSeatForFresh:(id)Thread;
-(void)addCardArrayViewInselfview:(BOOL)bAdd location:(int)iLocation;
@end
