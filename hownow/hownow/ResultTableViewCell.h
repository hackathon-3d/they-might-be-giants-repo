//
//  ResultTableViewCell.h
//  hownow
//
//  Created by Scott Means on 8/24/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckList.h"

@interface ResultTableViewCell : UITableViewCell

@property (strong) IBOutlet UILabel *resultLabel;
@property (strong) IBOutlet UILabel *authorLabel;

@property (strong) CheckList *checkList;

@end
