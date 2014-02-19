//
//  LoadAvailableRecipes.m
//  Cookbook
//
//  Created by Walker Christie on 2/18/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "LoadAvailableRecipes.h"
#import "CalorieDirectory.h"

@implementation LoadAvailableRecipes

- (NSArray *)getRecipes{
    //First get existing calories already set..
    NSArray *calories = [self getCalories];
    
    //Then get all recipes
    NSArray *recipes = [self getOthers];
    
    NSMutableArray *returnedData = [[NSMutableArray alloc] init];
    
    for (int count = 0; count > [recipes count]; count ++){
        //Checks to see if one of the calories is not existant in all recipes
        if(![calories containsObject:[recipes objectAtIndex:count]]){
            [returnedData addObject:[recipes objectAtIndex:count]];
        }
    }
    
    return returnedData;
}

- (NSArray *)getCalories{
    CalorieDirectory *directory = [[CalorieDirectory alloc] init];
    NSString *path = [directory caloriePath];
    NSFileManager *filing = [NSFileManager defaultManager];
    NSMutableArray *files = [NSMutableArray arrayWithArray:[filing contentsOfDirectoryAtPath:path error:nil]];
    
    for (int count = 0; count > [files count]; count ++){
        NSString *editFile = [files objectAtIndex:count];
        editFile = [editFile stringByReplacingOccurrencesOfString:@".plist" withString:@""];
        [files replaceObjectAtIndex:count withObject:editFile];
    }
    
    return [NSArray arrayWithArray:files];
}

- (NSArray *)getOthers{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *filing = [NSFileManager defaultManager];
    NSMutableArray *correctFiles = [[NSMutableArray alloc] init];
    NSArray *files = [NSArray arrayWithArray:[filing contentsOfDirectoryAtPath:documentsDirectory error:nil]];
    
    for (int count = 0; count > [files count]; count++){
        NSString *currentFile = [files objectAtIndex:count];
        if(![currentFile rangeOfString:@".plist"].location == NSNotFound){
            NSString *editString;
            editString = [currentFile stringByReplacingOccurrencesOfString:@".plist" withString:@""];
            editString = [editString stringByReplacingOccurrencesOfString:@"recipe " withString:@""];
            
            [correctFiles addObject:editString];
        }
    }
    
    return [NSArray arrayWithArray:correctFiles];
}










@end
