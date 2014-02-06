//
//  ViewImageViewController.m
//  Cookbook
//
//  Created by Walker Christie on 1/28/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "ViewImageViewController.h"
#import "ChangeImage.h"

@interface ViewImageViewController ()

@end

@implementation ViewImageViewController{
    UIImage *selectedImage;
}

@synthesize image;
@synthesize displayImage;
@synthesize foodName;

- (void)viewDidLoad
{
    [displayImage setImage:image];
    [super viewDidLoad];
}

- (IBAction)changeImage:(id)sender{
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

- (void)takePhoto{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (void)choosePhoto{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0 && alertView.tag == 50){
        [self takePhoto];
    }
    if(buttonIndex == 1 && alertView.tag == 50){
        [self choosePhoto];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    selectedImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
  
    ChangeImage *ci = [[ChangeImage alloc] init];
    [ci setImage:foodName :selectedImage];
    [displayImage setImage:selectedImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
