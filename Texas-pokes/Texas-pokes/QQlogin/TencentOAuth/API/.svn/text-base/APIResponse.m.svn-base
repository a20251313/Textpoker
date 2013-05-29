//
//  APIResponse.m
//  TencentOAuthDemo
//
//  Created by cloudxu on 11-8-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
/*!
    @header APIResponse.m
    @abstract   <#abstract#>
    @discussion <#description#>
*/

#import "APIResponse.h"


@implementation APIResponse

@synthesize retCode = _retCode;
@synthesize seq = _seq;
@synthesize errorMsg = _errorMsg;
@synthesize jsonResponse = _jsonResponse;
@synthesize message=_message;

- (void)dealloc {
	[_errorMsg release];
	[_jsonResponse release];
	[super dealloc];
}


-(NSString *)description
{
    return [NSString stringWithFormat:@"retCode:%d seq:%d errMsg:%@ jsonResponse:%@ message:%@",self.retCode,self.seq,self.errorMsg,self.jsonResponse,self.message];
}

@end