//
//  AppDelegate.h
//  hownow
//
//  Created by Scott Means on 8/23/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckList.h"
#import "LocalList.h"
#import "LocalListItem.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly) NSString *docPath;
@property (readonly) NSMutableArray *localLists;
@property (strong) LocalList *focusList;

- (LocalList *)createList:(NSString *)name withCheckList:(CheckList *)checkList;

- (void)loadLists;
- (void)saveLists;

@end

#define theApp ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define FOCUS_LIST_CHANGED      @"FOCUS_LIST_CHANGED"