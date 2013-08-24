//
//  LocalListItem.h
//  hownow
//
//  Created by Scott Means on 8/24/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalListItem : NSObject <NSCoding>

@property (assign) bool isComplete;
@property (strong) NSString *label;

@end
