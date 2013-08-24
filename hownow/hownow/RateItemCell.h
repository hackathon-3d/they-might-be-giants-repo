//
//  RateItemCell.h
//  hownow
//
//  Created by Scott Means on 8/24/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CheckList.h"

@interface RateItemCell : UITableViewCell

@property (strong) CheckList *checkList;
@property (strong) IBOutlet UIImageView *deadStars;
@property (strong) IBOutlet UIImageView *liveStars;
@property (strong) IBOutlet UIButton *rateButton;

@end
