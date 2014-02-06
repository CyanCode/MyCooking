//
//  ViewImageViewController.h
//  Cookbook
//
//  Created by Walker Christie on 1/28/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewImageViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *displayImage;
@property (weak, nonatomic) UIImage *image;
@property (weak, nonatomic) NSString *foodName;

- (IBAction)changeImage:(id)sender;

@end
