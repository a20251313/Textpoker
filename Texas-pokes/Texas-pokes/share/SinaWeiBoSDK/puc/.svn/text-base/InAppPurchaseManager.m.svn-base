//
//  InAppPurchaseManager.m
//  I366_V1_4
//
//  Created by  on 12-6-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InAppPurchaseManager.h"
#import "RJFChargeViewController.h"

#define kMyFeatureIdentifier @"com.opopo.i366.30idou"

#ifndef CHARGEHOST
#define CHARGEHOST                  @"texasfee.lelechat.com"
#define CHARGEPORT                  1990
#endif
@implementation InAppPurchaseManager
@synthesize productsRequest = _productsRequest;
@synthesize orderNumberOfProducts = _orderNumberOfProducts;
@synthesize delegate;
static InAppPurchaseManager *purchase = nil;

- (id)init
{
     
    self = [super init];
    if (self)
    {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
        self.orderNumberOfProducts = array;
        [array release];
    }
    
    return self;
    
}

+ (InAppPurchaseManager *)sharedAppPurchase
{
    if (!purchase)
    {
        purchase = [[InAppPurchaseManager alloc] init];
    }
    
    return purchase;
}

+ (void)closePurchase
{
    if (purchase)
    {
        [purchase release];
        purchase = nil;
    }
}

- (void)dealloc
{
#ifdef DEBUG_VERSION
    NSLog(@"InAppPurchaseManager dealloc");
#endif
    
    [_productsRequest cancel];
    [_productsRequest setDelegate:nil];
    self.productsRequest = nil;
    self.orderNumberOfProducts = nil;
    
    [proUpgradeProduct release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}

- (void)requestProUpgradeProductDataWithProductID:(NSString *)productID andOrderNumber:(NSString *)orderNumber
{  
    NSSet *productIdentifiers = [NSSet setWithObject:productID];  
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers]; 
    self.productsRequest = request;
    _productsRequest.delegate = self;  
    [_productsRequest start];  
    [request release];
    
    [_orderNumberOfProducts addObject:orderNumber];
    //[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    // we will release the request object in the delegate callback  
}  

#pragma mark -  
#pragma mark SKProductsRequestDelegate methods  

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response  
{  
    NSArray *products = response.products;  
    proUpgradeProduct = [products count] == 1 ? [[products objectAtIndex:0] retain] : nil;  
    if (proUpgradeProduct)  
    {  
        NSLog(@"Product title: %@" , proUpgradeProduct.localizedTitle);  
        NSLog(@"Product description: %@" , proUpgradeProduct.localizedDescription);  
        NSLog(@"Product price: %@" , proUpgradeProduct.price);  
        NSLog(@"Product id: %@" , proUpgradeProduct.productIdentifier);  
        
       // SKPayment *payment = [SKPayment paymentWithProductIdentifier:proUpgradeProduct.productIdentifier];
        SKPayment *payment = [SKPayment paymentWithProduct:proUpgradeProduct];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }  
    
    for (NSString *invalidProductId in response.invalidProductIdentifiers)  
    {  
        NSLog(@"Invalid product id: %@" , invalidProductId);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetShopListInAppStoreFail" object:nil];
    }  
    
    // finally release the reqest we alloc/init’ed in requestProUpgradeProductData  
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerProductsFetchedNotification object:self userInfo:nil];  
   
    if (delegate && [delegate respondsToSelector:@selector(removeHUDView:)])
    {
        [(RJFChargeViewController *)delegate removeHUDView:nil];
        
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"completeTransaction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(completeTransaction:)
                                                 name:@"completeTransaction"
                                               object:nil];
    
   
}

