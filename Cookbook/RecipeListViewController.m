//
//  RecipeListViewController.m
//  Cookbook
//
//  Created by Walker Christie on 1/19/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "RecipeListViewController.h"
#import "DisplayContentViewController.h"
#import "MoreViewController.h"
#import "ViewController.h"

@interface RecipeListViewController ()

@end

@implementation RecipeListViewController{
    NSMutableArray *compiledData;
    NSMutableArray *organizedData;
    NSMutableArray *compiledFoods;
    
    NSArray *paths;
    NSString *basePath;
    NSMutableArray *arr;
    
    NSMutableArray *images;
    NSString *imagePath;
    UIImage *retrievedImage;
    
    NSString *selectedFood;
}
@synthesize customTabBar;
@synthesize displayRecipesTableView;
@synthesize tableViewImage;

- (void)viewDidLoad
{
    //Customize Tab Bar
    customTabBar.delegate = self;
    [customTabBar setSelectedItem:[customTabBar.items objectAtIndex:0]];
    
    //Work with table view
    displayRecipesTableView.delegate = self;
    displayRecipesTableView.dataSource = self;
    
    //Call methods
    images = [[NSMutableArray alloc] init];
    [self loadData];
    [super viewDidLoad];
    [displayRecipesTableView reloadData];
}

- (void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if(tabBar.selectedItem == [tabBar.items objectAtIndex:0]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Recipes" bundle:nil];
        UIViewController *vc = [storyboard instantiateInitialViewController];
        [self presentViewController:vc animated:NO completion:nil];
    }
    if(tabBar.selectedItem == [tabBar.items objectAtIndex:1]){
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

#pragma mark - Table View Setup

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        //Remove actual file
        NSFileManager *fileManager = [NSFileManager defaultManager];
        paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        
        NSString *removeImagePath = [NSString stringWithFormat:@"%@.png", [images objectAtIndex:indexPath.row]];
        NSString *removeImage = [basePath stringByAppendingPathComponent:removeImagePath];
        NSString *removeFilePath = [NSString stringWithFormat:@"recipe %@.plist", [compiledFoods objectAtIndex:indexPath.row]];
        NSString *removeFile = [basePath stringByAppendingPathComponent:removeFilePath];
        
        [fileManager removeItemAtPath:removeFile error:NULL];
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:removeImage];
        if(fileExists){
            [fileManager removeItemAtPath:removeImage error:NULL];
        }
        [compiledFoods removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
        NSLog(@"%@", compiledFoods);
    }
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [compiledFoods count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    imagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", [compiledFoods objectAtIndex:indexPath.row]]];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:imagePath];
    if(compiledFoods != nil && fileExists){
        cell.textLabel.text = [compiledFoods objectAtIndex: indexPath.row];
        cell.imageView.image = [images objectAtIndex: indexPath.row];
    } else {
        NSLog(@"Issue with array or image, choosing default image");
        cell.textLabel.text = [compiledFoods objectAtIndex: indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"humburger-512.png"];
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@", [compiledFoods objectAtIndex:indexPath.row]);
    selectedFood = cell.textLabel.text;
    [self performSegueWithIdentifier:@"recipeToDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"recipeToDetail"]){
        DisplayContentViewController *dcvc = [segue destinationViewController];
        dcvc.food = selectedFood;
    }
}

- (void) loadData{
    //load all the stuff from file
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    compiledFoods = [[NSMutableArray alloc] init];
    
    //NEED a specific path, not a file
    [self listFileAtPath:basePath];
    
}

-(NSArray *)listFileAtPath:(NSString *)path{
    NSLog(@"LISTING ALL FILES IN PATH");
    int count;
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    for (count = 0; count < (int)[directoryContent count]; count++){
        NSLog(@"File %d: %@", (count + 1), [directoryContent objectAtIndex:count]);
        NSString *substring = [directoryContent objectAtIndex:count];
        if(substring && [substring rangeOfString:@"recipe "].location != NSNotFound){
            NSLog(@"A FOOD %@", substring);
            substring = [substring stringByReplacingOccurrencesOfString:@"recipe " withString:@""];
            substring = [substring stringByReplacingOccurrencesOfString:@".plist" withString:@""];
            NSLog(@"%@", substring);
            [compiledFoods addObject:substring];
            [self loadImageData:substring];
        }
    }
    return directoryContent;
}

- (void) loadImageData:(NSString *)image{
    
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    imagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", image]];
    NSLog(@"%@", imagePath);
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:imagePath];
    if(fileExists){
        [images addObject:[UIImage imageWithContentsOfFile:imagePath]];
    } else {
        NSLog(@"Image %@ did not exist.  Adding default", image);
        [images addObject:[UIImage imageNamed:@"humburger-512.png"]];
    }
    
    NSLog(@"%@", images);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
