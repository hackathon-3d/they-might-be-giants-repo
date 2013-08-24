//
//  ResultTableViewCell.m
//  hownow
//
//  Created by Scott Means on 8/24/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import "ResultTableViewCell.h"
#import "PFUser+HN.h"

@implementation ResultTableViewCell

@synthesize resultLabel=_resultLabel, authorLabel=_authorLabel, checkList=_checkList;
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

- (CheckList *)checkList
{
    return _checkList;
}

- (void)setCheckList:(CheckList *)checkList
{
    _checkList = checkList;
    
    _resultLabel.text = checkList.name;
    _authorLabel.text = checkList.author.friendlyName;
    CGFloat w = deadStars.image.size.width * (checkList.rating/5.0);
    liveStars.frame = CGRectMake(deadStars.frame.origin.x, deadStars.frame.origin.y, w, deadStars.image.size.height);
    NSLog(@"rating %@: %f", checkList.name, checkList.rating);
}

@end
