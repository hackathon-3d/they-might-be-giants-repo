//
//  AppDelegate.m
//  hownow
//
//  Created by Scott Means on 8/23/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

#import "CheckList.h"

@implementation AppDelegate

@synthesize localLists=_localLists, focusList=_focusList;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [CheckList registerSubclass];
    [Item registerSubclass];
    
    [Parse setApplicationId:@"7wU05Rz9uuSArgLRB4wh5H90zLC4wbluAies1Zgv"
                  clientKey:@"ugGxtXnOkBhuSfLVDWSTjuEH98jW2oVqM7fkoybb"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    
    [PFUser enableAutomaticUser];
    [[PFUser currentUser] incrementKey:@"RunCount"];
    [[PFUser currentUser] saveInBackground];
    
    return YES;
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSString *)docPath
{
   return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

- (LocalList *)focusList
{
    return _focusList;
}

- (void)setFocusList:(LocalList *)focusList
{
    _focusList = focusList;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:FOCUS_LIST_CHANGED object:_focusList];
}

- (NSString *)publishList:(LocalList *)list
{
    CheckList *cl = [CheckList object];
    cl.author = [PFUser currentUser];
    cl.name = list.name;
    
    NSError *err = nil;
    
    if ([cl save:&err]) {
        for (int i = 0; i < list.items.count; i++) {
            LocalListItem *lli = [list.items objectAtIndex:i];
            Item *cli = [Item object];

            cli.label = lli.label;
            cli.sequence = i;
            cli.checkList = cl;
            [cli saveInBackground];
        }
    }
    
    return cl.objectId;
}


- (void)checkFocusList
{
    if (!_focusList || ![_localLists containsObject:_focusList]) {
        if (_localLists.count) {
            self.focusList = [_localLists objectAtIndex:0];
        } else {
            self.focusList = nil;
        }
    }
}

- (NSArray *)localLists
{
    if (!_localLists) {
        [self loadLists];

        if (!_localLists) {
            _localLists = [NSMutableArray new];
        }
    }
    
    return _localLists;
}

- (LocalList *)createList:(NSString *)name withCheckList:(CheckList *)checkList
{
    LocalList *ll = [[LocalList alloc] init];
    
    ll.name = name;
    
    if (checkList.items) {
        for (Item *i in checkList.items) {
            LocalListItem *lli = [LocalListItem new];
            lli.label = i.label;
            
            [ll.items addObject:lli];
        }
    }
    
    [self.localLists addObject:ll];
    
    [self saveLists];
    
    return ll;
}

- (void)saveLists
{
    NSMutableData *md = [NSMutableData new];
    NSKeyedArchiver *ka = [[NSKeyedArchiver alloc] initForWritingWithMutableData:md];
    [ka encodeObject:_localLists forKey:@"localLists"];
    [ka finishEncoding];
    [md writeToFile:[self.docPath stringByAppendingPathComponent:@"localLists"] atomically:YES];
}

- (void)loadLists
{
    NSData *d = [NSData dataWithContentsOfFile:[self.docPath stringByAppendingPathComponent:@"localLists"]];
    if (d) {
        NSKeyedUnarchiver *ku = [[NSKeyedUnarchiver alloc] initForReadingWithData:d];
        _localLists = [ku decodeObjectForKey:@"localLists"];
    }
}

@end
