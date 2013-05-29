//
//  Texas_pokesTests.m
//  Texas-pokesTests
//
//  Created by popo on 12-6-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Texas_pokesTests.h"
#import "NSString+Number.h"
#import "BasisZipAndUnzip+PhaseAndLoad.h"

@implementation Texas_pokesTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
 
    int8_t    *card = malloc(sizeof(int8_t)*5);

    card[0] = 0;
    card[1] = 1;
    card[2] = 3;
    card[3] = 5;
    card[4] = 6;
    
    [self TestSort:card carnumber:5];
    //[self cardType:card Number:5];
}



-(void)TestSort:(int8_t *)cardSort carnumber:(int)cardNumber
{
    for (int i = 0;i < 7;i++)
    {
        
        int count = -1;
        for (int j = 0; j < cardNumber; j++)
        {
            
            if (i == cardSort[j])
            {
                count = 1;
                 NSLog(@"%i == cardSort[%i]:%d",i,j,cardSort[j]);
                //logMyLogInfo(@"cardsort[%d] == %d",j,cardSort[j]);
                break;
            }
            
            
        }
        if (count == -1)
        {
            if (i < 5)
            {
                NSLog(@"%i < 5",i);
            }else
            {
                 NSLog(@"%i > 5",i);
                //[userView setCardAlpha:i];
                /*  if (i == 5)
                 {
                 userView.imageViewCardOne.alpha = 0.5;
                 
                 }else if (i == 6)
                 {
                 userView.imageViewCardTwo.alpha = 0.5;
                 }*/
            }
        }
        
    }

}

@end
