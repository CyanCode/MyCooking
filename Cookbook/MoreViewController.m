//
//  MoreViewController.m
//  Cookbook
//
//  Created by Walker Christie on 2/10/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "MoreViewController.h"
#import "SectionsAndImages.h"
#import "OptionsCell.h"

@implementation MoreViewController{
    SectionsAndImages *sai;
}

@synthesize customTabBar;
@synthesize collection;

- (void)viewDidLoad
{
    [super viewDidLoad];
    sai = [[SectionsAndImages alloc] init];
    
    collection.delegate = self;
    collection.dataSource = self;
    customTabBar.delegate = self;
    
    [customTabBar setSelectedItem:[customTabBar.items objectAtIndex:3]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[sai loadImages] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    OptionsCell *cell = [collection dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSArray *images = [[NSArray alloc] init];
    images = [sai loadImages];
    
    cell.description.text = [[sai loadSections] objectAtIndex:indexPath.row];
    cell.image.image = [images objectAtIndex:indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(83, 106);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    int index = indexPath.row;
    
    if(index == 0){
        [self performSegueWithIdentifier:@"toCalories" sender:self];
    } if(index == 1){
        //Edit
    } if(index == 2){
        const int APP_ID = 811746997;
        NSString *reviewURL = [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%d&pageNumber=0&sortOrdering=1&type=Purple+Software&mt=8", APP_ID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURL]];
    } if(index == 3){
        //Time
    }
}

- (void)changeView :(NSString *)selection{
    
}

#pragma mark - Tab Bar

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if(tabBar.selectedItem == [tabBar.items objectAtIndex:0]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Recipes" bundle:nil];
        UIViewController *vc = [storyboard instantiateInitialViewController];
        [self presentViewController:vc animated:NO completion:nil];
    } if(tabBar.selectedItem == [tabBar.items objectAtIndex:1]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"New" bundle:nil];
        UIViewController *vc = [storyboard instantiateInitialViewController];
        vc.modalTransitionStyle = UIModalPresentationNone;
        [self presentViewController:vc animated:NO completion:nil];
    } if(tabBar.selectedItem == [tabBar.items objectAtIndex:2]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"List" bundle:nil];
        UIViewController *vc = [storyboard instantiateInitialViewController];
        vc.modalTransitionStyle = UIModalPresentationNone;
        [self presentViewController:vc animated:NO completion:nil];
    } if(tabBar.selectedItem == [tabBar.items objectAtIndex:3]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"More" bundle:nil];
        UIViewController *vc = [storyboard instantiateInitialViewController];
        vc.modalTransitionStyle = UIModalPresentationNone;
        [self presentViewController:vc animated:NO completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
