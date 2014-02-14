//
//  GetAllImages.m
//  Cookbook
//
//  Created by Walker Christie on 2/13/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "GetAllImages.h"

@implementation GetAllImages

- (NSMutableArray *)loadImages{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSMutableArray *compiledImages = [[NSMutableArray alloc] init];
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:basePath error:NULL];
    
    for (int count = 0; count < (int)[directoryContent count]; count++){
        NSLog(@"File %d: %@", (count + 1), [directoryContent objectAtIndex:count]);
        NSString *substring = [directoryContent objectAtIndex:count];
        if(substring && [substring rangeOfString:@"recipe "].location != NSNotFound){
            NSLog(@"A FOOD %@", substring);
            substring = [substring stringByReplacingOccurrencesOfString:@"recipe " withString:@""];
            substring = [substring stringByReplacingOccurrencesOfString:@".plist" withString:@""];
            NSLog(@"%@", substring);
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *imagePath;
            imagePath = [basePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", substring]];
            
            if ([fileManager fileExistsAtPath:imagePath]){
                [compiledImages addObject:[UIImage imageWithContentsOfFile:imagePath]];
            }
        }
    }
    return compiledImages;
}

@end
