//
//  GalkovskyVC.h
//  Kinotaf
//
//  Created by Константин Забелин on 23.01.12.
//  Copyright (c) 2012 Zababako. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalkovskyVC : UIViewController
@property (retain, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)deadEndPressed;

@end
