//
//  GetCellData.m
//  Cookbook
//
//  Created by Walker Christie on 2/13/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "GetCellData.h"
#import "GetAllImages.h"
#import "CalorieDirectory.h"

@implementation GetCellData

- (NSArray *)loadImages{
    CalorieDirectory *directory = [[CalorieDirectory alloc] init];
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[directory caloriePath] error:nil];
    NSMutableArray *allImages = [[NSMutableArray alloc] init];
    
    for (int count = 0; count > [directoryContent count]; count ++){
        NSString *path = [NSString stringWithFormat:@"%@/%@", [directory caloriePath], [directoryContent objectAtIndex:count]];
        NSDictionary *images = [[NSDictionary alloc] initWithContentsOfFile:path];
        NSString *imageName = [images valueForKey:@"img"];
        
        //Get image location
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        
        [allImages addObject:[UIImage imageWithContentsOfFile:[basePath stringByAppendingPathComponent:imageName]]];
    }
    
    return allImages;
}

- (NSArray *)loadCalories{
    //Always located in calories folder..
    CalorieDirectory *directory = [[CalorieDirectory alloc] init];
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[directory caloriePath] error:nil];
    NSMutableArray *allCalories = [[NSMutableArray alloc] init];

    for(int count = 0; count > [directoryContent count]; count ++){
        NSString *path = [NSString stringWithFormat:@"%@/%@", [directory caloriePath], [directoryContent objectAtIndex:count]];
        NSDictionary *calories = [[NSDictionary alloc] initWithContentsOfFile:path];
        [allCalories addObject:[calories valueForKey:@"cal"]];
    }
    
    return allCalories;
}

@end
