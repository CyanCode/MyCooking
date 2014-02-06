//
//  DisplayContentViewController.h
//  Cookbook
//
//  Created by Walker Christie on 1/22/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayContentViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) NSString *food;

@property (weak, nonatomic) IBOutlet UIImageView *recipeImage;
@property (weak, nonatomic) IBOutlet UITextView *recipeDescription;
@property (weak, nonatomic) IBOutlet UITextView *recipePrep;
@property (weak, nonatomic) IBOutlet UITableView *recipeTableView;
@property (weak, nonatomic) IBOutlet UILabel *foodLabel;

- (IBAction)recipeGenerateList:(id)sender;
- (IBAction)viewImage:(id)sender;

@end
