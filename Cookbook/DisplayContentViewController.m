//
//  DisplayContentViewController.m
//  Cookbook
//
//  Created by Walker Christie on 1/22/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "DisplayContentViewController.h"
#import "GetCorrectDictionary.h"
#import "ListViewController.h"
#import "ViewImageViewController.h"

@interface UIViewController()
@end

@implementation DisplayContentViewController{
    NSMutableDictionary *retrievedData;
    UIImage *displayedImage;
    NSMutableArray *tableData;
}

@synthesize food;
@synthesize recipeDescription, recipePrep;
@synthesize recipeImage;
@synthesize recipeTableView;
@synthesize foodLabel;

- (void)viewDidLoad
{
    //Set delegate and datasource
    recipeTableView.delegate = self;
    recipeTableView.dataSource = self;
    
    tableData = [[NSMutableArray alloc] init];
    [self loadData];
    [self setInteraction];
    [self assignData];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)loadData{
    GetCorrectDictionary *gcd = [[GetCorrectDictionary alloc] init];
    retrievedData = [[NSMutableDictionary alloc] init];
    retrievedData = [gcd getPath:food];
    [recipeImage setImage:[gcd getImage:food]];
}

- (void)setInteraction{
    [recipeDescription setEditable:NO];
    [recipePrep setEditable:NO];
}

- (void)assignData{
    foodLabel.text = [retrievedData valueForKey:[NSString stringWithFormat:@"1 %@", food]];
    
    NSString *description = [NSString stringWithFormat:@"%@", [retrievedData valueForKey:[NSString stringWithFormat:@"2 %@", food]]];
    NSString *time = [NSString stringWithFormat:@"%@", [retrievedData valueForKey:[NSString stringWithFormat:@"3 %@", food]]];
    recipeDescription.text = [NSString stringWithFormat:@"%@\n\nThis recipe takes about %@ minutes to make", description, time];
    
    recipePrep.text = [NSString stringWithFormat:@"%@", [retrievedData valueForKey:[NSString stringWithFormat:@"4 %@", food]]];
    [tableData addObjectsFromArray:[retrievedData valueForKey:[NSString stringWithFormat:@"5 %@", food]]];
}
- (IBAction)recipeGenerateList:(id)sender {
    [self performSegueWithIdentifier:@"displayToListModal" sender:self];
}

- (IBAction)viewImage:(id)sender {
    [self performSegueWithIdentifier:@"toImageView" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"displayToListModal"]){
        ListViewController *lvc = [segue destinationViewController];
        lvc.listedItems = tableData;
        lvc.food = food;
    }
    if([[segue identifier] isEqualToString:@"toImageView"]){
        ViewImageViewController *vi = [segue destinationViewController];
        vi.image = recipeImage.image;
        vi.foodName = foodLabel.text;
    }
}

#pragma mark - Table View Customization

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableIdentifier = @"tableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //Hopefully not..
}


@end
