//
//  ResultTableViewCell.m
//  hownow
//
//  Created by Scott Means on 8/24/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import "ResultTableViewCell.h"

@implementation ResultTableViewCell

@synthesize resultLabel=_resultLabel, authorLabel=_authorLabel, checkList=_checkList;

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
}

@end
