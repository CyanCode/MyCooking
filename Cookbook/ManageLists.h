//
//  ManageLists.h
//  Cookbook
//
//  Created by Walker Christie on 1/26/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManageLists : NSObject

- (NSArray *)loadLists;
- (void)deleteList:(NSString *)listName;

@end
