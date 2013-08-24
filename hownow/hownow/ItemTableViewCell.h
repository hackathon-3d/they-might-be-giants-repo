//
//  ItemTableViewCell.h
//  hownow
//
//  Created by Scott Means on 8/24/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LocalListItem.h"

@interface ItemTableViewCell : UITableViewCell

@property (strong) LocalListItem *item;

@property (strong) IBOutlet UIButton *itemButton;
@property (strong) IBOutlet UITextView *itemText;

- (IBAction)completeTouched:(id)sender;

@end
