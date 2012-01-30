	//
	//  LJLoader.m
	//  Kinotaf
	//
	//  Created by Константин Забелин on 18.01.12.
	//  Copyright (c) 2012 Zababako. All rights reserved.
	//

#import "LJLoader.h"

#import "XMLRPCRequest.h"
#import "XMLRPCConnectionManager.h"
#import "RequestDelegate.h"

NSString* KTLJInterfaceURL = @"http://www.livejournal.com/interface/xmlrpc";

@interface LJLoader()
{
	BOOL		requestThreadShouldStop_;
	NSRunLoop*	requestRunLoop_;
	NSThread*	requestThread_;	
	
	NSMutableDictionary *requestDelegates_;
}

- (void)requestThreadMain;
@end

@implementation LJLoader

#pragma mark - Main Thread

- (id)init
{
	self = [super init];
	if (!self) { return nil; }
	
	requestDelegates_ = [[NSMutableDictionary alloc] init];
		
	requestThreadShouldStop_ = NO;
	
	NSPort *port = [NSMachPort port];
	port.delegate = self;
	assert(port);
	
//	[[NSRunLoop currentRunLoop] addPort:port forMode:NSDefaultRunLoopMode];
	
	[self performSelectorInBackground:@selector(launchRequestThreadWithPort:) withObject:port];
	
	return self;
}

- (void)dealloc
{
	requestThreadShouldStop_ = YES;

	[requestDelegates_ release];

	[super dealloc];
}

- (void)getChallenge
{
	NSURL* url = [NSURL URLWithString:KTLJInterfaceURL];
	
	NSString *method = @"LJ.XMLRPC.getchallenge";
	
	XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL:url];
	[request setMethod:method withParameter:nil];	
	
	static long int i = 0;
	RequestDelegate *requestDelegate = [[RequestDelegate alloc] init];
	requestDelegate.requstId = [NSString stringWithFormat:@"%@,%d", method, ++i];
	
	[requestDelegate addObserver:self forKeyPath:@"result" options:0 context:nil];
	
	NSDictionary* userInfo = [NSDictionary dictionaryWithObjectsAndKeys:request, @"request", requestDelegate, @"requestDelegate", nil];
								
	[self performSelector:@selector(scheduleRequest:) onThread:requestThread_ withObject:userInfo waitUntilDone:NO];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	NSLog(@"Result value changed");
}

- (void)downloadPosts
{
		// TODO: implement
}

#pragma mark - Common Methods

- (void)handlePortMessage:(NSPortMessage *)message
{
	NSLog(@"Handling port message");
}

#pragma mark - Requests Thread

- (void)launchRequestThreadWithPort:(NSPort *)port
{
	@autoreleasepool 
	{
		requestThread_  = [NSThread currentThread];
		requestRunLoop_ = [NSRunLoop currentRunLoop];
		
		[requestRunLoop_ addPort:port forMode:NSDefaultRunLoopMode];
		
		while (!requestThreadShouldStop_ && [requestRunLoop_ runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
				
		requestRunLoop_ = nil;
		requestThread_  = nil;
	}
}

- (void)scheduleRequest:(NSDictionary *)userInfo
{
	XMLRPCRequest*		request =			[userInfo objectForKey:@"request"];
	RequestDelegate*	requestDelegate =	[userInfo objectForKey:@"requestDelegate"];
	
	assert(request);
	assert(requestDelegate);
	
	XMLRPCConnectionManager *manager = [XMLRPCConnectionManager sharedManager];
	[manager spawnConnectionWithXMLRPCRequest:request delegate: requestDelegate];
}

@end
