//
//  AddRecipeListViewController.h
//  Cookbook
//
//  Created by Walker Christie on 1/27/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddRecipeListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *recipeTableView;
@property (weak, nonatomic) NSString *listName;
@property (weak, nonatomic) IBOutlet UILabel *listLabel;

- (IBAction)doneButton:(id)sender;
- (IBAction)infoButton:(id)sender;

- (void)sendTo:(NSMutableArray *)ingredients :(NSString *)name;
@end
