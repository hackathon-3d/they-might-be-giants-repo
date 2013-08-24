//
//  AddChecklistViewController.m
//  hownow
//
//  Created by Scott Means on 8/23/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import <Parse/Parse.h>

#import "AddChecklistViewController.h"
#import "CheckList.h"
#import "ResultTableViewCell.h"

@interface AddChecklistViewController ()

@property (strong) PFQuery *query;
@property (strong) NSArray *results;
@property (strong) UIButton *addButton;

@end

@implementation AddChecklistViewController

@synthesize query=_query, results=_results, addButton=_addButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_results count];
}

#pragma mark UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultCell"];
    
    NSUInteger row = [indexPath row];
    
    cell.checkList = [_results objectAtIndex:row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 71.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _addButton.frame = CGRectMake(0, 0, tableView.bounds.size.width, [self tableView:tableView heightForHeaderInSection:section]);
    
    [_addButton setTitle:@"create a new list" forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(addTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    return _addButton;    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CheckList *cl = [_results objectAtIndex:[indexPath row]];
    
    NSLog(@"items: %@", cl.items);
}

- (void)addTouched:(id)sender
{
    
}

#pragma mark UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [_query cancel];
    
    NSString *ss = searchBar.text;
    
    if ([ss length]) {
        _query = [CheckList query];
        [_query whereKey:@"name" matchesRegex:[NSString stringWithFormat:@".*%@.*", ss] modifiers:@"i"];
        [_query findObjectsInBackgroundWithTarget:self selector:@selector(queryResult:error:)];
    } else {
        _results = [NSArray new];
        
        [resultsTable reloadData];
    }
}

- (void)queryResult:(NSArray *)results error:(NSError *)error
{
    _results = results;
    
    [resultsTable reloadData];
    
    _query = nil;
}

- (void)dealloc
{
    [_query cancel];
}
@end
