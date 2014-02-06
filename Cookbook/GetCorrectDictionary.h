//
//  GetCorrectDictionary.h
//  Cookbook
//
//  Created by Walker Christie on 1/22/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCorrectDictionary : NSObject

- (NSMutableDictionary *) getPath : (NSString *) food;
- (UIImage *)getImage : (NSString *)food;

@end
