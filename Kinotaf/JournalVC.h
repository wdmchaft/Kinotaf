//
//  JournalVC.h
//  Kinotaf
//
//  Created by Константин Забелин on 15.01.12.
//  Copyright (c) 2012 Zababako. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JournalVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
