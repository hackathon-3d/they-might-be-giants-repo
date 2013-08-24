//
//  CheckList.m
//  hownow
//
//  Created by Scott Means on 8/23/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import "CheckList.h"

@implementation CheckList

@dynamic name,author, rating;
@synthesize items=_items;

+ (NSString *)parseClassName
{
    return @"CheckList";
}

- (NSArray *)items
{
    if (!_items) {
        PFQuery *q = [Item query];
        [q whereKey:@"checkList" equalTo:self];
        [q orderByAscending:@"sequence"];
        
        _items = [q findObjects];
    }
    
    return _items;
}

- (Rating *)myRating
{
    PFQuery *q = [Rating query];
    [q whereKey:@"checklist" equalTo:self];
    [q whereKey:@"author" equalTo:[PFUser currentUser]];
    
    return (Rating *)[q getFirstObject];
}


@end
