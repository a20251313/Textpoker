//
//  ROPayDB.m
//  RenrenSDKDemo
//
//  Created by xiawenhai on 11-10-19.
//  Copyright 2011 renren.com. All rights reserved.
//

#import "ROPayDB.h"

#define DB_NAME @"RenrenPayRecord.db"


@implementation ROPayDB


- (BOOL)initDatabase
{
	BOOL success;
	NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
	
    db = [[FMDatabase databaseWithPath:writableDBPath] retain];
    if ([db open]) {
        [db setShouldCacheStatements:YES];
        success = YES;
    }else{
#ifdef DEBUG_VERSION
        logMyLogInfo(@"Failed to open database.");
#endif
        success = NO;
    }
    
    if (success) {
        char *errorMsg;
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS ORDERS (ORDERNUM TEXT PRIMARY KEY,APPID TEXT,TRADINGVOLUME TEXT,ORDERTIME TEXT,SERIALNUM TEXT,USERID TEXT,LOCALORDERSTATUS TEXT,SERVERORDERSTATUS TEXT,PAYENCODE TEXT,DESCRIPTION TEXT,CHECKCODE TEXT,ISTESTORDER TEXT,PAYSTATUSCODE TEXT,PAYMENT TEXT);";
        if (sqlite3_exec([db sqliteHandle], [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            [db close];
#ifdef DEBUG_VERSION
            logMyLogInfo(@"Failed to Create table.");
#endif
            success = NO;
        }
    }
	
	return success;
}


- (void)closeDatabase
{
	[db close];
}


- (FMDatabase *)getDatabase
{
    return db;
}


- (void)dealloc
{
	[self closeDatabase];
	
	[db release];
	[super dealloc];
}

@end
