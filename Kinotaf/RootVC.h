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
@property (retain, nonatomic) IBOutlet UIButton *continueButton;
@property (retain, nonatomic) IBOutlet UIButton *freshButton;
@property (retain, nonatomic) IBOutlet UIButton *libraryButton;

- (IBAction)infoButtonPressed:(id)sender;
- (IBAction)freshButtonPressed:(id)sender;
- (IBAction)continueButtonPressed:(id)sender;
- (IBAction)libraryButtonPressed:(id)sender;
- (IBAction)galkovskyButtonPressed:(id)sender;

@end
