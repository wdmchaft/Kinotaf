//
//  LJLoader.m
//  Kinotaf
//
//  Created by Константин Забелин on 18.01.12.
//  Copyright (c) 2012 Zababako. All rights reserved.
//

#import "LJLoader.h"

@interface LJLoader()
{
	NSURLConnection *connection_;
	NSMutableData *data_;
}
@property (retain, readonly, nonatomic) NSURLConnection *connection;
@end

@implementation LJLoader

- (void)dealloc
{
	[connection_ release];
	[data_ release];
	
	[super dealloc];
}

- (NSURLConnection *)connection
{
	if (connection_) { return connection_; }
	
	NSURL* url = [NSURL URLWithString:@"http://www.livejournal.com/interface/flat"];
	
	NSString *bodyString = @"mode=getchallenge";
	NSData* body = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:body];

	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%llu", [body length]] forHTTPHeaderField:@"Content-Length"];
	
	connection_ = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	if (connection_) {
		data_ = [[NSMutableData data] retain];
	}
	else {
		NSLog(@"Couldn't create a connection");
	}
	return connection_;
}

- (void)start
{
	[self.connection start];
}

#pragma mark - Connection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
	assert([httpResponse isKindOfClass:[NSHTTPURLResponse class]]);
	
	NSLog(@"Connection recieved a response with header fields: %@", [httpResponse allHeaderFields]);
	[data_ setLength:0];
	
    if ((httpResponse.statusCode / 100) != 2) {
		NSLog(@"HTTP error %zd", (ssize_t) httpResponse.statusCode);
    } else {
		NSLog(@"Response OK.");
    }    
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
	NSLog(@"Connection will cache response");
	return nil;
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
	NSLog(@"Connection should use credential storage");
	return NO;
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	NSLog(@"Connection will send request for authentication challenge");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	NSLog(@"Connection recieved data: %@", data);
	[data_ appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	if (connection != connection_) { return; }

    [connection_ release];
	connection_ = nil;
    [data_ release];
	data_ = nil;
    
	NSLog(@"Connection failed! Error - %@ %@",
		  [error localizedDescription],
		  [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSString* result = [[NSString alloc] initWithData:data_ encoding:NSUTF8StringEncoding];

	NSLog(@"Succeeded! Received %d bytes of data, interpretated as a string: %@",[data_ length], result);
    
	
    [connection_ release];
	connection_ = nil;
    [data_ release];
	data_ = nil;
}

@end
