//
//  RootVC.m
//  Kinotaf
//
//  Created by Константин Забелин on 14.01.12.
//  Copyright (c) 2012 Zababako. All rights reserved.
//

#import "RootVC.h"

#import "JournalVC.h"
#import "AboutVC.h"
#import "DeadEndVC.h"
#import "LibraryVC.h"

@interface RootVC()
{
}
@property (assign, nonatomic) CGFloat hue;
@end

@implementation RootVC
@synthesize infoButton;
@synthesize duckButton;
@synthesize deadEndButton;
@synthesize ljButton;
@synthesize continueButton;
@synthesize freshButton;
@synthesize libraryButton;
@synthesize hue = hue_;

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (!self) { return nil; }

	self.title = @"Главная";
	
	return self;
}

#pragma mark - View lifecycle

- (void)setHue:(CGFloat)hue
{
	if (hue > 1.0) { hue = 1.0; }
	if (hue < 0.0) { hue = 0.0; }
	if (hue_ == hue) { return; }
	hue_ = hue;
	
	self.navigationController.navigationBar.tintColor = [UIColor colorWithHue:hue_ saturation:1.0 brightness:0.6 alpha:1.0];
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
	
	self.hue = 0.5;
}

- (void)viewDidUnload
{
	[self setInfoButton:	nil];
	[self setDuckButton:	nil];
	[self setDeadEndButton:	nil];
	[self setLjButton:		nil];
	[self setContinueButton:nil];
	[self setFreshButton:	nil];
	[self setLibraryButton:	nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)dealloc {
	[infoButton release];
	[duckButton release];
	[deadEndButton release];
	[ljButton release];
	[continueButton release];
	[freshButton release];
	[libraryButton release];
	[super dealloc];
}

- (IBAction)ljButtonPressed:(id)sender 
{
	JournalVC *vc = [[JournalVC alloc] initWithNibName:@"JournalVC" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
	
	[self increaseHue];
}

- (IBAction)deadEndButtonPressed:(id)sender 
{
	DeadEndVC *vc = [[DeadEndVC alloc] initWithNibName:@"DeadEndVC" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];

	[self decreaseHue];
}

- (IBAction)duckButtonPressed:(id)sender 
{
	JournalVC *vc = [[JournalVC alloc] initWithNibName:@"JournalVC" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
	
	[self increaseHue];
}

- (IBAction)infoButtonPressed:(id)sender {
	AboutVC *vc = [[AboutVC alloc] initWithNibName:@"AboutVC" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
	
	[self decreaseHue];
}

- (IBAction)freshButtonPressed:(id)sender 
{
	JournalVC *vc = [[JournalVC alloc] initWithNibName:@"JournalVC" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
	
	[self increaseHue];
}

- (IBAction)continueButtonPressed:(id)sender 
{
	JournalVC *vc = [[JournalVC alloc] initWithNibName:@"JournalVC" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];	
	
	[self decreaseHue];
}

- (IBAction)libraryButtonPressed:(id)sender {
	LibraryVC *vc = [[LibraryVC alloc] initWithNibName:@"LibraryVC" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];	
	
	[self increaseHue];
}

@end
