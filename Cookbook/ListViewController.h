//
//  ListViewController.h
//  Cookbook
//
//  Created by Walker Christie on 1/25/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) NSMutableArray *listedItems;
@property (weak, nonatomic) NSString *food;

- (IBAction)informationButton:(id)sender;
- (IBAction)resetButton:(id)sender;

@end
