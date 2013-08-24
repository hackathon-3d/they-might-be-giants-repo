//
//  DetailViewController.m
//  hownow
//
//  Created by Scott Means on 8/23/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"

#import "ItemTableViewCell.h"

@interface DetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong) UIBarButtonItem *actionButton;
@property (strong) UIActionSheet *actionSheet;
@property (strong) UITapGestureRecognizer *tgr;

@end

@implementation DetailViewController

@synthesize list=_list, actionButton=_actionButton, actionSheet=_actionSheet, itemTable=_itemTable,
        tgr=_tgr;

#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(focusListChanged:) name:FOCUS_LIST_CHANGED object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    _actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionTouched:)];
    _actionButton.enabled = NO;
    
    self.navigationItem.rightBarButtonItem = _actionButton;
    
    [theApp checkFocusList];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    if (_masterPopoverController) {
        return;
    }
    
    NSDictionary* kbi = [notification userInfo];
    NSValue* kbf = [kbi valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rc = [kbf CGRectValue];
    rc = [self.view convertRect:rc fromView:nil];
    
    _itemTable.contentInset = UIEdgeInsetsMake(0, 0, rc.size.height, 0);
    
    CGFloat dy = rc.origin.y - _itemTable.frame.origin.y;
    CGRect rci = [_itemTable rectForRowAtIndexPath:[_itemTable indexPathForSelectedRow]];
    rci = [self.view convertRect:rci fromView:_itemTable];
    
    if (rci.origin.y+rci.size.height > dy) {
        [_itemTable scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    _tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTapDetected:)];
    [self.view addGestureRecognizer:_tgr];
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    if (_masterPopoverController) {
        return;
    }
    
    _itemTable.contentInset = UIEdgeInsetsZero;
    
    [self.view removeGestureRecognizer:_tgr];
}

- (IBAction)editTapDetected:(id)sender
{
    [self.view endEditing:YES];
}

- (void)actionTouched:(UIView *)sender
{
    if (_actionSheet) {
        return;
    }
    
    _actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"publish to HowNow", nil];

    [_actionSheet showFromBarButtonItem:_actionButton animated:YES];
}

- (void)focusListChanged:(NSNotification *)notification
{
    self.list = notification.object;
    self.navigationItem.title = _list.name;
    [self.masterPopoverController dismissPopoverAnimated:YES];
    
    [self.itemTable reloadData];
    _actionButton.enabled = !!_list;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addItemTouched:(UIView *)sender
{
    LocalListItem *lli = [LocalListItem new];
    
    while (sender && ![sender isKindOfClass:[ItemTableViewCell class]]) {
        sender = sender.superview;
    }
    
    assert(sender);
    
    ItemTableViewCell *cell = (ItemTableViewCell *)sender;

    lli.label = cell.itemText.text;
    cell.itemText.text = @"";
    
    [_list.items addObject:lli];
    
    [theApp saveLists];
    
    [self.itemTable reloadData];
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"My Lists", @"My Lists");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark UITableViewDataSource
- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_list items] count] + (_list ? 1 : 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    ItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:row >= [_list.items count] ? @"AddItemCell" : @"ItemCell"];
    
    if (row < [_list.items count]) {
        cell.item = [_list.items objectAtIndex:row];
    }
    
    return cell;
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    _actionSheet = nil;
    
    switch (buttonIndex) {
        case 0: {
            if ([PFUser currentUser].isAuthenticated) {
                [theApp publishList:_list];
                
                return;
            }
            
            PFLogInViewController *livc = [PFLogInViewController new];
            livc.delegate = self;
            
            [self presentViewController:livc animated:YES completion:nil];
        } break;
    }
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    _actionSheet = nil;
}

#pragma mark PFLoginViewControllerDelegate

- (void)logInViewController:(PFLogInViewController *)controller
               didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];

    [theApp publishList:_list];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self dismissViewControllerAnimated:YES completion:nil];

    [theApp publishList:_list];
}
@end
