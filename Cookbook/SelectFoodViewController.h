//
//  SelectFoodViewController.h
//  Cookbook
//
//  Created by Walker Christie on 2/18/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectFoodViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *selectionTable;

@end
