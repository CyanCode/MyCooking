//
//  SaveList.h
//  Cookbook
//
//  Created by Walker Christie on 1/27/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveList : NSObject

- (NSMutableArray *)load:(NSString *)listName;
- (void)save:(NSMutableArray *)ingredients :(NSString *)listName;

@end
