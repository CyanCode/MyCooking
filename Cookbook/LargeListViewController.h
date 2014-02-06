//
//  LargeListViewController.h
//  Cookbook
//
//  Created by Walker Christie on 1/26/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LargeListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
- (IBAction)addButton:(id)sender;
- (IBAction)infoButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITabBar *customTabBar;
@end
