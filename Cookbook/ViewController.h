//
//  ViewController.h
//  Cookbook
//
//  Created by Walker Christie on 1/17/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITabBarDelegate> {
    
}

@property (weak, nonatomic) IBOutlet UITextField *foodTextField;
@property (weak, nonatomic) IBOutlet UITableView *ingredientTableView;
@property (strong, nonatomic) NSMutableArray *addedIngredients;
@property (strong, nonatomic) IBOutlet UITabBar *customTabBar;
- (IBAction)addIngredientButton:(id)sender;
- (IBAction)continueButton:(id)sender;

@end
