	//
	//  LJLoader.m
	//  Kinotaf
	//
	//  Created by Константин Забелин on 18.01.12.
	//  Copyright (c) 2012 Zababako. All rights reserved.
	//

#import "LJLoader.h"

#import "XMLRPCConnectionManager.h"
#import "XMLRPCConnection.h"
#import "XMLRPCRequest.h"
#import "XMLRPCResponse.h"

@interface LJLoader()
{
	XMLRPCRequest *request_;
	NSMutableData *data_;
}
@property (retain, readonly, nonatomic) XMLRPCRequest *request;
@end

@implementation LJLoader

- (void)dealloc
{
	[request_ release];
	[data_ release];
	
	[super dealloc];
}

- (XMLRPCRequest *)request
{
	if (request_) { return request_; }
	
	NSURL* url = [NSURL URLWithString:@"http://www.livejournal.com/interface/xmlrpc"];
	
	request_ = [[XMLRPCRequest alloc] initWithURL:url];
	[request_ setMethod:@"LJ.XMLRPC.getchallenge" withParameter:nil];	
	
	NSLog(@"Request body: %@", [request_ body]);
	
	return request_;
}

- (void)start
{
	XMLRPCConnectionManager *manager = [XMLRPCConnectionManager sharedManager];
	[manager spawnConnectionWithXMLRPCRequest:self.request delegate: self];
}

#pragma mark - Connection delegate methods

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"Thread that finishes: %@", [[NSThread currentThread] name]);
	NSString* result = [[NSString alloc] initWithData:data_ encoding:NSUTF8StringEncoding];
	
	NSLog(@"Succeeded! Received %d bytes of data, interpretated as a string: %@",[data_ length], result);
    
    [request_ release];
	request_ = nil;
    [data_ release];
	data_ = nil;
}

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
	
	[data_ setLength:0];
}

- (void)request:(XMLRPCRequest *)request didFailWithError: (NSError *)error
{
    [request_ release];
	request_ = nil;
    [data_ release];
	data_ = nil;
    
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
