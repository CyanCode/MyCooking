//
//  DisplayAlerts.m
//  Cookbook
//
//  Created by Walker Christie on 1/25/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "DisplayAlerts.h"
#import "ListViewController.h"

@implementation DisplayAlerts

- (void)informationAlert{
    ListViewController *lvc = [[ListViewController alloc] init];
    UIAlertView *av = [[UIAlertView alloc] init];
    av.delegate = lvc.listTableView;
    [av setTitle:@"What's This?"];
    [av setMessage:@"The list feature allows you to easily organize what ingredients you need.  Perfect for grocery shopping!"];
    [av addButtonWithTitle:@"Okay"];
    [av show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    }
}
@end
