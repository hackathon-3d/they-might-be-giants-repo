//
//  MasterViewController.h
//  hownow
//
//  Created by Scott Means on 8/23/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController <UIPopoverControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

- (void)hideAddView;

@end
