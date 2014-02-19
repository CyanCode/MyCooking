//
//  SelectFoodViewController.m
//  Cookbook
//
//  Created by Walker Christie on 2/18/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "SelectFoodViewController.h"
#import "LoadAvailableRecipes.h"

@interface SelectFoodViewController ()

@end

@implementation SelectFoodViewController{
    NSArray *availableData;
}

@synthesize selectionTable;

- (void)viewDidLoad
{
    LoadAvailableRecipes *loadData = [[LoadAvailableRecipes alloc] init];
    availableData = [loadData getRecipes];
    
    selectionTable.delegate = self;
    selectionTable.dataSource = self;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [availableData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [availableData objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
