//
//  CalorieTableCell.h
//  Cookbook
//
//  Created by Walker Christie on 2/18/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalorieTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *calories;
@property (nonatomic, weak) IBOutlet UILabel *food;

@end
