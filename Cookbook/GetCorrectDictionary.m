//
//  GetCorrectDictionary.m
//  Cookbook
//
//  Created by Walker Christie on 1/22/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "GetCorrectDictionary.h"

@implementation GetCorrectDictionary{
    NSArray *imagePaths;
}

- (NSMutableDictionary *) getPath : (NSString *) food{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *fileName = [NSString stringWithFormat:@"recipe %@.plist", food];
    NSString *filePath = [basePath stringByAppendingPathComponent:fileName];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSArray *arr = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    dic = [arr objectAtIndex:0];
    NSLog(@"Retrieved Dictionary = %@", dic);
    
    return dic;
}

- (UIImage *)getImage : (NSString *)food{
    imagePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [imagePaths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", food]];

    NSLog(@"%@", food);
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if(fileExists){
        return [UIImage imageWithContentsOfFile:path];
    } else {
        return [UIImage imageNamed:@"humburger-512.png"];
    }
}

@end
