//
//  AddImageViewController.h
//  Cookbook
//
//  Created by Walker Christie on 1/19/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddImageViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *recipeImage;
@property (weak, nonatomic) IBOutlet UILabel *finishLabel;
- (IBAction)chooseImage:(id)sender;
- (IBAction)finishButton:(id)sender;

#pragma mark - Write Data
@property (weak, nonatomic) NSString *cookingProcess;
@property (weak, nonatomic) NSString *description;
@property (weak, nonatomic) NSString *cookingTime;
@property (weak, nonatomic) NSString *food;
@property (retain, nonatomic) NSArray *ingredients;

@end
