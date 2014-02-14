//
//  ViewController.m
//  Cookbook
//
//  Created by Walker Christie on 1/17/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "ViewController.h"
#import "EnterRecipeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize ingredientTableView;
@synthesize addedIngredients;
@synthesize foodTextField;
@synthesize customTabBar;
NSString *selectedFood;

NSArray *paths;
NSString *basePath;
NSString *filePath;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.foodTextField.delegate = self;
    self.ingredientTableView.dataSource = self;
    self.ingredientTableView.delegate = self;
    customTabBar.delegate = self;
    [customTabBar setSelectedItem:[customTabBar.items objectAtIndex:1]];
    addedIngredients = [[NSMutableArray alloc] initWithObjects: nil];
    
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)addIngredientButton:(id)sender {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Add Ingredient" message:@"Add a new ingredient below" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    [av textFieldAtIndex:0];
    [av show];
}

- (IBAction)continueButton:(id)sender {
    selectedFood = foodTextField.text;
    NSString *food = foodTextField.text;
    NSString *fileName = [NSString stringWithFormat:@"recipe %@.plist", food];
    
    filePath = [basePath stringByAppendingPathComponent:fileName];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    NSLog(@"%@", selectedFood);
    
    //    filePath = [basePath stringByAppendingPathComponent:@"cookingData.plist"];
    if(fileExists){
        UIAlertView *av = [[UIAlertView alloc] init];
        av.alertViewStyle = UIAlertViewStyleDefault;
        [av setMessage:@"That recipe name already exists"];
        [av setTitle:@"Oops!"];
        [av addButtonWithTitle:@"Okay"];
        [av show];
        return;
    }
    if(![selectedFood isEqual: @""] && ![addedIngredients isEqual: @""]){
        [self performSegueWithIdentifier:@"recipeOneModal" sender: self];
    } else {
        UIAlertView *av = [[UIAlertView alloc] init];
        av.alertViewStyle = UIAlertViewStyleDefault;
        [av setMessage:@"Please fill all values"];
        [av setTitle:@"Oops!"];
        [av addButtonWithTitle:@"Okay"];
        [av show];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"recipeOneModal"]){
        EnterRecipeViewController *erv = [segue destinationViewController];
        erv.food = selectedFood;
        erv.ingredients = addedIngredients;
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        NSString *chosenIngredient = [alertView textFieldAtIndex:0].text;
        [addedIngredients addObject:chosenIngredient];
        [self.ingredientTableView reloadData];
        NSLog(@"%@", addedIngredients);
        NSLog(@"%@", chosenIngredient);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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

#pragma mark - UITableView Datasource

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [addedIngredients removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
        NSLog(@"%@", addedIngredients);
    }
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [addedIngredients count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if(addedIngredients != nil){
        cell.textLabel.text = [self.addedIngredients objectAtIndex: indexPath.row];
    } else {
        NSLog(@"Array is empty");
    }
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
