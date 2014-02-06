//
//  SaveCurrentList.h
//  Cookbook
//
//  Created by Walker Christie on 1/26/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveCurrentList : NSObject

- (void)saveList:(NSArray *)listItems :(NSString *)food;
- (NSArray *)loadList:(NSString *)food;
- (NSMutableArray *)resetList:(NSString *)food;

@end
