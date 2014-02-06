//
//  AddImageViewController.m
//  Cookbook
//
//  Created by Walker Christie on 1/19/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "AddImageViewController.h"

@interface AddImageViewController ()

@end

@implementation AddImageViewController

@synthesize recipeImage;
@synthesize finishLabel;
@synthesize cookingProcess, cookingTime, description, food, ingredients;
BOOL imageChanged = NO;
UIImage *chosenRecipeImage;
NSMutableArray *compiledDictionaries;
NSMutableArray *compiledFoods;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) takePhoto{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (void) choosePhoto{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    chosenRecipeImage = info[UIImagePickerControllerEditedImage];
    [recipeImage setImage:chosenRecipeImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    imageChanged = YES;
    [finishLabel setText:@"Looks good!"];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)chooseImage:(id)sender {
    UIAlertView *av = [[UIAlertView alloc] init];
    av.tag = 50;
    av.delegate = self;
    [av setTitle:@"Add Image"];
    [av setMessage:@"Take or pick an image from your camera roll"];
    [av addButtonWithTitle:@"Take Photo"];
    [av addButtonWithTitle:@"Choose Photo"];
    av.alertViewStyle = UIAlertViewStyleDefault;
    [av show];
}

- (IBAction)finishButton:(id)sender {
    if(imageChanged){
        [self writeData];
        [self writeImage];
        [self performSegueWithIdentifier:@"finishModal" sender:self];
    } else {
        UIAlertView *av = [[UIAlertView alloc] init];
        av.tag = 40;
        av.delegate = self;
        [av setTitle:@"No Image?"];
        [av setMessage:@"An image is not required, and can be added later if you would like!"];
        [av addButtonWithTitle:@"Continue"];
        [av addButtonWithTitle:@"Add Image"];
        av.alertViewStyle = UIAlertViewStyleDefault;
        [av show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0 && alertView.tag == 50){
        [self takePhoto];
    }
    if(buttonIndex == 1 && alertView.tag == 50){
        [self choosePhoto];
    }
    if(buttonIndex == 0 && alertView.tag == 40){
        [self writeData];
        [self writeImage];
        [self performSegueWithIdentifier:@"finishModal" sender:self];
    }
    if(buttonIndex == 1 && alertView.tag == 40){
        //Close alert, try again
        [alertView dismissWithClickedButtonIndex:1 animated:YES];
    }
}

#pragma mark - Write everything
- (void) writeData{
    NSString *writeFoodKey = [NSString stringWithFormat:@"1 %@", food];
    NSString *writeDescriptionKey = [NSString stringWithFormat:@"2 %@", food];
    NSString *writeCookingTimeKey = [NSString stringWithFormat:@"3 %@", food];
    NSString *writeCookingProcessKey = [NSString stringWithFormat:@"4 %@", food];
    NSString *writeIngredientsKey = [NSString stringWithFormat:@"5 %@", food];
    
    NSMutableDictionary *writeDictionary = [[NSMutableDictionary alloc] init];
    compiledDictionaries = [[NSMutableArray alloc] init];
    
    //Creates a dictionary of all the objects
    //Will write them to the disk
    //Can be accessed by their specific key, and recipe name
    
    NSLog(@"desc %@", description);
    [writeDictionary setObject:food forKey:writeFoodKey];
    [writeDictionary setObject:description forKey:writeDescriptionKey];
    [writeDictionary setObject:cookingTime forKey:writeCookingTimeKey];
    [writeDictionary setObject:cookingProcess forKey:writeCookingProcessKey];
    [writeDictionary setObject:ingredients forKey:writeIngredientsKey];
    
    [compiledDictionaries addObject:writeDictionary];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *fileName = [NSString stringWithFormat:@"recipe %@.plist", food];
    NSString *filePath = [basePath stringByAppendingPathComponent:fileName];
    [compiledDictionaries writeToFile:filePath atomically:YES];
    
    //Reading it
    //NSRange startRange = [filePath rangeOfString:@"recipe "];
    //NSRange searchRange = NSMakeRange(startRange.location, filePath.length);
    //filePath = [basePath stringByAppendingPathComponent:];
    
    [self listFileAtPath:basePath];
    NSArray *arr = [NSMutableArray arrayWithContentsOfFile:filePath];
    NSLog(@"%@", arr);
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"%@", dict);
}

-(NSArray *)listFileAtPath:(NSString *)path{
    NSLog(@"LISTING ALL FILES IN PATH");
    int count;
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    for (count = 0; count < (int)[directoryContent count]; count++){
        NSLog(@"File %d: %@", (count + 1), [directoryContent objectAtIndex:count]);
        NSString *substring = [directoryContent objectAtIndex:count];
        if(substring && [substring rangeOfString:@"recipe "].location != NSNotFound){
            NSLog(@"A FOOD %@", substring);
            substring = [substring stringByReplacingOccurrencesOfString:@"recipe " withString:@""];
            substring = [substring stringByReplacingOccurrencesOfString:@".plist" withString:@""];
            NSLog(@"%@", substring);
            [compiledFoods addObject:substring];
            
        }
    }
    return directoryContent;
}

- (void)writeImage{
    //wmdeveloper.com/2010/09/save-and-load-uiimage-in-documents.html
    //Write image to documents directory
    if(chosenRecipeImage != nil){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", food]];
        NSLog(@"%@", path);
        NSData* data = UIImagePNGRepresentation(chosenRecipeImage);
        [data writeToFile:path atomically:YES];
    }
}











@end
