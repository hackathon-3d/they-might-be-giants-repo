//
//  Rating.h
//  hownow
//
//  Created by Scott Means on 8/24/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import <Parse/Parse.h>

@interface Rating : PFObject <PFSubclassing>

+ (NSString *)parseClassName;

@property (assign) float rating;

@end
