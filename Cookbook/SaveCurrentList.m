//
//  SaveCurrentList.m
//  Cookbook
//
//  Created by Walker Christie on 1/26/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "SaveCurrentList.h"
#import "GetCorrectDictionary.h"

@implementation SaveCurrentList

- (void)saveList:(NSArray *)listItems :(NSString *)food{
    if(listItems != nil){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@ list.plist", food]];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        [fileManager removeItemAtPath:path error:NULL];
        [listItems writeToFile:path atomically:YES];
        NSLog(@"%@", [NSArray arrayWithContentsOfFile:path]);
    }
}

- (NSArray *)loadList:(NSString *)food{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@ list.plist", food]];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];

    if(fileExists){
        NSArray *loadedItems = [NSArray arrayWithContentsOfFile:path];
        NSLog(@"%@", loadedItems);
        return loadedItems;
    } else {
        return nil;
    }
}

- (NSMutableArray *)resetList:(NSString *)food{
    GetCorrectDictionary *gcd = [[GetCorrectDictionary alloc] init];
    NSMutableDictionary *retrievedData = [[NSMutableDictionary alloc] init];
    NSMutableArray *listedData = [[NSMutableArray alloc] init];
    
    retrievedData = [NSMutableDictionary dictionaryWithDictionary:[gcd getPath:food]];
    listedData = [NSMutableArray arrayWithArray:[retrievedData valueForKey:[NSString stringWithFormat:@"5 %@", food]]];
    
    return listedData;
}

@end
