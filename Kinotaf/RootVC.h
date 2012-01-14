//
//  RootVC.h
//  Kinotaf
//
//  Created by Константин Забелин on 14.01.12.
//  Copyright (c) 2012 Zababako. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootVC : UIViewController

@property (retain, nonatomic) IBOutlet UIButton *infoButton;
@property (retain, nonatomic) IBOutlet UIButton *duckButton;
@property (retain, nonatomic) IBOutlet UIButton *deadEndButton;
@property (retain, nonatomic) IBOutlet UIButton *ljButton;

- (IBAction)ljButtonPressed:(id)sender;
- (IBAction)deadEndButtonPressed:(id)sender;
- (IBAction)duckButtonPressed:(id)sender;
- (IBAction)infoButtonPressed:(id)sender;

@end
