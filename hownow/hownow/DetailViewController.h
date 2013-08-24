//
//  DetailViewController.h
//  hownow
//
//  Created by Scott Means on 8/23/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LocalList.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) LocalList *list;
@property (strong) IBOutlet UITableView *itemTable;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

- (IBAction)addItemTouched:(id)sender;

@end
