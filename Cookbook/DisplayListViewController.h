//
//  DisplayListViewController.h
//  Cookbook
//
//  Created by Walker Christie on 1/27/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) NSString *list;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

- (IBAction)infoButton:(id)sender;
- (IBAction)addButton:(id)sender;

@end
