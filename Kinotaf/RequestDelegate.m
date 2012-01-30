//
//  RequestDelegate.m
//  Kinotaf
//
//  Created by Константин Забелин on 30.01.12.
//  Copyright (c) 2012 Zababako. All rights reserved.
//

#import "RequestDelegate.h"
#import "XMLRPCResponse.h"

@implementation RequestDelegate

@synthesize result;
@synthesize requstId;

#pragma mark - XMLRPCConnection delegate

- (void)request:(XMLRPCRequest *)request didReceiveResponse: (XMLRPCResponse *)response
{	
	if ([response isFault]) 
	{
        NSLog(@"Fault code: %@",   [response faultCode]);
        NSLog(@"Fault string: %@", [response faultString]);
    } else {
        NSLog(@"Parsed response: %@", [response object]);
    }
	
    NSLog(@"Response body: %@", [response body]);
	
	self.result = response.object;
}

- (void)request:(XMLRPCRequest *)request didFailWithError: (NSError *)error
{
	NSLog(@"Connection failed! Error - %@ %@",
		  [error localizedDescription],
		  [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (BOOL)request:(XMLRPCRequest *)request canAuthenticateAgainstProtectionSpace: (NSURLProtectionSpace *)protectionSpace
{
	NSLog(@"Requset can authenticate against protection space, but NO");
	return NO;
}

- (void)request:(XMLRPCRequest *)request didReceiveAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge
{
	NSLog(@"Requst received authentication challenge");
}

- (void)request: (XMLRPCRequest *)request didCancelAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge
{
	NSLog(@"Requst cancelled authentication challenge");
}

@end
