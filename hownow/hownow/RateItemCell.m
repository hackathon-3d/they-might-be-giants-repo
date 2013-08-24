//
//  RateItemCell.m
//  hownow
//
//  Created by Scott Means on 8/24/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import "RateItemCell.h"

@implementation RateItemCell

@synthesize deadStars, liveStars;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
