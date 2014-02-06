//
//  AddRecipeListViewController.m
//  Cookbook
//
//  Created by Walker Christie on 1/27/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "AddRecipeListViewController.h"
#import "LoadRecipes.h"
#import "CompileIngredients.h"
#import "DisplayListViewController.h"

@interface AddRecipeListViewController ()

@end

@implementation AddRecipeListViewController{
    NSMutableArray *compiledRecipes;
    NSMutableArray *selectedRecipes;
    NSMutableArray *sortedIngredients;
    BOOL loaded;
}

@synthesize recipeTableView;
@synthesize listName;
@synthesize listLabel;

- (void)viewDidLoad
{
    recipeTableView.delegate = self;
    recipeTableView.dataSource = self;
    recipeTableView.allowsMultipleSelection = YES;
    [listLabel setText:listName];
    
    [self createData];
    
    [super viewDidLoad];
    
}

- (void)createData{
    if(!loaded){
        LoadRecipes *lr = [[LoadRecipes alloc] init];
        compiledRecipes = [[NSMutableArray alloc] init];
        selectedRecipes = [[NSMutableArray alloc] init];
        [compiledRecipes addObjectsFromArray:[lr loadData]];
        [recipeTableView reloadData];
        loaded = YES;
    }
}

#pragma mark - Table View

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [recipeTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    if(compiledRecipes != nil){
        cell.textLabel.text = [compiledRecipes objectAtIndex: indexPath.row];
    } else {
        NSLog(@"Array is empty");
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [compiledRecipes count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Alert
- (void)addAlert{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.delegate = self;
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert setTitle:@"What's this?"];
    [alert setMessage:@"Lists allow you to add multiple recipes into one big list!  Select the ones you need."];
    [alert addButtonWithTitle:@"Okay"];
    [alert show];
}

- (IBAction)doneButton:(id)sender {
    selectedRecipes = [[NSMutableArray alloc] init];
    NSArray *allIndexes = [[NSArray alloc] initWithArray:[self.recipeTableView indexPathsForSelectedRows]];
    CompileIngredients *ci = [[CompileIngredients alloc] init];
    
    for (NSIndexPath *idx in allIndexes){
        [selectedRecipes addObject:[compiledRecipes objectAtIndex:idx.row]];
    }
    
    NSLog(@"Selected Things: %@", selectedRecipes);
    ci.name = listName;
    [ci getIngredients:selectedRecipes];
    [self performSegueWithIdentifier:@"toListDisplay" sender: self];
}

- (void)sendTo:(NSMutableArray *)ingredients :(NSString *)name{
    sortedIngredients = [[NSMutableArray alloc] init];
    sortedIngredients = ingredients;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *location = [NSString stringWithFormat:@"/lists/%@.plist", name];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:location];
    NSString *directoryPath = [documentsDirectory stringByAppendingPathComponent:@"/lists"];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:directoryPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    [ingredients writeToFile:path atomically:YES];
    
    NSLog(@"Saved: %@ At: %@", [NSMutableArray arrayWithContentsOfFile:path], path);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"toListDisplay"]){
        DisplayListViewController *dl = [segue destinationViewController];
        dl.list = listName;
    }
}

- (IBAction)infoButton:(id)sender {
    [self addAlert];
}







@end
