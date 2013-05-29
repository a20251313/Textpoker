//
//  MyStoreObserver.m
//  SignatureN
//
//  Created by fanshao on 09-9-1.
//  Copyright 2009 Sensky. All rights reserved.
//

#import "MyStoreObserver.h"
#import<UIKit/UIKit.h>
#import<UIKit/UIAlert.h>
#import "JSON.h"

@implementation MyStoreObserver


- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
	NSLog(@"paymetnQueue");
	for (SKPaymentTransaction* transaction in transactions)
	{
		switch (transaction.transactionState)
		{
			case SKPaymentTransactionStatePurchased:
				NSLog(@"Complete Transaction");
				[self completeTransaction:transaction];
				break;
			case SKPaymentTransactionStateFailed:
                NSLog(@",,,,,,Fail Transaction");
				[self failedTransaction:transaction];
				break;
			case SKPaymentTransactionStateRestored:
                NSLog(@"Restore Transaction");
                [self restoreTransaction:transaction];
				break;
			default:
				break;
		}
	}
}

- (void) PurchasedTransaction: (SKPaymentTransaction *)transaction
{
	NSArray *transactions =[[NSArray alloc] initWithObjects:transaction, nil];
	[self paymentQueue:[SKPaymentQueue defaultQueue] updatedTransactions:transactions];
	[transactions release];
}
				
- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
	NSLog(@"Transaction　complete");
    NSLog(@"Transaction transactionIdentifier : %@", transaction.transactionIdentifier);
	[[NSNotificationCenter defaultCenter]  postNotificationName:@"completeTransaction" object:transaction];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"faliedTransaction" object:nil];
	[[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction
{
    NSLog(@"paymentQueueRestoreCompletedTransactionsFinished");
}

-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error
{

    NSLog(@"restoreCompletedTransactionsFailedWithError");
}


#pragma mark connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	NSLog(@"receipt response : %@",  [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]);
	//[self.receivedData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	switch([(NSHTTPURLResponse *)response statusCode]) {
		case 200:
		case 206:
			break;
		case 304:
	
			break;
		case 400:

			break;
			
			
		case 404:
		break;
		case 416:
			break;
		case 403:
			break;
		case 401:
		case 500:
			break;
		default:
			break;
	}	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	

}

@end
