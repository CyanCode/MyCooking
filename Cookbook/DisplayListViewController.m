//
//  DisplayListViewController.m
//  Cookbook
//
//  Created by Walker Christie on 1/27/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "DisplayListViewController.h"
#import "SaveList.h"

@interface DisplayListViewController ()

@end

@implementation DisplayListViewController{
    SaveList *saveList;
    NSMutableArray *ingredients;
}

@synthesize list;
@synthesize listTableView;

- (void)viewDidLoad
{
    listTableView.delegate = self;
    listTableView.dataSource = self;
    
    ingredients = [[NSMutableArray alloc] init];
    saveList = [[SaveList alloc] init];
    ingredients = [saveList load:list];
    ingredients = [NSMutableArray arrayWithArray:[self order:ingredients]];
    
    [super viewDidLoad];
    [listTableView reloadData];
}



#pragma mark - Table View

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [listTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if(ingredients != nil){
        cell.textLabel.text = [ingredients objectAtIndex: indexPath.row];
    } else {
        NSLog(@"Array is empty");
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [ingredients removeObjectAtIndex:indexPath.row];
        [saveList save:ingredients :list];
        [tableView reloadData];
        NSLog(@"%@", ingredients);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ingredients count];
}

- (IBAction)addButton:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.delegate = self;
    alert.tag = 1;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert setTitle:@"Add Ingredient"];
    [alert setMessage:@"Add an ingredient to your list below"];
    [alert addButtonWithTitle:@"Done"];
    [alert addButtonWithTitle:@"Cancel"];
    [alert show];
}

- (IBAction)infoButton:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.delegate = self;
    alert.tag = 2;
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert setTitle:@"What's this?"];
    [alert setMessage:@"This is your completed list!  You can now delete and add ingredients whenever you like.  Duplicate ingredients have also been removed for your convenience."];
    [alert addButtonWithTitle:@"Okay"];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 1 && buttonIndex == 0){
        [ingredients addObject:[alertView textFieldAtIndex:0].text];
        [saveList save:ingredients :list];
        ingredients = [NSMutableArray arrayWithArray:[self order:ingredients]];
        [listTableView reloadData];
    } else if(alertView.tag == 1 && buttonIndex == 1){
        [alertView dismissWithClickedButtonIndex:1 animated:YES];
    }
}

- (NSMutableArray *)order:(NSMutableArray *)organizeList{
    [organizeList sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    for (int i = 0; i <= [organizeList count] - 1; i++){
        NSString *firstChar = [[[organizeList objectAtIndex:i] substringToIndex:1] capitalizedString];
        NSString *formattedChar = [[organizeList objectAtIndex:i] stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstChar];
        [organizeList replaceObjectAtIndex:i withObject:formattedChar];
    }
    
    return organizeList;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
