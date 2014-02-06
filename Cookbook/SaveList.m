//
//  SaveList.m
//  Cookbook
//
//  Created by Walker Christie on 1/27/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "SaveList.h"

@implementation SaveList

- (NSMutableArray *)load:(NSString *)listName{
    NSMutableArray *loadedData = [[NSMutableArray alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *location = [NSString stringWithFormat:@"/lists/%@.plist", listName];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:location];
    
    [loadedData addObjectsFromArray:[NSArray arrayWithContentsOfFile:path]];
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:nil];
    
    NSLog(@"Files: %@", files);
    
    return loadedData;
}

- (void)save:(NSMutableArray *)ingredients :(NSString *)listName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *location = [NSString stringWithFormat:@"/lists/%@.plist", listName];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:location];
    
    [ingredients writeToFile:path atomically:YES];
}

@end