- (void)completeTransaction:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"completeTransaction"
                                                  object:nil];
    
   
    if ([_orderNumberOfProducts lastObject] != nil)
    {
        if (delegate)
        {
            ShowHUD(@"验证充值信息中..........", (RJFChargeViewController *)delegate,180);
        }
        NSString *orderNumber = [NSString stringWithString:[_orderNumberOfProducts objectAtIndex:0]];
        [_orderNumberOfProducts removeObjectAtIndex:0];
        
        SKPaymentTransaction *transaction = [notification object];
        NSString *tradeid = transaction.transactionIdentifier;
        NSString *productid = proUpgradeProduct.productIdentifier;
        
        NSString *recepit = [GTMBase64 stringByEncodingData:transaction.transactionReceipt];
        NSDictionary *tempDict = [NSDictionary dictionaryWithObject:recepit forKey:@"receipt-data"];
        NSString *jsonValue = [tempDict JSONRepresentation];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *logPath = [documentsDirectory stringByAppendingPathComponent:@"log.txt"];
        [jsonValue writeToFile:logPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
//        NSLog(@"json value : %@", jsonValue);
        
       /* char *orderID = (char *)[orderNumber cStringUsingEncoding:NSUnicodeStringEncoding];
        char *tradeID = (char *)[tradeid cStringUsingEncoding:NSUnicodeStringEncoding];
        char *productID = (char *)[productid cStringUsingEncoding:NSUnicodeStringEncoding];
        char *receiptData = (char *)[jsonValue cStringUsingEncoding:NSUnicodeStringEncoding];*/
        
        
        
        
        
        DZPK_CLIENT_REQ_CHARGE_FOR_IPHONE  clientInfo = {orderNumber,tradeid,productid,DZPKPROTROLVERSION,jsonValue};
        RJFTcpSocket  *socket = [RJFTcpSocket shareInitWithHost:CHARGEHOST
                                                           Port:CHARGEPORT
                                                       Delagate:nil
                                                            tag:CHARGESOCKETTAG];
        UserInfo  *shareUser = [UserInfo shareInstance];
        
        BasisZipAndUnzip  *basic = [[BasisZipAndUnzip alloc] initWithSize:10*1024];
        [socket SendCharMessage:[basic syncWithRequest:REQ_CHARGE_FOR_IPHONE
                                                userID:shareUser.userIDForDzpk
                                           structArray:&clientInfo] size:[basic dataSize]];
        [basic release];
      
        
      //  mmc_vim_send_transaction_to_server(orderID, tradeID, productID, receiptData);
    }
    
}

/*- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    NSLog(@"queue %@ array:%@",queue,transactions);
    if (![transactions count])
    {
        return;
    }
    if ([_orderNumberOfProducts lastObject] != nil)
    {
        NSString *orderNumber = [NSString stringWithString:[_orderNumberOfProducts objectAtIndex:0]];
        [_orderNumberOfProducts removeObjectAtIndex:0];
        
        SKPaymentTransaction *transaction = [transactions lastObject];
        NSLog(@"error:%@ status:%d",transaction.error,transaction.transactionState);
        
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                
                break;
            case SKPaymentTransactionStateFailed:
                
                break;
            case SKPaymentTransactionStatePurchasing:
                
                break;
            case SKPaymentTransactionStateRestored:
                
                break;
                
            default:
                break;
        }
        NSString *tradeid = transaction.transactionIdentifier;
        NSString *productid = proUpgradeProduct.productIdentifier;
        
        NSString *recepit = [GTMBase64 stringByEncodingData:transaction.transactionReceipt];
        NSDictionary *tempDict = [NSDictionary dictionaryWithObject:recepit forKey:@"receipt-data"];
        NSString *jsonValue = [tempDict JSONRepresentation];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *logPath = [documentsDirectory stringByAppendingPathComponent:@"log.txt"];
        [jsonValue writeToFile:logPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        //        NSLog(@"json value : %@", jsonValue);
        

        DZPK_CLIENT_REQ_CHARGE_FOR_IPHONE  clientInfo = {orderNumber,tradeid,productid,DZPKPROTROLVERSION,jsonValue};
        RJFTcpSocket  *socket = [RJFTcpSocket shareInitWithHost:CHARGEHOST
                                                           Port:CHARGEPORT
                                                       Delagate:nil
                                                            tag:CHARGESOCKETTAG];
        UserInfo  *shareUser = [UserInfo shareInstance];
        
        BasisZipAndUnzip  *basic = [[BasisZipAndUnzip alloc] init];
        [socket SendCharMessage:[basic syncWithRequest:REQ_CHARGE_FOR_IPHONE
                                                userID:shareUser.userID
                                           structArray:&clientInfo
                                          structNumber:1
                                              dataSize:&size] size:[basic dataSize]];
        [basic release];
        
        // mmc_vim_send_transaction_to_server(orderID, tradeID, productID, receiptData);
    }
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"queue:%@",queue);
}*/
@end
