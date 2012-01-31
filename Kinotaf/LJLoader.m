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

#define kCheckInMessage 100

NSString* LJInterfaceURL = @"http://www.livejournal.com/interface/xmlrpc";

@interface LJLoader()
{
	BOOL		requestThreadShouldStop_;
	NSRunLoop*	requestRunLoop_;
	NSThread*	requestThread_;	
	
	NSMutableSet *requestDelegates_;
}

@end

@implementation LJLoader

#pragma mark - Main Thread

- (id)init
{
	self = [super init];
	if (!self) { return nil; }
	
	requestDelegates_ = [[NSMutableSet alloc] init];
		
	requestThreadShouldStop_ = NO;
	
	NSPort *port = [NSMachPort port];
	port.delegate = self;
	assert(port);
	
	[[NSRunLoop currentRunLoop] addPort:port forMode:NSDefaultRunLoopMode];
	
	[self performSelectorInBackground:@selector(launchRequestThreadWithPort:) withObject:port];
	
	return self;
}

- (void)dealloc
{
	NSLog(@"LJ loader deallocated");
	requestThreadShouldStop_ = YES;

	[requestDelegates_ release];

	[super dealloc];
}

- (void)getChallenge
{
	NSURL*		url =		[NSURL URLWithString:LJInterfaceURL];	
	NSString*	method =	@"LJ.XMLRPC.getchallenge";
	
	XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL:url];
	[request setMethod:method withParameter:nil];	
	
	static long int i = 0;
	RequestDelegate *requestDelegate = [[RequestDelegate alloc] init];
	requestDelegate.requstId = [NSString stringWithFormat:@"%@,%d", method, ++i];

	[requestDelegates_ addObject:requestDelegate];
	[requestDelegate release];
		
	NSDictionary* userInfo = [NSDictionary dictionaryWithObjectsAndKeys:request, @"request", requestDelegate, @"requestDelegate", nil];
	[request release];
								
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

- (void)handlePortMessage:(NSPortMessage *)portMessage
{
	NSLog(@"Handling port message");

	unsigned int message = [portMessage msgid];
	if (message == kCheckInMessage)
	{
		
	}
}

#pragma mark - Requests Thread

- (void)launchRequestThreadWithPort:(NSPort *)toMainPort
{
	@autoreleasepool 
	{
		requestThread_  = [NSThread currentThread];
		requestRunLoop_ = [NSRunLoop currentRunLoop];
		
			// TODO: store toMainPort
		
		NSPort *toRequestPort = [NSMachPort port];
		[requestRunLoop_ addPort:toRequestPort forMode:NSDefaultRunLoopMode];
		
		NSPortMessage *messageObj = [[NSPortMessage alloc] initWithSendPort:toMainPort receivePort:toRequestPort components:nil];
		if (messageObj)
		{
				// Finish configuring the message and send it immediately.
			[messageObj setMsgid:kCheckInMessage];
			[messageObj sendBeforeDate:[NSDate date]];
		}
		[messageObj release];
		
		while (!requestThreadShouldStop_ && [requestRunLoop_ runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]]); // [NSDate distantFuture]
				
		requestRunLoop_ = nil;
		requestThread_  = nil;
		
		NSLog(@"Request thread ended");
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
