//
//  AddChecklistViewController.h
//  hownow
//
//  Created by Scott Means on 8/23/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MasterViewController.h"

@interface AddChecklistViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    IBOutlet UITableView *resultsTable;
    IBOutlet UISearchBar *searchBarView;
}

@property (strong) MasterViewController *master;

@end
