//
//  Item.h
//  hownow
//
//  Created by Scott Means on 8/24/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>

@class CheckList;

@interface Item : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (strong) NSString *label;
@property (strong) CheckList *checkList;
@property (assign) int sequence;

@end
