//
//  GetCellData.m
//  Cookbook
//
//  Created by Walker Christie on 2/13/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "GetCellData.h"
#import "GetAllImages.h"

@implementation GetCellData

- (NSArray *)loadImages{
    GetAllImages *gai = [[GetAllImages alloc] init];
    NSMutableArray *compiledFoods = [NSMutableArray arrayWithArray:[gai loadImages]];
    
    return compiledFoods;
}

- (NSArray *)loadCalories{
    //Always located in calories folder..
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/cal"];
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dataPath error:nil];
    NSMutableArray *calories = [[NSMutableArray alloc] init];

    if([[NSFileManager defaultManager] fileExistsAtPath:dataPath] && directoryContent != nil){
        int count;
        
        for(count = 0; count < (int)[directoryContent count]; count ++){
            //CALORIE FILE FORMAT
            //Name: foodnameCal.txt
            //Content: foodname amtofcalories
            
            NSString *fileName = [NSString stringWithFormat:@"%@", [directoryContent objectAtIndex:count]];
            NSString *content = [[NSString alloc] initWithContentsOfFile:fileName usedEncoding:nil error:nil];
            [calories addObject:content];
        }
    }
    
    return calories;
}

@end
