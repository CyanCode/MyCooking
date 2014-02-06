//
//  EnterRecipeViewController.m
//  Cookbook
//
//  Created by Walker Christie on 1/18/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "EnterRecipeViewController.h"
#import "ViewController.h"
#import "AddImageViewController.h"

@implementation EnterRecipeViewController

@synthesize cookingProcessTextField;
@synthesize cookingTimeTextField;
@synthesize descriptionTextField;
@synthesize food;
@synthesize ingredients;

NSString *description;
NSString *cookingProcess;
NSString *cookingTime;

- (void)viewDidLoad
{
    cookingProcessTextField.delegate = self;
    cookingTimeTextField.delegate = self;
    descriptionTextField.delegate = self;
    
    NSLog(@"Passed Food %@", food);
    NSLog(@"Passed Ingredients %@", ingredients);
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [cookingTimeTextField resignFirstResponder];
    [cookingProcessTextField resignFirstResponder];
    [descriptionTextField resignFirstResponder];
    return YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)cancelButton:(id)sender {
    [self performSegueWithIdentifier:@"firstRecipeEntryModal" sender:self];
}

- (IBAction)continueButton:(id)sender {
    if([cookingTimeTextField.text isEqual: @""] || [cookingTimeTextField isEqual: @""] || [descriptionTextField isEqual: @""]){
        UIAlertView *av = [[UIAlertView alloc] init];
        av.alertViewStyle = UIAlertViewStyleDefault;
        [av setMessage:@"Please fill all values"];
        [av setTitle:@"Oops!"];
        [av addButtonWithTitle:@"Okay"];
        [av show];
    } else {
        //Send that shit over
        [self performSegueWithIdentifier:@"recipeToImageModal" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"recipeToImageModal"]){
        AddImageViewController *aivc = [segue destinationViewController];
        aivc.ingredients = ingredients;
        aivc.food = food;
        aivc.description = description;
        aivc.cookingTime = cookingTime;
        aivc.cookingProcess = cookingProcess;
    }
}

#pragma mark - Edit Text Field Sliding

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    cookingTime = cookingTimeTextField.text;
    [self animateTextField:textField up:NO];
}

- (void)animateTextField: (UITextField *) textField up: (BOOL) up{
    const int movementDistance = 185;
    const int movementDuration = 0.3f;
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

#pragma mark - Edit Text View Sliding

- (void)textViewDidBeginEditing:(UITextView *)textView{
    [self animateTextView:textView up:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    description = descriptionTextField.text;
    cookingProcess = cookingProcessTextField.text;
    [self animateTextView:textView up:NO];
}

- (void)animateTextView: (UITextView *) textView up: (BOOL) up{
    int movementDistance;
    
    if(textView == cookingProcessTextField){
        movementDistance = 0;
    }
    if(textView == descriptionTextField){
        movementDistance = 100;
    }
    
    const int movementDuration = 0.3f;
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
