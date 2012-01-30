//
//  JournalVC.m
//  Kinotaf
//
//  Created by Константин Забелин on 15.01.12.
//  Copyright (c) 2012 Zababako. All rights reserved.
//

#import "JournalVC.h"

#import "LJLoader.h"

@interface JournalVC()
{
	LJLoader *loader_;
}
@end

@implementation JournalVC
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
																				   target:self
																				   action:@selector(refresh) ];
		self.navigationItem.rightBarButtonItem = barButton;
		[barButton release];
		
		self.title = @"Потоковая читалка";
		
		loader_ = [[LJLoader alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
	[self setTableView:nil];
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
	[tableView release];
	[loader_ release];
	[super dealloc];
}

#pragma mark - Data behavior

- (void)refresh
{
	[loader_ getChallenge];
}

#pragma mark - TableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return nil;
}

#pragma mark - TableView delegate





@end
