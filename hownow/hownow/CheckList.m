//
//  CheckList.m
//  hownow
//
//  Created by Scott Means on 8/23/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import "CheckList.h"

@implementation CheckList

@dynamic name,author;
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


@end
