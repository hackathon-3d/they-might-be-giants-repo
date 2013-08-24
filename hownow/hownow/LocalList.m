//
//  LocalList.m
//  hownow
//
//  Created by Scott Means on 8/24/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import "LocalList.h"

@implementation LocalList

@synthesize name=_name, checkListId=_checkListId, items=_items;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_name forKey:@"checkListId"];
    [aCoder encodeObject:_items forKey:@"items"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    _name = [aDecoder decodeObjectForKey:@"name"];
    _checkListId = [aDecoder decodeObjectForKey:@"checkListId"];
    _items = [aDecoder decodeObjectForKey:@"items"];
    
    return self;
}
@end
