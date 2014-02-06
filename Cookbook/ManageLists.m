//
//  ManageLists.m
//  Cookbook
//
//  Created by Walker Christie on 1/26/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "ManageLists.h"

@implementation ManageLists

- (NSArray *)loadLists{
    NSMutableArray *compiledLists = [[NSMutableArray alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *location = [NSString stringWithFormat:@"/lists/"];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:location];
    NSArray *filePathsArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:nil];
    
    NSLog(@"All files at path: %@", filePathsArray);
    
    [compiledLists addObjectsFromArray:filePathsArray];

    for(int i = 0; i < [compiledLists count]; i++){
        if(compiledLists != nil){
            NSString *change = [compiledLists objectAtIndex:i];
            change = [change stringByReplacingOccurrencesOfString:@".plist" withString:@""];
            [compiledLists replaceObjectAtIndex:i withObject:change];
            
            NSLog(@"Added: %@", [compiledLists objectAtIndex:i]);
        }
    }
    
    return compiledLists;
}

- (void)deleteList:(NSString *)listName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *location = [NSString stringWithFormat:@"/lists/%@.plist", listName];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:location];
    
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    
}
@end
