//
//  CompileIngredients.m
//  Cookbook
//
//  Created by Walker Christie on 1/27/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "CompileIngredients.h"
#import "GetCorrectDictionary.h"
#import "AddRecipeListViewController.h"

@implementation CompileIngredients
@synthesize name;

- (void)getIngredients:(NSMutableArray *)recipes{
    GetCorrectDictionary *gcd = [[GetCorrectDictionary alloc] init];
    NSMutableDictionary *recipesDictionary = [[NSMutableDictionary alloc] init];
    NSMutableArray *allIngredients = [[NSMutableArray alloc] init];
    
    for(int i = 0; i <= [recipes count] - 1; i++){
        recipesDictionary = [gcd getPath:[recipes objectAtIndex:i]];
        NSArray *dictionaryObjs = [recipesDictionary valueForKey:[NSString stringWithFormat:@"5 %@", [recipes objectAtIndex:i]]];
        if(dictionaryObjs != nil){
            [allIngredients addObjectsFromArray:dictionaryObjs];
        }
    }
    
    NSLog(@"All ingredients: %@", allIngredients);
    [self organizeData:allIngredients];
}

- (void)organizeData:(NSMutableArray *)data{
    NSMutableArray *organizedArray = [[NSMutableArray alloc] init];
    
    //Delete repeats
    [organizedArray addObjectsFromArray:[[NSSet setWithArray:data] allObjects]];
    [organizedArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    //Capitalize letters
    for (int i = 0; i <= [organizedArray count] - 1; i++){
        NSString *firstChar = [[[organizedArray objectAtIndex:i] substringToIndex:1] capitalizedString];
        NSString *formattedChar = [[organizedArray objectAtIndex:i] stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstChar];
        [organizedArray replaceObjectAtIndex:i withObject:formattedChar];
        NSLog(@"Capitalized: %@", [organizedArray objectAtIndex:i]);
    }
    
    //Alphabetize
    [organizedArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSLog(@"Completed: %@", organizedArray);
    
    AddRecipeListViewController *arl = [[AddRecipeListViewController alloc] init];
    [arl sendTo:organizedArray :name];
}

- (NSMutableArray *)loadPath{
    return Nil;
}


@end
