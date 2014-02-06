//
//  RecipeListViewController.h
//  Cookbook
//
//  Created by Walker Christie on 1/19/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeListViewController : UIViewController <UITabBarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITabBar *customTabBar;
@property (weak, nonatomic) IBOutlet UITableView *displayRecipesTableView;
@property (retain, nonatomic) IBOutlet UIImageView *tableViewImage;
@property (retain, nonatomic) IBOutlet UILabel *tableViewLabel;

@end
