//
//  LoadRecipes.m
//  Cookbook
//
//  Created by Walker Christie on 1/27/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "LoadRecipes.h"

@implementation LoadRecipes

- (NSMutableArray *)loadData{
    NSLog(@"LISTING ALL FILES IN PATH");
    int count;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:basePath error:NULL];
    NSMutableArray *addedRecipes = [[NSMutableArray alloc] init];
    
    for (count = 0; count < (int)[directoryContent count]; count++){
        NSLog(@"File %d: %@", (count + 1), [directoryContent objectAtIndex:count]);
        NSString *substring = [directoryContent objectAtIndex:count];
        if(substring && [substring rangeOfString:@"recipe "].location != NSNotFound){
            NSLog(@"A FOOD %@", substring);
            substring = [substring stringByReplacingOccurrencesOfString:@"recipe " withString:@""];
            substring = [substring stringByReplacingOccurrencesOfString:@".plist" withString:@""];
            [addedRecipes addObject:substring];
            NSLog(@"%@", substring);
        }
    }
    return addedRecipes;
}

@end
