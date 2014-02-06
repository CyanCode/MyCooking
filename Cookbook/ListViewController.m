//
//  ListViewController.m
//  Cookbook
//
//  Created by Walker Christie on 1/25/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "ListViewController.h"
#import "DisplayAlerts.h"
#import "SaveCurrentList.h"

@interface ListViewController ()

@end

@implementation ListViewController{
    BOOL viewLoadedOnce;
}

@synthesize listTableView;
@synthesize listedItems;
@synthesize food;

- (void)viewDidLoad
{
    if(!viewLoadedOnce){
        [self setData];
        viewLoadedOnce = YES;
    }
    [super viewDidLoad];
    listTableView.delegate = self;
    listTableView.dataSource = self;
}

#pragma mark - Table View

- (void)setData{
    SaveCurrentList *scl = [[SaveCurrentList alloc] init];
    NSMutableArray *backupArray = listedItems;
    [listedItems removeAllObjects];
    [listedItems addObjectsFromArray:[scl loadList:food]];
    if(listedItems == nil){
        listedItems = backupArray;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [listedItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableIdentifier = @"tableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    cell.textLabel.text = [listedItems objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    SaveCurrentList *scl = [[SaveCurrentList alloc] init];
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [listedItems removeObjectAtIndex:indexPath.row];
        [scl saveList:listedItems :food];
        [tableView reloadData];
    }
}

- (IBAction)informationButton:(id)sender {
    DisplayAlerts *da = [[DisplayAlerts alloc] init];
    [da informationAlert];
}

- (IBAction)resetButton:(id)sender {
    SaveCurrentList *scl = [[SaveCurrentList alloc] init];
    [listedItems removeAllObjects];
    [listedItems addObjectsFromArray:[scl resetList:food]];
    [scl saveList:listedItems :food];
    [listTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
