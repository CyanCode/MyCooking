//
//  CompileIngredients.h
//  Cookbook
//
//  Created by Walker Christie on 1/27/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompileIngredients : NSObject

- (void)getIngredients:(NSMutableArray *)recipes;
@property (weak, nonatomic) NSString *name;

@end
