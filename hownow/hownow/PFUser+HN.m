//
//  PFUser+HN.m
//  hownow
//
//  Created by Scott Means on 8/24/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import "PFUser+HN.h"

@implementation PFUser (HN)

- (void)setFriendlyName:(NSString *)friendlyName
{
    [self setObject:friendlyName forKey:@"friendlyName"];
}

- (NSString *)friendlyName
{
    if (self.isAuthenticated) {
        return [self.allKeys containsObject:@"friendlyName"] ? [self objectForKey:@"friendlyName"] : nil;
    } else {
        return @"anonymous";
    }
}

@end
