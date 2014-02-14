//
//  CaloriesViewController.m
//  Cookbook
//
//  Created by Walker Christie on 2/13/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "CaloriesViewController.h"
#import "GetCellData.h"
#import "GetAllImages.h"
#import "CaloriesCell.h"

@implementation CaloriesViewController{
    GetCellData *gcd;
}

@synthesize collection;

- (void)viewDidLoad
{
    collection.delegate = self;
    collection.dataSource = self;
    gcd = [[GetCellData alloc] init];
    
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[gcd loadImages] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CaloriesCell *cell = [collection dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSArray *images = [[NSArray alloc] init];
    NSArray *calories = [[NSArray alloc] init];
    images = [gcd loadImages];
    calories = [gcd loadCalories];
    
    //Now loop through calories array and check for any comparison between the CURRENT image
    //If there is a comparison, display the calories! (without the "food" part of course..)
    
    cell.image.image = [images objectAtIndex:indexPath.row];
    cell.calories.text = [[gcd loadCalories] objectAtIndex:indexPath.row];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(83, 106);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
