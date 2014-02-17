//
//  CalorieDirectory.m
//  Cookbook
//
//  Created by Walker Christie on 2/15/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "CalorieDirectory.h"

@implementation CalorieDirectory

- (NSString *)caloriePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/cal"];
    
    return dataPath;
}

@end
