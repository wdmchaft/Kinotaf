//
//  LJLoader.h
//  Kinotaf
//
//  Created by Константин Забелин on 18.01.12.
//  Copyright (c) 2012 Zababako. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJLoader : NSObject <NSPortDelegate>

- (void)downloadPosts;
- (void)getChallenge;

@end
