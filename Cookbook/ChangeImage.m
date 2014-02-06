//
//  ChangeImage.m
//  Cookbook
//
//  Created by Walker Christie on 1/28/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "ChangeImage.h"

@implementation ChangeImage

- (void)setImage : (NSString *) food : (UIImage *)image{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", food]];
    NSLog(@"%@", path);
    NSData* data = UIImagePNGRepresentation(image);
    [data writeToFile:path atomically:YES];
}

@end
