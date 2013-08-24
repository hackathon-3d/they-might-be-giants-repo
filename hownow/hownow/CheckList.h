//
//  CheckList.h
//  hownow
//
//  Created by Scott Means on 8/23/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>

#import "Item.h"
#import "Rating.h"

@interface CheckList : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (strong) NSString *name;
@property (strong) PFUser *author;
@property (assign) float rating;
@property (readonly) Rating *myRating;
@property (readonly) NSArray *items;

@end
