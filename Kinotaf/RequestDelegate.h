//
//  RequestDelegate.h
//  Kinotaf
//
//  Created by Константин Забелин on 30.01.12.
//  Copyright (c) 2012 Zababako. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XMLRPCConnectionDelegate.h"

@interface RequestDelegate : NSObject<XMLRPCConnectionDelegate>

@property (retain) id result;
@property (nonatomic, copy) NSString *requstId;

@end
