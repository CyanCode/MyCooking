//
//  CalorieTableCell.m
//  Cookbook
//
//  Created by Walker Christie on 2/18/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "CalorieTableCell.h"

@implementation CalorieTableCell

@synthesize calories;
@synthesize food;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
