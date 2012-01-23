//
//  RootVC.m
//  Kinotaf
//
//  Created by Константин Забелин on 14.01.12.
//  Copyright (c) 2012 Zababako. All rights reserved.
//

#import "RootVC.h"

#import "JournalVC.h"
#import "DeadEndVC.h"
#import "LibraryVC.h"

#import "AboutVC.h"
#import "GalkovskyVC.h"
#import "ReaderVC.h"
#import "Search.h"

@interface RootVC()
{
}
@property (assign, nonatomic) CGFloat hue;
@end

@implementation RootVC
@synthesize infoButton;
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

- (void)dealloc 
{
	[infoButton release];
	[continueButton release];
	[freshButton release];
	[libraryButton release];
	[super dealloc];
}

- (IBAction)infoButtonPressed:(id)sender {
	AboutVC *vc = [[AboutVC alloc] initWithNibName:@"AboutVC" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
	
	[self decreaseHue];
}

- (IBAction)freshButtonPressed:(id)sender 
{
	ReaderVC *vc = [[ReaderVC alloc] initWithNibName:@"ReaderVC" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}

- (IBAction)continueButtonPressed:(id)sender 
{
	ReaderVC *vc = [[ReaderVC alloc] initWithNibName:@"ReaderVC" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];	
}

- (IBAction)libraryButtonPressed:(id)sender {
	LibraryVC *vc = [[LibraryVC alloc] initWithNibName:@"LibraryVC" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];	
	
	[self increaseHue];
}

- (IBAction)galkovskyButtonPressed:(id)sender 
{
	GalkovskyVC *vc = [[GalkovskyVC alloc] initWithNibName:@"GalkovskyVC" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}

- (IBAction)searchButtonPressed {
	Search *vc = [[Search alloc] initWithNibName:@"Search" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}

@end
