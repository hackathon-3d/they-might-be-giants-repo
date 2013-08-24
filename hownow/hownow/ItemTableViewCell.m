//
//  ItemTableViewCell.m
//  hownow
//
//  Created by Scott Means on 8/24/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import "AppDelegate.h"

#import "ItemTableViewCell.h"

@interface ItemTableViewCell ()

- (void)toggleComplete;
- (void)syncUI;

@end

@implementation ItemTableViewCell

@synthesize item=_item, itemButton, itemText;

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

- (LocalListItem *)item
{
    return _item;
}

- (void)setItem:(LocalListItem *)item
{
    _item = item;
    
    [self syncUI];
}

- (IBAction)completeTouched:(id)sender
{
    [self toggleComplete];
}

- (void)toggleComplete
{
    if (!_item) {
        return;
    }
    
    _item.isComplete = !_item.isComplete;
    [theApp saveLists];
    
    [self syncUI];
}

- (void)syncUI
{
    itemText.text = _item.label;

    [itemButton setImage:[UIImage imageNamed:_item.isComplete ? @"CheckSquareCross.png" : @"CheckSquare.png"] forState:UIControlStateNormal];
}
@end
