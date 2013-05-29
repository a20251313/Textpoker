//
//  PushManager.h
//  i366
//
//  Created by admin on 12-11-16.
//
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"

@interface PushManager : NSObject
{
    AsyncSocket *_socket;
    
    NSMutableData *receiveData;
    
    NSData *_tokenData;
    
    int addFlag;    //0:delete 1: add
    
    int sendMsgFlag; //0:sendToken 1:resetBadgeNumber
    
    int iMyID;

}

@property(nonatomic, retain) NSData *tokenData;
@property int addFlag;
@property int sendMsgFlag;
@property int iMyID;

+ (id)sharedManager;

- (void)connectToHost:(NSString *)host andPort:(int)port;

- (void)disconnect;

- (void)deleteAppCenter;

@end
