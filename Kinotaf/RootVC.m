//
//  RootVC.m
//  Kinotaf
//
//  Created by Константин Забелин on 14.01.12.
//  Copyright (c) 2012 Zababako. All rights reserved.
//

#import "RootVC.h"

@interface RootVC()
@property (assign, nonatomic) CGFloat hue;
@end

@implementation RootVC
@synthesize infoButton;
@synthesize duckButton;
@synthesize deadEndButton;
@synthesize ljButton;
@synthesize hue = hue_;

#pragma mark - View lifecycle

- (void)setHue:(CGFloat)hue
{
	if (hue > 1.0) { hue = 1.0; }
	if (hue < 0.0) { hue = 0.0; }
	if (hue_ == hue) { return; }
	hue_ = hue;
	
	self.navigationController.navigationBar.tintColor = [UIColor colorWithHue:hue_ saturation:1.0 brightness:1.0 alpha:1.0];
}

- (void)increaseHue {
	self.hue = self.hue + 0.1;
}

- (void)decreaseHue {
	self.hue = self.hue - 0.1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.title = @"Главная";
	self.hue = 0.5;
}

- (void)viewDidUnload
{
	[self setInfoButton:nil];
	[self setDuckButton:nil];
	[self setDeadEndButton:nil];
	[self setLjButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)dealloc {
	[infoButton release];
	[duckButton release];
	[deadEndButton release];
	[ljButton release];
	[super dealloc];
}
- (IBAction)ljButtonPressed:(id)sender {
	[self increaseHue];
}

- (IBAction)deadEndButtonPressed:(id)sender {
	[self decreaseHue];
}

- (IBAction)duckButtonPressed:(id)sender {
	[self increaseHue];
}

- (IBAction)infoButtonPressed:(id)sender {
	[self decreaseHue];
}

@end
