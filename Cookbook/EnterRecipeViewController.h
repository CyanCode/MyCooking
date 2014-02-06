//
//  EnterRecipeViewController.h
//  Cookbook
//
//  Created by Walker Christie on 1/18/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterRecipeViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *cookingProcessTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *cookingTimeTextField;
@property (weak, nonatomic) NSString *food;
@property (weak, nonatomic) NSArray *ingredients;
- (IBAction)cancelButton:(id)sender;
- (IBAction)continueButton:(id)sender;


@end
