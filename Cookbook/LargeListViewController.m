//
//  LargeListViewController.m
//  Cookbook
//
//  Created by Walker Christie on 1/26/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "LargeListViewController.h"
#import "ManageLists.h"
#import "AddRecipeListViewController.h"
#import "DisplayListViewController.h"

@interface LargeListViewController ()

@end

@implementation LargeListViewController{
    NSMutableArray *lists;
    NSString *enteredName;
    NSString *selectedList;
}

@synthesize listTableView;
@synthesize customTabBar;

- (void)viewDidLoad
{
    listTableView.delegate = self;
    listTableView.dataSource = self;
    
    customTabBar.delegate = self;
    [customTabBar setSelectedItem:[customTabBar.items objectAtIndex:2]];
    
    lists = [[NSMutableArray alloc] init];
    ManageLists *ml = [[ManageLists alloc] init];
    lists = [NSMutableArray arrayWithArray:[ml loadLists]];
    
    [super viewDidLoad];
    [listTableView reloadData];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [listTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if(lists != nil){
        cell.textLabel.text = [lists objectAtIndex: indexPath.row];
    } else {
        NSLog(@"Array is empty");
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [lists count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    selectedList = cell.textLabel.text;
    [self performSegueWithIdentifier:@"toListDetails" sender:self];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        ManageLists *ml = [[ManageLists alloc] init];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString *deletedList = cell.textLabel.text;
        
        [ml deleteList:deletedList];
        lists = [NSMutableArray arrayWithArray:[ml loadLists]];
        
        [listTableView reloadData];
        
    }
}

- (IBAction)addButton:(id)sender {
    [self addAlert:@"addButton"];
}

- (IBAction)infoButton:(id)sender {
    [self addAlert:@"infoButton"];
}

- (void)addAlert:(NSString *)type{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.delegate = self;
    
    if([type isEqualToString:@"addButton"]){
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.tag = 1;
        [alert setTitle:@"Add a New List"];
        [alert setMessage:@"Enter your list's name below"];
        [alert addButtonWithTitle:@"Done"];
        [alert addButtonWithTitle:@"Cancel"];
        [alert show];
    } else if([type isEqualToString:@"noValue"]){
        alert.alertViewStyle = UIAlertViewStyleDefault;
        alert.tag = 2;
        [alert setTitle:@"Oops!"];
        [alert setMessage:@"You didn't enter anything"];
        [alert addButtonWithTitle:@"Okay"];
        [alert show];
    } else if([type isEqualToString:@"infoButton"]){
        alert.alertViewStyle = UIAlertViewStyleDefault;
        alert.tag = 3;
        [alert setTitle:@"What Are Lists?"];
        [alert setMessage:@"Lists are a simple way to organize what you need most, allowing you to add multiple recipes at once, along with your own custom ingredients.  Perfect for big shopping trips or events!"];
        [alert addButtonWithTitle:@"Okay"];
        [alert show];
    } else if([type isEqualToString:@"listExists"]){
        alert.alertViewStyle = UIAlertViewStyleDefault;
        alert.tag = 4;
        [alert setTitle:@"Oops!"];
        [alert setMessage:@"That list already exists, why not try naming it something else.."];
        [alert addButtonWithTitle:@"Okay"];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 1 && buttonIndex == 0){
        enteredName = [alertView textFieldAtIndex:0].text;
        if([enteredName isEqualToString:@""]){
            NSLog(@"No entered value");
            [self addAlert:@"noValue"];
        } else {
            BOOL listExists = [lists containsObject:enteredName];
            if(listExists){
                [self addAlert:@"listExists"];
            } else {
                NSLog(@"List Name: %@", enteredName);
                [self performSegueWithIdentifier:@"listToRecipes" sender:self];
            }
        }
    } else if(alertView.tag == 2){
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        [self addAlert:@"addButton"];
    } else if(alertView.tag == 3){
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"listToRecipes"]){
        AddRecipeListViewController *arl = [segue destinationViewController];
        arl.listName = enteredName;
    } else if ([[segue identifier] isEqualToString:@"toListDetails"]){
        DisplayListViewController *dl = [segue destinationViewController];
        dl.list = selectedList;
    }
}

- (void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if(tabBar.selectedItem == [tabBar.items objectAtIndex:0]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Recipes" bundle:nil];
        UIViewController *vc = [storyboard instantiateInitialViewController];
        [self presentViewController:vc animated:NO completion:nil];
    } if(tabBar.selectedItem == [tabBar.items objectAtIndex:1]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"New" bundle:nil];
        UIViewController *vc = [storyboard instantiateInitialViewController];
        vc.modalTransitionStyle = UIModalPresentationNone;
        [self presentViewController:vc animated:NO completion:nil];
    } if(tabBar.selectedItem == [tabBar.items objectAtIndex:2]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"List" bundle:nil];
        UIViewController *vc = [storyboard instantiateInitialViewController];
        vc.modalTransitionStyle = UIModalPresentationNone;
        [self presentViewController:vc animated:NO completion:nil];
    } if(tabBar.selectedItem == [tabBar.items objectAtIndex:3]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"More" bundle:nil];
        UIViewController *vc = [storyboard instantiateInitialViewController];
        vc.modalTransitionStyle = UIModalPresentationNone;
        [self presentViewController:vc animated:NO completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
