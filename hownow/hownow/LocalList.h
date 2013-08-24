//
//  LocalList.h
//  hownow
//
//  Created by Scott Means on 8/24/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CheckList.h"

@interface LocalList : NSObject <NSCoding>

@property (strong) NSString *name;
@property (strong) NSString *checkListId;
@property (readonly) NSMutableArray *items;
@property (readonly) CheckList *publicList;

@end
