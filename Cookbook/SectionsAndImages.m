//
//  SectionsAndImages.m
//  Cookbook
//
//  Created by Walker Christie on 2/10/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "SectionsAndImages.h"

@implementation SectionsAndImages

- (NSArray *)loadImages{
    NSArray *images = [NSArray arrayWithObjects:[UIImage imageNamed:@"cal.png"], [UIImage imageNamed:@"edit.png"], [UIImage imageNamed:@"rate.png"], [UIImage imageNamed:@"time.png"], nil];
    
    return images;
}

- (NSArray *)loadSections{
    NSArray *sections = [[NSArray alloc] initWithObjects:@"Calories", @"Edit", @"Rate", @"Time", nil];
    
    return sections;
}

@end
