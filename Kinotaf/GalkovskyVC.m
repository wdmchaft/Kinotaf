//
//  GalkovskyVC.m
//  Kinotaf
//
//  Created by Константин Забелин on 23.01.12.
//  Copyright (c) 2012 Zababako. All rights reserved.
//

#import "GalkovskyVC.h"

#import "Book.h"

@implementation GalkovskyVC
@synthesize backButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
	[self setBackButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)dealloc {
	[backButton release];
	[super dealloc];
}
- (IBAction)backButtonPressed:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)deadEndPressed {
	Book* vc = [[Book alloc] initWithNibName:@"Book" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}
@end
