//
//  LocalListItem.m
//  hownow
//
//  Created by Scott Means on 8/24/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import "LocalListItem.h"

@implementation LocalListItem 

@synthesize isComplete=_isComplete, label=_label;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeBool:_isComplete forKey:@"isComplete"];
    [aCoder encodeObject:_label forKey:@"label"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    _isComplete = [aDecoder decodeBoolForKey:@"isComplete"];
    _label = [aDecoder decodeObjectForKey:@"label"];
    
    return self;
}

@end
